From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 8 Nov 2011 12:36:36 +0100 (CET)
Subject: [PATCH] fix compilation breakage in entry-armv.S
Message-ID: <Pine.LNX.4.64.1111081232140.10851@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compilation of Linus' tree of today without THUMB support for V7 machines 
breaks:

linux-2.6/arch/arm/kernel/entry-armv.S: Assembler messages:
linux-2.6/arch/arm/kernel/entry-armv.S:501: Error: backward ref to unknown label "2:"
linux-2.6/arch/arm/kernel/entry-armv.S:502: Error: backward ref to unknown label "3:"
make[2]: *** [arch/arm/kernel/entry-armv.o] Error 1

Fix this by adding a check for CONFIG_ARM_THUMB.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 9ad50c4..6f8fbfe 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -497,7 +497,7 @@ ENDPROC(__und_usr)
 	.popsection
 	.pushsection __ex_table,"a"
 	.long	1b, 4b
-#if __LINUX_ARM_ARCH__ >= 7
+#if CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 7
 	.long	2b, 4b
 	.long	3b, 4b
 #endif
