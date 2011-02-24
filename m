From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Feb 2011 22:04:40 +0100
Subject: [PATCH] ARM: mxs: Initial support for Ka-Ro TX28
In-Reply-To: <20110224210353.GA22310@pengutronix.de>
References: <20110224210353.GA22310@pengutronix.de>
Message-ID: <1298581480-15585-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lothar Wa?mann <LW@KARO-electronics.de>

Based on code created by Lothar Wa?mann, Sascha Hauer, Wolfram Sang and
me.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mxs/Kconfig                   |   12 ++
 arch/arm/mach-mxs/Makefile                  |    2 +
 arch/arm/mach-mxs/include/mach/mxs.h        |    9 +-
 arch/arm/mach-mxs/include/mach/uncompress.h |    1 +
 arch/arm/mach-mxs/mach-tx28.c               |  175 +++++++++++++++++++++++++++
 arch/arm/mach-mxs/module-tx28.c             |  131 ++++++++++++++++++++
 arch/arm/mach-mxs/module-tx28.h             |    9 ++
 7 files changed, 337 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-mxs/mach-tx28.c
 create mode 100644 arch/arm/mach-mxs/module-tx28.c
 create mode 100644 arch/arm/mach-mxs/module-tx28.h

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 836cc81..895d066 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -39,4 +39,16 @@ config MACH_MX28EVK
 	  Include support for MX28EVK platform. This includes specific
 	  configurations for the board and its peripherals.
 
+config MODULE_TX28
+	bool
+	select SOC_IMX28
+	select MXS_HAVE_AMBA_DUART
+	select MXS_HAVE_PLATFORM_AUART
+	select MXS_HAVE_PLATFORM_FEC
+	select MXS_HAVE_PLATFORM_MXS_PWM
+
+config MACH_TX28
+	bool "Ka-Ro TX28 module"
+	select MODULE_TX28
+
 endif
diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
index 6b26f02..2f1f614 100644
--- a/arch/arm/mach-mxs/Makefile
+++ b/arch/arm/mach-mxs/Makefile
@@ -9,5 +9,7 @@ obj-$(CONFIG_SOC_IMX28) += clock-mx28.o mm-mx28.o
 
 obj-$(CONFIG_MACH_MX23EVK) += mach-mx23evk.o
 obj-$(CONFIG_MACH_MX28EVK) += mach-mx28evk.o
+obj-$(CONFIG_MODULE_TX28) += module-tx28.o
+obj-$(CONFIG_MACH_TX28)    += mach-tx28.o
 
 obj-y += devices/
diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
index f186c08..35a89dd 100644
--- a/arch/arm/mach-mxs/include/mach/mxs.h
+++ b/arch/arm/mach-mxs/include/mach/mxs.h
@@ -28,8 +28,13 @@
 /*
  * MXS CPU types
  */
-#define cpu_is_mx23()		(machine_is_mx23evk())
-#define cpu_is_mx28()		(machine_is_mx28evk())
+#define cpu_is_mx23()		(					\
+		machine_is_mx23evk() ||					\
+		0)
+#define cpu_is_mx28()		(					\
+		machine_is_mx28evk() ||					\
+		machine_is_tx28() ||					\
+		0)
 
 /*
  * IO addresses common to MXS-based
diff --git a/arch/arm/mach-mxs/include/mach/uncompress.h b/arch/arm/mach-mxs/include/mach/uncompress.h
index a005e76..f12a173 100644
--- a/arch/arm/mach-mxs/include/mach/uncompress.h
+++ b/arch/arm/mach-mxs/include/mach/uncompress.h
@@ -63,6 +63,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		mxs_duart_base = MX23_DUART_BASE_ADDR;
 		break;
 	case MACH_TYPE_MX28EVK:
+	case MACH_TYPE_TX28:
 		mxs_duart_base = MX28_DUART_BASE_ADDR;
 		break;
 	default:
diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
new file mode 100644
index 0000000..540d6ea
--- /dev/null
+++ b/arch/arm/mach-mxs/mach-tx28.c
@@ -0,0 +1,175 @@
+/*
+ * Copyright (C) 2010 <LW@KARO-electronics.de>
+ *
+ * based on: mach-mx28_evk.c
+ * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation
+ */
+#include <linux/kernel.h>
+#include <linux/gpio.h>
+#include <linux/leds.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_gpio.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include <mach/common.h>
+#include <mach/iomux-mx28.h>
+
+#include "devices-mx28.h"
+#include "module-tx28.h"
+
+#define TX28_STK5_GPIO_LED		MXS_GPIO_NR(4, 10)
+
+static const iomux_cfg_t tx28_stk5v3_pads[] __initconst = {
+	/* LED */
+	MX28_PAD_ENET0_RXD3__GPIO_4_10 |
+		MXS_PAD_3V3 | MXS_PAD_4MA | MXS_PAD_NOPULL,
+
+	/* framebuffer */
+#define LCD_MODE (MXS_PAD_3V3 | MXS_PAD_4MA)
+	MX28_PAD_LCD_D00__LCD_D0 | LCD_MODE,
+	MX28_PAD_LCD_D01__LCD_D1 | LCD_MODE,
+	MX28_PAD_LCD_D02__LCD_D2 | LCD_MODE,
+	MX28_PAD_LCD_D03__LCD_D3 | LCD_MODE,
+	MX28_PAD_LCD_D04__LCD_D4 | LCD_MODE,
+	MX28_PAD_LCD_D05__LCD_D5 | LCD_MODE,
+	MX28_PAD_LCD_D06__LCD_D6 | LCD_MODE,
+	MX28_PAD_LCD_D07__LCD_D7 | LCD_MODE,
+	MX28_PAD_LCD_D08__LCD_D8 | LCD_MODE,
+	MX28_PAD_LCD_D09__LCD_D9 | LCD_MODE,
+	MX28_PAD_LCD_D10__LCD_D10 | LCD_MODE,
+	MX28_PAD_LCD_D11__LCD_D11 | LCD_MODE,
+	MX28_PAD_LCD_D12__LCD_D12 | LCD_MODE,
+	MX28_PAD_LCD_D13__LCD_D13 | LCD_MODE,
+	MX28_PAD_LCD_D14__LCD_D14 | LCD_MODE,
+	MX28_PAD_LCD_D15__LCD_D15 | LCD_MODE,
+	MX28_PAD_LCD_D16__LCD_D16 | LCD_MODE,
+	MX28_PAD_LCD_D17__LCD_D17 | LCD_MODE,
+	MX28_PAD_LCD_D18__LCD_D18 | LCD_MODE,
+	MX28_PAD_LCD_D19__LCD_D19 | LCD_MODE,
+	MX28_PAD_LCD_D20__LCD_D20 | LCD_MODE,
+	MX28_PAD_LCD_D21__LCD_D21 | LCD_MODE,
+	MX28_PAD_LCD_D22__LCD_D22 | LCD_MODE,
+	MX28_PAD_LCD_D23__LCD_D23 | LCD_MODE,
+	MX28_PAD_LCD_RD_E__LCD_VSYNC | LCD_MODE,
+	MX28_PAD_LCD_WR_RWN__LCD_HSYNC | LCD_MODE,
+	MX28_PAD_LCD_RS__LCD_DOTCLK | LCD_MODE,
+	MX28_PAD_LCD_CS__LCD_CS | LCD_MODE,
+	MX28_PAD_LCD_VSYNC__LCD_VSYNC | LCD_MODE,
+	MX28_PAD_LCD_HSYNC__LCD_HSYNC | LCD_MODE,
+	MX28_PAD_LCD_DOTCLK__LCD_DOTCLK | LCD_MODE,
+	MX28_PAD_LCD_ENABLE__GPIO_1_31 | LCD_MODE,
+	MX28_PAD_LCD_RESET__GPIO_3_30 | LCD_MODE,
+	MX28_PAD_PWM0__PWM_0 | LCD_MODE,
+
+	/* UART1 */
+	MX28_PAD_AUART0_CTS__DUART_RX,
+	MX28_PAD_AUART0_RTS__DUART_TX,
+	MX28_PAD_AUART0_TX__DUART_RTS,
+	MX28_PAD_AUART0_RX__DUART_CTS,
+
+	/* UART2 */
+	MX28_PAD_AUART1_RX__AUART1_RX,
+	MX28_PAD_AUART1_TX__AUART1_TX,
+	MX28_PAD_AUART1_RTS__AUART1_RTS,
+	MX28_PAD_AUART1_CTS__AUART1_CTS,
+
+	/* CAN */
+	MX28_PAD_GPMI_RDY2__CAN0_TX,
+	MX28_PAD_GPMI_RDY3__CAN0_RX,
+
+	/* I2C */
+	MX28_PAD_I2C0_SCL__I2C0_SCL,
+	MX28_PAD_I2C0_SDA__I2C0_SDA,
+
+	/* TSC2007 */
+	MX28_PAD_SAIF0_MCLK__GPIO_3_20 | MXS_PAD_3V3 | MXS_PAD_4MA | MXS_PAD_PULLUP,
+
+	/* MMC0 */
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
+};
+
+static struct gpio_led tx28_stk5v3_leds[] = {
+	{
+		.name = "GPIO-LED",
+		.default_trigger = "heartbeat",
+		.gpio = TX28_STK5_GPIO_LED,
+	},
+};
+
+static const struct gpio_led_platform_data tx28_stk5v3_led_data __initconst = {
+	.leds = tx28_stk5v3_leds,
+	.num_leds = ARRAY_SIZE(tx28_stk5v3_leds),
+};
+
+static struct spi_board_info tx28_spi_board_info[] = {
+#if defined(CONFIG_SPI_SPIDEV) || defined(CONFIG_SPI_SPIDEV_MODULE)
+	{
+		.modalias = "spidev",
+		.max_speed_hz = 20000000,
+		.bus_num = 0,
+		.chip_select = 1,
+		.controller_data = (void *)SPI_GPIO_NO_CHIPSELECT,
+		.mode = SPI_MODE_0,
+	},
+#endif
+};
+
+static void __init tx28_stk5v3_init(void)
+{
+	mxs_iomux_setup_multiple_pads(tx28_stk5v3_pads,
+			ARRAY_SIZE(tx28_stk5v3_pads));
+
+	mx28_add_duart(); /* UART1 */
+	mx28_add_auart(1); /* UART2 */
+
+	tx28_add_fec0();
+	/* spi via ssp will be added when available */
+	spi_register_board_info(tx28_spi_board_info,
+			ARRAY_SIZE(tx28_spi_board_info));
+	mxs_add_platform_device("leds-gpio", 0, NULL, 0,
+			&tx28_stk5v3_led_data, sizeof(tx28_stk5v3_led_data));
+}
+
+static void __init tx28_timer_init(void)
+{
+	mx28_clocks_init();
+}
+
+static struct sys_timer tx28_timer = {
+	.init = tx28_timer_init,
+};
+
+MACHINE_START(TX28, "Ka-Ro electronics TX28 module")
+	.map_io = mx28_map_io,
+	.init_irq = mx28_init_irq,
+	.init_machine = tx28_stk5v3_init,
+	.timer = &tx28_timer,
+MACHINE_END
diff --git a/arch/arm/mach-mxs/module-tx28.c b/arch/arm/mach-mxs/module-tx28.c
new file mode 100644
index 0000000..fa0b154
--- /dev/null
+++ b/arch/arm/mach-mxs/module-tx28.c
@@ -0,0 +1,131 @@
+/*
+ * Copyright (C) 2010 <LW@KARO-electronics.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/fec.h>
+#include <linux/gpio.h>
+
+#include <mach/iomux-mx28.h>
+#include "../devices-mx28.h"
+
+#include "module-tx28.h"
+
+#define TX28_FEC_PHY_POWER	MXS_GPIO_NR(3, 29)
+#define TX28_FEC_PHY_RESET	MXS_GPIO_NR(4, 13)
+
+static const iomux_cfg_t tx28_fec_gpio_pads[] __initconst = {
+	/* PHY POWER */
+	MX28_PAD_PWM4__GPIO_3_29 |
+		MXS_PAD_4MA | MXS_PAD_NOPULL | MXS_PAD_3V3,
+	/* PHY RESET */
+	MX28_PAD_ENET0_RX_CLK__GPIO_4_13 |
+		MXS_PAD_4MA | MXS_PAD_NOPULL | MXS_PAD_3V3,
+	/* Mode strap pins 0-2 */
+	MX28_PAD_ENET0_RXD0__GPIO_4_3 |
+		MXS_PAD_8MA | MXS_PAD_PULLUP | MXS_PAD_3V3,
+	MX28_PAD_ENET0_RXD1__GPIO_4_4 |
+		MXS_PAD_8MA | MXS_PAD_PULLUP | MXS_PAD_3V3,
+	MX28_PAD_ENET0_RX_EN__GPIO_4_2 |
+		MXS_PAD_8MA | MXS_PAD_PULLUP | MXS_PAD_3V3,
+	/* nINT */
+	MX28_PAD_ENET0_TX_CLK__GPIO_4_5 |
+		MXS_PAD_4MA | MXS_PAD_NOPULL | MXS_PAD_3V3,
+
+	MX28_PAD_ENET0_MDC__GPIO_4_0,
+	MX28_PAD_ENET0_MDIO__GPIO_4_1,
+	MX28_PAD_ENET0_TX_EN__GPIO_4_6,
+	MX28_PAD_ENET0_TXD0__GPIO_4_7,
+	MX28_PAD_ENET0_TXD1__GPIO_4_8,
+	MX28_PAD_ENET_CLK__GPIO_4_16,
+};
+
+#define FEC_MODE (MXS_PAD_8MA | MXS_PAD_PULLUP | MXS_PAD_3V3)
+static const iomux_cfg_t tx28_fec_pads[] __initconst = {
+	MX28_PAD_ENET0_MDC__ENET0_MDC | FEC_MODE,
+	MX28_PAD_ENET0_MDIO__ENET0_MDIO | FEC_MODE,
+	MX28_PAD_ENET0_RX_EN__ENET0_RX_EN | FEC_MODE,
+	MX28_PAD_ENET0_RXD0__ENET0_RXD0 | FEC_MODE,
+	MX28_PAD_ENET0_RXD1__ENET0_RXD1 | FEC_MODE,
+	MX28_PAD_ENET0_TX_EN__ENET0_TX_EN | FEC_MODE,
+	MX28_PAD_ENET0_TXD0__ENET0_TXD0 | FEC_MODE,
+	MX28_PAD_ENET0_TXD1__ENET0_TXD1 | FEC_MODE,
+	MX28_PAD_ENET_CLK__CLKCTRL_ENET | FEC_MODE,
+};
+
+static const struct fec_platform_data tx28_fec_data __initconst = {
+	.phy = PHY_INTERFACE_MODE_RMII,
+};
+
+int __init tx28_add_fec0(void)
+{
+	int i, ret;
+
+	pr_debug("%s: Switching FEC PHY power off\n", __func__);
+	ret = mxs_iomux_setup_multiple_pads(tx28_fec_gpio_pads,
+			ARRAY_SIZE(tx28_fec_gpio_pads));
+	for (i = 0; i < ARRAY_SIZE(tx28_fec_gpio_pads); i++) {
+		unsigned int gpio = MXS_GPIO_NR(PAD_BANK(tx28_fec_gpio_pads[i]),
+			PAD_PIN(tx28_fec_gpio_pads[i]));
+
+		ret = gpio_request(gpio, "FEC");
+		if (ret) {
+			pr_err("Failed to request GPIO_%d_%d: %d\n",
+				PAD_BANK(tx28_fec_gpio_pads[i]),
+				PAD_PIN(tx28_fec_gpio_pads[i]), ret);
+			goto free_gpios;
+		}
+		ret = gpio_direction_output(gpio, 0);
+		if (ret) {
+			pr_err("Failed to set direction of GPIO_%d_%d to output: %d\n",
+					gpio / 32 + 1, gpio % 32, ret);
+			goto free_gpios;
+		}
+	}
+
+	/* Power up fec phy */
+	pr_debug("%s: Switching FEC PHY power on\n", __func__);
+	ret = gpio_direction_output(TX28_FEC_PHY_POWER, 1);
+	if (ret) {
+		pr_err("Failed to power on PHY: %d\n", ret);
+		goto free_gpios;
+	}
+	mdelay(26); /* 25ms according to data sheet */
+
+	/* nINT */
+	gpio_direction_input(MXS_GPIO_NR(4, 5));
+	/* Mode strap pins */
+	gpio_direction_output(MXS_GPIO_NR(4, 2), 1);
+	gpio_direction_output(MXS_GPIO_NR(4, 3), 1);
+	gpio_direction_output(MXS_GPIO_NR(4, 4), 1);
+
+	udelay(100); /* minimum assertion time for nRST */
+
+	pr_debug("%s: Deasserting FEC PHY RESET\n", __func__);
+	gpio_set_value(TX28_FEC_PHY_RESET, 1);
+
+	ret = mxs_iomux_setup_multiple_pads(tx28_fec_pads,
+			ARRAY_SIZE(tx28_fec_pads));
+	if (ret) {
+		pr_debug("%s: mxs_iomux_setup_multiple_pads() failed with rc: %d\n",
+				__func__, ret);
+		goto free_gpios;
+	}
+	pr_debug("%s: Registering FEC device\n", __func__);
+	mx28_add_fec(0, &tx28_fec_data);
+	return 0;
+
+free_gpios:
+	while (--i >= 0) {
+		unsigned int gpio = MXS_GPIO_NR(PAD_BANK(tx28_fec_gpio_pads[i]),
+			PAD_PIN(tx28_fec_gpio_pads[i]));
+
+		gpio_free(gpio);
+	}
+
+	return ret;
+}
diff --git a/arch/arm/mach-mxs/module-tx28.h b/arch/arm/mach-mxs/module-tx28.h
new file mode 100644
index 0000000..df9e1b6
--- /dev/null
+++ b/arch/arm/mach-mxs/module-tx28.h
@@ -0,0 +1,9 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ *   Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+int __init tx28_add_fec0(void);
-- 
1.7.2.3
