From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Mon, 18 Jan 2016 09:27:47 +0100
Subject: [RESEND PATCH v2] ARM: debug: add support for Palmchip BK-310x UART
Message-ID: <569CA203.6050001@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mans Rullgard <mans@mansr.com>

Some SoCs use a Palmchip BK-310x UART which is mostly 16550 compatible
but with a different register layout. While this UART has previously
only been supported in MIPS based chips (Alchemy, Ralink), the ARM based
SMP87xx series from Sigma Designs also uses it.

This patch allows the debug console to work with this type of UART.

Signed-off-by: Mans Rullgard <mans@mansr.com>
Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
Peter, this is the patch I've been using on Tango for earlyprintk support.
arm-soc, this is just the Nov 8 patch with my Signed-off-by tag.
---
 arch/arm/Kconfig.debug            |  9 +++++++++
 arch/arm/include/debug/palmchip.S | 11 +++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/arm/include/debug/palmchip.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 259c0ca9c99a..708aa9150c00 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1304,6 +1304,7 @@ config DEBUG_SIRFSOC_UART
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/sa1100.S" if DEBUG_SA1100
+	default "debug/palmchip.S" if DEBUG_UART_8250_PALMCHIP
 	default "debug/8250.S" if DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	default "debug/at91.S" if DEBUG_AT91_UART
 	default "debug/asm9260.S" if DEBUG_ASM9260_UART
@@ -1588,6 +1589,14 @@ config DEBUG_UART_8250_WORD
 		DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2 || \
 		DEBUG_BRCMSTB_UART
 
+config DEBUG_UART_8250_PALMCHIP
+	bool "8250 UART is Palmchip BK-310x"
+	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
+	help
+	  Palmchip provides a UART implementation compatible with 16550
+	  except for having a different register layout.  Say Y here if
+	  the debug UART is of this type.
+
 config DEBUG_UART_8250_FLOW_CONTROL
 	bool "Enable flow control for 8250 UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
diff --git a/arch/arm/include/debug/palmchip.S b/arch/arm/include/debug/palmchip.S
new file mode 100644
index 000000000000..6824b2d1c38e
--- /dev/null
+++ b/arch/arm/include/debug/palmchip.S
@@ -0,0 +1,11 @@
+#include <linux/serial_reg.h>
+
+#undef UART_TX
+#undef UART_LSR
+#undef UART_MSR
+
+#define UART_TX 1
+#define UART_LSR 7
+#define UART_MSR 8
+
+#include <debug/8250.S>
