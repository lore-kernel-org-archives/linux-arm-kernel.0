From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 23:14:29 +0100
Subject: [PATCH 3/5] ARM: cns3xxx: move debug_ll code to include/debug/
In-Reply-To: <1363299271-8283-1-git-send-email-arnd@arndb.de>
References: <1363299271-8283-1-git-send-email-arnd@arndb.de>
Message-ID: <1363299271-8283-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed in order to keep debug_ll functionality on
cns3xxx working when we enable ARCH_MULTIPLATFORM.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug                                            | 8 ++++++++
 arch/arm/configs/cns3420vb_defconfig                              | 1 +
 .../include/mach/debug-macro.S => include/debug/cns3xxx.S}        | 0
 3 files changed, 9 insertions(+)
 rename arch/arm/{mach-cns3xxx/include/mach/debug-macro.S => include/debug/cns3xxx.S} (100%)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index acdddda..52f410d 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -103,6 +103,13 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the second serial port on these devices.
 
+	config DEBUG_CNS3XXX
+		bool "Kernel Kernel low-level debugging on Cavium Networks CNS3xxx"
+		depends on ARCH_CNS3XXX
+		help
+		  Say Y here if you want the debug print routines to direct
+                  their output to the CNS3xxx UART0.
+
 	config DEBUG_DAVINCI_DA8XX_UART1
 		bool "Kernel low-level debugging on DaVinci DA8XX using UART1"
 		depends on ARCH_DAVINCI_DA8XX
@@ -579,6 +586,7 @@ endchoice
 
 config DEBUG_LL_INCLUDE
 	string
+	default "debug/cns3xxx.S" if DEBUG_CNS3XXX
 	default "debug/icedcc.S" if DEBUG_ICEDCC
 	default "debug/imx.S" if DEBUG_IMX1_UART || \
 				 DEBUG_IMX25_UART || \
diff --git a/arch/arm/configs/cns3420vb_defconfig b/arch/arm/configs/cns3420vb_defconfig
index 313627a..b79e984 100644
--- a/arch/arm/configs/cns3420vb_defconfig
+++ b/arch/arm/configs/cns3420vb_defconfig
@@ -21,6 +21,7 @@ CONFIG_MODVERSIONS=y
 CONFIG_IOSCHED_CFQ=m
 CONFIG_ARCH_CNS3XXX=y
 CONFIG_MACH_CNS3420VB=y
+CONFIG_DEBUG_CNS3XXX=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
diff --git a/arch/arm/mach-cns3xxx/include/mach/debug-macro.S b/arch/arm/include/debug/cns3xxx.S
similarity index 100%
rename from arch/arm/mach-cns3xxx/include/mach/debug-macro.S
rename to arch/arm/include/debug/cns3xxx.S
-- 
1.8.1.2
