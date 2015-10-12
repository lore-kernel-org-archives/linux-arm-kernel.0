From: james.morse@arm.com (James Morse)
Date: Mon, 12 Oct 2015 14:17:33 +0100
Subject: [PATCH 1/6] arm64: kvm: add a cpu tear-down function
In-Reply-To: <1444655858-26083-1-git-send-email-james.morse@arm.com>
References: <1444655858-26083-1-git-send-email-james.morse@arm.com>
Message-ID: <1444655858-26083-2-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

The CPU must be put back into its initial state, at least, in the
following cases in order to shutdown the system and/or re-initialize CPUs
later on:
1) kexec/kdump
2) cpu hotplug (offline)
3) removing kvm as a module
4) resume from hibernate (pgd+stack moved)

To address those issues in later patches, this patch adds a tear-down
function, kvm_cpu_reset(), that disables the MMU and restores the vector
table to the initial stub at EL2.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
[use kvm_call_hyp(), simplified mmu-off code]
Signed-off-by: James Morse <james.morse@arm.com>
---
This is based on v4 from
http://lists.infradead.org/pipermail/kexec/2015-May/013709.html.
This patch is superseded by a v5 [0], but its changes to the cpu hotplug
hook are causing a problem.

[0] https://lists.linaro.org/pipermail/linaro-kernel/2015-May/021575.html

 arch/arm/include/asm/kvm_asm.h    |  1 +
 arch/arm/include/asm/kvm_host.h   |  7 +++++++
 arch/arm/include/asm/kvm_mmu.h    |  7 +++++++
 arch/arm/kvm/arm.c                | 18 ++++++++++++++++++
 arch/arm/kvm/init.S               |  5 +++++
 arch/arm/kvm/mmu.c                |  7 +++++--
 arch/arm64/include/asm/kvm_asm.h  |  1 +
 arch/arm64/include/asm/kvm_host.h |  8 ++++++++
 arch/arm64/include/asm/kvm_mmu.h  |  7 +++++++
 arch/arm64/kvm/hyp-init.S         | 37 +++++++++++++++++++++++++++++++++++++
 10 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 194c91b610ff..6ecd59127f3f 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -85,6 +85,7 @@ struct kvm_vcpu;
 
 extern char __kvm_hyp_init[];
 extern char __kvm_hyp_init_end[];
+extern char __kvm_hyp_reset[];
 
 extern char __kvm_hyp_exit[];
 extern char __kvm_hyp_exit_end[];
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index c4072d9f32c7..f27d45f9e346 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -44,6 +44,7 @@
 u32 *kvm_vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num, u32 mode);
 int __attribute_const__ kvm_target_cpu(void);
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
+void kvm_reset_cpu(void);
 void kvm_reset_coprocs(struct kvm_vcpu *vcpu);
 
 struct kvm_arch {
@@ -211,6 +212,12 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 	kvm_call_hyp((void*)hyp_stack_ptr, vector_ptr, pgd_ptr);
 }
 
+static inline void __cpu_reset_hyp_mode(phys_addr_t boot_pgd_ptr,
+					phys_addr_t phys_idmap_start,
+					unsigned long reset_func)
+{
+}
+
 static inline int kvm_arch_dev_ioctl_check_extension(long ext)
 {
 	return 0;
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 405aa1883307..64201f4f2de8 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -66,6 +66,8 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_mmu_get_boot_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
+phys_addr_t kvm_get_idmap_start(void);
+extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
@@ -269,6 +271,11 @@ static inline void __kvm_flush_dcache_pud(pud_t pud)
 void kvm_set_way_flush(struct kvm_vcpu *vcpu);
 void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled);
 
+#define kvm_virt_to_trampoline(x)	\
+		(TRAMPOLINE_VA		\
+		+ ((unsigned long)(x)	\
+		- ((unsigned long)__hyp_idmap_text_start & PAGE_MASK)))
+
 static inline bool __kvm_cpu_uses_extended_idmap(void)
 {
 	return false;
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index dc017adfddc8..f145c4453893 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -937,6 +937,24 @@ static void cpu_init_hyp_mode(void *dummy)
 	kvm_arm_init_debug();
 }
 
+void kvm_reset_cpu(void)
+{
+	phys_addr_t boot_pgd_ptr = kvm_mmu_get_boot_httbr();
+	phys_addr_t phys_idmap_start = kvm_get_idmap_start();
+
+	/* Is KVM initialised? */
+	if (boot_pgd_ptr == virt_to_phys(NULL) ||
+	    phys_idmap_start == virt_to_phys(NULL))
+		return;
+
+	/* Do we need to return the vectors to hyp_default_vectors? */
+	if (__hyp_get_vectors() == hyp_default_vectors)
+		return;
+
+	__cpu_reset_hyp_mode(boot_pgd_ptr, phys_idmap_start,
+			     kvm_virt_to_trampoline(__kvm_hyp_reset));
+}
+
 static int hyp_init_cpu_notify(struct notifier_block *self,
 			       unsigned long action, void *cpu)
 {
diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
index 3988e72d16ff..23bdeac287da 100644
--- a/arch/arm/kvm/init.S
+++ b/arch/arm/kvm/init.S
@@ -151,6 +151,11 @@ target:	@ We're now in the trampoline code, switch page tables
 
 	eret
 
+	.globl __kvm_hyp_reset
+__kvm_hyp_reset:
+	/* not yet implemented */
+	ret	lr
+
 	.ltorg
 
 	.globl __kvm_hyp_init_end
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 6984342da13d..88e7d29d8da8 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -31,8 +31,6 @@
 
 #include "trace.h"
 
-extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
-
 static pgd_t *boot_hyp_pgd;
 static pgd_t *hyp_pgd;
 static pgd_t *merged_hyp_pgd;
@@ -1644,6 +1642,11 @@ phys_addr_t kvm_get_idmap_vector(void)
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
index 5e377101f919..fae48c9584c3 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -108,6 +108,7 @@ struct kvm_vcpu;
 
 extern char __kvm_hyp_init[];
 extern char __kvm_hyp_init_end[];
+extern char __kvm_hyp_reset[];
 
 extern char __kvm_hyp_vector[];
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ed039688c221..91157de8a30a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -44,6 +44,7 @@
 
 int __attribute_const__ kvm_target_cpu(void);
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
+void kvm_reset_cpu(void);
 int kvm_arch_dev_ioctl_check_extension(long ext);
 
 struct kvm_arch {
@@ -244,6 +245,13 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 		     hyp_stack_ptr, vector_ptr);
 }
 
+static inline void __cpu_reset_hyp_mode(phys_addr_t boot_pgd_ptr,
+					phys_addr_t phys_idmap_start,
+					unsigned long reset_func)
+{
+	kvm_call_hyp((void *)reset_func, boot_pgd_ptr, phys_idmap_start);
+}
+
 static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 61505676d085..31c52e3bc518 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -98,6 +98,8 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_mmu_get_boot_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
+phys_addr_t kvm_get_idmap_start(void);
+extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
@@ -271,6 +273,11 @@ static inline void __kvm_flush_dcache_pud(pud_t pud)
 void kvm_set_way_flush(struct kvm_vcpu *vcpu);
 void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled);
 
+#define kvm_virt_to_trampoline(x)	\
+		(TRAMPOLINE_VA		\
+		+ ((unsigned long)(x)	\
+		  - ((unsigned long)__hyp_idmap_text_start & PAGE_MASK)))
+
 static inline bool __kvm_cpu_uses_extended_idmap(void)
 {
 	return __cpu_uses_extended_idmap();
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 178ba2248a98..009a9ffdfca3 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -140,6 +140,43 @@ merged:
 	eret
 ENDPROC(__kvm_hyp_init)
 
+	/*
+	 * x0: HYP boot pgd
+	 * x1: HYP phys_idmap_start
+	 */
+ENTRY(__kvm_hyp_reset)
+	/*
+	 * Restore el1's lr so we can eret from here. The stack is inaccessible
+	 * after we turn the mmu off. This value was pushed in el1_sync().
+	 */
+	pop lr, xzr
+
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
+	bic	x0, x0, #SCTLR_EL2_M
+	msr	sctlr_el2, x0
+	isb
+
+	/* Install stub vectors */
+	adr_l	x2, __hyp_stub_vectors
+	msr	vbar_el2, x2
+
+	eret
+ENDPROC(__kvm_hyp_reset)
+
 	.ltorg
 
 	.popsection
-- 
2.1.4
