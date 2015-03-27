From: jun.nie@linaro.org (Jun Nie)
Date: Fri, 27 Mar 2015 21:52:32 +0800
Subject: [PATCH v2 3/7] ARM: zx: add low level debug support for zx296702
In-Reply-To: <1427464356-20112-1-git-send-email-jun.nie@linaro.org>
References: <1427464356-20112-1-git-send-email-jun.nie@linaro.org>
Message-ID: <1427464356-20112-4-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the UART0 peripheral for low level debug. Only the UART port 0 is
currently supported.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 arch/arm/Kconfig.debug         | 14 ++++++++++++++
 arch/arm/include/debug/pl01x.S |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 970de75..8f0ad72 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1169,6 +1169,18 @@ choice
 		  For more details about semihosting, please see
 		  chapter 8 of DUI0203I_rvct_developer_guide.pdf from ARM Ltd.
 
+	config DEBUG_ZTE_ZX
+		bool "Use ZTE ZX UART"
+		select DEBUG_UART_PL01X
+		depends on ARCH_ZX
+		help
+		  Say Y here if you are enabling ZTE ZX296702 SOC and need
+		  debug uart support.
+
+		  This option is preferred over the platform specific
+		  options; the platform specific options are deprecated
+		  and will be soon removed.
+
 	config DEBUG_LL_UART_8250
 		bool "Kernel low-level debugging via 8250 UART"
 		help
@@ -1349,6 +1361,7 @@ config DEBUG_UART_PHYS
 	default 0x02531000 if DEBUG_KEYSTONE_UART1
 	default 0x03010fe0 if ARCH_RPC
 	default 0x07000000 if DEBUG_SUN9I_UART0
+	default 0x09405000 if DEBUG_ZTE_ZX
 	default 0x10009000 if DEBUG_REALVIEW_STD_PORT || \
 				DEBUG_VEXPRESS_UART0_CA9
 	default 0x1010c000 if DEBUG_REALVIEW_PB1176_PORT
@@ -1479,6 +1492,7 @@ config DEBUG_UART_VIRT
 	default 0xfb009000 if DEBUG_REALVIEW_STD_PORT
 	default 0xfb10c000 if DEBUG_REALVIEW_PB1176_PORT
 	default 0xfc40ab00 if DEBUG_BRCMSTB_UART
+	default 0xfc705000 if DEBUG_ZTE_ZX
 	default 0xfcfe8600 if DEBUG_UART_BCM63XX
 	default 0xfd000000 if ARCH_SPEAR3XX || ARCH_SPEAR6XX
 	default 0xfd000000 if ARCH_SPEAR13XX
diff --git a/arch/arm/include/debug/pl01x.S b/arch/arm/include/debug/pl01x.S
index 92ef808..f7d8323 100644
--- a/arch/arm/include/debug/pl01x.S
+++ b/arch/arm/include/debug/pl01x.S
@@ -12,6 +12,13 @@
 */
 #include <linux/amba/serial.h>
 
+#ifdef CONFIG_DEBUG_ZTE_ZX
+#undef UART01x_DR
+#undef UART01x_FR
+#define UART01x_DR     0x04
+#define UART01x_FR     0x14
+#endif
+
 #ifdef CONFIG_DEBUG_UART_PHYS
 		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =CONFIG_DEBUG_UART_PHYS
-- 
1.9.1
