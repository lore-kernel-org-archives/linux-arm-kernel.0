From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 Jul 2014 17:11:18 +0100
Subject: [PATCH] exynos: boot serial endian fix
Message-ID: <1405959078-10603-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Kamensky <victor.kamensky@linaro.org>

In order to support booting a big endian kernel the uncompress serial
line write utils need to use endian neutral functions to read h/w
register. Fix uart_rd, uart_wr and serial chip fifo related macros to do
this.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm/include/debug/samsung.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/include/debug/samsung.S b/arch/arm/include/debug/samsung.S
index 8d8d922e5e44..dc62d4ae04d0 100644
--- a/arch/arm/include/debug/samsung.S
+++ b/arch/arm/include/debug/samsung.S
@@ -9,17 +9,20 @@
  * published by the Free Software Foundation.
 */
 
+#include <asm/assembler.h>
 #include <linux/serial_s3c.h>
 
 /* The S5PV210/S5PC110 implementations are as belows. */
 
 	.macro fifo_level_s5pv210 rd, rx
 		ldr	\rd, [\rx, # S3C2410_UFSTAT]
+	ARM_BE8(rev	\rd, \rd)
 		and	\rd, \rd, #S5PV210_UFSTAT_TXMASK
 	.endm
 
 	.macro  fifo_full_s5pv210 rd, rx
 		ldr	\rd, [\rx, # S3C2410_UFSTAT]
+	ARM_BE8(rev	\rd, \rd)
 		tst	\rd, #S5PV210_UFSTAT_TXFULL
 	.endm
 
@@ -28,6 +31,7 @@
 
 	.macro fifo_level_s3c2440 rd, rx
 		ldr	\rd, [\rx, # S3C2410_UFSTAT]
+	ARM_BE8(rev	\rd, \rd)
 		and	\rd, \rd, #S3C2440_UFSTAT_TXMASK
 	.endm
 
@@ -37,6 +41,7 @@
 
 	.macro  fifo_full_s3c2440 rd, rx
 		ldr	\rd, [\rx, # S3C2410_UFSTAT]
+	ARM_BE8(rev	\rd, \rd)
 		tst	\rd, #S3C2440_UFSTAT_TXFULL
 	.endm
 
@@ -50,6 +55,7 @@
 
 	.macro	busyuart, rd, rx
 		ldr	\rd, [\rx, # S3C2410_UFCON]
+	ARM_BE8(rev	\rd, \rd)
 		tst	\rd, #S3C2410_UFCON_FIFOMODE	@ fifo enabled?
 		beq	1001f				@
 		@ FIFO enabled...
@@ -61,6 +67,7 @@
 1001:
 		@ busy waiting for non fifo
 		ldr	\rd, [\rx, # S3C2410_UTRSTAT]
+	ARM_BE8(rev	\rd, \rd)
 		tst	\rd, #S3C2410_UTRSTAT_TXFE
 		beq	1001b
 
@@ -69,6 +76,7 @@
 
 	.macro	waituart,rd,rx
 		ldr	\rd, [\rx, # S3C2410_UFCON]
+	ARM_BE8(rev	\rd, \rd)
 		tst	\rd, #S3C2410_UFCON_FIFOMODE	@ fifo enabled?
 		beq	1001f				@
 		@ FIFO enabled...
@@ -80,6 +88,7 @@
 1001:
 		@ idle waiting for non fifo
 		ldr	\rd, [\rx, # S3C2410_UTRSTAT]
+	ARM_BE8(rev	\rd, \rd)
 		tst	\rd, #S3C2410_UTRSTAT_TXFE
 		beq	1001b
 
-- 
2.0.1
