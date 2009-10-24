From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:12:09 +0400
Subject: [PATCH 09/20] SA1100: h3100/h3600: convert all users of
	assign_h3600_egpio to gpiolib
In-Reply-To: <1256414910-22665-2-git-send-email-mad_soft@inbox.ru>
References: <1256414910-22665-2-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256415129-22701-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use of gpio_request/gpio_free in some callbacks may look ugly, but
corresponding drivers (sa1100_serial and sa1100_fb) don't provide (yet)
init/exit hooks and registering these gpios in *_mach_init is also
not possible, because htc-gpio driver starts a bit later...

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/h3600.c  |   87 ++++++++++++++++++++++++++++++++++++++---
 drivers/pcmcia/sa1100_h3600.c |   57 +++++++++++++++++++++------
 2 files changed, 126 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 429fdb0..5e6011c 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -111,12 +111,32 @@ static struct mtd_partition h3xxx_partitions[] = {
 
 static void h3xxx_set_vpp(int vpp)
 {
-	assign_h3600_egpio(IPAQ_EGPIO_VPP_ON, vpp);
+	gpio_set_value(H3XXX_EGPIO_VPP_ON, vpp);
+}
+
+static int h3xxx_flash_init(void)
+{
+	int err = gpio_request(H3XXX_EGPIO_VPP_ON, "Flash Vpp");
+	if (err)
+		return err;
+
+	err = gpio_direction_output(H3XXX_EGPIO_VPP_ON, 0);
+	if (err)
+		gpio_free(H3XXX_EGPIO_VPP_ON);
+
+	return err;
+}
+
+static void h3xxx_flash_exit(void)
+{
+	gpio_free(H3XXX_EGPIO_VPP_ON);
 }
 
 static struct flash_platform_data h3xxx_flash_data = {
 	.map_name	= "cfi_probe",
 	.set_vpp	= h3xxx_set_vpp,
+	.init		= h3xxx_flash_init,
+	.exit		= h3xxx_flash_exit,
 	.parts		= h3xxx_partitions,
 	.nr_parts	= ARRAY_SIZE(h3xxx_partitions),
 };
@@ -158,7 +178,10 @@ static u_int h3xxx_uart_get_mctrl(struct uart_port *port)
 static void h3xxx_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 {
 	if (port->mapbase == _Ser3UTCR0)
-		assign_h3600_egpio(IPAQ_EGPIO_RS232_ON, !state);
+		if (!gpio_request(H3XXX_EGPIO_RS232_ON, "RS232 transceiver")) {
+			gpio_direction_output(H3XXX_EGPIO_RS232_ON, !state);
+			gpio_free(H3XXX_EGPIO_RS232_ON);
+		}
 }
 
 /*
@@ -362,7 +385,11 @@ static void h3100_control_egpio(enum ipaq_egpio_type x, int setp)
  */
 static void h3100_lcd_power(int enable)
 {
-	assign_h3600_egpio(IPAQ_EGPIO_LCD_POWER, enable);
+	if (!gpio_request(H3XXX_EGPIO_LCD_ON, "LCD ON")) {
+		gpio_set_value(H3100_GPIO_LCD_3V_ON, enable);
+		gpio_direction_output(H3XXX_EGPIO_LCD_ON, enable);
+		gpio_free(H3XXX_EGPIO_LCD_ON);
+	}
 }
 
 
@@ -412,6 +439,7 @@ static struct gpio_default_state h3100_default_gpio[] = {
 	{ H3XXX_GPIO_COM_DCD,	GPIO_MODE_IN,	"COM DCD" },
 	{ H3XXX_GPIO_COM_CTS,	GPIO_MODE_IN,	"COM CTS" },
 	{ H3XXX_GPIO_COM_RTS,	GPIO_MODE_OUT0,	"COM RTS" },
+	{ H3100_GPIO_LCD_3V_ON,	GPIO_MODE_OUT0,	"LCD 3v" },
 };
 
 static void __init h3100_mach_init(void)
@@ -506,7 +534,25 @@ static void h3600_control_egpio(enum ipaq_egpio_type x, int setp)
  */
 static void h3600_lcd_power(int enable)
 {
-	assign_h3600_egpio(IPAQ_EGPIO_LCD_POWER, enable);
+	if (gpio_request(H3XXX_EGPIO_LCD_ON, "LCD power"))
+		goto err1;
+	if (gpio_request(H3600_EGPIO_LCD_PCI, "LCD control"))
+		goto err2;
+	if (gpio_request(H3600_EGPIO_LCD_5V_ON, "LCD 5v"))
+		goto err3;
+	if (gpio_request(H3600_EGPIO_LVDD_ON, "LCD 9v/-6.5v"))
+		goto err4;
+
+	gpio_direction_output(H3XXX_EGPIO_LCD_ON, enable);
+	gpio_direction_output(H3600_EGPIO_LCD_PCI, enable);
+	gpio_direction_output(H3600_EGPIO_LCD_5V_ON, enable);
+	gpio_direction_output(H3600_EGPIO_LVDD_ON, enable);
+
+	gpio_free(H3600_EGPIO_LVDD_ON);
+err4:	gpio_free(H3600_EGPIO_LCD_5V_ON);
+err3:	gpio_free(H3600_EGPIO_LCD_PCI);
+err2:	gpio_free(H3XXX_EGPIO_LCD_ON);
+err1:	return;
 }
 
 static void __init h3600_map_io(void)
@@ -531,18 +577,47 @@ static void __init h3600_map_io(void)
  */
 static int h3600_irda_set_power(struct device *dev, unsigned int state)
 {
-	assign_h3600_egpio(IPAQ_EGPIO_IR_ON, state);
+	gpio_set_value(H3600_EGPIO_IR_ON, state);
 	return 0;
 }
 
 static void h3600_irda_set_speed(struct device *dev, unsigned int speed)
 {
-	assign_h3600_egpio(IPAQ_EGPIO_IR_FSEL, !(speed < 4000000));
+	gpio_set_value(H3600_EGPIO_IR_FSEL, !(speed < 4000000));
+}
+
+static int h3600_irda_startup(struct device *dev)
+{
+	int err = gpio_request(H3600_EGPIO_IR_ON, "IrDA power");
+	if (err)
+		goto err1;
+	err = gpio_direction_output(H3600_EGPIO_IR_ON, 0);
+	if (err)
+		goto err2;
+	err = gpio_request(H3600_EGPIO_IR_FSEL, "IrDA fsel");
+	if (err)
+		goto err2;
+	err = gpio_direction_output(H3600_EGPIO_IR_FSEL, 0);
+	if (err)
+		goto err3;
+	return 0;
+
+err3:	gpio_free(H3600_EGPIO_IR_FSEL);
+err2:	gpio_free(H3600_EGPIO_IR_ON);
+err1:	return err;
+}
+
+static void h3600_irda_shutdown(struct device *dev)
+{
+	gpio_free(H3600_EGPIO_IR_ON);
+	gpio_free(H3600_EGPIO_IR_FSEL);
 }
 
 static struct irda_platform_data h3600_irda_data = {
 	.set_power	= h3600_irda_set_power,
 	.set_speed	= h3600_irda_set_speed,
+	.startup	= h3600_irda_startup,
+	.shutdown	= h3600_irda_shutdown,
 };
 
 static struct gpio_default_state h3600_default_gpio[] = {
diff --git a/drivers/pcmcia/sa1100_h3600.c b/drivers/pcmcia/sa1100_h3600.c
index 6d92a49..4afd348 100644
--- a/drivers/pcmcia/sa1100_h3600.c
+++ b/drivers/pcmcia/sa1100_h3600.c
@@ -47,9 +47,33 @@ static int h3600_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 			goto err02;
 		irqs[0].irq = gpio_to_irq(H3XXX_GPIO_PCMCIA_CD0);
 
-		err = soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
+		err = gpio_request(H3XXX_EGPIO_OPT_NVRAM_ON, "OPT NVRAM ON");
 		if (err)
 			goto err02;
+		err = gpio_direction_output(H3XXX_EGPIO_OPT_NVRAM_ON, 0);
+		if (err)
+			goto err03;
+		err = gpio_request(H3XXX_EGPIO_OPT_ON, "OPT ON");
+		if (err)
+			goto err03;
+		err = gpio_direction_output(H3XXX_EGPIO_OPT_ON, 0);
+		if (err)
+			goto err04;
+		err = gpio_request(H3XXX_EGPIO_OPT_RESET, "OPT RESET");
+		if (err)
+			goto err04;
+		err = gpio_direction_output(H3XXX_EGPIO_OPT_RESET, 0);
+		if (err)
+			goto err05;
+		err = gpio_request(H3XXX_EGPIO_CARD_RESET, "PCMCIA CARD RESET");
+		if (err)
+			goto err05;
+		err = gpio_direction_output(H3XXX_EGPIO_CARD_RESET, 0);
+		if (err)
+			goto err06;
+		err = soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
+		if (err)
+			goto err06;
 		break;
 	case 1:
 		err = gpio_request(H3XXX_GPIO_PCMCIA_IRQ1, "PCMCIA IRQ1");
@@ -75,6 +99,10 @@ static int h3600_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	}
 	return 0;
 
+err06:	gpio_free(H3XXX_EGPIO_CARD_RESET);
+err05:	gpio_free(H3XXX_EGPIO_OPT_RESET);
+err04:	gpio_free(H3XXX_EGPIO_OPT_ON);
+err03:	gpio_free(H3XXX_EGPIO_OPT_NVRAM_ON);
 err02:	gpio_free(H3XXX_GPIO_PCMCIA_CD0);
 err01:	gpio_free(H3XXX_GPIO_PCMCIA_IRQ0);
 err00:	return err;
@@ -88,12 +116,17 @@ static void h3600_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 {
 	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
   
-	/* Disable CF bus: */
-	assign_h3600_egpio(IPAQ_EGPIO_OPT_NVRAM_ON, 0);
-	assign_h3600_egpio(IPAQ_EGPIO_OPT_ON, 0);
-	assign_h3600_egpio(IPAQ_EGPIO_OPT_RESET, 1);
 	switch (skt->nr) {
 	case 0:
+		/* Disable CF bus: */
+		gpio_set_value(H3XXX_EGPIO_OPT_NVRAM_ON, 0);
+		gpio_set_value(H3XXX_EGPIO_OPT_ON, 0);
+		gpio_set_value(H3XXX_EGPIO_OPT_RESET, 1);
+
+		gpio_free(H3XXX_EGPIO_CARD_RESET);
+		gpio_free(H3XXX_EGPIO_OPT_RESET);
+		gpio_free(H3XXX_EGPIO_OPT_ON);
+		gpio_free(H3XXX_EGPIO_OPT_NVRAM_ON);
 		gpio_free(H3XXX_GPIO_PCMCIA_CD0);
 		gpio_free(H3XXX_GPIO_PCMCIA_IRQ0);
 		break;
@@ -139,7 +172,7 @@ h3600_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state_
 		return -1;
 	}
 
-	assign_h3600_egpio(IPAQ_EGPIO_CARD_RESET, !!(state->flags & SS_RESET));
+	gpio_set_value(H3XXX_EGPIO_CARD_RESET, !!(state->flags & SS_RESET));
 
 	/* Silently ignore Vpp, output enable, speaker enable. */
 
@@ -149,9 +182,9 @@ h3600_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state_
 static void h3600_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
 {
 	/* Enable CF bus: */
-	assign_h3600_egpio(IPAQ_EGPIO_OPT_NVRAM_ON, 1);
-	assign_h3600_egpio(IPAQ_EGPIO_OPT_ON, 1);
-	assign_h3600_egpio(IPAQ_EGPIO_OPT_RESET, 0);
+	gpio_set_value(H3XXX_EGPIO_OPT_NVRAM_ON, 1);
+	gpio_set_value(H3XXX_EGPIO_OPT_ON, 1);
+	gpio_set_value(H3XXX_EGPIO_OPT_RESET, 0);
 
 	msleep(10);
 
@@ -169,10 +202,10 @@ static void h3600_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
 	 * socket 0 then socket 1.
 	 */
 	if (skt->nr == 1) {
-		assign_h3600_egpio(IPAQ_EGPIO_OPT_ON, 0);
-		assign_h3600_egpio(IPAQ_EGPIO_OPT_NVRAM_ON, 0);
+		gpio_set_value(H3XXX_EGPIO_OPT_ON, 0);
+		gpio_set_value(H3XXX_EGPIO_OPT_NVRAM_ON, 0);
 		/* hmm, does this suck power? */
-		assign_h3600_egpio(IPAQ_EGPIO_OPT_RESET, 1);
+		gpio_set_value(H3XXX_EGPIO_OPT_RESET, 1);
 	}
 }
 
-- 
1.6.5.1.63.ga9d7.dirty
