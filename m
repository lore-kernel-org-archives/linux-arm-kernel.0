From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Sat, 10 Oct 2009 18:28:41 +0200
Subject: [PATCH] s3c64xx: Add gpio_to_irq() support for EINTx
Message-ID: <b2e8f9f70910100928j6622b2d3ia1beb16d2378e2fa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio_to_irq() support for all individual external interrupts to s3c64xx

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/plat-s3c64xx/gpiolib.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

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
-- 
1.6.3.3
