From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 08 Jun 2011 23:53:02 -0400 (EDT)
Subject: [PATCH] ARM: zImage: fix Thumb2 breakage
Message-ID: <alpine.LFD.2.00.1106082350500.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Commit af3e4fd37a "ARM: 6859/1: Add writethrough dcache support for
ARM926EJS processor" broke Thumb2 compilation by omitting to maintain
the wide encoding for the added branch instructions which made the
ARM926EJ-S record smaller than expected, breaking the record walk code.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
CC: Mark A. Greer <mgreer@mvista.com>
---
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index f9da419..942fad9 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -691,9 +691,9 @@ proc_types:
 
 		.word	0x41069260		@ ARM926EJ-S (v5TEJ)
 		.word	0xff0ffff0
-		b	__arm926ejs_mmu_cache_on
-		b	__armv4_mmu_cache_off
-		b	__armv5tej_mmu_cache_flush
+		W(b)	__arm926ejs_mmu_cache_on
+		W(b)	__armv4_mmu_cache_off
+		W(b)	__armv5tej_mmu_cache_flush
 
 		.word	0x00007000		@ ARM7 IDs
 		.word	0x0000f000
