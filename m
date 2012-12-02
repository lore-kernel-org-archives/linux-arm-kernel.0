From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  2 Dec 2012 12:09:30 +0400
Subject: [PATCH 2/2] ARM: ixp4xx: Using gpiolib rather than a private GPIO API
In-Reply-To: <1354435770-2719-1-git-send-email-shc_work@mail.ru>
References: <201212020011.42105.arnd@arndb.de>
 <1354435770-2719-1-git-send-email-shc_work@mail.ru>
Message-ID: <1354435770-2719-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-ixp4xx/common.c                |   29 ++++++++++-----
 arch/arm/mach-ixp4xx/dsmg600-setup.c         |    9 ++---
 arch/arm/mach-ixp4xx/goramo_mlr.c            |   31 ++++++++--------
 arch/arm/mach-ixp4xx/include/mach/platform.h |   38 --------------------
 arch/arm/mach-ixp4xx/ixdp425-setup.c         |    6 ++--
 arch/arm/mach-ixp4xx/nas100d-setup.c         |    9 ++---
 arch/arm/mach-ixp4xx/nslu2-setup.c           |    5 +--
 drivers/input/misc/ixp4xx-beeper.c           |   49 ++++++++++++++------------
 drivers/ptp/ptp_ixp46x.c                     |   31 +++++++++++-----
 9 files changed, 91 insertions(+), 116 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 8e2a3b8..2039051 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -189,7 +189,7 @@ static int ixp4xx_set_irq_type(struct irq_data *d, unsigned int type)
 			int_reg);
 
 	/* Configure the line as an input */
-	gpio_line_config(irq2gpio[d->irq], IXP4XX_GPIO_IN);
+	gpio_direction_input(line);
 
 	return 0;
 }
@@ -401,7 +401,8 @@ EXPORT_SYMBOL(ixp4xx_exp_bus_size);
 
 static int ixp4xx_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 {
-	gpio_line_config(gpio, IXP4XX_GPIO_IN);
+	writel_relaxed(readl_relaxed(IXP4XX_GPIO_GPOER) | (1 << gpio),
+		       IXP4XX_GPIO_GPOER);
 
 	return 0;
 }
@@ -409,25 +410,33 @@ static int ixp4xx_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 static int ixp4xx_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 					int level)
 {
-	gpio_line_set(gpio, level);
-	gpio_line_config(gpio, IXP4XX_GPIO_OUT);
+	u32 outval = readl_relaxed(IXP4XX_GPIO_GPOUTR) & ~(1 << gpio);
+
+	if (level)
+		outval |= 1 << gpio;
+
+	writel_relaxed(outval, IXP4XX_GPIO_GPOUTR);
+
+	writel_relaxed(readl_relaxed(IXP4XX_GPIO_GPOER) & ~(1 << gpio),
+		       IXP4XX_GPIO_GPOER);
 
 	return 0;
 }
 
 static int ixp4xx_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
 {
-	int value;
-
-	gpio_line_get(gpio, &value);
-
-	return value;
+	return !!(readl_relaxed(IXP4XX_GPIO_GPINR) & (1 << gpio));
 }
 
 static void ixp4xx_gpio_set_value(struct gpio_chip *chip, unsigned gpio,
 				  int value)
 {
-	gpio_line_set(gpio, value);
+	u32 outval = readl_relaxed(IXP4XX_GPIO_GPOUTR) & ~(1 << gpio);
+
+	if (value)
+		outval |= 1 << gpio;
+
+	writel_relaxed(outval, IXP4XX_GPIO_GPOUTR);
 }
 
 static struct gpio_chip ixp4xx_gpio_chip = {
diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index 2f24df1..f6a80dc 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -161,10 +161,7 @@ static struct platform_device *dsmg600_devices[] __initdata = {
 static void dsmg600_power_off(void)
 {
 	/* enable the pwr cntl gpio */
-	gpio_line_config(DSMG600_PO_GPIO, IXP4XX_GPIO_OUT);
-
-	/* poweroff */
-	gpio_line_set(DSMG600_PO_GPIO, IXP4XX_GPIO_HIGH);
+	gpio_direction_output(DSMG600_PO_GPIO, 1);
 }
 
 /* This is used to make sure the power-button pusher is serious.  The button
@@ -201,7 +198,7 @@ static void dsmg600_power_handler(unsigned long data)
 			ctrl_alt_del();
 
 			/* Change the state of the power LED to "blink" */
-			gpio_line_set(DSMG600_LED_PWR_GPIO, IXP4XX_GPIO_LOW);
+			gpio_set_value(DSMG600_LED_PWR_GPIO, 0);
 		} else {
 			power_button_countdown = PBUTTON_HOLDDOWN_COUNT;
 		}
@@ -269,7 +266,7 @@ static void __init dsmg600_init(void)
 	 */
 
 	/* Make sure that the power button GPIO is set up as an input */
-	gpio_line_config(DSMG600_PB_GPIO, IXP4XX_GPIO_IN);
+	gpio_direction_input(DSMG600_PB_GPIO);
 
 	/* Set the initial value for the power button IRQ handler */
 	power_button_countdown = PBUTTON_HOLDDOWN_COUNT;
diff --git a/arch/arm/mach-ixp4xx/goramo_mlr.c b/arch/arm/mach-ixp4xx/goramo_mlr.c
index b81aa79..b80a256 100644
--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -8,6 +8,7 @@
 #include <linux/i2c-gpio.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/serial_8250.h>
@@ -80,19 +81,19 @@ static u8 control_value;
 
 static void set_scl(u8 value)
 {
-	gpio_line_set(GPIO_SCL, !!value);
+	gpio_set_value(GPIO_SCL, value);
 	udelay(3);
 }
 
 static void set_sda(u8 value)
 {
-	gpio_line_set(GPIO_SDA, !!value);
+	gpio_set_value(GPIO_SDA, value);
 	udelay(3);
 }
 
 static void set_str(u8 value)
 {
-	gpio_line_set(GPIO_STR, !!value);
+	gpio_set_value(GPIO_STR, value);
 	udelay(3);
 }
 
@@ -109,8 +110,8 @@ static void output_control(void)
 {
 	int i;
 
-	gpio_line_config(GPIO_SCL, IXP4XX_GPIO_OUT);
-	gpio_line_config(GPIO_SDA, IXP4XX_GPIO_OUT);
+	gpio_direction_output(GPIO_SCL, 1);
+	gpio_direction_output(GPIO_SDA, 1);
 
 	for (i = 0; i < 8; i++) {
 		set_scl(0);
@@ -153,7 +154,7 @@ static int hss_set_clock(int port, unsigned int clock_type)
 static irqreturn_t hss_dcd_irq(int irq, void *pdev)
 {
 	int i, port = (irq == IXP4XX_GPIO_IRQ(GPIO_HSS1_DCD_N));
-	gpio_line_get(port ? GPIO_HSS1_DCD_N : GPIO_HSS0_DCD_N, &i);
+	i = gpio_get_value(port ? GPIO_HSS1_DCD_N : GPIO_HSS0_DCD_N);
 	set_carrier_cb_tab[port](pdev, !i);
 	return IRQ_HANDLED;
 }
@@ -169,7 +170,7 @@ static int hss_open(int port, void *pdev,
 	else
 		irq = IXP4XX_GPIO_IRQ(GPIO_HSS1_DCD_N);
 
-	gpio_line_get(port ? GPIO_HSS1_DCD_N : GPIO_HSS0_DCD_N, &i);
+	i = gpio_get_value(port ? GPIO_HSS1_DCD_N : GPIO_HSS0_DCD_N);
 	set_carrier_cb(pdev, !i);
 
 	set_carrier_cb_tab[!!port] = set_carrier_cb;
@@ -182,7 +183,7 @@ static int hss_open(int port, void *pdev,
 
 	set_control(port ? CONTROL_HSS1_DTR_N : CONTROL_HSS0_DTR_N, 0);
 	output_control();
-	gpio_line_set(port ? GPIO_HSS1_RTS_N : GPIO_HSS0_RTS_N, 0);
+	gpio_set_value(port ? GPIO_HSS1_RTS_N : GPIO_HSS0_RTS_N, 0);
 	return 0;
 }
 
@@ -194,7 +195,7 @@ static void hss_close(int port, void *pdev)
 
 	set_control(port ? CONTROL_HSS1_DTR_N : CONTROL_HSS0_DTR_N, 1);
 	output_control();
-	gpio_line_set(port ? GPIO_HSS1_RTS_N : GPIO_HSS0_RTS_N, 1);
+	gpio_set_value(port ? GPIO_HSS1_RTS_N : GPIO_HSS0_RTS_N, 1);
 }
 
 
@@ -414,13 +415,11 @@ static void __init gmlr_init(void)
 	if (hw_bits & CFG_HW_HAS_EEPROM)
 		device_tab[devices++] = &device_i2c; /* max index 6 */
 
-	gpio_line_config(GPIO_SCL, IXP4XX_GPIO_OUT);
-	gpio_line_config(GPIO_SDA, IXP4XX_GPIO_OUT);
-	gpio_line_config(GPIO_STR, IXP4XX_GPIO_OUT);
-	gpio_line_config(GPIO_HSS0_RTS_N, IXP4XX_GPIO_OUT);
-	gpio_line_config(GPIO_HSS1_RTS_N, IXP4XX_GPIO_OUT);
-	gpio_line_config(GPIO_HSS0_DCD_N, IXP4XX_GPIO_IN);
-	gpio_line_config(GPIO_HSS1_DCD_N, IXP4XX_GPIO_IN);
+	gpio_direction_output(GPIO_SCL, 1);
+	gpio_direction_output(GPIO_SDA, 1);
+	gpio_direction_output(GPIO_STR, 1);
+	gpio_direction_output(GPIO_HSS0_RTS_N, 0);
+	gpio_direction_output(GPIO_HSS1_RTS_N, 0);
 	irq_set_irq_type(IXP4XX_GPIO_IRQ(GPIO_HSS0_DCD_N), IRQ_TYPE_EDGE_BOTH);
 	irq_set_irq_type(IXP4XX_GPIO_IRQ(GPIO_HSS1_DCD_N), IRQ_TYPE_EDGE_BOTH);
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/platform.h b/arch/arm/mach-ixp4xx/include/mach/platform.h
index 2d3e3f1..7fef868 100644
--- a/arch/arm/mach-ixp4xx/include/mach/platform.h
+++ b/arch/arm/mach-ixp4xx/include/mach/platform.h
@@ -132,47 +132,9 @@ struct pci_sys_data;
 extern int ixp4xx_setup(int nr, struct pci_sys_data *sys);
 extern struct pci_ops ixp4xx_ops;
 
-/*
- * GPIO-functions
- */
-/*
- * The following converted to the real HW bits the gpio_line_config
- */
-/* GPIO pin types */
-#define IXP4XX_GPIO_OUT 		0x1
-#define IXP4XX_GPIO_IN  		0x2
-
-/* GPIO signal types */
-#define IXP4XX_GPIO_LOW			0
-#define IXP4XX_GPIO_HIGH		1
-
 /* GPIO Clocks */
 #define IXP4XX_GPIO_CLK_0		14
 #define IXP4XX_GPIO_CLK_1		15
 
-/* using macros here to work around circular dependency with asm/io.h */
-#define gpio_line_config(line, direction)	\
-do {						\
-	u8 __line = (line);			\
-	if ((direction) == IXP4XX_GPIO_IN)	\
-		writel_relaxed(readl_relaxed(IXP4XX_GPIO_GPOER) | (1 << __line), IXP4XX_GPIO_GPOER); \
-	else					\
-		writel_relaxed(readl_relaxed(IXP4XX_GPIO_GPOER) & ~(1 << __line), IXP4XX_GPIO_GPOER); \
-} while (0)
-
-#define gpio_line_get(line, value)	\
-do {					\
-	*(value) = (readl_relaxed(IXP4XX_GPIO_GPINR) >> (line)) & 0x1; \
-} while(0)
-
-#define gpio_line_set(line, value)		\
-do {						\
-	u8 __line = (line);			\
-	if ((value) == IXP4XX_GPIO_HIGH)	\
-		writel_relaxed(readl_relaxed(IXP4XX_GPIO_GPOUTR) | (1 << __line), IXP4XX_GPIO_GPOUTR); \
-	else if ((value) == IXP4XX_GPIO_LOW)	\
-		writel_relaxed(readl_relaxed(IXP4XX_GPIO_GPOUTR) & ~(1 << __line), IXP4XX_GPIO_GPOUTR); \
-} while (0)
-
 #endif // __ASSEMBLY__
 
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index 399c5e3..736900a 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -80,10 +80,10 @@ ixdp425_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 
 	if (ctrl & NAND_CTRL_CHANGE) {
 		if (ctrl & NAND_NCE) {
-			gpio_line_set(IXDP425_NAND_NCE_PIN, IXP4XX_GPIO_LOW);
+			gpio_set_value(IXDP425_NAND_NCE_PIN, 0);
 			udelay(5);
 		} else
-			gpio_line_set(IXDP425_NAND_NCE_PIN, IXP4XX_GPIO_HIGH);
+			gpio_set_value(IXDP425_NAND_NCE_PIN, 1);
 
 		offset = (ctrl & NAND_CLE) ? IXDP425_NAND_CMD_BYTE : 0;
 		offset |= (ctrl & NAND_ALE) ? IXDP425_NAND_ADDR_BYTE : 0;
@@ -227,7 +227,7 @@ static void __init ixdp425_init(void)
 	ixdp425_flash_nand_resource.start = IXP4XX_EXP_BUS_BASE(3),
 	ixdp425_flash_nand_resource.end   = IXP4XX_EXP_BUS_BASE(3) + 0x10 - 1;
 
-	gpio_line_config(IXDP425_NAND_NCE_PIN, IXP4XX_GPIO_OUT);
+	gpio_direction_output(IXDP425_NAND_NCE_PIN, 1);
 
 	/* Configure expansion bus for NAND Flash */
 	*IXP4XX_EXP_CS3 = IXP4XX_EXP_BUS_CS_EN |
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
index 647d377..373cbd2 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -185,10 +185,7 @@ static void nas100d_power_off(void)
 	/* This causes the box to drop the power and go dead. */
 
 	/* enable the pwr cntl gpio */
-	gpio_line_config(NAS100D_PO_GPIO, IXP4XX_GPIO_OUT);
-
-	/* do the deed */
-	gpio_line_set(NAS100D_PO_GPIO, IXP4XX_GPIO_HIGH);
+	gpio_direction_output(NAS100D_PO_GPIO, 1);
 }
 
 /* This is used to make sure the power-button pusher is serious.  The button
@@ -225,7 +222,7 @@ static void nas100d_power_handler(unsigned long data)
 			ctrl_alt_del();
 
 			/* Change the state of the power LED to "blink" */
-			gpio_line_set(NAS100D_LED_PWR_GPIO, IXP4XX_GPIO_LOW);
+			gpio_set_value(NAS100D_LED_PWR_GPIO, 0);
 		} else {
 			power_button_countdown = PBUTTON_HOLDDOWN_COUNT;
 		}
@@ -284,7 +281,7 @@ static void __init nas100d_init(void)
 	 */
 
 	/* Make sure that the power button GPIO is set up as an input */
-	gpio_line_config(NAS100D_PB_GPIO, IXP4XX_GPIO_IN);
+	gpio_direction_input(NAS100D_PB_GPIO);
 
 	/* Set the initial value for the power button IRQ handler */
 	power_button_countdown = PBUTTON_HOLDDOWN_COUNT;
diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c b/arch/arm/mach-ixp4xx/nslu2-setup.c
index ada1175..6272e16 100644
--- a/arch/arm/mach-ixp4xx/nslu2-setup.c
+++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
@@ -198,10 +198,7 @@ static void nslu2_power_off(void)
 	/* This causes the box to drop the power and go dead. */
 
 	/* enable the pwr cntl gpio */
-	gpio_line_config(NSLU2_PO_GPIO, IXP4XX_GPIO_OUT);
-
-	/* do the deed */
-	gpio_line_set(NSLU2_PO_GPIO, IXP4XX_GPIO_HIGH);
+	gpio_direction_output(NSLU2_PO_GPIO, 1);
 }
 
 static irqreturn_t nslu2_power_handler(int irq, void *dev_id)
diff --git a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/ixp4xx-beeper.c
index 6b40950..07f75b2 100644
--- a/drivers/input/misc/ixp4xx-beeper.c
+++ b/drivers/input/misc/ixp4xx-beeper.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/input.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <mach/hardware.h>
@@ -35,14 +36,12 @@ static void ixp4xx_spkr_control(unsigned int pin, unsigned int count)
 
 	spin_lock_irqsave(&beep_lock, flags);
 
-	 if (count) {
-		gpio_line_config(pin, IXP4XX_GPIO_OUT);
-		gpio_line_set(pin, IXP4XX_GPIO_LOW);
+	if (count) {
+		gpio_direction_output(pin, 0);
 
 		writel_relaxed((count & ~IXP4XX_OST_RELOAD_MASK) | IXP4XX_OST_ENABLE, IXP4XX_OSRT2);
 	} else {
-		gpio_line_config(pin, IXP4XX_GPIO_IN);
-		gpio_line_set(pin, IXP4XX_GPIO_HIGH);
+		gpio_direction_input(pin);
 
 		writel_relaxed(0, IXP4XX_OSRT2);
 	}
@@ -52,7 +51,7 @@ static void ixp4xx_spkr_control(unsigned int pin, unsigned int count)
 
 static int ixp4xx_spkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
-	unsigned int pin = (unsigned int) input_get_drvdata(dev);
+	unsigned int pin = (unsigned int)input_get_drvdata(dev);
 	unsigned int count = 0;
 
 	if (type != EV_SND)
@@ -78,13 +77,15 @@ static int ixp4xx_spkr_event(struct input_dev *dev, unsigned int type, unsigned
 
 static irqreturn_t ixp4xx_spkr_interrupt(int irq, void *dev_id)
 {
-	/* flip the beeper output */
-	writel_relaxed(readl_relaxed(IXP4XX_GPIO_GPOUTR) ^ (1 << (unsigned int) dev_id), IXP4XX_GPIO_GPOUTR);
+	unsigned int pin = (unsigned int)dev_id;
+
+	/* Flip the beeper output */
+	gpio_set_value(pin, gpio_get_value(pin));
 
 	return IRQ_HANDLED;
 }
 
-static int ixp4xx_spkr_probe(struct platform_device *dev)
+static int ixp4xx_spkr_probe(struct platform_device *pdev)
 {
 	struct input_dev *input_dev;
 	int err;
@@ -93,7 +94,10 @@ static int ixp4xx_spkr_probe(struct platform_device *dev)
 	if (!input_dev)
 		return -ENOMEM;
 
-	input_set_drvdata(input_dev, (void *) dev->id);
+	WARN_ON(devm_gpio_request_one(&pdev->dev, pdev->id, GPIOF_IN,
+				      dev_name(&pdev->dev)));
+
+	input_set_drvdata(input_dev, (void *)pdev->id);
 
 	input_dev->name = "ixp4xx beeper",
 	input_dev->phys = "ixp4xx/gpio";
@@ -101,7 +105,7 @@ static int ixp4xx_spkr_probe(struct platform_device *dev)
 	input_dev->id.vendor  = 0x001f;
 	input_dev->id.product = 0x0001;
 	input_dev->id.version = 0x0100;
-	input_dev->dev.parent = &dev->dev;
+	input_dev->dev.parent = &pdev->dev;
 
 	input_dev->evbit[0] = BIT_MASK(EV_SND);
 	input_dev->sndbit[0] = BIT_MASK(SND_BELL) | BIT_MASK(SND_TONE);
@@ -109,7 +113,7 @@ static int ixp4xx_spkr_probe(struct platform_device *dev)
 
 	err = request_irq(IRQ_IXP4XX_TIMER2, &ixp4xx_spkr_interrupt,
 			  IRQF_NO_SUSPEND, "ixp4xx-beeper",
-			  (void *) dev->id);
+			  (void *)pdev->id);
 	if (err)
 		goto err_free_device;
 
@@ -117,39 +121,39 @@ static int ixp4xx_spkr_probe(struct platform_device *dev)
 	if (err)
 		goto err_free_irq;
 
-	platform_set_drvdata(dev, input_dev);
+	platform_set_drvdata(pdev, input_dev);
 
 	return 0;
 
  err_free_irq:
-	free_irq(IRQ_IXP4XX_TIMER2, dev);
+	free_irq(IRQ_IXP4XX_TIMER2, (void *)pdev->id);
  err_free_device:
 	input_free_device(input_dev);
 
 	return err;
 }
 
-static int ixp4xx_spkr_remove(struct platform_device *dev)
+static int ixp4xx_spkr_remove(struct platform_device *pdev)
 {
-	struct input_dev *input_dev = platform_get_drvdata(dev);
-	unsigned int pin = (unsigned int) input_get_drvdata(input_dev);
+	struct input_dev *input_dev = platform_get_drvdata(pdev);
+	unsigned int pin = (unsigned int)input_get_drvdata(input_dev);
 
 	input_unregister_device(input_dev);
-	platform_set_drvdata(dev, NULL);
+	platform_set_drvdata(pdev, NULL);
 
 	/* turn the speaker off */
 	disable_irq(IRQ_IXP4XX_TIMER2);
 	ixp4xx_spkr_control(pin, 0);
 
-	free_irq(IRQ_IXP4XX_TIMER2, dev);
+	free_irq(IRQ_IXP4XX_TIMER2, (void *)pdev->id);
 
 	return 0;
 }
 
-static void ixp4xx_spkr_shutdown(struct platform_device *dev)
+static void ixp4xx_spkr_shutdown(struct platform_device *pdev)
 {
-	struct input_dev *input_dev = platform_get_drvdata(dev);
-	unsigned int pin = (unsigned int) input_get_drvdata(input_dev);
+	struct input_dev *input_dev = platform_get_drvdata(pdev);
+	unsigned int pin = (unsigned int)input_get_drvdata(input_dev);
 
 	/* turn off the speaker */
 	disable_irq(IRQ_IXP4XX_TIMER2);
@@ -166,4 +170,3 @@ static struct platform_driver ixp4xx_spkr_platform_driver = {
 	.shutdown	= ixp4xx_spkr_shutdown,
 };
 module_platform_driver(ixp4xx_spkr_platform_driver);
-
diff --git a/drivers/ptp/ptp_ixp46x.c b/drivers/ptp/ptp_ixp46x.c
index d49b851..84ac0d2 100644
--- a/drivers/ptp/ptp_ixp46x.c
+++ b/drivers/ptp/ptp_ixp46x.c
@@ -260,8 +260,6 @@ static int setup_interrupt(int gpio)
 {
 	int irq;
 
-	gpio_line_config(gpio, IXP4XX_GPIO_IN);
-
 	irq = gpio_to_irq(gpio);
 
 	if (NO_IRQ == irq)
@@ -280,14 +278,6 @@ static int setup_interrupt(int gpio)
 	return irq;
 }
 
-static void __exit ptp_ixp_exit(void)
-{
-	free_irq(MASTER_IRQ, &ixp_clock);
-	free_irq(SLAVE_IRQ, &ixp_clock);
-	ixp46x_phc_index = -1;
-	ptp_clock_unregister(ixp_clock.ptp_clock);
-}
-
 static int __init ptp_ixp_init(void)
 {
 	if (!cpu_is_ixp46x())
@@ -310,6 +300,9 @@ static int __init ptp_ixp_init(void)
 	__raw_writel(0, &ixp_clock.regs->trgt_hi);
 	__raw_writel(TTIPEND, &ixp_clock.regs->event);
 
+	gpio_request_one(MASTER_GPIO, GPIOF_IN, "PTP Master");
+	gpio_request_one(SLAVE_GPIO, GPIOF_IN, "PTP Slave");
+
 	if (MASTER_IRQ != setup_interrupt(MASTER_GPIO)) {
 		pr_err("failed to setup gpio %d as irq\n", MASTER_GPIO);
 		goto no_master;
@@ -320,13 +313,31 @@ static int __init ptp_ixp_init(void)
 	}
 
 	return 0;
+
 no_slave:
 	free_irq(MASTER_IRQ, &ixp_clock);
+
 no_master:
+	gpio_free(MASTER_GPIO);
+	gpio_free(SLAVE_GPIO);
+
 	ptp_clock_unregister(ixp_clock.ptp_clock);
+
 	return -ENODEV;
 }
 
+static void __exit ptp_ixp_exit(void)
+{
+	free_irq(MASTER_IRQ, &ixp_clock);
+	free_irq(SLAVE_IRQ, &ixp_clock);
+
+	gpio_free(MASTER_GPIO);
+	gpio_free(SLAVE_GPIO);
+
+	ixp46x_phc_index = -1;
+	ptp_clock_unregister(ixp_clock.ptp_clock);
+}
+
 module_init(ptp_ixp_init);
 module_exit(ptp_ixp_exit);
 
-- 
1.7.8.6
