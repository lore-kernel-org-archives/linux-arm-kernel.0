From: geoff@infradead.org (Geoff Levand)
Date: Thu, 14 Apr 2016 21:21:37 +0000
Subject: [PATCH v16 06/20] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <cover.1460668521.git.geoff@infradead.org>
References: <cover.1460668521.git.geoff@infradead.org>
Message-ID: <9549c321700e68e7aa3e16ae3c9f5fd4e4936d06.1460668521.git.geoff@infradead.org>
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
[Rebase, added separate VHE init/exit path, changed resets use of
 kvm_call_hyp() to the __version, en/disabled hardware in init_subsystems(),
 added icache maintenance to __kvm_hyp_reset() and removed lr restore]
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm/include/asm/kvm_host.h   |  10 ++-
 arch/arm/include/asm/kvm_mmu.h    |   1 +
 arch/arm/kvm/arm.c                | 128 +++++++++++++++++++++++---------------
 arch/arm/kvm/mmu.c                |   5 ++
 arch/arm64/include/asm/kvm_asm.h  |   1 +
 arch/arm64/include/asm/kvm_host.h |  13 +++-
 arch/arm64/include/asm/kvm_mmu.h  |   1 +
 arch/arm64/kvm/hyp-init.S         |  38 +++++++++++
 arch/arm64/kvm/reset.c            |  14 +++++
 9 files changed, 158 insertions(+), 53 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 3850701..738d5ee 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -265,6 +265,15 @@ static inline void __cpu_init_stage2(void)
 	kvm_call_hyp(__init_stage2_translation);
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
@@ -277,7 +286,6 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
 
-static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index da44be9..f17a8d4 100644
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
index b538431..962904a 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -16,7 +16,6 @@
  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 
-#include <linux/cpu.h>
 #include <linux/cpu_pm.h>
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -66,6 +65,8 @@ static DEFINE_SPINLOCK(kvm_vmid_lock);
 
 static bool vgic_present;
 
+static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
+
 static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
 {
 	BUG_ON(preemptible());
@@ -90,11 +91,6 @@ struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void)
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
@@ -591,7 +587,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
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
@@ -1033,11 +1035,6 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	}
 }
 
-static void cpu_init_stage2(void *dummy)
-{
-	__cpu_init_stage2();
-}
-
 static void cpu_init_hyp_mode(void *dummy)
 {
 	phys_addr_t boot_pgd_ptr;
@@ -1065,43 +1062,87 @@ static void cpu_hyp_reinit(void)
 {
 	if (is_kernel_in_hyp_mode()) {
 		/*
-		 * cpu_init_stage2() is safe to call even if the PM
+		 * __cpu_init_stage2() is safe to call even if the PM
 		 * event was cancelled before the CPU was reset.
 		 */
-		cpu_init_stage2(NULL);
+		__cpu_init_stage2();
 	} else {
 		if (__hyp_get_vectors() == hyp_default_vectors)
 			cpu_init_hyp_mode(NULL);
 	}
 }
 
-static int hyp_init_cpu_notify(struct notifier_block *self,
-			       unsigned long action, void *cpu)
+static void cpu_hyp_reset(void)
 {
-	switch (action) {
-	case CPU_STARTING:
-	case CPU_STARTING_FROZEN:
+	phys_addr_t boot_pgd_ptr;
+	phys_addr_t phys_idmap_start;
+
+	if (!is_kernel_in_hyp_mode()) {
+		boot_pgd_ptr = kvm_mmu_get_boot_httbr();
+		phys_idmap_start = kvm_get_idmap_start();
+
+		__cpu_reset_hyp_mode(boot_pgd_ptr, phys_idmap_start);
+	}
+}
+
+static void _kvm_arch_hardware_enable(void *discard)
+{
+	if (!__this_cpu_read(kvm_arm_hardware_enabled)) {
 		cpu_hyp_reinit();
+		__this_cpu_write(kvm_arm_hardware_enabled, 1);
 	}
+}
 
-	return NOTIFY_OK;
+int kvm_arch_hardware_enable(void)
+{
+	_kvm_arch_hardware_enable(NULL);
+	return 0;
 }
 
-static struct notifier_block hyp_init_cpu_nb = {
-	.notifier_call = hyp_init_cpu_notify,
-};
+static void _kvm_arch_hardware_disable(void *discard)
+{
+	if (__this_cpu_read(kvm_arm_hardware_enabled)) {
+		cpu_hyp_reset();
+		__this_cpu_write(kvm_arm_hardware_enabled, 0);
+	}
+}
+
+void kvm_arch_hardware_disable(void)
+{
+	_kvm_arch_hardware_disable(NULL);
+}
 
 #ifdef CONFIG_CPU_PM
 static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
 				    unsigned long cmd,
 				    void *v)
 {
-	if (cmd == CPU_PM_EXIT) {
-		cpu_hyp_reinit();
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
+			cpu_hyp_reset();
+
 		return NOTIFY_OK;
-	}
+	case CPU_PM_EXIT:
+		if (__this_cpu_read(kvm_arm_hardware_enabled))
+			/* The hardware was enabled before suspend. */
+			cpu_hyp_reinit();
 
-	return NOTIFY_DONE;
+		return NOTIFY_OK;
+
+	default:
+		return NOTIFY_DONE;
+	}
 }
 
 static struct notifier_block hyp_init_cpu_pm_nb = {
@@ -1136,18 +1177,9 @@ static int init_common_resources(void)
 
 static int init_subsystems(void)
 {
-	int err;
+	int err = 0;
 
-	/*
-	 * Register CPU Hotplug notifier
-	 */
-	cpu_notifier_register_begin();
-	err = __register_cpu_notifier(&hyp_init_cpu_nb);
-	cpu_notifier_register_done();
-	if (err) {
-		kvm_err("Cannot register KVM init CPU notifier (%d)\n", err);
-		return err;
-	}
+	on_each_cpu(_kvm_arch_hardware_enable, NULL, 1);
 
 	/*
 	 * Register CPU lower-power notifier
@@ -1165,9 +1197,10 @@ static int init_subsystems(void)
 	case -ENODEV:
 	case -ENXIO:
 		vgic_present = false;
+		err = 0;
 		break;
 	default:
-		return err;
+		goto out;
 	}
 
 	/*
@@ -1175,12 +1208,15 @@ static int init_subsystems(void)
 	 */
 	err = kvm_timer_hyp_init();
 	if (err)
-		return err;
+		goto out;
 
 	kvm_perf_init();
 	kvm_coproc_table_init();
 
-	return 0;
+out:
+	on_each_cpu(_kvm_arch_hardware_disable, NULL, 1);
+
+	return err;
 }
 
 static void teardown_hyp_mode(void)
@@ -1197,11 +1233,6 @@ static void teardown_hyp_mode(void)
 
 static int init_vhe_mode(void)
 {
-	/*
-	 * Execute the init code on each CPU.
-	 */
-	on_each_cpu(cpu_init_stage2, NULL, 1);
-
 	/* set size of VMID supported by CPU */
 	kvm_vmid_bits = kvm_get_vmid_bits();
 	kvm_info("%d-bit VMID\n", kvm_vmid_bits);
@@ -1288,11 +1319,6 @@ static int init_hyp_mode(void)
 		}
 	}
 
-	/*
-	 * Execute the init code on each CPU.
-	 */
-	on_each_cpu(cpu_init_hyp_mode, NULL, 1);
-
 #ifndef CONFIG_HOTPLUG_CPU
 	free_boot_hyp_pgd();
 #endif
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 58dbd5c..7d86e15 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1666,6 +1666,11 @@ phys_addr_t kvm_get_idmap_vector(void)
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
index eb7490d..ebc8d0e 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -40,6 +40,7 @@ struct kvm_vcpu;
 
 extern char __kvm_hyp_init[];
 extern char __kvm_hyp_init_end[];
+extern char __kvm_hyp_reset[];
 
 extern char __kvm_hyp_vector[];
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index b7e82a7..b6f194d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -46,6 +46,7 @@
 int __attribute_const__ kvm_target_cpu(void);
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
 int kvm_arch_dev_ioctl_check_extension(long ext);
+phys_addr_t kvm_hyp_reset_entry(void);
 
 struct kvm_arch {
 	/* The VMID generation used for the virt. memory system */
@@ -352,7 +353,17 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 		       hyp_stack_ptr, vector_ptr);
 }
 
-static inline void kvm_arch_hardware_disable(void) {}
+static inline void __cpu_reset_hyp_mode(phys_addr_t boot_pgd_ptr,
+					phys_addr_t phys_idmap_start)
+{
+	/*
+	 * Call reset code, and switch back to stub hyp vectors.
+	 * Uses __kvm_call_hyp() to avoid kaslr's kvm_ksym_ref() translation.
+	 */
+	__kvm_call_hyp((void *)kvm_hyp_reset_entry(),
+		       boot_pgd_ptr, phys_idmap_start);
+}
+
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 22732a5..e8d39d4 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -109,6 +109,7 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_mmu_get_boot_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
+phys_addr_t kvm_get_idmap_start(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 5ce1b47..44ec4cb 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -139,6 +139,44 @@ merged:
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
+	/* Ensure the PA branch doesn't find a stale tlb entry or stale code. */
+	ic	iallu
+	tlbi	alle2
+	dsb	sy
+	isb
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
index 9677bf0..4062e6d 100644
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
@@ -130,3 +132,15 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
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
