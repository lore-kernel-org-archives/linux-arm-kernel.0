From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 17 Jan 2013 09:59:54 +0100
Subject: [PATCH v8 1/3] ARM: make cr_alignment read-only #ifndef
 CONFIG_CPU_CP15
In-Reply-To: <1358413196-5609-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1358413196-5609-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1358413196-5609-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes cr_alignment a constant 0 to break code that tries to modify
the value as it's likely that it's built on wrong assumption when
CONFIG_CPU_CP15 isn't defined. For code that is only reading the value 0
is more or less a fine value to report. As suggested by Nicolas this is
cleaner than to #ifdef out all uses.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/include/asm/cp15.h   |   16 +++++++++++++++-
 arch/arm/kernel/head-common.S |    9 +++++++--
 arch/arm/mm/alignment.c       |    2 ++
 arch/arm/mm/mmu.c             |   17 +++++++++++++++++
 4 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index 5ef4d80..1f3262e 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -42,6 +42,8 @@
 #define vectors_high()	(0)
 #endif
 
+#ifdef CONFIG_CPU_CP15
+
 extern unsigned long cr_no_alignment;	/* defined in entry-armv.S */
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 
@@ -82,6 +84,18 @@ static inline void set_copro_access(unsigned int val)
 	isb();
 }
 
-#endif
+#else /* ifdef CONFIG_CPU_CP15 */
+
+/*
+ * cr_alignment and cr_no_alignment are tightly coupled to cp15 (at least in the
+ * minds of the developers). Yielding 0 for machines without a cp15 (and making
+ * it read-only) is fine for most cases and saves quite some #ifdeffery.
+ */
+#define cr_no_alignment	UL(0)
+#define cr_alignment	UL(0)
+
+#endif /* ifdef CONFIG_CPU_CP15 / else */
+
+#endif /* ifndef __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 854bd22..5b391a6 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -98,8 +98,9 @@ __mmap_switched:
 	str	r9, [r4]			@ Save processor ID
 	str	r1, [r5]			@ Save machine type
 	str	r2, [r6]			@ Save atags pointer
-	bic	r4, r0, #CR_A			@ Clear 'A' bit
-	stmia	r7, {r0, r4}			@ Save control register values
+	cmp	r7, #0
+	bicne	r4, r0, #CR_A			@ Clear 'A' bit
+	stmneia	r7, {r0, r4}			@ Save control register values
 	b	start_kernel
 ENDPROC(__mmap_switched)
 
@@ -113,7 +114,11 @@ __mmap_switched_data:
 	.long	processor_id			@ r4
 	.long	__machine_arch_type		@ r5
 	.long	__atags_pointer			@ r6
+#ifdef CONFIG_CPU_CP15
 	.long	cr_alignment			@ r7
+#else
+	.long	0				@ r7
+#endif
 	.long	init_thread_union + THREAD_START_SP @ sp
 	.size	__mmap_switched_data, . - __mmap_switched_data
 
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index b9f60eb..5748094 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -962,12 +962,14 @@ static int __init alignment_init(void)
 		return -ENOMEM;
 #endif
 
+#ifdef CONFIG_CPU_CP15
 	if (cpu_is_v6_unaligned()) {
 		cr_alignment &= ~CR_A;
 		cr_no_alignment &= ~CR_A;
 		set_cr(cr_alignment);
 		ai_usermode = safe_usermode(ai_usermode, false);
 	}
+#endif
 
 	hook_fault_code(FAULT_CODE_ALIGNMENT, do_alignment, SIGBUS, BUS_ADRALN,
 			"alignment exception");
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 941dfb9..92abdb8 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -97,6 +97,7 @@ static struct cachepolicy cache_policies[] __initdata = {
 	}
 };
 
+#ifdef CONFIG_CPU_CP15
 /*
  * These are useful for identifying cache coherency
  * problems by allowing the cache or the cache and
@@ -195,6 +196,22 @@ void adjust_cr(unsigned long mask, unsigned long set)
 }
 #endif
 
+#else /* ifdef CONFIG_CPU_CP15 */
+
+static int __init early_cachepolicy(char *p)
+{
+	pr_warning("cachepolicy kernel parameter not supported without cp15\n");
+}
+early_param("cachepolicy", early_cachepolicy);
+
+static int __init noalign_setup(char *__unused)
+{
+	pr_warning("noalign kernel parameter not supported without cp15\n");
+}
+__setup("noalign", noalign_setup);
+
+#endif /* ifdef CONFIG_CPU_CP15 / else */
+
 #define PROT_PTE_DEVICE		L_PTE_PRESENT|L_PTE_YOUNG|L_PTE_DIRTY|L_PTE_XN
 #define PROT_SECT_DEVICE	PMD_TYPE_SECT|PMD_SECT_AP_WRITE
 
-- 
1.7.10.4
