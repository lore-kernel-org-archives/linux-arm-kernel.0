From: mans@mansr.com (Mans Rullgard)
Date: Fri,  2 Oct 2015 16:19:13 +0100
Subject: [PATCH v2] ARM: debug: add support for Palmchip 16550-like UART
Message-ID: <1443799154-26768-1-git-send-email-mans@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoCs have a Palmchip UART with a non-standard register layout.
This allows the debug console to work with these.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
Changed in v2:
- Updated to reflect actual vendor of this UART
---
 arch/arm/Kconfig.debug        |  8 ++++++++
 arch/arm/include/debug/8250.S | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0cfd7f9..9039fff 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1597,6 +1597,14 @@ config DEBUG_UART_8250_WORD
 		DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2 || \
 		DEBUG_BRCMSTB_UART
 
+config DEBUG_UART_8250_PALMCHIP
+	bool "8250 UART is Palmchip variant"
+	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
+	help
+	  Palmchip provides a UART implementation compatible with 16550
+	  except for having a different register layout.  Say Y here if
+	  the debug UART is of this type.
+
 config DEBUG_UART_8250_FLOW_CONTROL
 	bool "Enable flow control for 8250 UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
diff --git a/arch/arm/include/debug/8250.S b/arch/arm/include/debug/8250.S
index 7f7446f..2332f40 100644
--- a/arch/arm/include/debug/8250.S
+++ b/arch/arm/include/debug/8250.S
@@ -9,6 +9,18 @@
  */
 #include <linux/serial_reg.h>
 
+#ifdef CONFIG_DEBUG_UART_8250_PALMCHIP
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
