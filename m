From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 15:59:40 +0900
Subject: [PATCH 02/15] ARM: shmobile: Let romImage rely on default ATAGS
In-Reply-To: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371106793-25071-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove the ATAGS data structure from head-shmobile.S
since a default ATAGS is already provided by the code
in arch/arm/kernel/atags_parser.c. Passing a NULL as
ATAGS is valid. For actual hardware specific setup
the fixup callback in the board code may be used.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/compressed/head-shmobile.S | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/arm/boot/compressed/head-shmobile.S b/arch/arm/boot/compressed/head-shmobile.S
index fe3719b..19b2304 100644
--- a/arch/arm/boot/compressed/head-shmobile.S
+++ b/arch/arm/boot/compressed/head-shmobile.S
@@ -55,26 +55,9 @@ __tmp_stack:
 __continue:
 #endif /* CONFIG_ZBOOT_ROM_MMC || CONFIG_ZBOOT_ROM_SH_MOBILE_SDHI */
 
-	b	1f
-__atags:@ tag #1
-	.long	12			@ tag->hdr.size = tag_size(tag_core);
-	.long	0x54410001		@ tag->hdr.tag = ATAG_CORE;
-	.long   0			@ tag->u.core.flags = 0;
-	.long	0			@ tag->u.core.pagesize = 0;
-	.long	0			@ tag->u.core.rootdev = 0;
-	@ tag #2
-	.long	8			@ tag->hdr.size = tag_size(tag_mem32);
-	.long	0x54410002		@ tag->hdr.tag = ATAG_MEM;
-	.long	CONFIG_MEMORY_SIZE	@ tag->u.mem.size = CONFIG_MEMORY_SIZE;
-	.long	CONFIG_MEMORY_START	@ @ tag->u.mem.start = CONFIG_MEMORY_START;
-	@ tag #3
-	.long	0			@ tag->hdr.size = 0
-	.long	0			@ tag->hdr.tag = ATAG_NONE;
-1:
-
 	/* Set board ID necessary for boot */
 	ldr	r7, 1f				@ Set machine type register
-	adr	r8, __atags			@ Set atag register
+	mov	r8, #0				@ pass null pointer as atag
 	b	2f
 
 1 :	.long MACH_TYPE
-- 
1.8.2.1
