From: mans@mansr.com (Mans Rullgard)
Date: Fri,  2 Oct 2015 13:12:08 +0100
Subject: [PATCH] ARM: debug: add support for alternate 8250 register layout
Message-ID: <1443787929-19173-1-git-send-email-mans@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoCs have a UART with a non-standard register layout. This
allows the debug console to work with these.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
I would have preferred a more accurate description of the UART, but I've
not managed to figure out who the vendor is.
---
 arch/arm/Kconfig.debug        |  4 ++++
 arch/arm/include/debug/8250.S | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0cfd7f9..8d5c837 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1597,6 +1597,10 @@ config DEBUG_UART_8250_WORD
 		DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2 || \
 		DEBUG_BRCMSTB_UART
 
+config DEBUG_UART_8250_AU
+       bool "8250 UART has Alchemy register layout"
+       depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
+
 config DEBUG_UART_8250_FLOW_CONTROL
 	bool "Enable flow control for 8250 UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
diff --git a/arch/arm/include/debug/8250.S b/arch/arm/include/debug/8250.S
index 7f7446f..3c9ef68 100644
--- a/arch/arm/include/debug/8250.S
+++ b/arch/arm/include/debug/8250.S
@@ -9,6 +9,18 @@
  */
 #include <linux/serial_reg.h>
 
+#ifdef CONFIG_DEBUG_UART_8250_AU
+
+#undef UART_TX
+#undef UART_LSR
+#undef UART_MSR
+
+#define UART_TX 1
+#define UART_LSR 7
+#define UART_MSR 8
+
+#endif
+
 		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =CONFIG_DEBUG_UART_PHYS
 		ldr	\rv, =CONFIG_DEBUG_UART_VIRT
-- 
2.5.3
