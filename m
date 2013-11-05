From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  5 Nov 2013 13:35:59 +0100
Subject: [PATCH] ARM/serial: at91: switch atmel serial to use gpiolib
Message-ID: <1383654959-18112-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This passes the errata fix using a GPIO to control the RTS pin
on one of the AT91 chips to use gpiolib instead of the
AT91-specific interfaces. Also remove the reliance on
compile-time #defines and the cpu_* check and rely on the
platform passing down the proper GPIO pin through platform
data.

This is a prerequisite for getting rid of the local GPIO
implementation in the AT91 platform and move toward
multiplatform.

This also makes way for device tree conversion: the RTS
GPIO pin can be passed by standard GPIO bindings.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This is an alternative to the patch entitled
"ARM/serial: at91: move machine quirk into machine"
which needs testing to confirm this approach.
Seeking ACKs on this if the approach seems OK to
all parties.
---
 arch/arm/mach-at91/at91rm9200_devices.c |  1 +
 drivers/tty/serial/atmel_serial.c       | 51 +++++++++++++++++++++------------
 include/linux/platform_data/atmel.h     |  1 +
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index c721e9b08066..51d4c08962f6 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -961,6 +961,7 @@ static struct resource uart0_resources[] = {
 static struct atmel_uart_data uart0_data = {
 	.use_dma_tx	= 1,
 	.use_dma_rx	= 1,
+	.rts_gpio	= AT91_PIN_PA21,
 };
 
 static u64 uart0_dmamask = DMA_BIT_MASK(32);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index d067285a2d20..3d5c848cdfe1 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -41,15 +41,11 @@
 #include <linux/uaccess.h>
 #include <linux/platform_data/atmel.h>
 #include <linux/timer.h>
+#include <linux/gpio.h>
 
 #include <asm/io.h>
 #include <asm/ioctls.h>
 
-#ifdef CONFIG_ARM
-#include <mach/cpu.h>
-#include <asm/gpio.h>
-#endif
-
 #define PDC_BUFFER_SIZE		512
 /* Revisit: We should calculate this based on the actual port settings */
 #define PDC_RX_TIMEOUT		(3 * 10)		/* 3 bytes */
@@ -167,6 +163,7 @@ struct atmel_uart_port {
 	struct circ_buf		rx_ring;
 
 	struct serial_rs485	rs485;		/* rs485 settings */
+	int			rts_gpio;	/* optional RTS GPIO */
 	unsigned int		tx_done_mask;
 	bool			is_usart;	/* usart or uart */
 	struct timer_list	uart_timer;	/* uart timer */
@@ -300,20 +297,17 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
 	unsigned int mode;
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
-#ifdef CONFIG_ARCH_AT91RM9200
-	if (cpu_is_at91rm9200()) {
-		/*
-		 * AT91RM9200 Errata #39: RTS0 is not internally connected
-		 * to PA21. We need to drive the pin manually.
-		 */
-		if (port->mapbase == AT91RM9200_BASE_US0) {
-			if (mctrl & TIOCM_RTS)
-				at91_set_gpio_value(AT91_PIN_PA21, 0);
-			else
-				at91_set_gpio_value(AT91_PIN_PA21, 1);
-		}
+	/*
+	 * AT91RM9200 Errata #39: RTS0 is not internally connected
+	 * to PA21. We need to drive the pin as a GPIO.
+	 */
+	if (gpio_is_valid(atmel_port->rts_gpio) &&
+	    port->mapbase == AT91RM9200_BASE_US0) {
+		if (mctrl & TIOCM_RTS)
+			gpio_set_value(atmel_port->rts_gpio, 0);
+		else
+			gpio_set_value(atmel_port->rts_gpio, 1);
 	}
-#endif
 
 	if (mctrl & TIOCM_RTS)
 		control |= ATMEL_US_RTSEN;
@@ -2365,6 +2359,27 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	port = &atmel_ports[ret];
 	port->backup_imr = 0;
 	port->uart.line = ret;
+	port->rts_gpio = -1; /* Invalid, zero could be valid */
+	/*
+	 * In theory the GPIO pin controlling RTS could be zero and
+	 * this would be an improper check, but we know that the only
+	 * existing case is != 0 and it's nice to use the zero-initialized
+	 * structs to indicate "no RTS GPIO" instead of open-coding some
+	 * invalid value everywhere.
+	 */
+	if (pdata->rts_gpio > 0) {
+		ret = devm_gpio_request(&pdev->dev, pdata->rts_gpio, "RTS");
+		if (ret) {
+			dev_err(&pdev->dev, "error requesting RTS GPIO\n");
+			goto err;
+		}
+		port->rts_gpio = pdata->rts_gpio;
+		ret = gpio_direction_output(port->rts_gpio, 0);
+		if (ret) {
+			dev_err(&pdev->dev, "error setting up RTS GPIO\n");
+			goto err;
+		}
+	}
 
 	ret = atmel_init_port(port, pdev);
 	if (ret)
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index cea9f70133c5..e26b0c14edea 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -84,6 +84,7 @@ struct atmel_uart_data {
 	short			use_dma_rx;	/* use receive DMA? */
 	void __iomem		*regs;		/* virt. base address, if any */
 	struct serial_rs485	rs485;		/* rs485 settings */
+	int			rts_gpio;	/* optional RTS GPIO */
 };
 
  /* Touchscreen Controller */
-- 
1.8.3.1
