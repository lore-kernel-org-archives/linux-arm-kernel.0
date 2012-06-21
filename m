From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Jun 2012 10:46:53 +0200
Subject: [PATCH 1/2] Early support for the Crystalfontz CFA10036 module
In-Reply-To: <1340268415-5022-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1340268415-5022-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1340268415-5022-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Cc: Brian Lily <brian@crystalfontz.com>
---
 arch/arm/mach-mxs/Kconfig         |   15 +++++
 arch/arm/mach-mxs/Makefile        |    1 +
 arch/arm/mach-mxs/mach-cfa10036.c |  129 +++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 arch/arm/mach-mxs/mach-cfa10036.c

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 91cf062..54ace90 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -70,6 +70,21 @@ config MACH_MX28EVK
 	  Include support for MX28EVK platform. This includes specific
 	  configurations for the board and its peripherals.
 
+config MACH_CFA10036
+	bool "Support Crystalfontz CFA-10036 Module"
+	select SOC_IMX28
+	select NEW_LEDS
+	select LEDS_CLASS
+	select LEDS_GPIO
+	select LEDS_GPIO_REGISTER
+	select MXS_HAVE_AMBA_DUART
+	select MXS_HAVE_PLATFORM_MXS_MMC
+	select MXS_HAVE_PLATFORM_MXS_I2C
+	select MXS_HAVE_PLATFORM_RTC_STMP3XXX
+	help
+	  Include support for CFA10036 module. This includes specific
+	  configurations for the board and its peripherals.
+
 config MODULE_TX28
 	bool
 	select SOC_IMX28
diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
index e41590c..36633b9 100644
--- a/arch/arm/mach-mxs/Makefile
+++ b/arch/arm/mach-mxs/Makefile
@@ -12,5 +12,6 @@ obj-$(CONFIG_MACH_M28EVK)    += mach-m28evk.o
 obj-$(CONFIG_MACH_APX4DEVKIT) += mach-apx4devkit.o
 obj-$(CONFIG_MODULE_TX28) += module-tx28.o
 obj-$(CONFIG_MACH_TX28)    += mach-tx28.o
+obj-$(CONFIG_MACH_CFA10036) += mach-cfa10036.o
 
 obj-y += devices/
diff --git a/arch/arm/mach-mxs/mach-cfa10036.c b/arch/arm/mach-mxs/mach-cfa10036.c
new file mode 100644
index 0000000..2cea113
--- /dev/null
+++ b/arch/arm/mach-mxs/mach-cfa10036.c
@@ -0,0 +1,129 @@
+/*
+ * Copyright 2012, Free Electrons. All Rights Reserved.
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
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include <mach/common.h>
+#include <mach/iomux-mx28.h>
+#include <mach/digctl.h>
+
+#include "devices-mx28.h"
+
+#define CFA10036_GPIO_PWR_LED		MXS_GPIO_NR(3, 4)
+#define CFA10036_MMC0_SLOT_POWER	MXS_GPIO_NR(3, 28)
+
+static const iomux_cfg_t cfa10036_pads[] __initconst = {
+	/* duart */
+	MXS_IOMUX_PAD_NAKED(3, 2, PAD_MUXSEL_2) | MXS_PAD_CTRL,
+	MXS_IOMUX_PAD_NAKED(3, 3, PAD_MUXSEL_2) | MXS_PAD_CTRL,
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
+	MX28_PAD_SSP0_CMD__SSP0_CMD |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_DETECT__SSP0_CARD_DETECT |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_SSP0_SCK__SSP0_SCK |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	/* slot power enable */
+	MX28_PAD_PWM3__GPIO_3_28 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+
+	/* Power Led */
+	MXS_IOMUX_PAD_NAKED(3, 4, PAD_MUXSEL_GPIO) | MXS_PAD_CTRL,
+};
+
+/* led */
+static const struct gpio_led cfa10036_leds[] __initconst = {
+	{
+		.name = "power-led",
+		.default_state = LEDS_GPIO_DEFSTATE_ON,
+		.gpio = CFA10036_GPIO_PWR_LED,
+		.active_low = true,
+	},
+};
+
+static const struct gpio_led_platform_data cfa10036_led_data __initconst = {
+	.leds = cfa10036_leds,
+	.num_leds = ARRAY_SIZE(cfa10036_leds),
+};
+
+/* mmc */
+static struct mxs_mmc_platform_data cfa10036_mmc_pdata[] __initdata = {
+	{
+		/* mmc0 */
+		.wp_gpio = -EINVAL,
+		.flags = SLOTF_4_BIT_CAPABLE,
+	},
+};
+
+static const struct gpio cfa10036_gpios[] __initconst = {
+	{ CFA10036_MMC0_SLOT_POWER, GPIOF_OUT_INIT_LOW, "mmc0-slot-power" },
+};
+
+static void __init cfa10036_init(void)
+{
+	int ret;
+
+	mx28_soc_init();
+
+	mxs_iomux_setup_multiple_pads(cfa10036_pads, ARRAY_SIZE(cfa10036_pads));
+
+	mx28_add_duart();
+
+	ret = gpio_request_array(cfa10036_gpios, ARRAY_SIZE(cfa10036_gpios));
+	if (ret)
+		pr_err("One or more GPIOs failed to be requested: %d\n", ret);
+
+	mx28_add_mxs_mmc(0, &cfa10036_mmc_pdata[0]);
+
+	mx28_add_rtc_stmp3xxx();
+
+	gpio_led_register_device(0, &cfa10036_led_data);
+}
+
+static void __init cfa10036_timer_init(void)
+{
+	mx28_clocks_init();
+}
+
+static struct sys_timer cfa10036_timer = {
+	.init	= cfa10036_timer_init,
+};
+
+MACHINE_START(CFA10036, "Crystalfontz CFA-10036")
+	.map_io		= mx28_map_io,
+	.init_irq	= mx28_init_irq,
+	.timer		= &cfa10036_timer,
+	.init_machine	= cfa10036_init,
+	.restart	= mxs_restart,
+MACHINE_END
-- 
1.7.9.5
