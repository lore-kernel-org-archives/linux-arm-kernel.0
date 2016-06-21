From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 11:20:22 +0100
Subject: [[PATCH v2] 01/11] ARM: EXYNOS: fixup debug macros for big-endian
In-Reply-To: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1466504432-24187-2-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos low-level debug macros need to be fixed if the system is being
built big endian. Add the necessary endian swaps for accessing the registers
to get output working again

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/include/debug/samsung.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/include/debug/samsung.S b/arch/arm/include/debug/samsung.S
index 8d8d922..f4eeed2 100644
--- a/arch/arm/include/debug/samsung.S
+++ b/arch/arm/include/debug/samsung.S
@@ -15,11 +15,13 @@
 
 	.macro fifo_level_s5pv210 rd, rx
 		ldr	\rd, [\rx, # S3C2410_UFSTAT]
+ARM_BE8(rev \rd, \rd)
 		and	\rd, \rd, #S5PV210_UFSTAT_TXMASK
 	.endm
 
 	.macro  fifo_full_s5pv210 rd, rx
 		ldr	\rd, [\rx, # S3C2410_UFSTAT]
+ARM_BE8(rev \rd, \rd)
 		tst	\rd, #S5PV210_UFSTAT_TXFULL
 	.endm
 
@@ -28,6 +30,7 @@
 
 	.macro fifo_level_s3c2440 rd, rx
 		ldr	\rd, [\rx, # S3C2410_UFSTAT]
+ARM_BE8(rev \rd, \rd)
 		and	\rd, \rd, #S3C2440_UFSTAT_TXMASK
 	.endm
 
@@ -37,6 +40,7 @@
 
 	.macro  fifo_full_s3c2440 rd, rx
 		ldr	\rd, [\rx, # S3C2410_UFSTAT]
+ARM_BE8(rev \rd, \rd)
 		tst	\rd, #S3C2440_UFSTAT_TXFULL
 	.endm
 
@@ -50,6 +54,7 @@
 
 	.macro	busyuart, rd, rx
 		ldr	\rd, [\rx, # S3C2410_UFCON]
+ARM_BE8(rev \rd, \rd)
 		tst	\rd, #S3C2410_UFCON_FIFOMODE	@ fifo enabled?
 		beq	1001f				@
 		@ FIFO enabled...
@@ -61,6 +66,7 @@
 1001:
 		@ busy waiting for non fifo
 		ldr	\rd, [\rx, # S3C2410_UTRSTAT]
+ARM_BE8(rev \rd, \rd)
 		tst	\rd, #S3C2410_UTRSTAT_TXFE
 		beq	1001b
 
@@ -69,6 +75,7 @@
 
 	.macro	waituart,rd,rx
 		ldr	\rd, [\rx, # S3C2410_UFCON]
+ARM_BE8(rev \rd, \rd)
 		tst	\rd, #S3C2410_UFCON_FIFOMODE	@ fifo enabled?
 		beq	1001f				@
 		@ FIFO enabled...
@@ -80,6 +87,7 @@
 1001:
 		@ idle waiting for non fifo
 		ldr	\rd, [\rx, # S3C2410_UTRSTAT]
+ARM_BE8(rev \rd, \rd)
 		tst	\rd, #S3C2410_UTRSTAT_TXFE
 		beq	1001b
 
-- 
2.8.1
