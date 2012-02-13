From: bill4carson@gmail.com (Bill Carson)
Date: Mon, 13 Feb 2012 17:44:24 +0800
Subject: [PATCH 3/7] Introduce set_hugepte_ext api to setup huge hardware pmds
In-Reply-To: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
Message-ID: <1329126268-11032-4-git-send-email-bill4carson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bill Carson <bill4carson@gmail.com>
---
 arch/arm/include/asm/glue-proc.h |    3 +
 arch/arm/include/asm/proc-fns.h  |    3 +
 arch/arm/mm/proc-v7-2level.S     |   87 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/glue-proc.h b/arch/arm/include/asm/glue-proc.h
index e2be7f1..2bbd452 100644
--- a/arch/arm/include/asm/glue-proc.h
+++ b/arch/arm/include/asm/glue-proc.h
@@ -256,6 +256,9 @@
 #define cpu_dcache_clean_area		__glue(CPU_NAME,_dcache_clean_area)
 #define cpu_do_switch_mm		__glue(CPU_NAME,_switch_mm)
 #define cpu_set_pte_ext			__glue(CPU_NAME,_set_pte_ext)
+#ifdef CONFIG_ARM_HUGETLB_SUPPORT
+#define cpu_set_hugepte_ext		__glue(CPU_NAME,_set_hugepte_ext)
+#endif
 #define cpu_suspend_size		__glue(CPU_NAME,_suspend_size)
 #define cpu_do_suspend			__glue(CPU_NAME,_do_suspend)
 #define cpu_do_resume			__glue(CPU_NAME,_do_resume)
diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index f3628fb..75bd755 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -87,6 +87,9 @@ extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
 extern void cpu_set_pte_ext(pte_t *ptep, pte_t pte);
 #else
 extern void cpu_set_pte_ext(pte_t *ptep, pte_t pte, unsigned int ext);
+#ifdef CONFIG_ARM_HUGETLB_SUPPORT
+extern void cpu_set_hugepte_ext(pte_t *ptep, pte_t pte, unsigned int ext);
+#endif
 #endif
 extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
 
diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index 3a4b3e7..4dc1554 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -111,6 +111,93 @@ ENTRY(cpu_v7_set_pte_ext)
 	mov	pc, lr
 ENDPROC(cpu_v7_set_pte_ext)
 
+#ifdef CONFIG_ARM_HUGETLB_SUPPORT
+ENTRY(cpu_v7_set_hugepte_ext)
+	@mask out AP[2:0] TEX[2:0] in first level section descriptor
+	bic	r3, r1, #0x0000fc00
+	@clear NX/IMP
+	bic	r3, r3,#0x210
+
+	@clear BIT1:0
+	bic	r3, r3, #PMD_TYPE_MASK
+
+	@set extension bit
+	orr	r3, r3, #PMD_SECT_nG @HUGEPAGE always non-global
+
+	@set SECT mapping,1M section or 16M supersection
+	orr	r3, r3, #PMD_SECT_AP_WRITE
+	orr	r3, r3, #PMD_TYPE_SECT
+
+	@BIT18 1: 16M supersection 0: 1M section
+	bic	r3, r3, #PMD_SECT_SUPER
+
+	@ shared bit
+	tst	r1,#L_PTE_SHARED
+	orrne	r3,r3,#PMD_SECT_S
+
+	@ shared device ?
+	tst	r1, #1 << 4
+	orrne	r3, r3, #PMD_SECT_TEX(1)
+
+	eor	r1, r1,  #L_PTE_DIRTY
+	tst	r1, #L_PTE_RDONLY | L_PTE_DIRTY
+	orrne	r3, r3, #PMD_SECT_APX
+
+	tst	r1, #L_PTE_USER
+	orrne	r3, r3, #PMD_SECT_AP_READ
+#ifdef CONFIG_CPU_USE_DOMAINS
+	tstne	r3, #PMD_SECT_APX
+	bicne	r3, r3, #PMD_SECT_APX | PMD_SECT_AP_WRITE
+#endif
+
+	@set domain
+	bic 	r3, r3, #(0xf << 5)
+	orr	r3, r3, #PMD_DOMAIN(0x1)
+
+#ifdef CONFIG_HUGEPAGE_SIZE_16MB
+	@ for supersection mapping
+	@ clear domain setting and extend addr
+	@ set BIT18 to denote supersection
+	ldr	r2, =((0xf << 5) | (0xf << 20))
+	bic	r3, r3, r2
+	orr	r3, r3, #PMD_SECT_SUPER
+#endif
+
+	tst	r1, #L_PTE_XN
+	orrne	r3, r3, #PMD_SECT_XN
+
+	tst	r1, #L_PTE_YOUNG
+	tstne	r1, #L_PTE_PRESENT
+	moveq	r3, #0
+
+#ifdef CONFIG_HUGEPAGE_SIZE_16MB
+	@ set 16M huge page
+	.rept 16
+ 	str r3, [r0]
+	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
+	add	r0, r0, #4
+	.endr
+#endif
+
+#ifdef CONFIG_HUGEPAGE_SIZE_2MB
+	@ set 2M huge page
+	@ 1st 1MB mapping
+ 	str r3, [r0]
+	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
+	@ 2st 1MB mapping
+	cmp	r3,#0
+	movne	r2,#0x100000
+	addne	r3, r3, r2
+
+	add	r0, r0, #4
+ 	str r3, [r0]
+	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
+#endif
+	mov pc, lr
+#endif /*COFNIG_ARM_HUGETLB_SUPPORT*/
+
+ENDPROC(cpu_v7_set_hugepte_ext)
+
 	/*
 	 * Memory region attributes with SCTLR.TRE=1
 	 *
-- 
1.7.1
