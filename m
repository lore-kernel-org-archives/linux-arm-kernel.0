From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Mar 2012 01:44:27 -0400
Subject: [PATCH 1/2] DEBUG_LL: limit early mapping to the minimum
In-Reply-To: <1331876668-32492-1-git-send-email-nico@fluxnic.net>
References: <1331876668-32492-1-git-send-email-nico@fluxnic.net>
Message-ID: <1331876668-32492-2-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is just no point mapping up to 512MB for a serial port.
Using a single 1MB entry is way sufficient for all users.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/head.S |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 3bf0c7f8b0..835898e7d7 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -277,10 +277,6 @@ __create_page_tables:
 	mov	r3, r3, lsl #PMD_ORDER
 
 	add	r0, r4, r3
-	rsb	r3, r3, #0x4000			@ PTRS_PER_PGD*sizeof(long)
-	cmp	r3, #0x0800			@ limit to 512MB
-	movhi	r3, #0x0800
-	add	r6, r0, r3
 	mov	r3, r7, lsr #SECTION_SHIFT
 	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
 	orr	r3, r7, r3, lsl #SECTION_SHIFT
@@ -289,13 +285,10 @@ __create_page_tables:
 #else
 	orr	r3, r3, #PMD_SECT_XN
 #endif
-1:	str	r3, [r0], #4
+	str	r3, [r0], #4
 #ifdef CONFIG_ARM_LPAE
 	str	r7, [r0], #4
 #endif
-	add	r3, r3, #1 << SECTION_SHIFT
-	cmp	r0, r6
-	blo	1b
 
 #else /* CONFIG_DEBUG_ICEDCC || CONFIG_DEBUG_SEMIHOSTING */
 	/* we don't need any serial debugging mappings */
-- 
1.7.9.rc2
