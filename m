From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 26 Aug 2011 16:54:07 +0100
Subject: [PATCH] mach-ux500: Remove most of the ugly machine_is_u8500() calls
Message-ID: <1314374047-2824-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-pins.c       |   34 +++++++----
 arch/arm/mach-ux500/board-mop500-sdi.c        |   52 +++++++++++-----
 arch/arm/mach-ux500/board-mop500.c            |   78 +++++++++++++++++++-----
 arch/arm/mach-ux500/board-mop500.h            |    3 +
 arch/arm/mach-ux500/include/mach/uncompress.h |   10 +---
 5 files changed, 124 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index f26fd76..4108c7b 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -153,7 +153,7 @@ static pin_cfg_t mop500_pins_default[] = {
 	GPIO7_U1_RTSn	| PIN_OUTPUT_HIGH,
 };
 
-static pin_cfg_t mop500_pins_hrefv60[] = {
+static pin_cfg_t hrefv60_pins[] = {
 	/* WLAN */
 	GPIO4_GPIO		| PIN_INPUT_PULLUP,/* WLAN_IRQ */
 	GPIO85_GPIO		| PIN_OUTPUT_LOW,/* WLAN_ENA */
@@ -279,14 +279,26 @@ static pin_cfg_t snowball_pins[] = {
 void __init mop500_pins_init(void)
 {
 	nmk_config_pins(mop500_pins_common,
-				ARRAY_SIZE(mop500_pins_common));
-	if (machine_is_hrefv60())
-		nmk_config_pins(mop500_pins_hrefv60,
-				ARRAY_SIZE(mop500_pins_hrefv60));
-	else if (machine_is_snowball())
-		nmk_config_pins(snowball_pins,
-				ARRAY_SIZE(snowball_pins));
-	else
-		nmk_config_pins(mop500_pins_default,
-				ARRAY_SIZE(mop500_pins_default));
+			ARRAY_SIZE(mop500_pins_common));
+
+	nmk_config_pins(mop500_pins_default,
+			ARRAY_SIZE(mop500_pins_default));
+}
+
+void __init snowball_pins_init(void)
+{
+	nmk_config_pins(mop500_pins_common,
+			ARRAY_SIZE(mop500_pins_common));
+
+	nmk_config_pins(snowball_pins,
+			ARRAY_SIZE(snowball_pins));
+}
+
+void __init hrefv60_pins_init(void)
+{
+	nmk_config_pins(mop500_pins_common,
+			ARRAY_SIZE(mop500_pins_common));
+
+	nmk_config_pins(hrefv60_pins,
+			ARRAY_SIZE(hrefv60_pins));
 }
diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index d0cb9e5..6826fae 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -216,30 +216,48 @@ void __init mop500_sdi_init(void)
 	/* PoP:ed eMMC on top of DB8500 v1.0 has problems with high speed */
 	if (!cpu_is_u8500v10())
 		mop500_sdi2_data.capabilities |= MMC_CAP_MMC_HIGHSPEED;
-	/* sdi2 on snowball is in ATL_B mode for FSMC (LAN) */
-	if (!machine_is_snowball())
-		db8500_add_sdi2(&mop500_sdi2_data, periphid);
+
+	db8500_add_sdi2(&mop500_sdi2_data, periphid);
 
 	/* On-board eMMC */
 	db8500_add_sdi4(&mop500_sdi4_data, periphid);
 
-	if (machine_is_hrefv60() || machine_is_snowball()) {
-		if (machine_is_hrefv60()) {
-			mop500_sdi0_data.gpio_cd = HREFV60_SDMMC_CD_GPIO;
-			sdi0_en = HREFV60_SDMMC_EN_GPIO;
-			sdi0_vsel = HREFV60_SDMMC_1V8_3V_GPIO;
-		} else if (machine_is_snowball()) {
-			mop500_sdi0_data.gpio_cd = SNOWBALL_SDMMC_CD_GPIO;
-			mop500_sdi0_data.cd_invert = true;
-			sdi0_en = SNOWBALL_SDMMC_EN_GPIO;
-			sdi0_vsel = SNOWBALL_SDMMC_1V8_3V_GPIO;
-		}
-		sdi0_configure();
-	}
-
 	/*
 	 * On boards with the TC35892 GPIO expander, sdi0 will finally
 	 * be added when the TC35892 initializes and calls
 	 * mop500_sdi_tc35892_init() above.
 	 */
 }
+
+void __init snowball_sdi_init(void)
+{
+	u32 periphid = 0x10480180;
+
+	mop500_sdi2_data.capabilities |= MMC_CAP_MMC_HIGHSPEED;
+
+	/* On-board eMMC */
+	db8500_add_sdi4(&mop500_sdi4_data, periphid);
+
+	mop500_sdi0_data.gpio_cd = SNOWBALL_SDMMC_CD_GPIO;
+	mop500_sdi0_data.cd_invert = true;
+	sdi0_en = SNOWBALL_SDMMC_EN_GPIO;
+	sdi0_vsel = SNOWBALL_SDMMC_1V8_3V_GPIO;
+	sdi0_configure();
+}
+
+void __init hrefv60_sdi_init(void)
+{
+	u32 periphid = 0x10480180;
+
+	mop500_sdi2_data.capabilities |= MMC_CAP_MMC_HIGHSPEED;
+
+	db8500_add_sdi2(&mop500_sdi2_data, periphid);
+
+	/* On-board eMMC */
+	db8500_add_sdi4(&mop500_sdi4_data, periphid);
+
+	mop500_sdi0_data.gpio_cd = HREFV60_SDMMC_CD_GPIO;
+	sdi0_en = HREFV60_SDMMC_EN_GPIO;
+	sdi0_vsel = HREFV60_SDMMC_1V8_3V_GPIO;
+	sdi0_configure();
+}
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index cd54aba..6c00d49 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -603,28 +603,72 @@ static void __init mop500_init_machine(void)
 {
 	int i2c0_devs;
 
+	mop500_gpio_keys[0].gpio = GPIO_PROX_SENSOR;
+
+	u8500_init_devices();
+
+	mop500_pins_init();
+
+	platform_add_devices(mop500_platform_devs,
+			ARRAY_SIZE(mop500_platform_devs));
+
+	mop500_i2c_init();
+	mop500_sdi_init();
+	mop500_spi_init();
+	mop500_uart_init();
+
+	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
+
+	i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
+	i2c_register_board_info(2, mop500_i2c2_devices,
+				ARRAY_SIZE(mop500_i2c2_devices));
+
+	/* This board has full regulator constraints */
+	regulator_has_full_constraints();
+}
+
+static void __init snowball_init_machine(void)
+{
+	int i2c0_devs;
+
+	u8500_init_devices();
+
+	snowball_pins_init();
+
+	platform_add_devices(snowball_platform_devs,
+			ARRAY_SIZE(snowball_platform_devs));
+
+	mop500_i2c_init();
+	snowball_sdi_init();
+	mop500_spi_init();
+	mop500_uart_init();
+
+	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
+	i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
+	i2c_register_board_info(2, mop500_i2c2_devices,
+				ARRAY_SIZE(mop500_i2c2_devices));
+
+	/* This board has full regulator constraints */
+	regulator_has_full_constraints();
+}
+
+static void __init hrefv60_init_machine(void)
+{
+	int i2c0_devs;
+
 	/*
 	 * The HREFv60 board removed a GPIO expander and routed
 	 * all these GPIO pins to the internal GPIO controller
 	 * instead.
 	 */
-	if (!machine_is_snowball()) {
-		if (machine_is_hrefv60())
-			mop500_gpio_keys[0].gpio = HREFV60_PROX_SENSE_GPIO;
-		else
-			mop500_gpio_keys[0].gpio = GPIO_PROX_SENSOR;
-	}
+	mop500_gpio_keys[0].gpio = HREFV60_PROX_SENSE_GPIO;
 
 	u8500_init_devices();
 
-	mop500_pins_init();
+	hrefv60_pins_init();
 
-	if (machine_is_snowball())
-		platform_add_devices(snowball_platform_devs,
-					ARRAY_SIZE(snowball_platform_devs));
-	else
-		platform_add_devices(mop500_platform_devs,
-					ARRAY_SIZE(mop500_platform_devs));
+	platform_add_devices(mop500_platform_devs,
+			ARRAY_SIZE(mop500_platform_devs));
 
 	mop500_i2c_init();
 	mop500_sdi_init();
@@ -632,8 +676,8 @@ static void __init mop500_init_machine(void)
 	mop500_uart_init();
 
 	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
-	if (machine_is_hrefv60())
-		i2c0_devs -= NUM_PRE_V60_I2C0_DEVICES;
+
+	i2c0_devs -= NUM_PRE_V60_I2C0_DEVICES;
 
 	i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
 	i2c_register_board_info(2, mop500_i2c2_devices,
@@ -658,7 +702,7 @@ MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
 	.timer		= &ux500_timer,
-	.init_machine	= mop500_init_machine,
+	.init_machine	= hrefv60_init_machine,
 MACHINE_END
 
 MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
@@ -667,5 +711,5 @@ MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
 	.timer		= &ux500_timer,
-	.init_machine	= mop500_init_machine,
+	.init_machine	= snowball_init_machine,
 MACHINE_END
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index ee77a89..de18a2a 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -40,10 +40,13 @@
 struct i2c_board_info;
 
 extern void mop500_sdi_init(void);
+extern void snowball_sdi_init(void);
 extern void mop500_sdi_tc35892_init(void);
 void __init mop500_u8500uib_init(void);
 void __init mop500_stuib_init(void);
 void __init mop500_pins_init(void);
+void __init hrefv60_pins_init(void);
+void __init snowball_pins_init(void);
 
 void mop500_uib_i2c_add(int busnum, struct i2c_board_info *info,
 		unsigned n);
diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
index 7dd0807..6fb3c4b 100644
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -51,15 +51,9 @@ static void flush(void)
 static inline void arch_decomp_setup(void)
 {
 	/* Check in run time if we run on an U8500 or U5500 */
-	if (machine_is_u8500() ||
-	    machine_is_svp8500v1() ||
-	    machine_is_svp8500v2() ||
-	    machine_is_hrefv60()   ||
-	    machine_is_snowball())
-		ux500_uart_base = U8500_UART2_BASE;
-	else if (machine_is_u5500())
+	if (machine_is_u5500())
 		ux500_uart_base = U5500_UART0_BASE;
-	else /* not much can be done to help here */
+	else
 		ux500_uart_base = U8500_UART2_BASE;
 }
 
-- 
1.7.4.1
