From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Tue, 10 Nov 2009 22:49:32 +0100
Subject: S3C64xx GPIO EINT problem
Message-ID: <b2e8f9f70911101349g4e4a2d00hcc155094fb509f4b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'm trying to get all Group 0 GPIO external interrupts working on an S3C6410
board, but I'm being flooded by interrupts.

I am requesting an IRQ handler for both trigger edges for GPL9, 10 and 12. These
are connected to (respectively) USB OTG VBUS detect, USB host OC detect and
headphone jack. All three of these flood me with their respective EINT_X_Y
interrupt, while GPL14 (connected to a button) works fine.

I've attached the patch I'm using (they are 2 patches merged, I've sent the
first part before to this list; the #if 0 part enables the EINT filter control
which didn't seem to work).

Does anyone have any ideas how to fix this?

Thanks,
Maurus Cuelenaere

---

diff --git a/arch/arm/plat-s3c64xx/gpiolib.c b/arch/arm/plat-s3c64xx/gpiolib.c
index 9285929..7785604 100644
--- a/arch/arm/plat-s3c64xx/gpiolib.c
+++ b/arch/arm/plat-s3c64xx/gpiolib.c
@@ -213,6 +213,11 @@ static struct s3c_gpio_cfg gpio_4bit_cfg_eint0011 = {
 	.get_pull	= s3c_gpio_getpull_updown,
 };

+int s3c64xx_gpio2int_gpm(struct gpio_chip *chip, unsigned pin)
+{
+	return pin < 5 ? IRQ_EINT(23) + pin : -ENXIO;
+}
+
 static struct s3c_gpio_chip gpio_4bit[] = {
 	{
 		.base	= S3C64XX_GPA_BASE,
@@ -269,10 +274,16 @@ static struct s3c_gpio_chip gpio_4bit[] = {
 			.base	= S3C64XX_GPM(0),
 			.ngpio	= S3C64XX_GPIO_M_NR,
 			.label	= "GPM",
+			.to_irq = s3c64xx_gpio2int_gpm,
 		},
 	},
 };

+int s3c64xx_gpio2int_gpl(struct gpio_chip *chip, unsigned pin)
+{
+	return pin >= 8 ? IRQ_EINT(16) + pin - 8 : -ENXIO;
+}
+
 static struct s3c_gpio_chip gpio_4bit2[] = {
 	{
 		.base	= S3C64XX_GPH_BASE + 0x4,
@@ -297,6 +308,7 @@ static struct s3c_gpio_chip gpio_4bit2[] = {
 			.base	= S3C64XX_GPL(0),
 			.ngpio	= S3C64XX_GPIO_L_NR,
 			.label	= "GPL",
+			.to_irq = s3c64xx_gpio2int_gpl,
 		},
 	},
 };
diff --git a/arch/arm/plat-s3c64xx/irq-eint.c b/arch/arm/plat-s3c64xx/irq-eint.c
index f81b7b8..7150388 100644
--- a/arch/arm/plat-s3c64xx/irq-eint.c
+++ b/arch/arm/plat-s3c64xx/irq-eint.c
@@ -65,7 +65,7 @@ static void s3c_irq_eint_maskack(unsigned int irq)
 static int s3c_irq_eint_set_type(unsigned int irq, unsigned int type)
 {
 	int offs = eint_offset(irq);
-	int pin;
+	int pin, pin_val;
 	int shift;
 	u32 ctrl, mask;
 	u32 newvalue = 0;
@@ -117,14 +117,44 @@ static int s3c_irq_eint_set_type(unsigned int
irq, unsigned int type)
 	ctrl |= newvalue << shift;
 	__raw_writel(ctrl, reg);

+#if 0
+if (offs < 8) {
+	reg = S3C64XX_EINT0FLTCON0;
+	shift = offs * 8;
+} else if (offs < 16) {
+	reg = S3C64XX_EINT0FLTCON1;
+	shift = (offs - 8) * 8;
+} else if (offs < 24) {
+	reg = S3C64XX_EINT0FLTCON2;
+	shift = (offs - 16) * 8;
+} else {
+	reg = S3C64XX_EINT0FLTCON3;
+	shift = (offs - 24) * 8;
+}
+
+mask = 0xFF << shift;
+newvalue = (1<<7) | (1<<6) | 30;
+
+ctrl = __raw_readl(reg);
+ctrl &= ~mask;
+ctrl |= newvalue << shift;
+__raw_writel(ctrl, reg);
+#endif
+
 	/* set the GPIO pin appropriately */

-	if (offs < 23)
+	if (offs < 16) {
 		pin = S3C64XX_GPN(offs);
-	else
+		pin_val = S3C_GPIO_SFN(2);
+	} else if (offs < 23) {
+		pin = S3C64XX_GPL(offs + 8 - 16);
+		pin_val = S3C_GPIO_SFN(3);
+	} else {
 		pin = S3C64XX_GPM(offs - 23);
+		pin_val = S3C_GPIO_SFN(3);
+	}

-	s3c_gpio_cfgpin(pin, S3C_GPIO_SFN(2));
+	s3c_gpio_cfgpin(pin, pin_val);

 	return 0;
 }
