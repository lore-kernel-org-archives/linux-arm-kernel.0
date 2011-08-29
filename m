From: sbabic@denx.de (Stefano Babic)
Date: Mon, 29 Aug 2011 09:50:50 +0200
Subject: [PATCH] ARM: mxs: Add initial support for DENX MX28
Message-ID: <1314604250-29511-1-git-send-email-sbabic@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added initial support for DENX M28 module and M28EVK
board. Ethernet(FEC), SDHC, Display are supported.

Signed-off-by: Stefano Babic <sbabic@denx.de>
---
 arch/arm/configs/mxs_defconfig              |    1 +
 arch/arm/mach-mxs/Kconfig                   |   16 ++
 arch/arm/mach-mxs/Makefile                  |    1 +
 arch/arm/mach-mxs/clock-mx28.c              |   16 +-
 arch/arm/mach-mxs/include/mach/mxs.h        |    1 +
 arch/arm/mach-mxs/include/mach/uncompress.h |    1 +
 arch/arm/mach-mxs/mach-m28evk.c             |  369 +++++++++++++++++++++++++++
 7 files changed, 400 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-mxs/mach-m28evk.c

Note: details on the board can be found at http://www.denx-cs.de/?q=M28

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index db2cb7d..6ee781b 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -26,6 +26,7 @@ CONFIG_MACH_MX23EVK=y
 CONFIG_MACH_MX28EVK=y
 CONFIG_MACH_STMP378X_DEVB=y
 CONFIG_MACH_TX28=y
+CONFIG_MACH_M28EVK=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index fdf104f..92ed935 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -70,8 +70,24 @@ config MODULE_TX28
 	select MXS_HAVE_PLATFORM_MXS_PWM
 	select MXS_HAVE_PLATFORM_RTC_STMP3XXX
 
+config MODULE_M28
+	bool
+	select SOC_IMX28
+	select LEDS_GPIO_REGISTER
+	select MXS_HAVE_AMBA_DUART
+	select MXS_HAVE_PLATFORM_AUART
+	select MXS_HAVE_PLATFORM_FEC
+	select MXS_HAVE_PLATFORM_FLEXCAN
+	select MXS_HAVE_PLATFORM_MXS_MMC
+	select MXS_HAVE_PLATFORM_MXSFB
+	select MXS_OCOTP
+
 config MACH_TX28
 	bool "Ka-Ro TX28 module"
 	select MODULE_TX28
 
+config MACH_M28EVK
+	bool "Support DENX M28EVK Platform"
+	select MODULE_M28
+
 endif
diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
index 6c38262..adcfb4e 100644
--- a/arch/arm/mach-mxs/Makefile
+++ b/arch/arm/mach-mxs/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SOC_IMX28) += clock-mx28.o mm-mx28.o
 obj-$(CONFIG_MACH_STMP378X_DEVB) += mach-stmp378x_devb.o
 obj-$(CONFIG_MACH_MX23EVK) += mach-mx23evk.o
 obj-$(CONFIG_MACH_MX28EVK) += mach-mx28evk.o
+obj-$(CONFIG_MACH_M28EVK)    += mach-m28evk.o
 obj-$(CONFIG_MODULE_TX28) += module-tx28.o
 obj-$(CONFIG_MACH_TX28)    += mach-tx28.o
 
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 7954013..e2fb70c 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -740,11 +740,17 @@ static int clk_misc_init(void)
 	__raw_writel(BM_CLKCTRL_CPU_INTERRUPT_WAIT,
 			CLKCTRL_BASE_ADDR + HW_CLKCTRL_CPU_SET);
 
-	/* Extra fec clock setting */
-	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_ENET);
-	reg &= ~BM_CLKCTRL_ENET_SLEEP;
-	reg |= BM_CLKCTRL_ENET_CLK_OUT_EN;
-	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_ENET);
+	/*
+	 * Extra fec clock setting
+	 * The DENX M28 uses an external clock source
+	 * and the clock output must not be enabled
+	 */
+	if (!machine_is_m28evk()) {
+		reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_ENET);
+		reg &= ~BM_CLKCTRL_ENET_SLEEP;
+		reg |= BM_CLKCTRL_ENET_CLK_OUT_EN;
+		__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_ENET);
+	}
 
 	/*
 	 * 480 MHz seems too high to be ssp clock source directly,
diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
index 5aa5f75..0d2d2b4 100644
--- a/arch/arm/mach-mxs/include/mach/mxs.h
+++ b/arch/arm/mach-mxs/include/mach/mxs.h
@@ -33,6 +33,7 @@
 		0)
 #define cpu_is_mx28()		(					\
 		machine_is_mx28evk() ||					\
+		machine_is_m28evk() ||					\
 		machine_is_tx28() ||					\
 		0)
 
diff --git a/arch/arm/mach-mxs/include/mach/uncompress.h b/arch/arm/mach-mxs/include/mach/uncompress.h
index 7f8bf65..6777674 100644
--- a/arch/arm/mach-mxs/include/mach/uncompress.h
+++ b/arch/arm/mach-mxs/include/mach/uncompress.h
@@ -63,6 +63,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		mxs_duart_base = MX23_DUART_BASE_ADDR;
 		break;
 	case MACH_TYPE_MX28EVK:
+	case MACH_TYPE_M28EVK:
 	case MACH_TYPE_TX28:
 		mxs_duart_base = MX28_DUART_BASE_ADDR;
 		break;
diff --git a/arch/arm/mach-mxs/mach-m28evk.c b/arch/arm/mach-mxs/mach-m28evk.c
new file mode 100644
index 0000000..578a8b0
--- /dev/null
+++ b/arch/arm/mach-mxs/mach-m28evk.c
@@ -0,0 +1,369 @@
+/*
+ * Copyright (C) 2011
+ * Stefano Babic, DENX Software Engineering, <sbabic@denx.de>
+ *
+ * based on: mach-mx28_evk.c
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
+#include <linux/irq.h>
+#include <linux/clk.h>
+#include <linux/i2c.h>
+#include <linux/i2c/at24.h>
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
+#define M28EVK_GPIO_USERLED1	MXS_GPIO_NR(3, 16)
+#define M28EVK_GPIO_USERLED2	MXS_GPIO_NR(3, 17)
+
+#define MX28EVK_BL_ENABLE	MXS_GPIO_NR(3, 18)
+#define M28EVK_LCD_ENABLE	MXS_GPIO_NR(3, 28)
+
+#define MX28EVK_MMC0_WRITE_PROTECT	MXS_GPIO_NR(2, 12)
+#define MX28EVK_MMC1_WRITE_PROTECT	MXS_GPIO_NR(0, 28)
+
+static const iomux_cfg_t m28evk_pads[] __initconst = {
+	/* duart */
+	MX28_PAD_AUART0_CTS__DUART_RX | MXS_PAD_CTRL,
+	MX28_PAD_AUART0_RTS__DUART_TX | MXS_PAD_CTRL,
+
+	/* auart0 */
+	MX28_PAD_AUART0_RX__AUART0_RX | MXS_PAD_CTRL,
+	MX28_PAD_AUART0_TX__AUART0_TX | MXS_PAD_CTRL,
+
+	/* auart3 */
+	MX28_PAD_AUART3_RX__AUART3_RX | MXS_PAD_CTRL,
+	MX28_PAD_AUART3_TX__AUART3_TX | MXS_PAD_CTRL,
+	MX28_PAD_AUART3_CTS__AUART3_CTS | MXS_PAD_CTRL,
+	MX28_PAD_AUART3_RTS__AUART3_RTS | MXS_PAD_CTRL,
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
+	/* fec1 */
+	MX28_PAD_ENET0_CRS__ENET1_RX_EN | MXS_PAD_FEC,
+	MX28_PAD_ENET0_RXD2__ENET1_RXD0 | MXS_PAD_FEC,
+	MX28_PAD_ENET0_RXD3__ENET1_RXD1 | MXS_PAD_FEC,
+	MX28_PAD_ENET0_COL__ENET1_TX_EN | MXS_PAD_FEC,
+	MX28_PAD_ENET0_TXD2__ENET1_TXD0 | MXS_PAD_FEC,
+	MX28_PAD_ENET0_TXD3__ENET1_TXD1 | MXS_PAD_FEC,
+
+	/* flexcan0 */
+	MX28_PAD_GPMI_RDY2__CAN0_TX,
+	MX28_PAD_GPMI_RDY3__CAN0_RX,
+
+	/* flexcan1 */
+	MX28_PAD_GPMI_CE2N__CAN1_TX,
+	MX28_PAD_GPMI_CE3N__CAN1_RX,
+
+	/* I2C */
+	MX28_PAD_I2C0_SCL__I2C0_SCL,
+	MX28_PAD_I2C0_SDA__I2C0_SDA,
+
+	/* mxsfb (lcdif) */
+	MX28_PAD_LCD_D00__LCD_D0 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D01__LCD_D1 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D02__LCD_D2 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D03__LCD_D3 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D04__LCD_D4 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D05__LCD_D5 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D06__LCD_D6 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D07__LCD_D7 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D08__LCD_D8 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D09__LCD_D9 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D10__LCD_D10 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D11__LCD_D11 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D12__LCD_D12 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D13__LCD_D13 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D14__LCD_D14 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D15__LCD_D15 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D16__LCD_D16 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D17__LCD_D17 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D18__LCD_D18 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D19__LCD_D19 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D20__LCD_D20 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D21__LCD_D21 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D22__LCD_D22 | MXS_PAD_CTRL,
+	MX28_PAD_LCD_D23__LCD_D23 | MXS_PAD_CTRL,
+
+	MX28_PAD_LCD_ENABLE__LCD_ENABLE	| MXS_PAD_CTRL,
+	MX28_PAD_LCD_DOTCLK__LCD_DOTCLK | MXS_PAD_CTRL,
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
+	/* mmc1 */
+	MX28_PAD_GPMI_D00__SSP1_D0 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_D01__SSP1_D1 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_D02__SSP1_D2 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_D03__SSP1_D3 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_D04__SSP1_D4 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_D05__SSP1_D5 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_D06__SSP1_D6 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_D07__SSP1_D7 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_RDY1__SSP1_CMD |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_RDY0__SSP1_CARD_DETECT |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_WRN__SSP1_SCK |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	/* write protect */
+	MX28_PAD_GPMI_RESETN__GPIO_0_28 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	/* slot power enable */
+	MX28_PAD_PWM4__GPIO_3_29 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+
+	/* led */
+	MX28_PAD_PWM0__GPIO_3_16 | MXS_PAD_CTRL,
+	MX28_PAD_PWM1__GPIO_3_17 | MXS_PAD_CTRL,
+
+	/* nand */
+	MX28_PAD_GPMI_D00__GPMI_D0 |
+		(MXS_PAD_4MA | MXS_PAD_1V8 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_D01__GPMI_D1 |
+		(MXS_PAD_4MA | MXS_PAD_1V8 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_D02__GPMI_D2 |
+		(MXS_PAD_4MA | MXS_PAD_1V8 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_D03__GPMI_D3 |
+		(MXS_PAD_4MA | MXS_PAD_1V8 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_D04__GPMI_D4 |
+		(MXS_PAD_4MA | MXS_PAD_1V8 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_D05__GPMI_D5 |
+		(MXS_PAD_4MA | MXS_PAD_1V8 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_D06__GPMI_D6 |
+		(MXS_PAD_4MA | MXS_PAD_1V8 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_D07__GPMI_D7 |
+		(MXS_PAD_4MA | MXS_PAD_1V8 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_CE0N__GPMI_CE0N |
+		(MXS_PAD_4MA | MXS_PAD_1V8 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_RDY0__GPMI_READY0 |
+		(MXS_PAD_4MA | MXS_PAD_1V8 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_RDN__GPMI_RDN |
+		(MXS_PAD_12MA | MXS_PAD_1V8 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_WRN__GPMI_WRN |
+		(MXS_PAD_12MA | MXS_PAD_1V8 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_ALE__GPMI_ALE |
+		(MXS_PAD_4MA | MXS_PAD_1V8 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_CLE__GPMI_CLE |
+		(MXS_PAD_4MA | MXS_PAD_1V8 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_RESETN__GPMI_RESETN |
+		(MXS_PAD_12MA | MXS_PAD_1V8 | MXS_PAD_PULLUP),
+
+	/* Backlight */
+	MX28_PAD_PWM3__GPIO_3_28 | MXS_PAD_CTRL,
+};
+
+/* led */
+static const struct gpio_led m28evk_leds[] __initconst = {
+	{
+		.name = "user-led1",
+		.default_trigger = "heartbeat",
+		.gpio = M28EVK_GPIO_USERLED1,
+	},
+	{
+		.name = "user-led2",
+		.default_trigger = "heartbeat",
+		.gpio = M28EVK_GPIO_USERLED2,
+	},
+};
+
+static const struct gpio_led_platform_data m28evk_led_data __initconst = {
+	.leds = m28evk_leds,
+	.num_leds = ARRAY_SIZE(m28evk_leds),
+};
+
+static struct fec_platform_data mx28_fec_pdata[] __initdata = {
+	{
+		/* fec0 */
+		.phy = PHY_INTERFACE_MODE_RMII,
+	}, {
+		/* fec1 */
+		.phy = PHY_INTERFACE_MODE_RMII,
+	},
+};
+
+static int __init m28evk_fec_get_mac(void)
+{
+	int i;
+	u32 val;
+	const u32 *ocotp = mxs_get_ocotp();
+
+	if (!ocotp)
+		goto error;
+
+	/*
+	 * OCOTP only stores the last 4 octets for each mac address,
+	 * so hard-code DENX OUI (C0:E5:4E) here.
+	 */
+	for (i = 0; i < 2; i++) {
+		val = ocotp[i * 4];
+		mx28_fec_pdata[i].mac[0] = 0xC0;
+		mx28_fec_pdata[i].mac[1] = 0xE5;
+		mx28_fec_pdata[i].mac[2] = 0x4E;
+		mx28_fec_pdata[i].mac[3] = (val >> 16) & 0xff;
+		mx28_fec_pdata[i].mac[4] = (val >> 8) & 0xff;
+		mx28_fec_pdata[i].mac[5] = (val >> 0) & 0xff;
+	}
+
+	return 0;
+
+error:
+	pr_err("%s: timeout when reading fec mac from OCOTP\n", __func__);
+	return -ETIMEDOUT;
+}
+
+/* mxsfb (lcdif) */
+static struct fb_videomode m28evk_video_modes[] = {
+	{
+		.name		= "Ampire AM-800480R2TMQW-T01H",
+		.refresh	= 60,
+		.xres		= 800,
+		.yres		= 480,
+		.pixclock	= 30066, /* picosecond (33.26 MHz) */
+		.left_margin	= 0,
+		.right_margin	= 256,
+		.upper_margin	= 0,
+		.lower_margin	= 45,
+		.hsync_len	= 1,
+		.vsync_len	= 1,
+		.sync		= FB_SYNC_DATA_ENABLE_HIGH_ACT,
+	},
+};
+
+static const struct mxsfb_platform_data m28evk_mxsfb_pdata __initconst = {
+	.mode_list	= m28evk_video_modes,
+	.mode_count	= ARRAY_SIZE(m28evk_video_modes),
+	.default_bpp	= 16,
+	.ld_intf_width	= STMLCDIF_18BIT,
+};
+
+static struct at24_platform_data m28evk_eeprom = {
+	.byte_len = 16384,
+	.page_size = 32,
+	.flags = AT24_FLAG_ADDR16,
+};
+
+static struct i2c_board_info m28_stk5v3_i2c_boardinfo[] __initdata = {
+	{
+		I2C_BOARD_INFO("at24", 0x51),	/* E0=1, E1=0, E2=0 */
+		.platform_data = &m28evk_eeprom,
+	},
+};
+
+static struct mxs_mmc_platform_data m28evk_mmc_pdata[] __initdata = {
+	{
+		/* mmc0 */
+		.wp_gpio = MX28EVK_MMC0_WRITE_PROTECT,
+		.flags = SLOTF_8_BIT_CAPABLE,
+	}, {
+		/* mmc1 */
+		.wp_gpio = MX28EVK_MMC1_WRITE_PROTECT,
+		.flags = SLOTF_8_BIT_CAPABLE,
+	},
+};
+
+static void __init m28evk_init(void)
+{
+
+	mxs_iomux_setup_multiple_pads(m28evk_pads, ARRAY_SIZE(m28evk_pads));
+
+	mx28_add_duart();
+	mx28_add_auart0();
+	mx28_add_auart3();
+
+	if (m28evk_fec_get_mac())
+		pr_warn("%s: failed on fec mac setup\n", __func__);
+
+	mx28_add_fec(0, &mx28_fec_pdata[0]);
+	mx28_add_fec(1, &mx28_fec_pdata[1]);
+
+	mx28_add_flexcan(0, NULL);
+	mx28_add_flexcan(1, NULL);
+
+	mx28_add_mxsfb(&m28evk_mxsfb_pdata);
+
+	mx28_add_mxs_mmc(0, &m28evk_mmc_pdata[0]);
+	mx28_add_mxs_mmc(1, &m28evk_mmc_pdata[1]);
+
+	gpio_led_register_device(0, &m28evk_led_data);
+
+	/* I2C */
+	mx28_add_mxs_i2c(0);
+	i2c_register_board_info(0, m28_stk5v3_i2c_boardinfo,
+			ARRAY_SIZE(m28_stk5v3_i2c_boardinfo));
+}
+
+static void __init m28evk_timer_init(void)
+{
+	mx28_clocks_init();
+}
+
+static struct sys_timer m28evk_timer = {
+	.init	= m28evk_timer_init,
+};
+
+MACHINE_START(M28EVK, "DENX M28 EVK")
+	.map_io		= mx28_map_io,
+	.init_irq	= mx28_init_irq,
+	.init_machine	= m28evk_init,
+	.timer		= &m28evk_timer,
+MACHINE_END
-- 
1.7.1
