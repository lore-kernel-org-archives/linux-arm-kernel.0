From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Thu, 17 Dec 2009 11:13:51 +0100
Subject: [PATCH 3/3] nhk8815: add platform data for port expanders
In-Reply-To: <cover.1261044597.git.rubini@unipv.it>
References: <cover.1261044597.git.rubini@unipv.it>
Message-ID: <801be98610d67ac5a13560abd6ddc91297fba3cc.1261044597.git.rubini@unipv.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@unipv.it>


Signed-off-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
---
 arch/arm/mach-nomadik/i2c-8815nhk.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-nomadik/i2c-8815nhk.c b/arch/arm/mach-nomadik/i2c-8815nhk.c
index 7045ec1..975ee96 100644
--- a/arch/arm/mach-nomadik/i2c-8815nhk.c
+++ b/arch/arm/mach-nomadik/i2c-8815nhk.c
@@ -1,10 +1,12 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/i2c/stmpe2401.h>
 #include <linux/i2c-algo-bit.h>
 #include <linux/i2c-gpio.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
+#include <mach/irqs.h>
 
 /*
  * There are two busses in the 8815NHK.
@@ -41,6 +43,34 @@ static struct platform_device nhk8815_i2c_dev1 = {
 	},
 };
 
+/*
+ * Data for the GPIO expanders
+ */
+static struct stmpe2401_platform_data nmk_egpio0_data = {
+	.gpio_base = NOMADIK_NR_GPIO,
+	.irq_base = NHK8815_EGPIO0_IRQ(0),
+	.parent_irq = NOMADIK_GPIO_TO_IRQ(76),
+};
+
+static struct stmpe2401_platform_data nmk_egpio1_data = {
+	.gpio_base = NOMADIK_NR_GPIO + STMPE2401_NGPIO,
+	.irq_base = NHK8815_EGPIO1_IRQ(0),
+	.parent_irq = NOMADIK_GPIO_TO_IRQ(78),
+};
+
+static struct i2c_board_info nhk8815_i2c_board_info[] = {
+	{
+		.type		= "stmpe2401",
+		.addr		= 0x43,
+		.platform_data	= &nmk_egpio0_data,
+	},
+	{
+		.type		= "stmpe2401",
+		.addr		= 0x44,
+		.platform_data	= &nmk_egpio1_data,
+	},
+};
+
 static int __init nhk8815_i2c_init(void)
 {
 	/* i2c-gpio switches from out to in and back, so force out data to 0 */
@@ -56,6 +86,9 @@ static int __init nhk8815_i2c_init(void)
 	gpio_set_value(nhk8815_i2c_data1.scl_pin, 0);
 	platform_device_register(&nhk8815_i2c_dev1);
 
+	/* The stmpe2401 devices live on bus 0 */
+	i2c_register_board_info(0, nhk8815_i2c_board_info,
+				ARRAY_SIZE(nhk8815_i2c_board_info));
 	return 0;
 }
 
-- 
1.6.0.2
