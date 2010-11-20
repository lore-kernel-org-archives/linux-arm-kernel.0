From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 20 Nov 2010 11:08:48 +0100
Subject: [PATCH 1/6] at91: Convert remaining boards to new-style UART
	initialization
In-Reply-To: <20101120095906.GD4216@game.jcrosoft.org>
References: <20101120095906.GD4216@game.jcrosoft.org>
Message-ID: <1290247733-17834-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the following AT91RM9200-based boards to the new-style UART
initialization:
  - Ajeco 1ARM Single Board Computer
  - Sperry-Sun KAFA board
  - picotux 200

Remove the deprecated at91_init_serial

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/at91rm9200_devices.c |   45 -------------------------------
 arch/arm/mach-at91/board-1arm.c         |   26 +++++++++---------
 arch/arm/mach-at91/board-kafa.c         |   21 +++++---------
 arch/arm/mach-at91/board-picotux200.c   |   23 +++++++---------
 arch/arm/mach-at91/include/mach/board.h |    6 ----
 5 files changed, 31 insertions(+), 90 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 9338825..7b53922 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -1106,51 +1106,6 @@ static inline void configure_usart3_pins(unsigned pins)
 static struct platform_device *__initdata at91_uarts[ATMEL_MAX_UART];	/* the UARTs to use */
 struct platform_device *atmel_default_console_device;	/* the serial console device */
 
-void __init __deprecated at91_init_serial(struct at91_uart_config *config)
-{
-	int i;
-
-	/* Fill in list of supported UARTs */
-	for (i = 0; i < config->nr_tty; i++) {
-		switch (config->tty_map[i]) {
-			case 0:
-				configure_usart0_pins(ATMEL_UART_CTS | ATMEL_UART_RTS);
-				at91_uarts[i] = &at91rm9200_uart0_device;
-				at91_clock_associate("usart0_clk", &at91rm9200_uart0_device.dev, "usart");
-				break;
-			case 1:
-				configure_usart1_pins(ATMEL_UART_CTS | ATMEL_UART_RTS | ATMEL_UART_DSR | ATMEL_UART_DTR | ATMEL_UART_DCD | ATMEL_UART_RI);
-				at91_uarts[i] = &at91rm9200_uart1_device;
-				at91_clock_associate("usart1_clk", &at91rm9200_uart1_device.dev, "usart");
-				break;
-			case 2:
-				configure_usart2_pins(0);
-				at91_uarts[i] = &at91rm9200_uart2_device;
-				at91_clock_associate("usart2_clk", &at91rm9200_uart2_device.dev, "usart");
-				break;
-			case 3:
-				configure_usart3_pins(0);
-				at91_uarts[i] = &at91rm9200_uart3_device;
-				at91_clock_associate("usart3_clk", &at91rm9200_uart3_device.dev, "usart");
-				break;
-			case 4:
-				configure_dbgu_pins();
-				at91_uarts[i] = &at91rm9200_dbgu_device;
-				at91_clock_associate("mck", &at91rm9200_dbgu_device.dev, "usart");
-				break;
-			default:
-				continue;
-		}
-		at91_uarts[i]->id = i;		/* update ID number to mapped ID */
-	}
-
-	/* Set serial console device */
-	if (config->console_tty < ATMEL_MAX_UART)
-		atmel_default_console_device = at91_uarts[config->console_tty];
-	if (!atmel_default_console_device)
-		printk(KERN_INFO "AT91: No default serial console defined.\n");
-}
-
 void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins)
 {
 	struct platform_device *pdev;
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index 46bdc82..8a3fc84 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -39,24 +39,24 @@
 #include "generic.h"
 
 
-/*
- * Serial port configuration.
- *    0 .. 3 = USART0 .. USART3
- *    4      = DBGU
- */
-static struct at91_uart_config __initdata onearm_uart_config = {
-	.console_tty	= 0,				/* ttyS0 */
-	.nr_tty		= 3,
-	.tty_map	= { 4, 0, 1, -1, -1 },		/* ttyS0, ..., ttyS4 */
-};
-
 static void __init onearm_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91rm9200_initialize(18432000, AT91RM9200_PQFP);
 
-	/* Setup the serial ports and console */
-	at91_init_serial(&onearm_uart_config);
+	/* DBGU on ttyS0. (Rx & Tx only) */
+	at91_register_uart(0, 0, 0);
+
+	/* USART0 on ttyS1 (Rx, Tx, CTS, RTS) */
+	at91_register_uart(AT91RM9200_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
+
+	/* USART1 on ttyS2 (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
+	at91_register_uart(AT91RM9200_ID_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS
+			   | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
+			   | ATMEL_UART_RI);
+
+	/* set serial console to ttyS0 (ie, DBGU) */
+	at91_set_serial_console(0);
 }
 
 static void __init onearm_init_irq(void)
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index c0ce79d..d2e1f4e 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -39,17 +39,6 @@
 #include "generic.h"
 
 
-/*
- * Serial port configuration.
- *    0 .. 3 = USART0 .. USART3
- *    4      = DBGU
- */
-static struct at91_uart_config __initdata kafa_uart_config = {
-	.console_tty	= 0,				/* ttyS0 */
-	.nr_tty		= 2,
-	.tty_map	= { 4, 0, -1, -1, -1 }		/* ttyS0, ..., ttyS4 */
-};
-
 static void __init kafa_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
@@ -58,8 +47,14 @@ static void __init kafa_map_io(void)
 	/* Set up the LEDs */
 	at91_init_leds(AT91_PIN_PB4, AT91_PIN_PB4);
 
-	/* Setup the serial ports and console */
-	at91_init_serial(&kafa_uart_config);
+	/* DBGU on ttyS0. (Rx & Tx only) */
+	at91_register_uart(0, 0, 0);
+
+	/* USART0 on ttyS1 (Rx, Tx, CTS, RTS) */
+	at91_register_uart(AT91RM9200_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
+
+	/* set serial console to ttyS0 (ie, DBGU) */
+	at91_set_serial_console(0);
 }
 
 static void __init kafa_init_irq(void)
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index 9d833bb..ac1a3b5 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -43,24 +43,21 @@
 #include "generic.h"
 
 
-/*
- * Serial port configuration.
- *    0 .. 3 = USART0 .. USART3
- *    4      = DBGU
- */
-static struct at91_uart_config __initdata picotux200_uart_config = {
-	.console_tty	= 0,				/* ttyS0 */
-	.nr_tty		= 2,
-	.tty_map	= { 4, 1, -1, -1, -1 }		/* ttyS0, ..., ttyS4 */
-};
-
 static void __init picotux200_map_io(void)
 {
 	/* Initialize processor: 18.432 MHz crystal */
 	at91rm9200_initialize(18432000, AT91RM9200_BGA);
 
-	/* Setup the serial ports and console */
-	at91_init_serial(&picotux200_uart_config);
+	/* DBGU on ttyS0. (Rx & Tx only) */
+	at91_register_uart(0, 0, 0);
+
+	/* USART1 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
+	at91_register_uart(AT91RM9200_ID_US1, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
+			  | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
+			  | ATMEL_UART_RI);
+
+	/* set serial console to ttyS0 (ie, DBGU) */
+	at91_set_serial_console(0);
 }
 
 static void __init picotux200_init_irq(void)
diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index 58528aa..2b499eb 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -137,13 +137,7 @@ extern void __init at91_add_device_spi(struct spi_board_info *devices, int nr_de
 extern void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins);
 extern void __init at91_set_serial_console(unsigned portnr);
 
-struct at91_uart_config {
-	unsigned short	console_tty;	/* tty number of serial console */
-	unsigned short	nr_tty;		/* number of serial tty's */
-	short		tty_map[];	/* map UART to tty number */
-};
 extern struct platform_device *atmel_default_console_device;
-extern void __init __deprecated at91_init_serial(struct at91_uart_config *config);
 
 struct atmel_uart_data {
 	short			use_dma_tx;	/* use transmit DMA? */
-- 
1.7.1
