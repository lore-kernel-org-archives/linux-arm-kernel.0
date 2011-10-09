From: zoss@devai.org (Zoltan Devai)
Date: Sun,  9 Oct 2011 18:36:11 +0200
Subject: [PATCH 8/9] ARM: SPMP8000: Add support for the Letcool board
In-Reply-To: <1318178172-7965-1-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
Message-ID: <1318178172-7965-9-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/mach-spmp8000/board_letcool.c           |  154 ++++++++++++++++++++++
 arch/arm/mach-spmp8000/include/mach/spmp8000fb.h |   32 +++++
 2 files changed, 186 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spmp8000/board_letcool.c
 create mode 100644 arch/arm/mach-spmp8000/include/mach/spmp8000fb.h

diff --git a/arch/arm/mach-spmp8000/board_letcool.c b/arch/arm/mach-spmp8000/board_letcool.c
new file mode 100644
index 0000000..8d6c081
--- /dev/null
+++ b/arch/arm/mach-spmp8000/board_letcool.c
@@ -0,0 +1,154 @@
+/*
+ * Letcool board support file
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/pwm_backlight.h>
+#include <linux/input.h>
+#include <linux/basic_mmio_gpio.h>
+#include <linux/gpio_keys.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <asm/hardware/vic.h>
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+
+#include <mach/core.h>
+#include <mach/gpio.h>
+#include <mach/scu.h>
+#include <mach/spmp8000fb.h>
+
+/* Backlight */
+static struct platform_pwm_backlight_data backlight_letcool = {
+	.pwm_id		= 0,
+	.max_brightness	= 100,
+	.dft_brightness	= 20,
+	.pwm_period_ns	= 100000,
+};
+
+/* Framebuffer */
+static struct spmp8000fb_pdata spmp8000fb_letcool = {
+	.data_fmt = TFT_FMT_RGB565,
+	.mode = {
+		.name = "A035QN02V6",
+		.refresh = 60,
+		.xres = 320,
+		.yres = 240,
+		.pixclock = KHZ2PICOS(5000),
+		.left_margin = 8,
+		.right_margin = 8,
+		.upper_margin = 2,
+		.lower_margin = 2,
+		.hsync_len = 1,
+		.vsync_len = 1,
+	},
+};
+
+/* GPIO3 */
+static struct resource spmp8000_gpio3_resources[] = {
+	[0] = {
+		.name = "dat",
+		.start = SPMP8000_SCU_B_BASE + SCU_B_GPIO3_I,
+		.end = SPMP8000_SCU_B_BASE + SCU_B_GPIO3_I + 3,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.name = "set",
+		.start = SPMP8000_SCU_B_BASE + SCU_B_GPIO3_O,
+		.end = SPMP8000_SCU_B_BASE + SCU_B_GPIO3_O + 3,
+		.flags = IORESOURCE_MEM,
+	},
+	[2] = {
+		.name = "dirin",
+		.start = SPMP8000_SCU_B_BASE + SCU_B_GPIO3_E,
+		.end = SPMP8000_SCU_B_BASE + SCU_B_GPIO3_E + 3,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct of_dev_auxdata letcool_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("pwm-backlight", 0, "pwm-backlight",
+			&backlight_letcool),
+	OF_DEV_AUXDATA("sunplus,spmp8000-lcd", 0x93000000, "93000000.fb",
+			&spmp8000fb_letcool),
+	OF_DEV_AUXDATA("basic-mmio-gpio", 0x90005070, "basic-mmio-gpio",
+			NULL),
+	{ /* sentinel */ },
+};
+
+static void __init letcool_dt_init(void)
+{
+	struct device_node *gpio3_np;
+	struct platform_device *gpio3_pdev;
+
+	/* Static board setup stuff */
+
+	/* Switch off pull-down on SD Card detect pin */
+	spmp8000_pinmux_pgc_set(47, 0);
+
+	/* Set GPIO0 pins as GPIO */
+	spmp8000_pinmux_pgs_set(31, 2);
+	spmp8000_pinmux_pgs_set(32, 2);
+	spmp8000_pinmux_pgs_set(37, 1);
+	spmp8000_pinmux_pgs_set(38, 1);
+
+	/* Set up SAR-GPIOs for the ADC power supply */
+	writel(0xCC, REG_SCU_A(SCU_A_SAR_GPIO_CTRL));
+	writel(0x3, REG_SCU_A(SCU_A_SAR_GPIO_OEN));
+	writel(0xC, REG_SCU_A(SCU_A_SAR_GPIO_O));
+
+	/* Switch UART_MISC_TX and RX to GPIO3 pins */
+	spmp8000_pinmux_pgs_set(43, 2);
+	spmp8000_pinmux_pgs_set(44, 2);
+
+	/* Codec errata fix */
+	writel(SCU_A_CODEC_CFG_VAL, REG_SCU_A(SCU_A_CODEC_CFG));
+
+	/* DT and platform device setup */
+
+	/* Create platform devces */
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     letcool_auxdata_lookup, NULL);
+
+	/* Fix-up GPIO3 platform device resources to make gpio-generic work.
+	 * Should be removed once it has DT bindings. */
+	gpio3_np = of_find_compatible_node(NULL, NULL, "basic-mmio-gpio");
+	if (!gpio3_np) {
+		pr_err("letcool: Can't find gpio3 DT node\n");
+		return;
+	}
+
+	gpio3_pdev = of_find_device_by_node(gpio3_np);
+	if (!gpio3_pdev) {
+		pr_err("letcool: Can't find gpio3 platform device\n");
+		return;
+	}
+
+	gpio3_pdev->num_resources = ARRAY_SIZE(spmp8000_gpio3_resources);
+	gpio3_pdev->resource = spmp8000_gpio3_resources;
+}
+
+static const char *letcool_dt_match[] __initconst = {
+	"gameware,letcool",
+	NULL,
+};
+
+DT_MACHINE_START(LETCOOL, "Letcool N350JP")
+	.map_io		= spmp8000_map_io,
+	.init_early	= spmp8000_init_clkdev,
+	.init_irq	= spmp8000_init_irq,
+	.handle_irq	= vic_handle_irq,
+	.nr_irqs	= SPMP8000_TOTAL_IRQS,
+	.init_machine	= letcool_dt_init,
+	.timer		= &spmp8000_sys_timer,
+	.dt_compat	= letcool_dt_match,
+MACHINE_END
diff --git a/arch/arm/mach-spmp8000/include/mach/spmp8000fb.h b/arch/arm/mach-spmp8000/include/mach/spmp8000fb.h
new file mode 100644
index 0000000..525e23f
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/spmp8000fb.h
@@ -0,0 +1,32 @@
+/*
+ * SPMP8000 machines LCD controller support
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPMP8000_FB_H__
+#define __MACH_SPMP8000_FB_H__
+
+#include <linux/fb.h>
+
+#define TFT_FMT_RGB565		0
+#define TFT_FMT_SRGB		1
+#define TFT_FMT_RGBDM		2
+#define TFT_FMT_CCIR601		3
+#define TFT_FMT_CCIR656		4
+#define TFT_FMT_RGB24B		5
+#define TFT_FMT_CCIR_720M	(1 << 8)
+
+struct spmp8000fb_pdata {
+	u32			data_fmt;
+	u32			xres_virtual;
+	u32			yres_virtual;
+	u32			bpp;
+	struct fb_videomode	mode;
+};
+
+#endif /* __MACH_SPMP8000_FB_H__ */
-- 
1.7.4.1
