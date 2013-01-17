From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 17 Jan 2013 09:59:53 +0100
Subject: [PATCH v8 0/3] Cortex-M3 series once more
Message-ID: <1358413196-5609-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on Jonny's comments I changed a few more details. The diff to v7
can be found below after the diffstat. These are:

 - describe why a #define for cr_alignment is OK in both the
   commit log and a comment in the header file
 - a work around for errata 752419 that newer gcc warns about
 - add a few more comments for better readability
 - a whitespace fix

I think the updates are minor enough to still allow the patches to go
into v3.9-rc1. Russell, what do you think? You can pull them from

	git://git.pengutronix.de/git/ukl/linux.git for-next

still based on v3.7-rc1 + your commit "ARM: fix oops on initial entry to
userspace with Thumb2 kernels".

Catalin Marinas (1):
  Cortex-M3: Add base support for Cortex-M3

Uwe Kleine-K?nig (2):
  ARM: make cr_alignment read-only #ifndef CONFIG_CPU_CP15
  Cortex-M3: Add support for exception handling

 arch/arm/include/asm/assembler.h   |   13 ++-
 arch/arm/include/asm/cp15.h        |   16 +++-
 arch/arm/include/asm/cputype.h     |    3 +
 arch/arm/include/asm/glue-cache.h  |   25 ++++++
 arch/arm/include/asm/glue-df.h     |    8 ++
 arch/arm/include/asm/glue-proc.h   |    9 ++
 arch/arm/include/asm/irqflags.h    |   22 +++--
 arch/arm/include/asm/processor.h   |    7 ++
 arch/arm/include/asm/ptrace.h      |    8 ++
 arch/arm/include/asm/system_info.h |    1 +
 arch/arm/include/uapi/asm/ptrace.h |   36 ++++++--
 arch/arm/kernel/asm-offsets.c      |    3 +
 arch/arm/kernel/entry-common.S     |    4 +
 arch/arm/kernel/entry-header.S     |  148 +++++++++++++++++++++++++++++++++
 arch/arm/kernel/entry-v7m.S        |  134 ++++++++++++++++++++++++++++++
 arch/arm/kernel/head-common.S      |    9 +-
 arch/arm/kernel/head-nommu.S       |    9 +-
 arch/arm/kernel/process.c          |    4 +
 arch/arm/kernel/ptrace.c           |    3 +
 arch/arm/kernel/setup.c            |   13 ++-
 arch/arm/kernel/traps.c            |    2 +
 arch/arm/mm/alignment.c            |    2 +
 arch/arm/mm/mmu.c                  |   17 ++++
 arch/arm/mm/nommu.c                |    2 +
 arch/arm/mm/proc-v7m.S             |  161 ++++++++++++++++++++++++++++++++++++
 25 files changed, 637 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/kernel/entry-v7m.S
 create mode 100644 arch/arm/mm/proc-v7m.S

The incremental changes since v7 are:

diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index d814435..1f3262e 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -86,6 +86,11 @@ static inline void set_copro_access(unsigned int val)
 
 #else /* ifdef CONFIG_CPU_CP15 */
 
+/*
+ * cr_alignment and cr_no_alignment are tightly coupled to cp15 (at least in the
+ * minds of the developers). Yielding 0 for machines without a cp15 (and making
+ * it read-only) is fine for most cases and saves quite some #ifdeffery.
+ */
 #define cr_no_alignment	UL(0)
 #define cr_alignment	UL(0)
 
diff --git a/arch/arm/include/uapi/asm/ptrace.h b/arch/arm/include/uapi/asm/ptrace.h
index 2ae7d1b..d3be66e 100644
--- a/arch/arm/include/uapi/asm/ptrace.h
+++ b/arch/arm/include/uapi/asm/ptrace.h
@@ -144,7 +144,7 @@ struct pt_regs {
 #define ARM_r1		uregs[1]
 #define ARM_r0		uregs[0]
 #define ARM_ORIG_r0	uregs[17]
-#define ARM_EXC_RET    uregs[18]
+#define ARM_EXC_RET	uregs[18]
 
 /*
  * The size of the user-visible VFP state as seen by PTRACE_GET/SETVFPREGS
diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index a0991dc..842394c 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -102,8 +102,8 @@ ENTRY(__switch_to)
 	mov	ip, r4
 	mov	r0, r5
 	ldmia	ip!, {r4 - r11}		@ Load all regs saved previously
-	ldr	sp, [ip], #4
-	ldr	pc, [ip]
+	ldr	sp, [ip]
+	ldr	pc, [ip, #4]!
 	.fnend
 ENDPROC(__switch_to)
 
diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 2f560c5..5b391a6 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -117,7 +117,7 @@ __mmap_switched_data:
 #ifdef CONFIG_CPU_CP15
 	.long	cr_alignment			@ r7
 #else
-	.long	0
+	.long	0				@ r7
 #endif
 	.long	init_thread_union + THREAD_START_SP @ sp
 	.size	__mmap_switched_data, . - __mmap_switched_data
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index b675918..92abdb8 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -196,7 +196,7 @@ void adjust_cr(unsigned long mask, unsigned long set)
 }
 #endif
 
-#else
+#else /* ifdef CONFIG_CPU_CP15 */
 
 static int __init early_cachepolicy(char *p)
 {
@@ -210,7 +210,7 @@ static int __init noalign_setup(char *__unused)
 }
 __setup("noalign", noalign_setup);
 
-#endif
+#endif /* ifdef CONFIG_CPU_CP15 / else */
 
 #define PROT_PTE_DEVICE		L_PTE_PRESENT|L_PTE_YOUNG|L_PTE_DIRTY|L_PTE_XN
 #define PROT_SECT_DEVICE	PMD_TYPE_SECT|PMD_SECT_AP_WRITE

-- 
1.7.10.4
