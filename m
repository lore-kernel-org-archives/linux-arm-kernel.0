From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 12:58:32 -0500
Subject: [PATCH v6 07/15] KVM: ARM: World-switch implementation
In-Reply-To: <20130116175716.29147.15348.stgit@ubuntu>
References: <20130116175716.29147.15348.stgit@ubuntu>
Message-ID: <20130116175832.29147.50195.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provides complete world-switch implementation to switch to other guests
running in non-secure modes. Includes Hyp exception handlers that
capture necessary exception information and stores the information on
the VCPU and KVM structures.

The following Hyp-ABI is also documented in the code:

Hyp-ABI: Calling HYP-mode functions from host (in SVC mode):
   Switching to Hyp mode is done through a simple HVC #0 instruction. The
   exception vector code will check that the HVC comes from VMID==0 and if
   so will push the necessary state (SPSR, lr_usr) on the Hyp stack.
   - r0 contains a pointer to a HYP function
   - r1, r2, and r3 contain arguments to the above function.
   - The HYP function will be called with its arguments in r0, r1 and r2.
   On HYP function return, we return directly to SVC.

A call to a function executing in Hyp mode is performed like the following:

        <svc code>
        ldr     r0, =BSYM(my_hyp_fn)
        ldr     r1, =my_param
        hvc #0  ; Call my_hyp_fn(my_param) from HYP mode
        <svc code>

Otherwise, the world-switch is pretty straight-forward. All state that
can be modified by the guest is first backed up on the Hyp stack and the
VCPU values is loaded onto the hardware. State, which is not loaded, but
theoretically modifiable by the guest is protected through the
virtualiation features to generate a trap and cause software emulation.
Upon guest returns, all state is restored from hardware onto the VCPU
struct and the original state is restored from the Hyp-stack onto the
hardware.

SMP support using the VMPIDR calculated on the basis of the host MPIDR
and overriding the low bits with KVM vcpu_id contributed by Marc Zyngier.

Reuse of VMIDs has been implemented by Antonios Motakis and adapated from
a separate patch into the appropriate patches introducing the
functionality. Note that the VMIDs are stored per VM as required by the ARM
architecture reference manual.

To support VFP/NEON we trap those instructions using the HPCTR. When
we trap, we switch the FPU.  After a guest exit, the VFP state is
returned to the host.  When disabling access to floating point
instructions, we also mask FPEXC_EN in order to avoid the guest
receiving Undefined instruction exceptions before we have a chance to
switch back the floating point state.  We are reusing vfp_hard_struct,
so we depend on VFPv3 being enabled in the host kernel, if not, we still
trap cp10 and cp11 in order to inject an undefined instruction exception
whenever the guest tries to use VFP/NEON. VFP/NEON developed by
Antionios Motakis and Rusty Russell.

Aborts that are permission faults, and not stage-1 page table walk, do
not report the faulting address in the HPFAR.  We have to resolve the
IPA, and store it just like the HPFAR register on the VCPU struct. If
the IPA cannot be resolved, it means another CPU is playing with the
page tables, and we simply restart the guest.  This quirk was fixed by
Marc Zyngier.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_arm.h  |   51 +++++
 arch/arm/include/asm/kvm_host.h |   13 +
 arch/arm/kernel/asm-offsets.c   |   25 ++
 arch/arm/kvm/arm.c              |  200 ++++++++++++++++++
 arch/arm/kvm/interrupts.S       |  395 +++++++++++++++++++++++++++++++++++
 arch/arm/kvm/interrupts_head.S  |  441 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 1121 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/kvm/interrupts_head.S

diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
index d64b525..c69936b 100644
--- a/arch/arm/include/asm/kvm_arm.h
+++ b/arch/arm/include/asm/kvm_arm.h
@@ -98,6 +98,18 @@
 #define TTBCR_T0SZ	3
 #define HTCR_MASK	(TTBCR_T0SZ | TTBCR_IRGN0 | TTBCR_ORGN0 | TTBCR_SH0)
 
+/* Hyp System Trap Register */
+#define HSTR_T(x)	(1 << x)
+#define HSTR_TTEE	(1 << 16)
+#define HSTR_TJDBX	(1 << 17)
+
+/* Hyp Coprocessor Trap Register */
+#define HCPTR_TCP(x)	(1 << x)
+#define HCPTR_TCP_MASK	(0x3fff)
+#define HCPTR_TASE	(1 << 15)
+#define HCPTR_TTA	(1 << 20)
+#define HCPTR_TCPAC	(1 << 31)
+
 /* Hyp Debug Configuration Register bits */
 #define HDCR_TDRA	(1 << 11)
 #define HDCR_TDOSA	(1 << 10)
@@ -144,6 +156,45 @@
 #else
 #define VTTBR_X		(5 - KVM_T0SZ)
 #endif
+#define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
+#define VTTBR_BADDR_MASK  (((1LLU << (40 - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
+#define VTTBR_VMID_SHIFT  (48LLU)
+#define VTTBR_VMID_MASK	  (0xffLLU << VTTBR_VMID_SHIFT)
+
+/* Hyp Syndrome Register (HSR) bits */
+#define HSR_EC_SHIFT	(26)
+#define HSR_EC		(0x3fU << HSR_EC_SHIFT)
+#define HSR_IL		(1U << 25)
+#define HSR_ISS		(HSR_IL - 1)
+#define HSR_ISV_SHIFT	(24)
+#define HSR_ISV		(1U << HSR_ISV_SHIFT)
+#define HSR_FSC		(0x3f)
+#define HSR_FSC_TYPE	(0x3c)
+#define HSR_WNR		(1 << 6)
+
+#define FSC_FAULT	(0x04)
+#define FSC_PERM	(0x0c)
+
+/* Hyp Prefetch Fault Address Register (HPFAR/HDFAR) */
+#define HPFAR_MASK	(~0xf)
 
+#define HSR_EC_UNKNOWN	(0x00)
+#define HSR_EC_WFI	(0x01)
+#define HSR_EC_CP15_32	(0x03)
+#define HSR_EC_CP15_64	(0x04)
+#define HSR_EC_CP14_MR	(0x05)
+#define HSR_EC_CP14_LS	(0x06)
+#define HSR_EC_CP_0_13	(0x07)
+#define HSR_EC_CP10_ID	(0x08)
+#define HSR_EC_JAZELLE	(0x09)
+#define HSR_EC_BXJ	(0x0A)
+#define HSR_EC_CP14_64	(0x0C)
+#define HSR_EC_SVC_HYP	(0x11)
+#define HSR_EC_HVC	(0x12)
+#define HSR_EC_SMC	(0x13)
+#define HSR_EC_IABT	(0x20)
+#define HSR_EC_IABT_HYP	(0x21)
+#define HSR_EC_DABT	(0x24)
+#define HSR_EC_DABT_HYP	(0x25)
 
 #endif /* __ARM_KVM_ARM_H__ */
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 3636c7e..7a12108 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -21,6 +21,7 @@
 
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
+#include <asm/fpstate.h>
 
 #define KVM_MAX_VCPUS CONFIG_KVM_ARM_MAX_VCPUS
 #define KVM_MEMORY_SLOTS 32
@@ -85,6 +86,14 @@ struct kvm_vcpu_arch {
 	u32 hxfar;		/* Hyp Data/Inst Fault Address Register */
 	u32 hpfar;		/* Hyp IPA Fault Address Register */
 
+	/* Floating point registers (VFP and Advanced SIMD/NEON) */
+	struct vfp_hard_struct vfp_guest;
+	struct vfp_hard_struct *vfp_host;
+
+	/*
+	 * Anything that is not used directly from assembly code goes
+	 * here.
+	 */
 	/* Interrupt related fields */
 	u32 irq_lines;		/* IRQ and FIQ levels */
 
@@ -93,6 +102,9 @@ struct kvm_vcpu_arch {
 
 	/* Cache some mmu pages needed inside spinlock regions */
 	struct kvm_mmu_memory_cache mmu_page_cache;
+
+	/* Detect first run of a vcpu */
+	bool has_run_once;
 };
 
 struct kvm_vm_stat {
@@ -112,6 +124,7 @@ struct kvm_one_reg;
 int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 u64 kvm_call_hyp(void *hypfn, ...);
+void force_vm_exit(const cpumask_t *mask);
 
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 struct kvm;
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index c985b48..c8b3272 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -13,6 +13,9 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
+#ifdef CONFIG_KVM_ARM_HOST
+#include <linux/kvm_host.h>
+#endif
 #include <asm/cacheflush.h>
 #include <asm/glue-df.h>
 #include <asm/glue-pf.h>
@@ -146,5 +149,27 @@ int main(void)
   DEFINE(DMA_BIDIRECTIONAL,	DMA_BIDIRECTIONAL);
   DEFINE(DMA_TO_DEVICE,		DMA_TO_DEVICE);
   DEFINE(DMA_FROM_DEVICE,	DMA_FROM_DEVICE);
+#ifdef CONFIG_KVM_ARM_HOST
+  DEFINE(VCPU_KVM,		offsetof(struct kvm_vcpu, kvm));
+  DEFINE(VCPU_MIDR,		offsetof(struct kvm_vcpu, arch.midr));
+  DEFINE(VCPU_CP15,		offsetof(struct kvm_vcpu, arch.cp15));
+  DEFINE(VCPU_VFP_GUEST,	offsetof(struct kvm_vcpu, arch.vfp_guest));
+  DEFINE(VCPU_VFP_HOST,		offsetof(struct kvm_vcpu, arch.vfp_host));
+  DEFINE(VCPU_REGS,		offsetof(struct kvm_vcpu, arch.regs));
+  DEFINE(VCPU_USR_REGS,		offsetof(struct kvm_vcpu, arch.regs.usr_regs));
+  DEFINE(VCPU_SVC_REGS,		offsetof(struct kvm_vcpu, arch.regs.svc_regs));
+  DEFINE(VCPU_ABT_REGS,		offsetof(struct kvm_vcpu, arch.regs.abt_regs));
+  DEFINE(VCPU_UND_REGS,		offsetof(struct kvm_vcpu, arch.regs.und_regs));
+  DEFINE(VCPU_IRQ_REGS,		offsetof(struct kvm_vcpu, arch.regs.irq_regs));
+  DEFINE(VCPU_FIQ_REGS,		offsetof(struct kvm_vcpu, arch.regs.fiq_regs));
+  DEFINE(VCPU_PC,		offsetof(struct kvm_vcpu, arch.regs.usr_regs.ARM_pc));
+  DEFINE(VCPU_CPSR,		offsetof(struct kvm_vcpu, arch.regs.usr_regs.ARM_cpsr));
+  DEFINE(VCPU_IRQ_LINES,	offsetof(struct kvm_vcpu, arch.irq_lines));
+  DEFINE(VCPU_HSR,		offsetof(struct kvm_vcpu, arch.hsr));
+  DEFINE(VCPU_HxFAR,		offsetof(struct kvm_vcpu, arch.hxfar));
+  DEFINE(VCPU_HPFAR,		offsetof(struct kvm_vcpu, arch.hpfar));
+  DEFINE(VCPU_HYP_PC,		offsetof(struct kvm_vcpu, arch.hyp_pc));
+  DEFINE(KVM_VTTBR,		offsetof(struct kvm, arch.vttbr));
+#endif
   return 0; 
 }
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 2101152..9e9fa44 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -40,6 +40,7 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_emulate.h>
 
 #ifdef REQUIRES_VIRT
 __asm__(".arch_extension	virt");
@@ -49,6 +50,10 @@ static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 static struct vfp_hard_struct __percpu *kvm_host_vfp_state;
 static unsigned long hyp_default_vectors;
 
+/* The VMID used in the VTTBR */
+static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
+static u8 kvm_next_vmid;
+static DEFINE_SPINLOCK(kvm_vmid_lock);
 
 int kvm_arch_hardware_enable(void *garbage)
 {
@@ -276,6 +281,8 @@ int __attribute_const__ kvm_target_cpu(void)
 
 int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 {
+	/* Force users to call KVM_ARM_VCPU_INIT */
+	vcpu->arch.target = -1;
 	return 0;
 }
 
@@ -286,6 +293,7 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	vcpu->cpu = cpu;
+	vcpu->arch.vfp_host = this_cpu_ptr(kvm_host_vfp_state);
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
@@ -316,9 +324,199 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 	return 0;
 }
 
+/* Just ensure a guest exit from a particular CPU */
+static void exit_vm_noop(void *info)
+{
+}
+
+void force_vm_exit(const cpumask_t *mask)
+{
+	smp_call_function_many(mask, exit_vm_noop, NULL, true);
+}
+
+/**
+ * need_new_vmid_gen - check that the VMID is still valid
+ * @kvm: The VM's VMID to checkt
+ *
+ * return true if there is a new generation of VMIDs being used
+ *
+ * The hardware supports only 256 values with the value zero reserved for the
+ * host, so we check if an assigned value belongs to a previous generation,
+ * which which requires us to assign a new value. If we're the first to use a
+ * VMID for the new generation, we must flush necessary caches and TLBs on all
+ * CPUs.
+ */
+static bool need_new_vmid_gen(struct kvm *kvm)
+{
+	return unlikely(kvm->arch.vmid_gen != atomic64_read(&kvm_vmid_gen));
+}
+
+/**
+ * update_vttbr - Update the VTTBR with a valid VMID before the guest runs
+ * @kvm	The guest that we are about to run
+ *
+ * Called from kvm_arch_vcpu_ioctl_run before entering the guest to ensure the
+ * VM has a valid VMID, otherwise assigns a new one and flushes corresponding
+ * caches and TLBs.
+ */
+static void update_vttbr(struct kvm *kvm)
+{
+	phys_addr_t pgd_phys;
+	u64 vmid;
+
+	if (!need_new_vmid_gen(kvm))
+		return;
+
+	spin_lock(&kvm_vmid_lock);
+
+	/*
+	 * We need to re-check the vmid_gen here to ensure that if another vcpu
+	 * already allocated a valid vmid for this vm, then this vcpu should
+	 * use the same vmid.
+	 */
+	if (!need_new_vmid_gen(kvm)) {
+		spin_unlock(&kvm_vmid_lock);
+		return;
+	}
+
+	/* First user of a new VMID generation? */
+	if (unlikely(kvm_next_vmid == 0)) {
+		atomic64_inc(&kvm_vmid_gen);
+		kvm_next_vmid = 1;
+
+		/*
+		 * On SMP we know no other CPUs can use this CPU's or each
+		 * other's VMID after force_vm_exit returns since the
+		 * kvm_vmid_lock blocks them from reentry to the guest.
+		 */
+		force_vm_exit(cpu_all_mask);
+		/*
+		 * Now broadcast TLB + ICACHE invalidation over the inner
+		 * shareable domain to make sure all data structures are
+		 * clean.
+		 */
+		kvm_call_hyp(__kvm_flush_vm_context);
+	}
+
+	kvm->arch.vmid_gen = atomic64_read(&kvm_vmid_gen);
+	kvm->arch.vmid = kvm_next_vmid;
+	kvm_next_vmid++;
+
+	/* update vttbr to be used with the new vmid */
+	pgd_phys = virt_to_phys(kvm->arch.pgd);
+	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK;
+	kvm->arch.vttbr = pgd_phys & VTTBR_BADDR_MASK;
+	kvm->arch.vttbr |= vmid;
+
+	spin_unlock(&kvm_vmid_lock);
+}
+
+/*
+ * Return > 0 to return to guest, < 0 on error, 0 (and set exit_reason) on
+ * proper exit to QEMU.
+ */
+static int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
+		       int exception_index)
+{
+	run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+	return 0;
+}
+
+static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
+{
+	if (likely(vcpu->arch.has_run_once))
+		return 0;
+
+	vcpu->arch.has_run_once = true;
+	return 0;
+}
+
+/**
+ * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute guest code
+ * @vcpu:	The VCPU pointer
+ * @run:	The kvm_run structure pointer used for userspace state exchange
+ *
+ * This function is called through the VCPU_RUN ioctl called from user space. It
+ * will execute VM code in a loop until the time slice for the process is used
+ * or some emulation is needed from user space in which case the function will
+ * return with return value 0 and with the kvm_run structure filled in with the
+ * required data for the requested emulation.
+ */
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	return -EINVAL;
+	int ret;
+	sigset_t sigsaved;
+
+	/* Make sure they initialize the vcpu with KVM_ARM_VCPU_INIT */
+	if (unlikely(vcpu->arch.target < 0))
+		return -ENOEXEC;
+
+	ret = kvm_vcpu_first_run_init(vcpu);
+	if (ret)
+		return ret;
+
+	if (vcpu->sigset_active)
+		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
+
+	ret = 1;
+	run->exit_reason = KVM_EXIT_UNKNOWN;
+	while (ret > 0) {
+		/*
+		 * Check conditions before entering the guest
+		 */
+		cond_resched();
+
+		update_vttbr(vcpu->kvm);
+
+		local_irq_disable();
+
+		/*
+		 * Re-check atomic conditions
+		 */
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			run->exit_reason = KVM_EXIT_INTR;
+		}
+
+		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
+			local_irq_enable();
+			continue;
+		}
+
+		/**************************************************************
+		 * Enter the guest
+		 */
+		trace_kvm_entry(*vcpu_pc(vcpu));
+		kvm_guest_enter();
+		vcpu->mode = IN_GUEST_MODE;
+
+		ret = kvm_call_hyp(__kvm_vcpu_run, vcpu);
+
+		vcpu->mode = OUTSIDE_GUEST_MODE;
+		kvm_guest_exit();
+		trace_kvm_exit(*vcpu_pc(vcpu));
+		/*
+		 * We may have taken a host interrupt in HYP mode (ie
+		 * while executing the guest). This interrupt is still
+		 * pending, as we haven't serviced it yet!
+		 *
+		 * We're now back in SVC mode, with interrupts
+		 * disabled.  Enabling the interrupts now will have
+		 * the effect of taking the interrupt again, in SVC
+		 * mode this time.
+		 */
+		local_irq_enable();
+
+		/*
+		 * Back from guest
+		 *************************************************************/
+
+		ret = handle_exit(vcpu, run, ret);
+	}
+
+	if (vcpu->sigset_active)
+		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+	return ret;
 }
 
 static int vcpu_interrupt_line(struct kvm_vcpu *vcpu, int number, bool level)
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 99fbf6a..04a9705 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -20,9 +20,12 @@
 #include <linux/const.h>
 #include <asm/unified.h>
 #include <asm/page.h>
+#include <asm/ptrace.h>
 #include <asm/asm-offsets.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_arm.h>
+#include <asm/vfpmacros.h>
+#include "interrupts_head.S"
 
 	.text
 
@@ -31,23 +34,163 @@ __kvm_hyp_code_start:
 
 /********************************************************************
  * Flush per-VMID TLBs
+ *
+ * void __kvm_tlb_flush_vmid(struct kvm *kvm);
+ *
+ * We rely on the hardware to broadcast the TLB invalidation to all CPUs
+ * inside the inner-shareable domain (which is the case for all v7
+ * implementations).  If we come across a non-IS SMP implementation, we'll
+ * have to use an IPI based mechanism. Until then, we stick to the simple
+ * hardware assisted version.
  */
 ENTRY(__kvm_tlb_flush_vmid)
+	push	{r2, r3}
+
+	add	r0, r0, #KVM_VTTBR
+	ldrd	r2, r3, [r0]
+	mcrr	p15, 6, r2, r3, c2	@ Write VTTBR
+	isb
+	mcr     p15, 0, r0, c8, c3, 0	@ TLBIALLIS (rt ignored)
+	dsb
+	isb
+	mov	r2, #0
+	mov	r3, #0
+	mcrr	p15, 6, r2, r3, c2	@ Back to VMID #0
+	isb				@ Not necessary if followed by eret
+
+	pop	{r2, r3}
 	bx	lr
 ENDPROC(__kvm_tlb_flush_vmid)
 
 /********************************************************************
- * Flush TLBs and instruction caches of current CPU for all VMIDs
+ * Flush TLBs and instruction caches of all CPUs inside the inner-shareable
+ * domain, for all VMIDs
+ *
+ * void __kvm_flush_vm_context(void);
  */
 ENTRY(__kvm_flush_vm_context)
+	mov	r0, #0			@ rn parameter for c15 flushes is SBZ
+
+	/* Invalidate NS Non-Hyp TLB Inner Shareable (TLBIALLNSNHIS) */
+	mcr     p15, 4, r0, c8, c3, 4
+	/* Invalidate instruction caches Inner Shareable (ICIALLUIS) */
+	mcr     p15, 0, r0, c7, c1, 0
+	dsb
+	isb				@ Not necessary if followed by eret
+
 	bx	lr
 ENDPROC(__kvm_flush_vm_context)
 
+
 /********************************************************************
  *  Hypervisor world-switch code
+ *
+ *
+ * int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
  */
 ENTRY(__kvm_vcpu_run)
-	bx	lr
+	@ Save the vcpu pointer
+	mcr	p15, 4, vcpu, c13, c0, 2	@ HTPIDR
+
+	save_host_regs
+
+	@ Store hardware CP15 state and load guest state
+	read_cp15_state store_to_vcpu = 0
+	write_cp15_state read_from_vcpu = 1
+
+	@ If the host kernel has not been configured with VFPv3 support,
+	@ then it is safer if we deny guests from using it as well.
+#ifdef CONFIG_VFPv3
+	@ Set FPEXC_EN so the guest doesn't trap floating point instructions
+	VFPFMRX r2, FPEXC		@ VMRS
+	push	{r2}
+	orr	r2, r2, #FPEXC_EN
+	VFPFMXR FPEXC, r2		@ VMSR
+#endif
+
+	@ Configure Hyp-role
+	configure_hyp_role vmentry
+
+	@ Trap coprocessor CRx accesses
+	set_hstr vmentry
+	set_hcptr vmentry, (HCPTR_TTA | HCPTR_TCP(10) | HCPTR_TCP(11))
+	set_hdcr vmentry
+
+	@ Write configured ID register into MIDR alias
+	ldr	r1, [vcpu, #VCPU_MIDR]
+	mcr	p15, 4, r1, c0, c0, 0
+
+	@ Write guest view of MPIDR into VMPIDR
+	ldr	r1, [vcpu, #CP15_OFFSET(c0_MPIDR)]
+	mcr	p15, 4, r1, c0, c0, 5
+
+	@ Set up guest memory translation
+	ldr	r1, [vcpu, #VCPU_KVM]
+	add	r1, r1, #KVM_VTTBR
+	ldrd	r2, r3, [r1]
+	mcrr	p15, 6, r2, r3, c2	@ Write VTTBR
+
+	@ We're all done, just restore the GPRs and go to the guest
+	restore_guest_regs
+	clrex				@ Clear exclusive monitor
+	eret
+
+__kvm_vcpu_return:
+	/*
+	 * return convention:
+	 * guest r0, r1, r2 saved on the stack
+	 * r0: vcpu pointer
+	 * r1: exception code
+	 */
+	save_guest_regs
+
+	@ Set VMID == 0
+	mov	r2, #0
+	mov	r3, #0
+	mcrr	p15, 6, r2, r3, c2	@ Write VTTBR
+
+	@ Don't trap coprocessor accesses for host kernel
+	set_hstr vmexit
+	set_hdcr vmexit
+	set_hcptr vmexit, (HCPTR_TTA | HCPTR_TCP(10) | HCPTR_TCP(11))
+
+#ifdef CONFIG_VFPv3
+	@ Save floating point registers we if let guest use them.
+	tst	r2, #(HCPTR_TCP(10) | HCPTR_TCP(11))
+	bne	after_vfp_restore
+
+	@ Switch VFP/NEON hardware state to the host's
+	add	r7, vcpu, #VCPU_VFP_GUEST
+	store_vfp_state r7
+	add	r7, vcpu, #VCPU_VFP_HOST
+	ldr	r7, [r7]
+	restore_vfp_state r7
+
+after_vfp_restore:
+	@ Restore FPEXC_EN which we clobbered on entry
+	pop	{r2}
+	VFPFMXR FPEXC, r2
+#endif
+
+	@ Reset Hyp-role
+	configure_hyp_role vmexit
+
+	@ Let host read hardware MIDR
+	mrc	p15, 0, r2, c0, c0, 0
+	mcr	p15, 4, r2, c0, c0, 0
+
+	@ Back to hardware MPIDR
+	mrc	p15, 0, r2, c0, c0, 5
+	mcr	p15, 4, r2, c0, c0, 5
+
+	@ Store guest CP15 state and restore host state
+	read_cp15_state store_to_vcpu = 1
+	write_cp15_state read_from_vcpu = 0
+
+	restore_host_regs
+	clrex				@ Clear exclusive monitor
+	mov	r0, r1			@ Return the return code
+	bx	lr			@ return to IOCTL
 
 ENTRY(kvm_call_hyp)
 	hvc	#0
@@ -55,12 +198,258 @@ ENTRY(kvm_call_hyp)
 
 /********************************************************************
  * Hypervisor exception vector and handlers
+ *
+ *
+ * The KVM/ARM Hypervisor ABI is defined as follows:
+ *
+ * Entry to Hyp mode from the host kernel will happen _only_ when an HVC
+ * instruction is issued since all traps are disabled when running the host
+ * kernel as per the Hyp-mode initialization at boot time.
+ *
+ * HVC instructions cause a trap to the vector page + offset 0x18 (see hyp_hvc
+ * below) when the HVC instruction is called from SVC mode (i.e. a guest or the
+ * host kernel) and they cause a trap to the vector page + offset 0xc when HVC
+ * instructions are called from within Hyp-mode.
+ *
+ * Hyp-ABI: Calling HYP-mode functions from host (in SVC mode):
+ *    Switching to Hyp mode is done through a simple HVC #0 instruction. The
+ *    exception vector code will check that the HVC comes from VMID==0 and if
+ *    so will push the necessary state (SPSR, lr_usr) on the Hyp stack.
+ *    - r0 contains a pointer to a HYP function
+ *    - r1, r2, and r3 contain arguments to the above function.
+ *    - The HYP function will be called with its arguments in r0, r1 and r2.
+ *    On HYP function return, we return directly to SVC.
+ *
+ * Note that the above is used to execute code in Hyp-mode from a host-kernel
+ * point of view, and is a different concept from performing a world-switch and
+ * executing guest code SVC mode (with a VMID != 0).
  */
 
+/* Handle undef, svc, pabt, or dabt by crashing with a user notice */
+.macro bad_exception exception_code, panic_str
+	push	{r0-r2}
+	mrrc	p15, 6, r0, r1, c2	@ Read VTTBR
+	lsr	r1, r1, #16
+	ands	r1, r1, #0xff
+	beq	99f
+
+	load_vcpu			@ Load VCPU pointer
+	.if \exception_code == ARM_EXCEPTION_DATA_ABORT
+	mrc	p15, 4, r2, c5, c2, 0	@ HSR
+	mrc	p15, 4, r1, c6, c0, 0	@ HDFAR
+	str	r2, [vcpu, #VCPU_HSR]
+	str	r1, [vcpu, #VCPU_HxFAR]
+	.endif
+	.if \exception_code == ARM_EXCEPTION_PREF_ABORT
+	mrc	p15, 4, r2, c5, c2, 0	@ HSR
+	mrc	p15, 4, r1, c6, c0, 2	@ HIFAR
+	str	r2, [vcpu, #VCPU_HSR]
+	str	r1, [vcpu, #VCPU_HxFAR]
+	.endif
+	mov	r1, #\exception_code
+	b	__kvm_vcpu_return
+
+	@ We were in the host already. Let's craft a panic-ing return to SVC.
+99:	mrs	r2, cpsr
+	bic	r2, r2, #MODE_MASK
+	orr	r2, r2, #SVC_MODE
+THUMB(	orr	r2, r2, #PSR_T_BIT	)
+	msr	spsr_cxsf, r2
+	mrs	r1, ELR_hyp
+	ldr	r2, =BSYM(panic)
+	msr	ELR_hyp, r2
+	ldr	r0, =\panic_str
+	eret
+.endm
+
+	.text
+
 	.align 5
 __kvm_hyp_vector:
 	.globl __kvm_hyp_vector
-	nop
+
+	@ Hyp-mode exception vector
+	W(b)	hyp_reset
+	W(b)	hyp_undef
+	W(b)	hyp_svc
+	W(b)	hyp_pabt
+	W(b)	hyp_dabt
+	W(b)	hyp_hvc
+	W(b)	hyp_irq
+	W(b)	hyp_fiq
+
+	.align
+hyp_reset:
+	b	hyp_reset
+
+	.align
+hyp_undef:
+	bad_exception ARM_EXCEPTION_UNDEFINED, und_die_str
+
+	.align
+hyp_svc:
+	bad_exception ARM_EXCEPTION_HVC, svc_die_str
+
+	.align
+hyp_pabt:
+	bad_exception ARM_EXCEPTION_PREF_ABORT, pabt_die_str
+
+	.align
+hyp_dabt:
+	bad_exception ARM_EXCEPTION_DATA_ABORT, dabt_die_str
+
+	.align
+hyp_hvc:
+	/*
+	 * Getting here is either becuase of a trap from a guest or from calling
+	 * HVC from the host kernel, which means "switch to Hyp mode".
+	 */
+	push	{r0, r1, r2}
+
+	@ Check syndrome register
+	mrc	p15, 4, r1, c5, c2, 0	@ HSR
+	lsr	r0, r1, #HSR_EC_SHIFT
+#ifdef CONFIG_VFPv3
+	cmp	r0, #HSR_EC_CP_0_13
+	beq	switch_to_guest_vfp
+#endif
+	cmp	r0, #HSR_EC_HVC
+	bne	guest_trap		@ Not HVC instr.
+
+	/*
+	 * Let's check if the HVC came from VMID 0 and allow simple
+	 * switch to Hyp mode
+	 */
+	mrrc    p15, 6, r0, r2, c2
+	lsr     r2, r2, #16
+	and     r2, r2, #0xff
+	cmp     r2, #0
+	bne	guest_trap		@ Guest called HVC
+
+host_switch_to_hyp:
+	pop	{r0, r1, r2}
+
+	push	{lr}
+	mrs	lr, SPSR
+	push	{lr}
+
+	mov	lr, r0
+	mov	r0, r1
+	mov	r1, r2
+	mov	r2, r3
+
+THUMB(	orr	lr, #1)
+	blx	lr			@ Call the HYP function
+
+	pop	{lr}
+	msr	SPSR_csxf, lr
+	pop	{lr}
+	eret
+
+guest_trap:
+	load_vcpu			@ Load VCPU pointer to r0
+	str	r1, [vcpu, #VCPU_HSR]
+
+	@ Check if we need the fault information
+	lsr	r1, r1, #HSR_EC_SHIFT
+	cmp	r1, #HSR_EC_IABT
+	mrceq	p15, 4, r2, c6, c0, 2	@ HIFAR
+	beq	2f
+	cmp	r1, #HSR_EC_DABT
+	bne	1f
+	mrc	p15, 4, r2, c6, c0, 0	@ HDFAR
+
+2:	str	r2, [vcpu, #VCPU_HxFAR]
+
+	/*
+	 * B3.13.5 Reporting exceptions taken to the Non-secure PL2 mode:
+	 *
+	 * Abort on the stage 2 translation for a memory access from a
+	 * Non-secure PL1 or PL0 mode:
+	 *
+	 * For any Access flag fault or Translation fault, and also for any
+	 * Permission fault on the stage 2 translation of a memory access
+	 * made as part of a translation table walk for a stage 1 translation,
+	 * the HPFAR holds the IPA that caused the fault. Otherwise, the HPFAR
+	 * is UNKNOWN.
+	 */
+
+	/* Check for permission fault, and S1PTW */
+	mrc	p15, 4, r1, c5, c2, 0	@ HSR
+	and	r0, r1, #HSR_FSC_TYPE
+	cmp	r0, #FSC_PERM
+	tsteq	r1, #(1 << 7)		@ S1PTW
+	mrcne	p15, 4, r2, c6, c0, 4	@ HPFAR
+	bne	3f
+
+	/* Resolve IPA using the xFAR */
+	mcr	p15, 0, r2, c7, c8, 0	@ ATS1CPR
+	isb
+	mrrc	p15, 0, r0, r1, c7	@ PAR
+	tst	r0, #1
+	bne	4f			@ Failed translation
+	ubfx	r2, r0, #12, #20
+	lsl	r2, r2, #4
+	orr	r2, r2, r1, lsl #24
+
+3:	load_vcpu			@ Load VCPU pointer to r0
+	str	r2, [r0, #VCPU_HPFAR]
+
+1:	mov	r1, #ARM_EXCEPTION_HVC
+	b	__kvm_vcpu_return
+
+4:	pop	{r0, r1, r2}		@ Failed translation, return to guest
+	eret
+
+/*
+ * If VFPv3 support is not available, then we will not switch the VFP
+ * registers; however cp10 and cp11 accesses will still trap and fallback
+ * to the regular coprocessor emulation code, which currently will
+ * inject an undefined exception to the guest.
+ */
+#ifdef CONFIG_VFPv3
+switch_to_guest_vfp:
+	load_vcpu			@ Load VCPU pointer to r0
+	push	{r3-r7}
+
+	@ NEON/VFP used.  Turn on VFP access.
+	set_hcptr vmexit, (HCPTR_TCP(10) | HCPTR_TCP(11))
+
+	@ Switch VFP/NEON hardware state to the guest's
+	add	r7, r0, #VCPU_VFP_HOST
+	ldr	r7, [r7]
+	store_vfp_state r7
+	add	r7, r0, #VCPU_VFP_GUEST
+	restore_vfp_state r7
+
+	pop	{r3-r7}
+	pop	{r0-r2}
+	eret
+#endif
+
+	.align
+hyp_irq:
+	push	{r0, r1, r2}
+	mov	r1, #ARM_EXCEPTION_IRQ
+	load_vcpu			@ Load VCPU pointer to r0
+	b	__kvm_vcpu_return
+
+	.align
+hyp_fiq:
+	b	hyp_fiq
+
+	.ltorg
 
 __kvm_hyp_code_end:
 	.globl	__kvm_hyp_code_end
+
+	.section ".rodata"
+
+und_die_str:
+	.ascii	"unexpected undefined exception in Hyp mode at: %#08x"
+pabt_die_str:
+	.ascii	"unexpected prefetch abort in Hyp mode at: %#08x"
+dabt_die_str:
+	.ascii	"unexpected data abort in Hyp mode at: %#08x"
+svc_die_str:
+	.ascii	"unexpected HVC/SVC trap in Hyp mode at: %#08x"
diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
new file mode 100644
index 0000000..6a95d34
--- /dev/null
+++ b/arch/arm/kvm/interrupts_head.S
@@ -0,0 +1,441 @@
+#define VCPU_USR_REG(_reg_nr)	(VCPU_USR_REGS + (_reg_nr * 4))
+#define VCPU_USR_SP		(VCPU_USR_REG(13))
+#define VCPU_USR_LR		(VCPU_USR_REG(14))
+#define CP15_OFFSET(_cp15_reg_idx) (VCPU_CP15 + (_cp15_reg_idx * 4))
+
+/*
+ * Many of these macros need to access the VCPU structure, which is always
+ * held in r0. These macros should never clobber r1, as it is used to hold the
+ * exception code on the return path (except of course the macro that switches
+ * all the registers before the final jump to the VM).
+ */
+vcpu	.req	r0		@ vcpu pointer always in r0
+
+/* Clobbers {r2-r6} */
+.macro store_vfp_state vfp_base
+	@ The VFPFMRX and VFPFMXR macros are the VMRS and VMSR instructions
+	VFPFMRX	r2, FPEXC
+	@ Make sure VFP is enabled so we can touch the registers.
+	orr	r6, r2, #FPEXC_EN
+	VFPFMXR	FPEXC, r6
+
+	VFPFMRX	r3, FPSCR
+	tst	r2, #FPEXC_EX		@ Check for VFP Subarchitecture
+	beq	1f
+	@ If FPEXC_EX is 0, then FPINST/FPINST2 reads are upredictable, so
+	@ we only need to save them if FPEXC_EX is set.
+	VFPFMRX r4, FPINST
+	tst	r2, #FPEXC_FP2V
+	VFPFMRX r5, FPINST2, ne		@ vmrsne
+	bic	r6, r2, #FPEXC_EX	@ FPEXC_EX disable
+	VFPFMXR	FPEXC, r6
+1:
+	VFPFSTMIA \vfp_base, r6		@ Save VFP registers
+	stm	\vfp_base, {r2-r5}	@ Save FPEXC, FPSCR, FPINST, FPINST2
+.endm
+
+/* Assume FPEXC_EN is on and FPEXC_EX is off, clobbers {r2-r6} */
+.macro restore_vfp_state vfp_base
+	VFPFLDMIA \vfp_base, r6		@ Load VFP registers
+	ldm	\vfp_base, {r2-r5}	@ Load FPEXC, FPSCR, FPINST, FPINST2
+
+	VFPFMXR FPSCR, r3
+	tst	r2, #FPEXC_EX		@ Check for VFP Subarchitecture
+	beq	1f
+	VFPFMXR FPINST, r4
+	tst	r2, #FPEXC_FP2V
+	VFPFMXR FPINST2, r5, ne
+1:
+	VFPFMXR FPEXC, r2	@ FPEXC	(last, in case !EN)
+.endm
+
+/* These are simply for the macros to work - value don't have meaning */
+.equ usr, 0
+.equ svc, 1
+.equ abt, 2
+.equ und, 3
+.equ irq, 4
+.equ fiq, 5
+
+.macro push_host_regs_mode mode
+	mrs	r2, SP_\mode
+	mrs	r3, LR_\mode
+	mrs	r4, SPSR_\mode
+	push	{r2, r3, r4}
+.endm
+
+/*
+ * Store all host persistent registers on the stack.
+ * Clobbers all registers, in all modes, except r0 and r1.
+ */
+.macro save_host_regs
+	/* Hyp regs. Only ELR_hyp (SPSR_hyp already saved) */
+	mrs	r2, ELR_hyp
+	push	{r2}
+
+	/* usr regs */
+	push	{r4-r12}	@ r0-r3 are always clobbered
+	mrs	r2, SP_usr
+	mov	r3, lr
+	push	{r2, r3}
+
+	push_host_regs_mode svc
+	push_host_regs_mode abt
+	push_host_regs_mode und
+	push_host_regs_mode irq
+
+	/* fiq regs */
+	mrs	r2, r8_fiq
+	mrs	r3, r9_fiq
+	mrs	r4, r10_fiq
+	mrs	r5, r11_fiq
+	mrs	r6, r12_fiq
+	mrs	r7, SP_fiq
+	mrs	r8, LR_fiq
+	mrs	r9, SPSR_fiq
+	push	{r2-r9}
+.endm
+
+.macro pop_host_regs_mode mode
+	pop	{r2, r3, r4}
+	msr	SP_\mode, r2
+	msr	LR_\mode, r3
+	msr	SPSR_\mode, r4
+.endm
+
+/*
+ * Restore all host registers from the stack.
+ * Clobbers all registers, in all modes, except r0 and r1.
+ */
+.macro restore_host_regs
+	pop	{r2-r9}
+	msr	r8_fiq, r2
+	msr	r9_fiq, r3
+	msr	r10_fiq, r4
+	msr	r11_fiq, r5
+	msr	r12_fiq, r6
+	msr	SP_fiq, r7
+	msr	LR_fiq, r8
+	msr	SPSR_fiq, r9
+
+	pop_host_regs_mode irq
+	pop_host_regs_mode und
+	pop_host_regs_mode abt
+	pop_host_regs_mode svc
+
+	pop	{r2, r3}
+	msr	SP_usr, r2
+	mov	lr, r3
+	pop	{r4-r12}
+
+	pop	{r2}
+	msr	ELR_hyp, r2
+.endm
+
+/*
+ * Restore SP, LR and SPSR for a given mode. offset is the offset of
+ * this mode's registers from the VCPU base.
+ *
+ * Assumes vcpu pointer in vcpu reg
+ *
+ * Clobbers r1, r2, r3, r4.
+ */
+.macro restore_guest_regs_mode mode, offset
+	add	r1, vcpu, \offset
+	ldm	r1, {r2, r3, r4}
+	msr	SP_\mode, r2
+	msr	LR_\mode, r3
+	msr	SPSR_\mode, r4
+.endm
+
+/*
+ * Restore all guest registers from the vcpu struct.
+ *
+ * Assumes vcpu pointer in vcpu reg
+ *
+ * Clobbers *all* registers.
+ */
+.macro restore_guest_regs
+	restore_guest_regs_mode svc, #VCPU_SVC_REGS
+	restore_guest_regs_mode abt, #VCPU_ABT_REGS
+	restore_guest_regs_mode und, #VCPU_UND_REGS
+	restore_guest_regs_mode irq, #VCPU_IRQ_REGS
+
+	add	r1, vcpu, #VCPU_FIQ_REGS
+	ldm	r1, {r2-r9}
+	msr	r8_fiq, r2
+	msr	r9_fiq, r3
+	msr	r10_fiq, r4
+	msr	r11_fiq, r5
+	msr	r12_fiq, r6
+	msr	SP_fiq, r7
+	msr	LR_fiq, r8
+	msr	SPSR_fiq, r9
+
+	@ Load return state
+	ldr	r2, [vcpu, #VCPU_PC]
+	ldr	r3, [vcpu, #VCPU_CPSR]
+	msr	ELR_hyp, r2
+	msr	SPSR_cxsf, r3
+
+	@ Load user registers
+	ldr	r2, [vcpu, #VCPU_USR_SP]
+	ldr	r3, [vcpu, #VCPU_USR_LR]
+	msr	SP_usr, r2
+	mov	lr, r3
+	add	vcpu, vcpu, #(VCPU_USR_REGS)
+	ldm	vcpu, {r0-r12}
+.endm
+
+/*
+ * Save SP, LR and SPSR for a given mode. offset is the offset of
+ * this mode's registers from the VCPU base.
+ *
+ * Assumes vcpu pointer in vcpu reg
+ *
+ * Clobbers r2, r3, r4, r5.
+ */
+.macro save_guest_regs_mode mode, offset
+	add	r2, vcpu, \offset
+	mrs	r3, SP_\mode
+	mrs	r4, LR_\mode
+	mrs	r5, SPSR_\mode
+	stm	r2, {r3, r4, r5}
+.endm
+
+/*
+ * Save all guest registers to the vcpu struct
+ * Expects guest's r0, r1, r2 on the stack.
+ *
+ * Assumes vcpu pointer in vcpu reg
+ *
+ * Clobbers r2, r3, r4, r5.
+ */
+.macro save_guest_regs
+	@ Store usr registers
+	add	r2, vcpu, #VCPU_USR_REG(3)
+	stm	r2, {r3-r12}
+	add	r2, vcpu, #VCPU_USR_REG(0)
+	pop	{r3, r4, r5}		@ r0, r1, r2
+	stm	r2, {r3, r4, r5}
+	mrs	r2, SP_usr
+	mov	r3, lr
+	str	r2, [vcpu, #VCPU_USR_SP]
+	str	r3, [vcpu, #VCPU_USR_LR]
+
+	@ Store return state
+	mrs	r2, ELR_hyp
+	mrs	r3, spsr
+	str	r2, [vcpu, #VCPU_PC]
+	str	r3, [vcpu, #VCPU_CPSR]
+
+	@ Store other guest registers
+	save_guest_regs_mode svc, #VCPU_SVC_REGS
+	save_guest_regs_mode abt, #VCPU_ABT_REGS
+	save_guest_regs_mode und, #VCPU_UND_REGS
+	save_guest_regs_mode irq, #VCPU_IRQ_REGS
+.endm
+
+/* Reads cp15 registers from hardware and stores them in memory
+ * @store_to_vcpu: If 0, registers are written in-order to the stack,
+ * 		   otherwise to the VCPU struct pointed to by vcpup
+ *
+ * Assumes vcpu pointer in vcpu reg
+ *
+ * Clobbers r2 - r12
+ */
+.macro read_cp15_state store_to_vcpu
+	mrc	p15, 0, r2, c1, c0, 0	@ SCTLR
+	mrc	p15, 0, r3, c1, c0, 2	@ CPACR
+	mrc	p15, 0, r4, c2, c0, 2	@ TTBCR
+	mrc	p15, 0, r5, c3, c0, 0	@ DACR
+	mrrc	p15, 0, r6, r7, c2	@ TTBR 0
+	mrrc	p15, 1, r8, r9, c2	@ TTBR 1
+	mrc	p15, 0, r10, c10, c2, 0	@ PRRR
+	mrc	p15, 0, r11, c10, c2, 1	@ NMRR
+	mrc	p15, 2, r12, c0, c0, 0	@ CSSELR
+
+	.if \store_to_vcpu == 0
+	push	{r2-r12}		@ Push CP15 registers
+	.else
+	str	r2, [vcpu, #CP15_OFFSET(c1_SCTLR)]
+	str	r3, [vcpu, #CP15_OFFSET(c1_CPACR)]
+	str	r4, [vcpu, #CP15_OFFSET(c2_TTBCR)]
+	str	r5, [vcpu, #CP15_OFFSET(c3_DACR)]
+	add	r2, vcpu, #CP15_OFFSET(c2_TTBR0)
+	strd	r6, r7, [r2]
+	add	r2, vcpu, #CP15_OFFSET(c2_TTBR1)
+	strd	r8, r9, [r2]
+	str	r10, [vcpu, #CP15_OFFSET(c10_PRRR)]
+	str	r11, [vcpu, #CP15_OFFSET(c10_NMRR)]
+	str	r12, [vcpu, #CP15_OFFSET(c0_CSSELR)]
+	.endif
+
+	mrc	p15, 0, r2, c13, c0, 1	@ CID
+	mrc	p15, 0, r3, c13, c0, 2	@ TID_URW
+	mrc	p15, 0, r4, c13, c0, 3	@ TID_URO
+	mrc	p15, 0, r5, c13, c0, 4	@ TID_PRIV
+	mrc	p15, 0, r6, c5, c0, 0	@ DFSR
+	mrc	p15, 0, r7, c5, c0, 1	@ IFSR
+	mrc	p15, 0, r8, c5, c1, 0	@ ADFSR
+	mrc	p15, 0, r9, c5, c1, 1	@ AIFSR
+	mrc	p15, 0, r10, c6, c0, 0	@ DFAR
+	mrc	p15, 0, r11, c6, c0, 2	@ IFAR
+	mrc	p15, 0, r12, c12, c0, 0	@ VBAR
+
+	.if \store_to_vcpu == 0
+	push	{r2-r12}		@ Push CP15 registers
+	.else
+	str	r2, [vcpu, #CP15_OFFSET(c13_CID)]
+	str	r3, [vcpu, #CP15_OFFSET(c13_TID_URW)]
+	str	r4, [vcpu, #CP15_OFFSET(c13_TID_URO)]
+	str	r5, [vcpu, #CP15_OFFSET(c13_TID_PRIV)]
+	str	r6, [vcpu, #CP15_OFFSET(c5_DFSR)]
+	str	r7, [vcpu, #CP15_OFFSET(c5_IFSR)]
+	str	r8, [vcpu, #CP15_OFFSET(c5_ADFSR)]
+	str	r9, [vcpu, #CP15_OFFSET(c5_AIFSR)]
+	str	r10, [vcpu, #CP15_OFFSET(c6_DFAR)]
+	str	r11, [vcpu, #CP15_OFFSET(c6_IFAR)]
+	str	r12, [vcpu, #CP15_OFFSET(c12_VBAR)]
+	.endif
+.endm
+
+/*
+ * Reads cp15 registers from memory and writes them to hardware
+ * @read_from_vcpu: If 0, registers are read in-order from the stack,
+ *		    otherwise from the VCPU struct pointed to by vcpup
+ *
+ * Assumes vcpu pointer in vcpu reg
+ */
+.macro write_cp15_state read_from_vcpu
+	.if \read_from_vcpu == 0
+	pop	{r2-r12}
+	.else
+	ldr	r2, [vcpu, #CP15_OFFSET(c13_CID)]
+	ldr	r3, [vcpu, #CP15_OFFSET(c13_TID_URW)]
+	ldr	r4, [vcpu, #CP15_OFFSET(c13_TID_URO)]
+	ldr	r5, [vcpu, #CP15_OFFSET(c13_TID_PRIV)]
+	ldr	r6, [vcpu, #CP15_OFFSET(c5_DFSR)]
+	ldr	r7, [vcpu, #CP15_OFFSET(c5_IFSR)]
+	ldr	r8, [vcpu, #CP15_OFFSET(c5_ADFSR)]
+	ldr	r9, [vcpu, #CP15_OFFSET(c5_AIFSR)]
+	ldr	r10, [vcpu, #CP15_OFFSET(c6_DFAR)]
+	ldr	r11, [vcpu, #CP15_OFFSET(c6_IFAR)]
+	ldr	r12, [vcpu, #CP15_OFFSET(c12_VBAR)]
+	.endif
+
+	mcr	p15, 0, r2, c13, c0, 1	@ CID
+	mcr	p15, 0, r3, c13, c0, 2	@ TID_URW
+	mcr	p15, 0, r4, c13, c0, 3	@ TID_URO
+	mcr	p15, 0, r5, c13, c0, 4	@ TID_PRIV
+	mcr	p15, 0, r6, c5, c0, 0	@ DFSR
+	mcr	p15, 0, r7, c5, c0, 1	@ IFSR
+	mcr	p15, 0, r8, c5, c1, 0	@ ADFSR
+	mcr	p15, 0, r9, c5, c1, 1	@ AIFSR
+	mcr	p15, 0, r10, c6, c0, 0	@ DFAR
+	mcr	p15, 0, r11, c6, c0, 2	@ IFAR
+	mcr	p15, 0, r12, c12, c0, 0	@ VBAR
+
+	.if \read_from_vcpu == 0
+	pop	{r2-r12}
+	.else
+	ldr	r2, [vcpu, #CP15_OFFSET(c1_SCTLR)]
+	ldr	r3, [vcpu, #CP15_OFFSET(c1_CPACR)]
+	ldr	r4, [vcpu, #CP15_OFFSET(c2_TTBCR)]
+	ldr	r5, [vcpu, #CP15_OFFSET(c3_DACR)]
+	add	r12, vcpu, #CP15_OFFSET(c2_TTBR0)
+	ldrd	r6, r7, [r12]
+	add	r12, vcpu, #CP15_OFFSET(c2_TTBR1)
+	ldrd	r8, r9, [r12]
+	ldr	r10, [vcpu, #CP15_OFFSET(c10_PRRR)]
+	ldr	r11, [vcpu, #CP15_OFFSET(c10_NMRR)]
+	ldr	r12, [vcpu, #CP15_OFFSET(c0_CSSELR)]
+	.endif
+
+	mcr	p15, 0, r2, c1, c0, 0	@ SCTLR
+	mcr	p15, 0, r3, c1, c0, 2	@ CPACR
+	mcr	p15, 0, r4, c2, c0, 2	@ TTBCR
+	mcr	p15, 0, r5, c3, c0, 0	@ DACR
+	mcrr	p15, 0, r6, r7, c2	@ TTBR 0
+	mcrr	p15, 1, r8, r9, c2	@ TTBR 1
+	mcr	p15, 0, r10, c10, c2, 0	@ PRRR
+	mcr	p15, 0, r11, c10, c2, 1	@ NMRR
+	mcr	p15, 2, r12, c0, c0, 0	@ CSSELR
+.endm
+
+/*
+ * Save the VGIC CPU state into memory
+ *
+ * Assumes vcpu pointer in vcpu reg
+ */
+.macro save_vgic_state
+.endm
+
+/*
+ * Restore the VGIC CPU state from memory
+ *
+ * Assumes vcpu pointer in vcpu reg
+ */
+.macro restore_vgic_state
+.endm
+
+.equ vmentry,	0
+.equ vmexit,	1
+
+/* Configures the HSTR (Hyp System Trap Register) on entry/return
+ * (hardware reset value is 0) */
+.macro set_hstr operation
+	mrc	p15, 4, r2, c1, c1, 3
+	ldr	r3, =HSTR_T(15)
+	.if \operation == vmentry
+	orr	r2, r2, r3		@ Trap CR{15}
+	.else
+	bic	r2, r2, r3		@ Don't trap any CRx accesses
+	.endif
+	mcr	p15, 4, r2, c1, c1, 3
+.endm
+
+/* Configures the HCPTR (Hyp Coprocessor Trap Register) on entry/return
+ * (hardware reset value is 0). Keep previous value in r2. */
+.macro set_hcptr operation, mask
+	mrc	p15, 4, r2, c1, c1, 2
+	ldr	r3, =\mask
+	.if \operation == vmentry
+	orr	r3, r2, r3		@ Trap coproc-accesses defined in mask
+	.else
+	bic	r3, r2, r3		@ Don't trap defined coproc-accesses
+	.endif
+	mcr	p15, 4, r3, c1, c1, 2
+.endm
+
+/* Configures the HDCR (Hyp Debug Configuration Register) on entry/return
+ * (hardware reset value is 0) */
+.macro set_hdcr operation
+	mrc	p15, 4, r2, c1, c1, 1
+	ldr	r3, =(HDCR_TPM|HDCR_TPMCR)
+	.if \operation == vmentry
+	orr	r2, r2, r3		@ Trap some perfmon accesses
+	.else
+	bic	r2, r2, r3		@ Don't trap any perfmon accesses
+	.endif
+	mcr	p15, 4, r2, c1, c1, 1
+.endm
+
+/* Enable/Disable: stage-2 trans., trap interrupts, trap wfi, trap smc */
+.macro configure_hyp_role operation
+	mrc	p15, 4, r2, c1, c1, 0	@ HCR
+	bic	r2, r2, #HCR_VIRT_EXCP_MASK
+	ldr	r3, =HCR_GUEST_MASK
+	.if \operation == vmentry
+	orr	r2, r2, r3
+	ldr	r3, [vcpu, #VCPU_IRQ_LINES]
+	orr	r2, r2, r3
+	.else
+	bic	r2, r2, r3
+	.endif
+	mcr	p15, 4, r2, c1, c1, 0
+.endm
+
+.macro load_vcpu
+	mrc	p15, 4, vcpu, c13, c0, 2	@ HTPIDR
+.endm
