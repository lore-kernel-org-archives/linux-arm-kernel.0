From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Mon, 10 Jun 2013 01:40:04 +0300
Subject: [PATCH 1/3] ARM: OMAP1: nokia770: enable Tahvo
In-Reply-To: <1370817606-1008-1-git-send-email-aaro.koskinen@iki.fi>
References: <1370817606-1008-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <1370817606-1008-2-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add platform data for Tahvo.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-nokia770.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 62a15e2..91449c5 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -234,16 +234,26 @@ static struct i2c_board_info nokia770_i2c_board_info_2[] __initdata = {
 	{
 		I2C_BOARD_INFO("retu-mfd", 0x01),
 	},
+	{
+		I2C_BOARD_INFO("tahvo-mfd", 0x02),
+	},
 };
 
 static void __init nokia770_cbus_init(void)
 {
 	const int retu_irq_gpio = 62;
+	const int tahvo_irq_gpio = 40;
 
 	if (gpio_request_one(retu_irq_gpio, GPIOF_IN, "Retu IRQ"))
 		return;
+	if (gpio_request_one(tahvo_irq_gpio, GPIOF_IN, "Tahvo IRQ")) {
+		gpio_free(retu_irq_gpio);
+		return;
+	}
 	irq_set_irq_type(gpio_to_irq(retu_irq_gpio), IRQ_TYPE_EDGE_RISING);
+	irq_set_irq_type(gpio_to_irq(tahvo_irq_gpio), IRQ_TYPE_EDGE_RISING);
 	nokia770_i2c_board_info_2[0].irq = gpio_to_irq(retu_irq_gpio);
+	nokia770_i2c_board_info_2[1].irq = gpio_to_irq(tahvo_irq_gpio);
 	i2c_register_board_info(2, nokia770_i2c_board_info_2,
 				ARRAY_SIZE(nokia770_i2c_board_info_2));
 	platform_device_register(&nokia770_cbus_device);
-- 
1.7.10.4
