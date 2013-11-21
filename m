From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 21 Nov 2013 19:40:11 +0400
Subject: [PATCH 3/6] arm: sa1100: h3100: refactor IrDA GPIO handling
In-Reply-To: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
References: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1385048414-9812-4-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As GPIOs are going to move to platform device, there is no guarantee
that they will be available at init_machine time.

Request and free all GPIOs from IrDA startup/shutdown callbacks and not
at init_machine time.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/h3100.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index 5b78c9f..daa27c4 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -89,6 +89,11 @@ static void __init h3100_map_io(void)
 /*
  * This turns the IRDA power on or off on the Compaq H3100
  */
+static struct gpio h3100_irda_gpio[] = {
+	{ H3100_GPIO_IR_ON,	GPIOF_OUT_INIT_LOW, "IrDA power" },
+	{ H3100_GPIO_IR_FSEL,	GPIOF_OUT_INIT_LOW, "IrDA fsel" },
+};
+
 static int h3100_irda_set_power(struct device *dev, unsigned int state)
 {
 	gpio_set_value(H3100_GPIO_IR_ON, state);
@@ -100,14 +105,24 @@ static void h3100_irda_set_speed(struct device *dev, unsigned int speed)
 	gpio_set_value(H3100_GPIO_IR_FSEL, !(speed < 4000000));
 }
 
+static int h3100_irda_startup(struct device *dev)
+{
+	return gpio_request_array(h3100_irda_gpio, sizeof(h3100_irda_gpio));
+}
+
+static void h3100_irda_shutdown(struct device *dev)
+{
+	return gpio_free_array(h3100_irda_gpio, sizeof(h3100_irda_gpio));
+}
+
 static struct irda_platform_data h3100_irda_data = {
 	.set_power	= h3100_irda_set_power,
 	.set_speed	= h3100_irda_set_speed,
+	.startup	= h3100_irda_startup,
+	.shutdown	= h3100_irda_shutdown,
 };
 
 static struct gpio_default_state h3100_default_gpio[] = {
-	{ H3100_GPIO_IR_ON,	GPIO_MODE_OUT0, "IrDA power" },
-	{ H3100_GPIO_IR_FSEL,	GPIO_MODE_OUT0, "IrDA fsel" },
 	{ H3XXX_GPIO_COM_DCD,	GPIO_MODE_IN,	"COM DCD" },
 	{ H3XXX_GPIO_COM_CTS,	GPIO_MODE_IN,	"COM CTS" },
 	{ H3XXX_GPIO_COM_RTS,	GPIO_MODE_OUT0,	"COM RTS" },
-- 
1.8.4.2
