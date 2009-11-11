From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Wed, 11 Nov 2009 19:46:34 +0100
Subject: [PATCH] s3c64xx: Add other group 0 EINTs
Message-ID: <b2e8f9f70911111046u233a7223o8275dd86ff7f204e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for all group 0 external interrupts to S3C64xx.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/plat-s3c64xx/gpiolib.c  |   12 ++++++++++++
 arch/arm/plat-s3c64xx/irq-eint.c |   19 ++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

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
index f81b7b8..ebdf183 100644
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
@@ -109,7 +109,10 @@ static int s3c_irq_eint_set_type(unsigned int
irq, unsigned int type)
 		return -1;
 	}

-	shift = (offs / 2) * 4;
+	if (offs <= 15)
+		shift = (offs / 2) * 4;
+	else
+		shift = ((offs - 16) / 2) * 4;
 	mask = 0x7 << shift;

 	ctrl = __raw_readl(reg);
@@ -119,12 +122,18 @@ static int s3c_irq_eint_set_type(unsigned int
irq, unsigned int type)

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
-- 
1.6.3.3
