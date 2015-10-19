From: geoff@infradead.org (Geoff Levand)
Date: Mon, 19 Oct 2015 23:38:53 +0000
Subject: [PATCH 04/16] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <cover.1445297709.git.geoff@infradead.org>
References: <cover.1445297709.git.geoff@infradead.org>
Message-ID: <2bffc2f8ecec7b696231f451e580ab683e6936b9.1445297709.git.geoff@infradead.org>
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
 arch/arm/include/asm/kvm_host.h   | 10 ++++++-
 arch/arm/include/asm/kvm_mmu.h    |  1 +
 arch/arm/kvm/arm.c                | 58 ++++++++++++---------------------------
 arch/arm/kvm/mmu.c                |  5 ++++
 arch/arm64/include/asm/kvm_host.h | 16 ++++++++++-
 arch/arm64/include/asm/kvm_mmu.h  |  1 +
 arch/arm64/include/asm/virt.h     |  9 ++++++
 arch/arm64/kvm/hyp-init.S         | 33 ++++++++++++++++++++++
 arch/arm64/kvm/hyp.S              | 32 ++++++++++++++++++---
 9 files changed, 119 insertions(+), 46 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index c4072d9..4c6a38c 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -211,6 +211,15 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
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
@@ -223,7 +232,6 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
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
index dc017ad..0871809 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -16,7 +16,6 @@
  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 
-#include <linux/cpu.h>
 #include <linux/cpu_pm.h>
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -85,11 +84,6 @@ struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void)
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
@@ -915,7 +909,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	}
 }
 
-static void cpu_init_hyp_mode(void *dummy)
+int kvm_arch_hardware_enable(void)
 {
 	phys_addr_t boot_pgd_ptr;
 	phys_addr_t pgd_ptr;
@@ -923,6 +917,9 @@ static void cpu_init_hyp_mode(void *dummy)
 	unsigned long stack_page;
 	unsigned long vector_ptr;
 
+	if (__hyp_get_vectors() != hyp_default_vectors)
+		return 0;
+
 	/* Switch from the HYP stub to our own HYP init vector */
 	__hyp_set_vectors(kvm_get_idmap_vector());
 
@@ -935,34 +932,31 @@ static void cpu_init_hyp_mode(void *dummy)
 	__cpu_init_hyp_mode(boot_pgd_ptr, pgd_ptr, hyp_stack_ptr, vector_ptr);
 
 	kvm_arm_init_debug();
+
+	return 0;
 }
 
-static int hyp_init_cpu_notify(struct notifier_block *self,
-			       unsigned long action, void *cpu)
+void kvm_arch_hardware_disable(void)
 {
-	switch (action) {
-	case CPU_STARTING:
-	case CPU_STARTING_FROZEN:
-		if (__hyp_get_vectors() == hyp_default_vectors)
-			cpu_init_hyp_mode(NULL);
-		break;
-	}
+	phys_addr_t boot_pgd_ptr;
+	phys_addr_t phys_idmap_start;
 
-	return NOTIFY_OK;
-}
+	if (__hyp_get_vectors() == hyp_default_vectors)
+		return;
 
-static struct notifier_block hyp_init_cpu_nb = {
-	.notifier_call = hyp_init_cpu_notify,
-};
+	boot_pgd_ptr = kvm_mmu_get_boot_httbr();
+	phys_idmap_start = kvm_get_idmap_start();
+
+	__cpu_reset_hyp_mode(boot_pgd_ptr, phys_idmap_start);
+}
 
 #ifdef CONFIG_CPU_PM
 static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
 				    unsigned long cmd,
 				    void *v)
 {
-	if (cmd == CPU_PM_EXIT &&
-	    __hyp_get_vectors() == hyp_default_vectors) {
-		cpu_init_hyp_mode(NULL);
+	if (cmd == CPU_PM_EXIT && kvm_arm_get_running_vcpu()) {
+		kvm_arch_hardware_enable();
 		return NOTIFY_OK;
 	}
 
@@ -1064,11 +1058,6 @@ static int init_hyp_mode(void)
 	}
 
 	/*
-	 * Execute the init code on each CPU.
-	 */
-	on_each_cpu(cpu_init_hyp_mode, NULL, 1);
-
-	/*
 	 * Init HYP view of VGIC
 	 */
 	err = kvm_vgic_hyp_init();
@@ -1142,26 +1131,15 @@ int kvm_arch_init(void *opaque)
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
index 6984342..69b4a33 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1644,6 +1644,11 @@ phys_addr_t kvm_get_idmap_vector(void)
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
index ed03968..e86421a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -220,6 +220,7 @@ struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
 struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void);
 
 u64 kvm_call_hyp(void *hypfn, ...);
+void kvm_call_reset(phys_addr_t boot_pgd_ptr, phys_addr_t phys_idmap_start);
 void force_vm_exit(const cpumask_t *mask);
 void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
@@ -244,7 +245,20 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
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
+struct vgic_sr_vectors {
+	void	*save_vgic;
+	void	*restore_vgic;
+};
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
index 2e67a48..1925163 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -139,6 +139,39 @@ merged:
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
+	ldr	x1, =SCTLR_EL2_FLAGS
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
index 073b8bf..c9804ac 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -931,6 +931,11 @@ ENTRY(kvm_call_hyp)
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
@@ -974,10 +979,27 @@ el1_sync:					// Guest trapped into EL2
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
@@ -991,7 +1013,9 @@ el1_sync:					// Guest trapped into EL2
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
