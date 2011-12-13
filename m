From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Tue, 13 Dec 2011 11:02:46 +0200
Subject: [PATCH v3] ARM: mxs: Add initial support for Bluegiga APX4
 Development Kit
Message-ID: <1323766966-30502-1-git-send-email-lauri.hintsala@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added initial support for APX4 Development Kit with RTC, LED, Ethernet,
Audio, SDIO, I2C, DUART and AUART support.

cc: shawn.guo at linaro.org
Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Signed-off-by: Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>

---
Patch is based on linux v3.2-rc5.

Changes since V2
* audio support (saif, mxs-sgtl5000, fixed regulators)
* const attributes to structs
* mmc bus width to 4 bits
* removed unused header "irq.h"
* ethernet phy fixup (Veli-Pekka Peltola)
---
 arch/arm/configs/mxs_defconfig              |    1 +
 arch/arm/mach-mxs/Kconfig                   |   16 ++
 arch/arm/mach-mxs/Makefile                  |    1 +
 arch/arm/mach-mxs/include/mach/mxs.h        |    1 +
 arch/arm/mach-mxs/include/mach/uncompress.h |    1 +
 arch/arm/mach-mxs/mach-apx4devkit.c         |  245 +++++++++++++++++++++++++++
 6 files changed, 265 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/mach-apx4devkit.c

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 6ee781b..fb19ca8 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -27,6 +27,7 @@ CONFIG_MACH_MX28EVK=y
 CONFIG_MACH_STMP378X_DEVB=y
 CONFIG_MACH_TX28=y
 CONFIG_MACH_M28EVK=y
+CONFIG_MACH_APX4DEVKIT=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index cf00b3e..c57f996 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -83,6 +83,18 @@ config MODULE_M28
 	select MXS_HAVE_PLATFORM_MXSFB
 	select MXS_OCOTP
 
+config MODULE_APX4
+	bool
+	select SOC_IMX28
+	select LEDS_GPIO_REGISTER
+	select MXS_HAVE_AMBA_DUART
+	select MXS_HAVE_PLATFORM_AUART
+	select MXS_HAVE_PLATFORM_FEC
+	select MXS_HAVE_PLATFORM_MXS_I2C
+	select MXS_HAVE_PLATFORM_MXS_MMC
+	select MXS_HAVE_PLATFORM_MXS_SAIF
+	select MXS_OCOTP
+
 config MACH_TX28
 	bool "Ka-Ro TX28 module"
 	select MODULE_TX28
@@ -91,4 +103,8 @@ config MACH_M28EVK
 	bool "Support DENX M28EVK Platform"
 	select MODULE_M28
 
+config MACH_APX4DEVKIT
+	bool "Support Bluegiga APX4 Development Kit"
+	select MODULE_APX4
+
 endif
diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
index 8c93b24..908bf9a 100644
--- a/arch/arm/mach-mxs/Makefile
+++ b/arch/arm/mach-mxs/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MACH_STMP378X_DEVB) += mach-stmp378x_devb.o
 obj-$(CONFIG_MACH_MX23EVK) += mach-mx23evk.o
 obj-$(CONFIG_MACH_MX28EVK) += mach-mx28evk.o
 obj-$(CONFIG_MACH_M28EVK)    += mach-m28evk.o
+obj-$(CONFIG_MACH_APX4DEVKIT) += mach-apx4devkit.o
 obj-$(CONFIG_MODULE_TX28) += module-tx28.o
 obj-$(CONFIG_MACH_TX28)    += mach-tx28.o
 
diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
index bde5f66..7e72a6c 100644
--- a/arch/arm/mach-mxs/include/mach/mxs.h
+++ b/arch/arm/mach-mxs/include/mach/mxs.h
@@ -33,6 +33,7 @@
 		machine_is_stmp378x() ||				\
 		0)
 #define cpu_is_mx28()		(					\
+		machine_is_apx4devkit() ||				\
 		machine_is_mx28evk() ||					\
 		machine_is_m28evk() ||					\
 		machine_is_tx28() ||					\
diff --git a/arch/arm/mach-mxs/include/mach/uncompress.h b/arch/arm/mach-mxs/include/mach/uncompress.h
index 6777674..3e5309d 100644
--- a/arch/arm/mach-mxs/include/mach/uncompress.h
+++ b/arch/arm/mach-mxs/include/mach/uncompress.h
@@ -62,6 +62,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 	case MACH_TYPE_MX23EVK:
 		mxs_duart_base = MX23_DUART_BASE_ADDR;
 		break;
+	case MACH_TYPE_APX4DEVKIT:
 	case MACH_TYPE_MX28EVK:
 	case MACH_TYPE_M28EVK:
 	case MACH_TYPE_TX28:
diff --git a/arch/arm/mach-mxs/mach-apx4devkit.c b/arch/arm/mach-mxs/mach-apx4devkit.c
new file mode 100644
index 0000000..08693f1
--- /dev/null
+++ b/arch/arm/mach-mxs/mach-apx4devkit.c
@@ -0,0 +1,245 @@
+/*
+ * Copyright (C) 2011
+ * Lauri Hintsala, Bluegiga, <lauri.hintsala@bluegiga.com>
+ * Veli-Pekka Peltola, Bluegiga, <veli-pekka.peltola@bluegiga.com>
+ *
+ * based on: mach-mx28evk.c
+ * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/leds.h>
+#include <linux/clk.h>
+#include <linux/i2c.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
+#include <linux/micrel_phy.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include <mach/common.h>
+#include <mach/iomux-mx28.h>
+
+#include "devices-mx28.h"
+
+#define APX4DEVKIT_GPIO_USERLED	MXS_GPIO_NR(3, 28)
+
+static const iomux_cfg_t apx4devkit_pads[] __initconst = {
+	/* duart */
+	MX28_PAD_PWM0__DUART_RX | MXS_PAD_CTRL,
+	MX28_PAD_PWM1__DUART_TX | MXS_PAD_CTRL,
+
+	/* auart0 */
+	MX28_PAD_AUART0_RX__AUART0_RX | MXS_PAD_CTRL,
+	MX28_PAD_AUART0_TX__AUART0_TX | MXS_PAD_CTRL,
+	MX28_PAD_AUART0_CTS__AUART0_CTS | MXS_PAD_CTRL,
+	MX28_PAD_AUART0_RTS__AUART0_RTS | MXS_PAD_CTRL,
+
+	/* auart1 */
+	MX28_PAD_AUART1_RX__AUART1_RX | MXS_PAD_CTRL,
+	MX28_PAD_AUART1_TX__AUART1_TX | MXS_PAD_CTRL,
+
+	/* auart2 */
+	MX28_PAD_SSP2_SCK__AUART2_RX | MXS_PAD_CTRL,
+	MX28_PAD_SSP2_MOSI__AUART2_TX | MXS_PAD_CTRL,
+
+	/* auart3 */
+	MX28_PAD_SSP2_MISO__AUART3_RX | MXS_PAD_CTRL,
+	MX28_PAD_SSP2_SS0__AUART3_TX | MXS_PAD_CTRL,
+
+#define MXS_PAD_FEC	(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP)
+	/* fec0 */
+	MX28_PAD_ENET0_MDC__ENET0_MDC | MXS_PAD_FEC,
+	MX28_PAD_ENET0_MDIO__ENET0_MDIO | MXS_PAD_FEC,
+	MX28_PAD_ENET0_RX_EN__ENET0_RX_EN | MXS_PAD_FEC,
+	MX28_PAD_ENET0_RXD0__ENET0_RXD0 | MXS_PAD_FEC,
+	MX28_PAD_ENET0_RXD1__ENET0_RXD1 | MXS_PAD_FEC,
+	MX28_PAD_ENET0_TX_EN__ENET0_TX_EN | MXS_PAD_FEC,
+	MX28_PAD_ENET0_TXD0__ENET0_TXD0 | MXS_PAD_FEC,
+	MX28_PAD_ENET0_TXD1__ENET0_TXD1 | MXS_PAD_FEC,
+	MX28_PAD_ENET_CLK__CLKCTRL_ENET | MXS_PAD_FEC,
+
+	/* i2c */
+	MX28_PAD_I2C0_SCL__I2C0_SCL,
+	MX28_PAD_I2C0_SDA__I2C0_SDA,
+
+	/* mmc0 */
+	MX28_PAD_SSP0_DATA0__SSP0_D0 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_DATA1__SSP0_D1 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_DATA2__SSP0_D2 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_DATA3__SSP0_D3 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_DATA4__SSP0_D4 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_DATA5__SSP0_D5 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_DATA6__SSP0_D6 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_DATA7__SSP0_D7 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_CMD__SSP0_CMD |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_DETECT__SSP0_CARD_DETECT |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_SSP0_SCK__SSP0_SCK |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+
+	/* led */
+	MX28_PAD_PWM3__GPIO_3_28 | MXS_PAD_CTRL,
+
+	/* saif0 & saif1 */
+	MX28_PAD_SAIF0_MCLK__SAIF0_MCLK |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SAIF0_LRCLK__SAIF0_LRCLK |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SAIF0_BITCLK__SAIF0_BITCLK |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SAIF0_SDATA0__SAIF0_SDATA0 |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SAIF1_SDATA0__SAIF1_SDATA0 |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+};
+
+/* led */
+static const struct gpio_led apx4devkit_leds[] __initconst = {
+	{
+		.name = "user-led",
+		.default_trigger = "heartbeat",
+		.gpio = APX4DEVKIT_GPIO_USERLED,
+	},
+};
+
+static const struct gpio_led_platform_data apx4devkit_led_data __initconst = {
+	.leds = apx4devkit_leds,
+	.num_leds = ARRAY_SIZE(apx4devkit_leds),
+};
+
+static const struct fec_platform_data mx28_fec_pdata __initconst = {
+	.phy = PHY_INTERFACE_MODE_RMII,
+};
+
+static const struct mxs_mmc_platform_data apx4devkit_mmc_pdata __initconst = {
+	.wp_gpio = -EINVAL,
+	.flags = SLOTF_4_BIT_CAPABLE,
+};
+
+static const struct i2c_board_info apx4devkit_i2c_boardinfo[] __initconst = {
+	{ I2C_BOARD_INFO("sgtl5000", 0x0a) }, /* ASoC */
+	{ I2C_BOARD_INFO("pcf8563", 0x51) }, /* RTC */
+};
+
+#if defined(CONFIG_REGULATOR_FIXED_VOLTAGE) || \
+		defined(CONFIG_REGULATOR_FIXED_VOLTAGE_MODULE)
+static struct regulator_consumer_supply apx4devkit_audio_consumer_supplies[] = {
+	REGULATOR_SUPPLY("VDDA", "0-000a"),
+	REGULATOR_SUPPLY("VDDIO", "0-000a"),
+};
+
+static struct regulator_init_data apx4devkit_vdd_reg_init_data = {
+	.constraints	= {
+		.name	= "3V3",
+		.always_on = 1,
+	},
+	.consumer_supplies = apx4devkit_audio_consumer_supplies,
+	.num_consumer_supplies = ARRAY_SIZE(apx4devkit_audio_consumer_supplies),
+};
+
+static struct fixed_voltage_config apx4devkit_vdd_pdata = {
+	.supply_name	= "board-3V3",
+	.microvolts	= 3300000,
+	.gpio		= -EINVAL,
+	.enabled_at_boot = 1,
+	.init_data	= &apx4devkit_vdd_reg_init_data,
+};
+
+static struct platform_device apx4devkit_voltage_regulator = {
+	.name		= "reg-fixed-voltage",
+	.id		= -1,
+	.num_resources	= 0,
+	.dev		= {
+		.platform_data	= &apx4devkit_vdd_pdata,
+	},
+};
+
+static void __init apx4devkit_add_regulators(void)
+{
+	platform_device_register(&apx4devkit_voltage_regulator);
+}
+#else
+static void __init apx4devkit_add_regulators(void) {}
+#endif
+
+static int apx4devkit_phy_fixup(struct phy_device *phy)
+{
+	phy->dev_flags |= MICREL_PHY_50MHZ_CLK;
+	return 0;
+}
+
+static void __init apx4devkit_init(void)
+{
+	mxs_iomux_setup_multiple_pads(apx4devkit_pads,
+			ARRAY_SIZE(apx4devkit_pads));
+
+	mx28_add_duart();
+	mx28_add_auart0();
+	mx28_add_auart1();
+	mx28_add_auart2();
+	mx28_add_auart3();
+
+	/*
+	 * Register fixup for the Micrel KS8031 PHY clock
+	 * (shares same ID with KS8051)
+	 */
+	phy_register_fixup_for_uid(PHY_ID_KS8051, MICREL_PHY_ID_MASK,
+			apx4devkit_phy_fixup);
+
+	mx28_add_fec(0, &mx28_fec_pdata);
+
+	mx28_add_mxs_mmc(0, &apx4devkit_mmc_pdata);
+
+	gpio_led_register_device(0, &apx4devkit_led_data);
+
+	mx28_add_saif(0);
+	mx28_add_saif(1);
+
+	apx4devkit_add_regulators();
+
+	mx28_add_mxs_i2c(0);
+	i2c_register_board_info(0, apx4devkit_i2c_boardinfo,
+			ARRAY_SIZE(apx4devkit_i2c_boardinfo));
+
+	mxs_add_platform_device("mxs-sgtl5000", 0, NULL, 0, NULL, 0);
+}
+
+static void __init apx4devkit_timer_init(void)
+{
+	mx28_clocks_init();
+}
+
+static struct sys_timer apx4devkit_timer = {
+	.init	= apx4devkit_timer_init,
+};
+
+MACHINE_START(APX4DEVKIT, "Bluegiga APX4 Development Kit")
+	.map_io		= mx28_map_io,
+	.init_irq	= mx28_init_irq,
+	.timer		= &apx4devkit_timer,
+	.init_machine	= apx4devkit_init,
+MACHINE_END
-- 
1.7.4.1
