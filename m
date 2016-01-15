From: geoff@infradead.org (Geoff Levand)
Date: Fri, 15 Jan 2016 19:18:38 +0000
Subject: [PATCH 10/19] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <cover.1452884156.git.geoff@infradead.org>
References: <cover.1452884156.git.geoff@infradead.org>
Message-ID: <ab2ffead6b80df7e0676bc7383c1183c1e50453f.1452884156.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

The current kvm implementation on arm64 does cpu-specific initialization
at system boot, and has no way to gracefully shutdown a core in terms of
kvm. This prevents, especially, kexec from rebooting the system on a boot
core in EL2.

This patch adds a cpu tear-down function and also puts an existing cpu-init
code into a separate function, kvm_arch_hardware_disable() and
kvm_arch_hardware_enable() respectively.
We don't need arm64-specific cpu hotplug hook any more.

Since this patch modifies common part of code between arm and arm64, one
stub definition, __cpu_reset_hyp_mode(), is added on arm side to avoid
compiling errors.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm/include/asm/kvm_host.h   | 10 ++++-
 arch/arm/include/asm/kvm_mmu.h    |  1 +
 arch/arm/kvm/arm.c                | 93 +++++++++++++++++++++++----------------
 arch/arm/kvm/mmu.c                |  5 +++
 arch/arm64/include/asm/kvm_host.h | 11 ++++-
 arch/arm64/include/asm/kvm_mmu.h  |  1 +
 arch/arm64/include/asm/virt.h     |  9 ++++
 arch/arm64/kvm/hyp-init.S         | 33 ++++++++++++++
 arch/arm64/kvm/hyp.S              | 32 ++++++++++++--
 9 files changed, 151 insertions(+), 44 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 6692982..9242765 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -214,6 +214,15 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 	kvm_call_hyp((void*)hyp_stack_ptr, vector_ptr, pgd_ptr);
 }
 
+static inline void __cpu_reset_hyp_mode(phys_addr_t boot_pgd_ptr,
+					phys_addr_t phys_idmap_start)
+{
+	/*
+	 * TODO
+	 * kvm_call_reset(boot_pgd_ptr, phys_idmap_start);
+	 */
+}
+
 static inline int kvm_arch_dev_ioctl_check_extension(long ext)
 {
 	return 0;
@@ -226,7 +235,6 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
 
-static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 405aa18..dc6fadf 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -66,6 +66,7 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_mmu_get_boot_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
+phys_addr_t kvm_get_idmap_start(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index e06fd29..e91f80e 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -16,7 +16,6 @@
  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 
-#include <linux/cpu.h>
 #include <linux/cpu_pm.h>
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -61,6 +60,8 @@ static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
 static u8 kvm_next_vmid;
 static DEFINE_SPINLOCK(kvm_vmid_lock);
 
+static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
+
 static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
 {
 	BUG_ON(preemptible());
@@ -85,11 +86,6 @@ struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void)
 	return &kvm_arm_running_vcpu;
 }
 
-int kvm_arch_hardware_enable(void)
-{
-	return 0;
-}
-
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
@@ -577,7 +573,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		/*
 		 * Re-check atomic conditions
 		 */
-		if (signal_pending(current)) {
+		if (unlikely(!__this_cpu_read(kvm_arm_hardware_enabled))) {
+			/* cpu has been torn down */
+			ret = 0;
+			run->exit_reason = KVM_EXIT_FAIL_ENTRY;
+			run->fail_entry.hardware_entry_failure_reason
+					= (u64)-ENOEXEC;
+		} else if (signal_pending(current)) {
 			ret = -EINTR;
 			run->exit_reason = KVM_EXIT_INTR;
 		}
@@ -954,7 +956,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	}
 }
 
-static void cpu_init_hyp_mode(void *dummy)
+static void cpu_init_hyp_mode(void)
 {
 	phys_addr_t boot_pgd_ptr;
 	phys_addr_t pgd_ptr;
@@ -976,36 +978,56 @@ static void cpu_init_hyp_mode(void *dummy)
 	kvm_arm_init_debug();
 }
 
-static int hyp_init_cpu_notify(struct notifier_block *self,
-			       unsigned long action, void *cpu)
+static void cpu_reset_hyp_mode(void)
 {
-	switch (action) {
-	case CPU_STARTING:
-	case CPU_STARTING_FROZEN:
-		if (__hyp_get_vectors() == hyp_default_vectors)
-			cpu_init_hyp_mode(NULL);
-		break;
+	phys_addr_t boot_pgd_ptr;
+	phys_addr_t phys_idmap_start;
+
+	boot_pgd_ptr = kvm_mmu_get_boot_httbr();
+	phys_idmap_start = kvm_get_idmap_start();
+
+	__cpu_reset_hyp_mode(boot_pgd_ptr, phys_idmap_start);
+}
+
+int kvm_arch_hardware_enable(void)
+{
+	if (!__this_cpu_read(kvm_arm_hardware_enabled)) {
+		cpu_init_hyp_mode();
+		__this_cpu_write(kvm_arm_hardware_enabled, 1);
 	}
 
-	return NOTIFY_OK;
+	return 0;
 }
 
-static struct notifier_block hyp_init_cpu_nb = {
-	.notifier_call = hyp_init_cpu_notify,
-};
+void kvm_arch_hardware_disable(void)
+{
+	if (!__this_cpu_read(kvm_arm_hardware_enabled))
+		return;
+
+	cpu_reset_hyp_mode();
+	__this_cpu_write(kvm_arm_hardware_enabled, 0);
+}
 
 #ifdef CONFIG_CPU_PM
 static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
 				    unsigned long cmd,
 				    void *v)
 {
-	if (cmd == CPU_PM_EXIT &&
-	    __hyp_get_vectors() == hyp_default_vectors) {
-		cpu_init_hyp_mode(NULL);
+	switch (cmd) {
+	case CPU_PM_ENTER:
+		if (__this_cpu_read(kvm_arm_hardware_enabled))
+			cpu_reset_hyp_mode();
+
 		return NOTIFY_OK;
-	}
+	case CPU_PM_EXIT:
+		if (__this_cpu_read(kvm_arm_hardware_enabled))
+			cpu_init_hyp_mode();
 
-	return NOTIFY_DONE;
+		return NOTIFY_OK;
+
+	default:
+		return NOTIFY_DONE;
+	}
 }
 
 static struct notifier_block hyp_init_cpu_pm_nb = {
@@ -1103,14 +1125,20 @@ static int init_hyp_mode(void)
 	}
 
 	/*
-	 * Execute the init code on each CPU.
+	 * Init this CPU temporarily to execute kvm_hyp_call()
+	 * during kvm_vgic_hyp_init().
 	 */
-	on_each_cpu(cpu_init_hyp_mode, NULL, 1);
+	preempt_disable();
+	cpu_init_hyp_mode();
 
 	/*
 	 * Init HYP view of VGIC
 	 */
 	err = kvm_vgic_hyp_init();
+
+	cpu_reset_hyp_mode();
+	preempt_enable();
+
 	if (err)
 		goto out_free_context;
 
@@ -1181,26 +1209,15 @@ int kvm_arch_init(void *opaque)
 		}
 	}
 
-	cpu_notifier_register_begin();
-
 	err = init_hyp_mode();
 	if (err)
 		goto out_err;
 
-	err = __register_cpu_notifier(&hyp_init_cpu_nb);
-	if (err) {
-		kvm_err("Cannot register HYP init CPU notifier (%d)\n", err);
-		goto out_err;
-	}
-
-	cpu_notifier_register_done();
-
 	hyp_cpu_pm_init();
 
 	kvm_coproc_table_init();
 	return 0;
 out_err:
-	cpu_notifier_register_done();
 	return err;
 }
 
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 61d96a6..e6651dd 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1643,6 +1643,11 @@ phys_addr_t kvm_get_idmap_vector(void)
 	return hyp_idmap_vector;
 }
 
+phys_addr_t kvm_get_idmap_start(void)
+{
+	return hyp_idmap_start;
+}
+
 int kvm_mmu_init(void)
 {
 	int err;
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a35ce72..de08e4c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -223,6 +223,7 @@ struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
 struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void);
 
 u64 kvm_call_hyp(void *hypfn, ...);
+void kvm_call_reset(phys_addr_t boot_pgd_ptr, phys_addr_t phys_idmap_start);
 void force_vm_exit(const cpumask_t *mask);
 void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
@@ -247,7 +248,15 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 		     hyp_stack_ptr, vector_ptr);
 }
 
-static inline void kvm_arch_hardware_disable(void) {}
+static inline void __cpu_reset_hyp_mode(phys_addr_t boot_pgd_ptr,
+					phys_addr_t phys_idmap_start)
+{
+	/*
+	 * Call reset code, and switch back to stub hyp vectors.
+	 */
+	kvm_call_reset(boot_pgd_ptr, phys_idmap_start);
+}
+
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 6150567..ff5a087 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -98,6 +98,7 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_mmu_get_boot_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
+phys_addr_t kvm_get_idmap_start(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 3070096..bca79f9 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -58,9 +58,18 @@
 
 #define HVC_CALL_FUNC 3
 
+/*
+ * HVC_RESET_CPU - Reset cpu in EL2 to initial state.
+ *
+ * @x0: entry address in trampoline code in va
+ * @x1: identical mapping page table in pa
+ */
+
 #define BOOT_CPU_MODE_EL1	(0xe11)
 #define BOOT_CPU_MODE_EL2	(0xe12)
 
+#define HVC_RESET_CPU 4
+
 #ifndef __ASSEMBLY__
 
 /*
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 1d7e502..d909ce2 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -140,6 +140,39 @@ merged:
 	eret
 ENDPROC(__kvm_hyp_init)
 
+	/*
+	 * x0: HYP boot pgd
+	 * x1: HYP phys_idmap_start
+	 */
+ENTRY(__kvm_hyp_reset)
+	/* We're in trampoline code in VA, switch back to boot page tables */
+	msr	ttbr0_el2, x0
+	isb
+
+	/* Invalidate the old TLBs */
+	tlbi	alle2
+	dsb	sy
+
+	/* Branch into PA space */
+	adr	x0, 1f
+	bfi	x1, x0, #0, #PAGE_SHIFT
+	br	x1
+
+	/* We're now in idmap, disable MMU */
+1:	mrs	x0, sctlr_el2
+	ldr	x1, =SCTLR_ELx_FLAGS
+	bic	x0, x0, x1		// Clear SCTL_M and etc
+	msr	sctlr_el2, x0
+	isb
+
+	/* Install stub vectors */
+	adrp	x0, __hyp_stub_vectors
+	add	x0, x0, #:lo12:__hyp_stub_vectors
+	msr	vbar_el2, x0
+
+	eret
+ENDPROC(__kvm_hyp_reset)
+
 	.ltorg
 
 	.popsection
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 15b1ef9..ed82dc2 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -943,6 +943,11 @@ ENTRY(kvm_call_hyp)
 	ret
 ENDPROC(kvm_call_hyp)
 
+ENTRY(kvm_call_reset)
+	hvc	#HVC_RESET_CPU
+	ret
+ENDPROC(kvm_call_reset)
+
 .macro invalid_vector	label, target
 	.align	2
 \label:
@@ -986,10 +991,27 @@ el1_sync:					// Guest trapped into EL2
 	cmp	x18, #HVC_GET_VECTORS
 	b.ne	1f
 	mrs	x0, vbar_el2
-	b	2f
-
-1:	/* Default to HVC_CALL_HYP. */
+	b	do_eret
 
+	/* jump into trampoline code */
+1:	cmp	x18, #HVC_RESET_CPU
+	b.ne	2f
+	/*
+	 * Entry point is:
+	 *	TRAMPOLINE_VA
+	 *	+ (__kvm_hyp_reset - (__hyp_idmap_text_start & PAGE_MASK))
+	 */
+	adrp	x2, __kvm_hyp_reset
+	add	x2, x2, #:lo12:__kvm_hyp_reset
+	adrp	x3, __hyp_idmap_text_start
+	add	x3, x3, #:lo12:__hyp_idmap_text_start
+	and	x3, x3, PAGE_MASK
+	sub	x2, x2, x3
+	ldr	x3, =TRAMPOLINE_VA
+	add	x2, x2, x3
+	br	x2				// no return
+
+2:	/* Default to HVC_CALL_HYP. */
 	push	lr, xzr
 
 	/*
@@ -1003,7 +1025,9 @@ el1_sync:					// Guest trapped into EL2
 	blr	lr
 
 	pop	lr, xzr
-2:	eret
+
+do_eret:
+	eret
 
 el1_trap:
 	/*
-- 
2.5.0
