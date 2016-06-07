From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue,  7 Jun 2016 17:24:39 +0200
Subject: [PATCH] ARM: at91: debug: use DEBUG_UART_VIRT
Message-ID: <1465313079-6307-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AT91 still uses an offset (0x0100 0000) from the physical address to map
the debug UART. This is unfortunate as for some platforms (sama5d3 and
earlier), it ends up in the PCI zone and PCI is enabled in multi_v7.
Switch to DEBUG_UART_VIRT to solve that.

Tested on sama5d3 and 9g20.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/Kconfig.debug        | 11 ++++++-----
 arch/arm/include/debug/at91.S | 10 +---------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 19a3dcf5eb2e..2609491f4ab1 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -117,15 +117,15 @@ choice
 		  their output to the serial port on atmel devices.
 
 		  SOC                  DEBUG_UART_PHYS   DEBUG_UART_VIRT  PORT
-		  rm9200, 9260/9g20,   0xfffff200        0xfefff200       DBGU
+		  rm9200, 9260/9g20,   0xfffff200        0xf8fff200       DBGU
 		  9261/9g10, 9rl
-		  9263, 9g45, sama5d3  0xffffee00        0xfeffee00       DBGU
+		  9263, 9g45, sama5d3  0xffffee00        0xf8ffee00       DBGU
 		  sama5d4              0xfc00c000        0xfb00c000       USART3
 		  sama5d4              0xfc069000        0xfb069000       DBGU
 		  sama5d2              0xf8020000        0xf7020000       UART1
 
-		  Please adjust DEBUG_UART_PHYS configuration options based on
-		  your needs.
+		  Please adjust DEBUG_UART_PHYS and DEBUG_UART_VIRT
+		  configuration options based on your needs.
 
 	config DEBUG_BCM2835
 		bool "Kernel low-level debugging on BCM2835 PL011 UART"
@@ -1627,7 +1627,8 @@ config DEBUG_UART_VIRT
 		DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART || \
 		DEBUG_S3C64XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
-		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0
+		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
+		DEBUG_AT91_UART
 
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
diff --git a/arch/arm/include/debug/at91.S b/arch/arm/include/debug/at91.S
index d4ae3b8e2426..0098401e5aeb 100644
--- a/arch/arm/include/debug/at91.S
+++ b/arch/arm/include/debug/at91.S
@@ -9,14 +9,6 @@
  *
 */
 
-#ifdef CONFIG_MMU
-#define AT91_IO_P2V(x) ((x) - 0x01000000)
-#else
-#define AT91_IO_P2V(x) (x)
-#endif
-
-#define AT91_DEBUG_UART_VIRT AT91_IO_P2V(CONFIG_DEBUG_UART_PHYS)
-
 #define AT91_DBGU_SR		(0x14)	/* Status Register */
 #define AT91_DBGU_THR		(0x1c)	/* Transmitter Holding Register */
 #define AT91_DBGU_TXRDY		(1 << 1)	/* Transmitter Ready */
@@ -24,7 +16,7 @@
 
 	.macro	addruart, rp, rv, tmp
 	ldr	\rp, =CONFIG_DEBUG_UART_PHYS		@ System peripherals (phys address)
-	ldr	\rv, =AT91_DEBUG_UART_VIRT		@ System peripherals (virt address)
+	ldr	\rv, =CONFIG_DEBUG_UART_VIRT		@ System peripherals (virt address)
 	.endm
 
 	.macro	senduart,rd,rx
-- 
2.8.1
