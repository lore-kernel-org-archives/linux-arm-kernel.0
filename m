From: geoff@infradead.org (Geoff Levand)
Date: Fri, 04 Mar 2016 23:51:14 +0000
Subject: [PATCH v14 05/20] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <cover.1457135058.git.geoff@infradead.org>
References: <cover.1457135058.git.geoff@infradead.org>
Message-ID: <89b75e7bb9abd3fe62ff74b090cfc7794feb2375.1457135058.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

The current kvm implementation on arm64 does cpu-specific initialization
at system boot, and has no way to gracefully shutdown a core in terms of
kvm. This prevents kexec from rebooting the system at EL2.

This patch adds a cpu tear-down function and also puts an existing cpu-init
code into a separate function, kvm_arch_hardware_disable() and
kvm_arch_hardware_enable() respectively.
We don't need the arm64 specific cpu hotplug hook any more.

Since this patch modifies common code between arm and arm64, one stub
definition, __cpu_reset_hyp_mode(), is added on arm side to avoid
compilation errors.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
[Moved __kvm_hyp_reset() to use kvm_call_hyp(), instead of having its own
 dedicated entry point in el1_sync. Added some comments and a tlbi.]
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm/include/asm/kvm_host.h   |  10 +++-
 arch/arm/include/asm/kvm_mmu.h    |   1 +
 arch/arm/kvm/arm.c                | 104 ++++++++++++++++++++++++--------------
 arch/arm/kvm/mmu.c                |   5 ++
 arch/arm64/include/asm/kvm_asm.h  |   1 +
 arch/arm64/include/asm/kvm_host.h |  12 ++++-
 arch/arm64/include/asm/kvm_mmu.h  |   1 +
 arch/arm64/kvm/hyp-init.S         |  42 +++++++++++++++
 arch/arm64/kvm/reset.c            |  14 +++++
 9 files changed, 150 insertions(+), 40 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index f9f2779..8af531d 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -220,6 +220,15 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
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
@@ -232,7 +241,6 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
 
-static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index a520b79..4fd9ddb 100644
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
index dda1959..0aad49f 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -16,7 +16,6 @@
  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 
-#include <linux/cpu.h>
 #include <linux/cpu_pm.h>
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -65,6 +64,8 @@ static DEFINE_SPINLOCK(kvm_vmid_lock);
 
 static bool vgic_present;
 
+static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
+
 static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
 {
 	BUG_ON(preemptible());
@@ -89,11 +90,6 @@ struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void)
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
@@ -585,7 +581,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
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
@@ -967,7 +969,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	}
 }
 
-static void cpu_init_hyp_mode(void *dummy)
+static void cpu_init_hyp_mode(void)
 {
 	phys_addr_t boot_pgd_ptr;
 	phys_addr_t pgd_ptr;
@@ -989,36 +991,67 @@ static void cpu_init_hyp_mode(void *dummy)
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
+	/*
+	 * kvm_arm_hardware_enabled is left with its old value over
+	 * PM_ENTER->PM_EXIT. It is used to indicate PM_EXIT should
+	 * re-enable hyp.
+	 */
+	switch (cmd) {
+	case CPU_PM_ENTER:
+		if (__this_cpu_read(kvm_arm_hardware_enabled))
+			/*
+			 * don't update kvm_arm_hardware_enabled here
+			 * so that the hardware will be re-enabled
+			 * when we resume. See below.
+			 */
+			cpu_reset_hyp_mode();
+
+		return NOTIFY_OK;
+	case CPU_PM_EXIT:
+		if (__this_cpu_read(kvm_arm_hardware_enabled))
+			/* The hardware was enabled before suspend. */
+			cpu_init_hyp_mode();
+
 		return NOTIFY_OK;
-	}
 
-	return NOTIFY_DONE;
+	default:
+		return NOTIFY_DONE;
+	}
 }
 
 static struct notifier_block hyp_init_cpu_pm_nb = {
@@ -1122,14 +1155,20 @@ static int init_hyp_mode(void)
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
 	switch (err) {
 	case 0:
 		vgic_present = true;
@@ -1213,26 +1252,15 @@ int kvm_arch_init(void *opaque)
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
index aba61fd..7a3aed6 100644
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
diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 52b777b..4191d12 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -32,6 +32,7 @@ struct kvm_vcpu;
 
 extern char __kvm_hyp_init[];
 extern char __kvm_hyp_init_end[];
+extern char __kvm_hyp_reset[];
 
 extern char __kvm_hyp_vector[];
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 689d4c9..b218211 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -44,6 +44,7 @@
 int __attribute_const__ kvm_target_cpu(void);
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
 int kvm_arch_dev_ioctl_check_extension(long ext);
+phys_addr_t kvm_hyp_reset_entry(void);
 
 struct kvm_arch {
 	/* The VMID generation used for the virt. memory system */
@@ -332,7 +333,16 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 		     hyp_stack_ptr, vector_ptr);
 }
 
-static inline void kvm_arch_hardware_disable(void) {}
+static inline void __cpu_reset_hyp_mode(phys_addr_t boot_pgd_ptr,
+					phys_addr_t phys_idmap_start)
+{
+	/*
+	 * Call reset code, and switch back to stub hyp vectors.
+	 */
+	kvm_call_hyp((void *)kvm_hyp_reset_entry(),
+		     boot_pgd_ptr, phys_idmap_start);
+}
+
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 7364339..7ee6824 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -99,6 +99,7 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_mmu_get_boot_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
+phys_addr_t kvm_get_idmap_start(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 034d152c..a19a7ef 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -152,6 +152,48 @@ merged:
 	eret
 ENDPROC(__kvm_hyp_init)
 
+	/*
+	 * x0: HYP boot pgd
+	 * x1: HYP phys_idmap_start
+	 */
+ENTRY(__kvm_hyp_reset)
+	/*
+	 * Retrieve lr from the stack (pushed by el1_sync()), so we can eret
+	 * from here.
+	 */
+	ldp	lr, xzr, [sp], #16
+
+	/* We're in trampoline code in VA, switch back to boot page tables */
+	msr	ttbr0_el2, x0
+	isb
+
+	/* Ensure the PA branch doesn't find a stale tlb entry. */
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
+	/* Invalidate the old TLBs */
+	tlbi	alle2
+	dsb	sy
+
+	/* Install stub vectors */
+	adr_l	x0, __hyp_stub_vectors
+	msr	vbar_el2, x0
+
+	eret
+ENDPROC(__kvm_hyp_reset)
+
 	.ltorg
 
 	.popsection
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index f34745c..d6e155a 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -29,7 +29,9 @@
 #include <asm/cputype.h>
 #include <asm/ptrace.h>
 #include <asm/kvm_arm.h>
+#include <asm/kvm_asm.h>
 #include <asm/kvm_coproc.h>
+#include <asm/kvm_mmu.h>
 
 /*
  * ARMv8 Reset Values
@@ -123,3 +125,15 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	/* Reset timer */
 	return kvm_timer_vcpu_reset(vcpu, cpu_vtimer_irq);
 }
+
+extern char __hyp_idmap_text_start[];
+
+phys_addr_t kvm_hyp_reset_entry(void)
+{
+	unsigned long offset;
+
+	offset = (unsigned long)__kvm_hyp_reset
+		 - ((unsigned long)__hyp_idmap_text_start & PAGE_MASK);
+
+	return TRAMPOLINE_VA + offset;
+}
-- 
2.5.0
