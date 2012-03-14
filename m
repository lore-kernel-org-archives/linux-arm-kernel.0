From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 14 Mar 2012 13:04:59 +0000
Subject: [PATCH 03/10] ARM: ux500: combine the board init functions for DT boot
In-Reply-To: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
References: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1331730306-11461-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

This lets us move over evertything to device tree one by one.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |   57 ++++++++++++++++++++++++++++++++----
 1 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 0fb5dfd..e2932fc 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -745,12 +745,57 @@ MACHINE_END
 #ifdef CONFIG_MACH_UX500_DT
 static void __init u8500_init_machine(void)
 {
-	if (of_machine_is_compatible("calaosystems,snowball-a9500"))
-		return snowball_init_machine();
-	else if (of_machine_is_compatible("st-ericsson,hrefv60+"))
-		return hrefv60_init_machine();
-	else if (of_machine_is_compatible("st-ericsson,mop500"))
-		return mop500_init_machine();
+	struct device *parent = NULL;
+	int i2c0_devs;
+	int i;
+
+	parent = u8500_init_devices();
+	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
+
+	for (i = 0; i < ARRAY_SIZE(mop500_platform_devs); i++)
+		mop500_platform_devs[i]->dev.parent = parent;
+	for (i = 0; i < ARRAY_SIZE(snowball_platform_devs); i++)
+		snowball_platform_devs[i]->dev.parent = parent;
+
+
+	if (of_machine_is_compatible("st-ericsson,mop500")) {
+		mop500_gpio_keys[0].gpio = GPIO_PROX_SENSOR;
+		mop500_pins_init();
+
+		platform_add_devices(mop500_platform_devs,
+				ARRAY_SIZE(mop500_platform_devs));
+
+		mop500_sdi_init(parent);
+	} else if (of_machine_is_compatible("calaosystems,snowball-a9500")) {
+		snowball_pins_init();
+		platform_add_devices(snowball_platform_devs,
+				ARRAY_SIZE(snowball_platform_devs));
+
+		snowball_sdi_init(parent);
+	} else if (of_machine_is_compatible("st-ericsson,hrefv60+")) {
+		/*
+		 * The HREFv60 board removed a GPIO expander and routed
+		 * all these GPIO pins to the internal GPIO controller
+		 * instead.
+		 */
+		mop500_gpio_keys[0].gpio = HREFV60_PROX_SENSE_GPIO;
+		i2c0_devs -= NUM_PRE_V60_I2C0_DEVICES;
+		hrefv60_pins_init();
+		platform_add_devices(mop500_platform_devs,
+				ARRAY_SIZE(mop500_platform_devs));
+
+		hrefv60_sdi_init(parent);
+	}
+	mop500_i2c_init(parent);
+	mop500_spi_init(parent);
+	mop500_uart_init(parent);
+
+	i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
+	i2c_register_board_info(2, mop500_i2c2_devices,
+				ARRAY_SIZE(mop500_i2c2_devices));
+
+	/* This board has full regulator constraints */
+	regulator_has_full_constraints();
 }
 
 static const char * u8500_dt_board_compat[] = {
-- 
1.7.5.4
