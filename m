From: johannes@sipsolutions.net (Johannes Berg)
Date: Wed, 27 Jan 2016 17:59:36 +0100
Subject: [PATCH v2 2/2] arm/mach-imx: enable big endian mode
In-Reply-To: <1453913976-30619-1-git-send-email-johannes@sipsolutions.net>
References: <1453913976-30619-1-git-send-email-johannes@sipsolutions.net>
Message-ID: <1453913976-30619-3-git-send-email-johannes@sipsolutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ARM big-endian mode on mach-imx. This requires adding some
byte swapping in the debug functions (which otherwise hang forever)
and of course the secondary core bringup.

Tested (on top of 4.4) on i.MX6 HummingBoard quad-core (IMX6Q).

The patch is pretty much as suggested by Arnd Bergmann, thanks!

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 arch/arm/include/debug/imx.S | 3 +++
 arch/arm/mach-imx/Kconfig    | 1 +
 arch/arm/mach-imx/headsmp.S  | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/include/debug/imx.S b/arch/arm/include/debug/imx.S
index 619d8cc1ac12..92c44760d656 100644
--- a/arch/arm/include/debug/imx.S
+++ b/arch/arm/include/debug/imx.S
@@ -11,6 +11,7 @@
  *
  */
 
+#include <asm/assembler.h>
 #include "imx-uart.h"
 
 /*
@@ -34,6 +35,7 @@
 		.endm
 
 		.macro	senduart,rd,rx
+		ARM_BE8(rev \rd, \rd)
 		str	\rd, [\rx, #0x40]	@ TXDATA
 		.endm
 
@@ -42,6 +44,7 @@
 
 		.macro	busyuart,rd,rx
 1002:		ldr	\rd, [\rx, #0x98]	@ SR2
+		ARM_BE8(rev \rd, \rd)
 		tst	\rd, #1 << 3		@ TXDC
 		beq	1002b			@ wait until transmit done
 		.endm
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 15df34fbdf44..607e0fedbf1c 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -9,6 +9,7 @@ menuconfig ARCH_MXC
 	select PM_OPP if PM
 	select SOC_BUS
 	select SRAM
+	select ARCH_SUPPORTS_BIG_ENDIAN
 	help
 	  Support for Freescale MXC/iMX-based family of processors
 
diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
index b5e976816b63..6c28d28b3c64 100644
--- a/arch/arm/mach-imx/headsmp.S
+++ b/arch/arm/mach-imx/headsmp.S
@@ -12,6 +12,7 @@
 
 #include <linux/linkage.h>
 #include <linux/init.h>
+#include <asm/assembler.h>
 
 diag_reg_offset:
 	.word	g_diag_reg - .
@@ -25,6 +26,7 @@ diag_reg_offset:
 	.endm
 
 ENTRY(v7_secondary_startup)
+ARM_BE8(setend be)			@ go BE8 if entered LE
 	set_diag_reg
 	b	secondary_startup
 ENDPROC(v7_secondary_startup)
-- 
2.6.2
