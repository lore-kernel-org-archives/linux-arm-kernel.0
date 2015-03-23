From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 23 Mar 2015 20:53:56 +0900
Subject: [RFC 1/4] arm64: kvm: add a cpu tear-down function
In-Reply-To: <1427111639-4575-1-git-send-email-takahiro.akashi@linaro.org>
References: <1427111639-4575-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1427111639-4575-2-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cpu must be put back into its initial state, at least, in the
following cases in order to shutdown the system and/or re-initialize cpus
later on:
1) kexec/kdump
2) cpu hotplug (offline)
3) removing kvm as a module

To address those issues in later patches, this patch adds a tear-down
function, kvm_cpu_reset(), that disables D-cache & MMU and restore a vector
table to the initial stub at EL2.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm/kvm/arm.c                |   18 ++++++++++++++++
 arch/arm/kvm/mmu.c                |   16 +++++++++++++++
 arch/arm64/include/asm/kvm_asm.h  |    3 +++
 arch/arm64/include/asm/kvm_host.h |   10 +++++++++
 arch/arm64/include/asm/kvm_mmu.h  |    3 +++
 arch/arm64/include/asm/virt.h     |   11 ++++++++++
 arch/arm64/kvm/hyp-init.S         |   41 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp.S              |   29 ++++++++++++++++++++++----
 8 files changed, 127 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 5560f74..35c8bc0 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -897,6 +897,24 @@ static void cpu_init_hyp_mode(void *dummy)
 	__cpu_init_hyp_mode(boot_pgd_ptr, pgd_ptr, hyp_stack_ptr, vector_ptr);
 }
 
+void kvm_cpu_reset(void *dummy)
+{
+	phys_addr_t boot_pgd_ptr;
+	phys_addr_t phys_idmap_start;
+	unsigned long reset_func;
+	unsigned long vector_ptr;
+
+	if (__hyp_get_vectors() == hyp_default_vectors)
+		return;
+
+	reset_func = kvm_reset_func_entry();
+	boot_pgd_ptr = kvm_mmu_get_boot_httbr();
+	phys_idmap_start = kvm_get_idmap_start();
+	vector_ptr = kvm_get_stub_vectors();
+	__cpu_reset_hyp_mode(reset_func,
+			     boot_pgd_ptr, phys_idmap_start, vector_ptr);
+}
+
 static int hyp_init_cpu_notify(struct notifier_block *self,
 			       unsigned long action, void *cpu)
 {
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 3e6859b..428f41c 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1490,6 +1490,22 @@ phys_addr_t kvm_get_idmap_vector(void)
 	return hyp_idmap_vector;
 }
 
+phys_addr_t kvm_get_idmap_start(void)
+{
+	return hyp_idmap_start;
+}
+
+phys_addr_t kvm_get_stub_vectors(void)
+{
+	return virt_to_phys(__hyp_stub_vectors);
+}
+
+unsigned long kvm_reset_func_entry(void)
+{
+	/* VA of __kvm_hyp_reset in trampline code */
+	return TRAMPOLINE_VA + (__kvm_hyp_reset - __hyp_idmap_text_start);
+}
+
 int kvm_mmu_init(void)
 {
 	int err;
diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 4f7310f..97ee2fc 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -116,8 +116,11 @@
 struct kvm;
 struct kvm_vcpu;
 
+extern char __hyp_stub_vectors[];
+
 extern char __kvm_hyp_init[];
 extern char __kvm_hyp_init_end[];
+extern char __kvm_hyp_reset[];
 
 extern char __kvm_hyp_vector[];
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 8ac3c70..97f88fe 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -199,6 +199,7 @@ struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
 struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void);
 
 u64 kvm_call_hyp(void *hypfn, ...);
+void kvm_call_reset(unsigned long reset_func, ...);
 void force_vm_exit(const cpumask_t *mask);
 void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
@@ -223,6 +224,15 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 		     hyp_stack_ptr, vector_ptr);
 }
 
+static inline void __cpu_reset_hyp_mode(unsigned long reset_func,
+					phys_addr_t boot_pgd_ptr,
+					phys_addr_t phys_idmap_start,
+					unsigned long stub_vector_ptr)
+{
+	kvm_call_reset(reset_func, boot_pgd_ptr,
+		       phys_idmap_start, stub_vector_ptr);
+}
+
 struct vgic_sr_vectors {
 	void	*save_vgic;
 	void	*restore_vgic;
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 6458b53..36be582 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -96,6 +96,9 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_mmu_get_boot_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
+phys_addr_t kvm_get_idmap_start(void);
+phys_addr_t kvm_get_stub_vectors(void);
+unsigned long kvm_reset_func_entry(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 3070096..7fcd087 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -61,6 +61,17 @@
 #define BOOT_CPU_MODE_EL1	(0xe11)
 #define BOOT_CPU_MODE_EL2	(0xe12)
 
+/*
+ * HVC_RESET - Reset cpu in EL2 to initial state.
+ *
+ * @x0: entry address in trampoline code in va
+ * @x1: identical mapping page table in pa
+ * @x2: start address of identical mapping in pa
+ * @x3: initial stub vector in pa
+ */
+
+#define HVC_RESET 5
+
 #ifndef __ASSEMBLY__
 
 /*
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index c319116..ca7e6bf 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -115,6 +115,47 @@ target: /* We're now in the trampoline code, switch page tables */
 	eret
 ENDPROC(__kvm_hyp_init)
 
+	/*
+	 * x0: HYP boot pgd
+	 * x1: HYP phys_idmap_start
+	 * x2: HYP stub vectors
+	 */
+ENTRY(__kvm_hyp_reset)
+	/* We're in trampoline code in VA */
+	/* Invalidate the old TLBs */
+	tlbi	alle2
+	dsb	sy
+
+	/* Switch back to boot page tables */
+	msr	ttbr0_el2, x0
+	isb
+
+	/* Branch into PA space */
+	adr	x0, 1f
+	bfi	x1, x0, #0, #PAGE_SHIFT
+	br	x1
+
+	/* We're now in idmap */
+1:	/* Invalidate the old TLBs again */
+	tlbi	alle2
+	dsb	sy
+
+	/* Disable MMU */
+	mrs	x0, sctlr_el2
+	and	x1, x0, #SCTLR_EL2_EE
+	orr	x0, x0, x1		// preserve endianness of EL2
+	ldr	x1, =SCTLR_EL2_FLAGS
+	eor	x1, x1, xzr
+	bic	x0, x0, x1		// Clear SCTL_M and etc
+	msr	sctlr_el2, x0
+	isb
+
+	/* Switch back to stub vectors */
+	msr	vbar_el2, x2
+
+	eret
+ENDPROC(__kvm_hyp_reset)
+
 	.ltorg
 
 	.popsection
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index fd085ec..aee75f9 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -1136,6 +1136,11 @@ ENTRY(kvm_call_hyp)
 	ret
 ENDPROC(kvm_call_hyp)
 
+ENTRY(kvm_call_reset)
+	hvc	#HVC_RESET
+	ret
+ENDPROC(kvm_call_reset)
+
 .macro invalid_vector	label, target
 	.align	2
 \label:
@@ -1179,10 +1184,10 @@ el1_sync:					// Guest trapped into EL2
 	cmp	x18, #HVC_GET_VECTORS
 	b.ne	1f
 	mrs	x0, vbar_el2
-	b	2f
-
-1:	/* Default to HVC_CALL_HYP. */
+	b	3f
 
+1:	cmp	x18, #HVC_CALL_HYP
+	b.ne	2f
 	push	lr, xzr
 
 	/*
@@ -1196,7 +1201,23 @@ el1_sync:					// Guest trapped into EL2
 	blr	lr
 
 	pop	lr, xzr
-2:	eret
+	b	3f
+
+	/*
+	 * shuffle the parameters and jump into trampline code.
+	 */
+2:	cmp	x18, #HVC_RESET
+	b.ne	3f
+
+	mov	x18, x0
+	mov	x0, x1
+	mov	x1, x2
+	mov	x2, x3
+	mov	x3, x4
+	br	x18
+	/* not reach here */
+
+3:	eret
 
 el1_trap:
 	/*
-- 
1.7.9.5
