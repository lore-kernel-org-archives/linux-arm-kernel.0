From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 11 Dec 2013 02:44:35 +0400
Subject: [PATCH] ARM: debug: move StrongARM debug include to
 arch/arm/include/debug
Message-ID: <1386715475-17966-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

StrongARM debug-macro.S is quite standalone thing, depending only on
register mappings. Move it to proper place and add Kconfig entry.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/Kconfig.debug                                           | 9 +++++++++
 .../include/mach/debug-macro.S => include/debug/sa1100.S}        | 0
 2 files changed, 9 insertions(+)
 rename arch/arm/{mach-sa1100/include/mach/debug-macro.S => include/debug/sa1100.S} (100%)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 9762c84..55ae5cf 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -493,6 +493,14 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on PXA UART1.
 
+	config DEBUG_SA1100
+		depends on ARCH_SA1100
+		bool "Use SA1100 UARTs for low-level debug"
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on SA-11x0 UART ports. The kernel will check for the first
+		  enabled UART in a sequence 3-1-2.
+
 	config DEBUG_REALVIEW_STD_PORT
 		bool "RealView Default UART"
 		depends on ARCH_REALVIEW
@@ -882,6 +890,7 @@ config DEBUG_STI_UART
 
 config DEBUG_LL_INCLUDE
 	string
+	default "debug/sa1100.S" if DEBUG_SA1100
 	default "debug/8250.S" if DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	default "debug/pl01x.S" if DEBUG_LL_UART_PL01X || DEBUG_UART_PL01X
 	default "debug/exynos.S" if DEBUG_EXYNOS_UART
diff --git a/arch/arm/mach-sa1100/include/mach/debug-macro.S b/arch/arm/include/debug/sa1100.S
similarity index 100%
rename from arch/arm/mach-sa1100/include/mach/debug-macro.S
rename to arch/arm/include/debug/sa1100.S
-- 
1.8.4.3
