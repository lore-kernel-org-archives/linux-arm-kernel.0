From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Feb 2013 15:16:41 +0000
Subject: [PATCH] ARM: head: fix swapper and idmap population with LPAE and
 big-endian
Message-ID: <1361805401-8629-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LPAE page table format uses 64-bit descriptors, so we need to take
endianness into account when populating the swapper and idmap tables
during early initialisation.

This patch ensures that we store the two words making up each page table
entry in the correct order when running big-endian.

Cc: <stable@vger.kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/head.S | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 486a15a..e0eb9a1 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -184,13 +184,22 @@ __create_page_tables:
 	orr	r3, r3, #3			@ PGD block type
 	mov	r6, #4				@ PTRS_PER_PGD
 	mov	r7, #1 << (55 - 32)		@ L_PGD_SWAPPER
-1:	str	r3, [r0], #4			@ set bottom PGD entry bits
+1:
+#ifdef CONFIG_CPU_ENDIAN_BE8
 	str	r7, [r0], #4			@ set top PGD entry bits
+	str	r3, [r0], #4			@ set bottom PGD entry bits
+#else
+	str	r3, [r0], #4			@ set bottom PGD entry bits
+	str	r7, [r0], #4			@ set top PGD entry bits
+#endif
 	add	r3, r3, #0x1000			@ next PMD table
 	subs	r6, r6, #1
 	bne	1b
 
 	add	r4, r4, #0x1000			@ point to the PMD tables
+#ifdef CONFIG_CPU_ENDIAN_BE8
+	add	r4, r4, #4			@ we only write the bottom word
+#endif
 #endif
 
 	ldr	r7, [r10, #PROCINFO_MM_MMUFLAGS] @ mm_mmuflags
@@ -258,6 +267,11 @@ __create_page_tables:
 	addne	r6, r6, #1 << SECTION_SHIFT
 	strne	r6, [r3]
 
+#if defined(CONFIG_LPAE) && defined(CONFIG_CPU_ENDIAN_BE8)
+	sub	r4, r4, #4			@ Fixup page table pointer
+						@ for 64-bit descriptors
+#endif
+
 #ifdef CONFIG_DEBUG_LL
 #if !defined(CONFIG_DEBUG_ICEDCC) && !defined(CONFIG_DEBUG_SEMIHOSTING)
 	/*
@@ -276,13 +290,17 @@ __create_page_tables:
 	orr	r3, r7, r3, lsl #SECTION_SHIFT
 #ifdef CONFIG_ARM_LPAE
 	mov	r7, #1 << (54 - 32)		@ XN
+#ifdef CONFIG_CPU_ENDIAN_BE8
+	str	r7, [r0], #4
+	str	r3, [r0], #4
 #else
-	orr	r3, r3, #PMD_SECT_XN
-#endif
 	str	r3, [r0], #4
-#ifdef CONFIG_ARM_LPAE
 	str	r7, [r0], #4
 #endif
+#else
+	orr	r3, r3, #PMD_SECT_XN
+	str	r3, [r0], #4
+#endif
 
 #else /* CONFIG_DEBUG_ICEDCC || CONFIG_DEBUG_SEMIHOSTING */
 	/* we don't need any serial debugging mappings */
-- 
1.8.0
