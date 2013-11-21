From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 21 Nov 2013 19:40:12 +0400
Subject: [PATCH 4/6] arm: sa1100: h3600: refactor IrDA GPIO handling
In-Reply-To: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
References: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1385048414-9812-5-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpio_request_array/gpio_free_array to request all GPIOs at once.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/h3600.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 559c2a0..a663e72 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -97,6 +97,11 @@ static void __init h3600_map_io(void)
 /*
  * This turns the IRDA power on or off on the Compaq H3600
  */
+static struct gpio h3600_irda_gpio[] = {
+	{ H3600_EGPIO_IR_ON,	GPIOF_OUT_INIT_LOW, "IrDA power" },
+	{ H3600_EGPIO_IR_FSEL,	GPIOF_OUT_INIT_LOW, "IrDA fsel" },
+};
+
 static int h3600_irda_set_power(struct device *dev, unsigned int state)
 {
 	gpio_set_value(H3600_EGPIO_IR_ON, state);
@@ -110,29 +115,12 @@ static void h3600_irda_set_speed(struct device *dev, unsigned int speed)
 
 static int h3600_irda_startup(struct device *dev)
 {
-	int err = gpio_request(H3600_EGPIO_IR_ON, "IrDA power");
-	if (err)
-		goto err1;
-	err = gpio_direction_output(H3600_EGPIO_IR_ON, 0);
-	if (err)
-		goto err2;
-	err = gpio_request(H3600_EGPIO_IR_FSEL, "IrDA fsel");
-	if (err)
-		goto err2;
-	err = gpio_direction_output(H3600_EGPIO_IR_FSEL, 0);
-	if (err)
-		goto err3;
-	return 0;
-
-err3:	gpio_free(H3600_EGPIO_IR_FSEL);
-err2:	gpio_free(H3600_EGPIO_IR_ON);
-err1:	return err;
+	return gpio_request_array(h3600_irda_gpio, sizeof(h3600_irda_gpio));
 }
 
 static void h3600_irda_shutdown(struct device *dev)
 {
-	gpio_free(H3600_EGPIO_IR_ON);
-	gpio_free(H3600_EGPIO_IR_FSEL);
+	return gpio_free_array(h3600_irda_gpio, sizeof(h3600_irda_gpio));
 }
 
 static struct irda_platform_data h3600_irda_data = {
-- 
1.8.4.2
