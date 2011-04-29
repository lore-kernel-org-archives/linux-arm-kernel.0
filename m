From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 29 Apr 2011 15:06:39 +0200
Subject: [PATCH 1/5] arm: mach-mxs: add stmp378x-devb
In-Reply-To: <1304082403-8897-1-git-send-email-w.sang@pengutronix.de>
References: <1304082403-8897-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1304082403-8897-2-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STMP378x and MX23 are the same and just relabeled. There is a
mach-stmp378x, however, it has a lot of reinvented interfaces, leaking
all sorts of mach-specific functions into the drivers. One example is
the dmaengine which does not use the linux dmaengine-API but some
privately exported symbols. This makes generic use of the drivers
impossible. mach-mxs does it better, so convert the board to mach-mxs.
After that, it is possible to delete all stmp-specific code which should
ease further ARM-consolidation.

Compile tested only due to no hardware (seems not available anymore).

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/Kconfig              |   10 +++
 arch/arm/mach-mxs/Makefile             |    1 +
 arch/arm/mach-mxs/mach-stmp378x_devb.c |  120 ++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/mach-stmp378x_devb.c

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 4522fbb..edacefa 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -17,6 +17,16 @@ config SOC_IMX28
 
 comment "MXS platforms:"
 
+config MACH_STMP378X_DEVB
+	bool "Support STMP378x_devb Platform"
+	select SOC_IMX23
+	select MXS_HAVE_AMBA_DUART
+	select MXS_HAVE_PLATFORM_AUART
+	select MXS_HAVE_PLATFORM_MXS_MMC
+	help
+	  Include support for STMP378x-devb platform. This includes specific
+	  configurations for the board and its peripherals.
+
 config MACH_MX23EVK
 	bool "Support MX23EVK Platform"
 	select SOC_IMX23
diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
index 2f1f614..58e8923 100644
--- a/arch/arm/mach-mxs/Makefile
+++ b/arch/arm/mach-mxs/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PM) += pm.o
 obj-$(CONFIG_SOC_IMX23) += clock-mx23.o mm-mx23.o
 obj-$(CONFIG_SOC_IMX28) += clock-mx28.o mm-mx28.o
 
+obj-$(CONFIG_MACH_STMP378X_DEVB) += mach-stmp378x_devb.o
 obj-$(CONFIG_MACH_MX23EVK) += mach-mx23evk.o
 obj-$(CONFIG_MACH_MX28EVK) += mach-mx28evk.o
 obj-$(CONFIG_MODULE_TX28) += module-tx28.o
diff --git a/arch/arm/mach-mxs/mach-stmp378x_devb.c b/arch/arm/mach-mxs/mach-stmp378x_devb.c
new file mode 100644
index 0000000..7f38d82
--- /dev/null
+++ b/arch/arm/mach-mxs/mach-stmp378x_devb.c
@@ -0,0 +1,120 @@
+/*
+ * board setup for STMP378x-Development-Board
+ *
+ * based on mx23evk board setup and information gained form the original
+ * plat-stmp based board setup, now converted to mach-mxs.
+ *
+ * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright (C) 2011 Wolfram Sang, Pengutronix e.K.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/spi/spi.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include <mach/common.h>
+#include <mach/iomux-mx23.h>
+
+#include "devices-mx23.h"
+
+#define STMP378X_DEVB_MMC0_WRITE_PROTECT	MXS_GPIO_NR(1, 30)
+#define STMP378X_DEVB_MMC0_SLOT_POWER		MXS_GPIO_NR(1, 29)
+
+#define STMP378X_DEVB_PAD_AUART (MXS_PAD_4MA | MXS_PAD_1V8 | MXS_PAD_NOPULL)
+
+static const iomux_cfg_t stmp378x_dvb_pads[] __initconst = {
+	/* duart (extended setup missing in old boardcode, too */
+	MX23_PAD_PWM0__DUART_RX,
+	MX23_PAD_PWM1__DUART_TX,
+
+	/* auart */
+	MX23_PAD_AUART1_RX__AUART1_RX | STMP378X_DEVB_PAD_AUART,
+	MX23_PAD_AUART1_TX__AUART1_TX | STMP378X_DEVB_PAD_AUART,
+	MX23_PAD_AUART1_CTS__AUART1_CTS | STMP378X_DEVB_PAD_AUART,
+	MX23_PAD_AUART1_RTS__AUART1_RTS | STMP378X_DEVB_PAD_AUART,
+
+	/* mmc */
+	MX23_PAD_SSP1_DATA0__SSP1_DATA0 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_SSP1_DATA1__SSP1_DATA1 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_SSP1_DATA2__SSP1_DATA2 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_SSP1_DATA3__SSP1_DATA3 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_SSP1_CMD__SSP1_CMD |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_SSP1_DETECT__SSP1_DETECT |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_SSP1_SCK__SSP1_SCK |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_PWM4__GPIO_1_30 | MXS_PAD_CTRL, /* write protect */
+	MX23_PAD_PWM3__GPIO_1_29 | MXS_PAD_CTRL, /* power enable */
+};
+
+static struct mxs_mmc_platform_data stmp378x_dvb_mmc_pdata __initdata = {
+	.wp_gpio = STMP378X_DEVB_MMC0_WRITE_PROTECT,
+};
+
+static struct spi_board_info spi_board_info[] __initdata = {
+#if defined(CONFIG_ENC28J60) || defined(CONFIG_ENC28J60_MODULE)
+	{
+		.modalias       = "enc28j60",
+		.max_speed_hz   = 6 * 1000 * 1000,
+		.bus_num	= 1,
+		.chip_select    = 0,
+		.platform_data  = NULL,
+	},
+#endif
+};
+
+static void __init stmp378x_dvb_init(void)
+{
+	int ret;
+
+	mxs_iomux_setup_multiple_pads(stmp378x_dvb_pads,
+			ARRAY_SIZE(stmp378x_dvb_pads));
+
+	mx23_add_duart();
+	mx23_add_auart0();
+
+	/* power on mmc slot */
+	ret = gpio_request_one(STMP378X_DEVB_MMC0_SLOT_POWER,
+		GPIOF_OUT_INIT_LOW, "mmc0-slot-power");
+	if (ret)
+		pr_warn("could not power mmc (%d)\n", ret);
+
+	mx23_add_mxs_mmc(0, &stmp378x_dvb_mmc_pdata);
+
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+}
+
+static void __init stmp378x_dvb_timer_init(void)
+{
+	mx23_clocks_init();
+}
+
+static struct sys_timer stmp378x_dvb_timer = {
+	.init	= stmp378x_dvb_timer_init,
+};
+
+MACHINE_START(STMP378X, "STMP378X")
+	.map_io		= mx23_map_io,
+	.init_irq	= mx23_init_irq,
+	.init_machine	= stmp378x_dvb_init,
+	.timer		= &stmp378x_dvb_timer,
+MACHINE_END
-- 
1.7.2.5
