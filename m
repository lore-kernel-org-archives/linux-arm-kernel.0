From: jason.chen@freescale.com (jason.chen at freescale.com)
Date: Tue, 15 Feb 2011 16:56:15 +0800
Subject: [PATCH 3/3] ARM i.MX53 LoCo: Add PWM backlight device support
In-Reply-To: <1297760175-19211-1-git-send-email-jason.chen@freescale.com>
References: <1297760175-19211-1-git-send-email-jason.chen@freescale.com>
Message-ID: <1297760175-19211-3-git-send-email-jason.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Chen <b02280@freescale.com>

Signed-off-by: Jason Chen <b02280@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_loco.c          |   29 ++++++++++++++++++++++++++
 arch/arm/mach-mx5/clock-mx51-mx53.c          |    2 +
 arch/arm/mach-mx5/devices-imx53.h            |    2 +
 arch/arm/mach-mx5/devices.c                  |   10 +++++++++
 arch/arm/mach-mx5/devices.h                  |    2 +
 arch/arm/plat-mxc/devices/Kconfig            |    1 +
 arch/arm/plat-mxc/devices/platform-mxc_pwm.c |    9 ++++++++
 arch/arm/plat-mxc/pwm.c                      |    3 +-
 8 files changed, 57 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 8da1cd4..1ded0ef 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/mfd/imx-ipu-v3.h>
+#include <linux/pwm_backlight.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
@@ -39,6 +40,7 @@
 #include "devices-imx53.h"
 #include "devices.h"
 
+#define LOCO_DISP0_PWR			IMX_GPIO_NR(3, 24)
 #define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
 
 static iomux_v3_cfg_t mx53_loco_pads[] = {
@@ -74,6 +76,12 @@ static iomux_v3_cfg_t mx53_loco_pads[] = {
 	MX53_PAD_DISP0_DAT21__IPU_DISP0_DAT_21,
 	MX53_PAD_DISP0_DAT22__IPU_DISP0_DAT_22,
 	MX53_PAD_DISP0_DAT23__IPU_DISP0_DAT_23,
+
+	/* DISP0_POWER_EN */
+	MX53_PAD_EIM_D24__GPIO3_24,
+
+	/* PWM */
+	MX53_PAD_GPIO_1__PWM2_PWMO,
 };
 
 static inline void mx53_loco_fec_reset(void)
@@ -95,6 +103,13 @@ static struct fec_platform_data mx53_loco_fec_data = {
 	.phy = PHY_INTERFACE_MODE_RMII,
 };
 
+static struct platform_pwm_backlight_data loco_pwm_backlight_data = {
+        .pwm_id = 1,
+        .max_brightness = 255,
+        .dft_brightness = 128,
+        .pwm_period_ns = 50000,
+};
+
 static struct ipuv3_fb_platform_data loco_fb0_data = {
 	.interface_pix_fmt = IPU_PIX_FMT_RGB565,
 	.flags = IMX_IPU_FB_USE_MODEDB | IMX_IPU_FB_USE_OVERLAY,
@@ -114,6 +129,8 @@ static struct imx_ipuv3_platform_data ipu_data = {
 
 static void __init mx53_loco_board_init(void)
 {
+	int ret;
+
 	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
 					ARRAY_SIZE(mx53_loco_pads));
 	imx53_add_imx_uart(0, NULL);
@@ -121,6 +138,18 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_fec(&mx53_loco_fec_data);
 
 	imx_add_ipuv3(&ipu_data);
+
+	imx_add_mxc_pwm(&imx53_mxc_pwm_data[1]);
+	mxc_register_device(&mxc_pwm1_backlight_device,
+			&loco_pwm_backlight_data);
+
+	/* enable disp0 power */
+	ret = gpio_request(LOCO_DISP0_PWR, "disp0-power-en");
+	if (ret) {
+		printk(KERN_ERR"failed to get GPIO_LOCO_DISP0_PWR: %d\n", ret);
+		return;
+	}
+	gpio_direction_output(LOCO_DISP0_PWR, 1);
 }
 
 static void __init mx53_loco_timer_init(void)
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 043572f..64419e0 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1339,6 +1339,8 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx-ipuv3", "ipu", ipu_clk)
 	_REGISTER_CLOCK("imx-ipuv3", "di0", ipu_di0_clk)
 	_REGISTER_CLOCK("imx-ipuv3", "di1", ipu_di1_clk)
+	_REGISTER_CLOCK("mxc_pwm.0", "pwm", pwm1_clk)
+	_REGISTER_CLOCK("mxc_pwm.1", "pwm", pwm2_clk)
 };
 
 static void clk_tree_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index 8639735..a60ef2e 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -29,3 +29,5 @@ imx53_sdhci_esdhc_imx_data[] __initconst;
 extern const struct imx_spi_imx_data imx53_ecspi_data[] __initconst;
 #define imx53_add_ecspi(id, pdata)	\
 	imx_add_spi_imx(&imx53_ecspi_data[id], pdata)
+
+extern const struct imx_mxc_pwm_data imx53_mxc_pwm_data[] __initconst;
diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index 153ada5..f523209 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -120,6 +120,16 @@ struct platform_device mxc_usbh2_device = {
 	},
 };
 
+struct platform_device mxc_pwm1_backlight_device = {
+        .name = "pwm-backlight",
+        .id = 0,
+};
+
+struct platform_device mxc_pwm2_backlight_device = {
+        .name = "pwm-backlight",
+        .id = 1,
+};
+
 static struct mxc_gpio_port mxc_gpio_ports[] = {
 	{
 		.chip.label = "gpio-0",
diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
index 55a5129..a74cd97 100644
--- a/arch/arm/mach-mx5/devices.h
+++ b/arch/arm/mach-mx5/devices.h
@@ -3,3 +3,5 @@ extern struct platform_device mxc_usbh1_device;
 extern struct platform_device mxc_usbh2_device;
 extern struct platform_device mxc_usbdr_udc_device;
 extern struct platform_device mxc_hsi2c_device;
+extern struct platform_device mxc_pwm1_backlight_device;
+extern struct platform_device mxc_pwm2_backlight_device;
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index f99317e..83e9f1c 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -58,6 +58,7 @@ config IMX_HAVE_PLATFORM_MXC_NAND
 
 config IMX_HAVE_PLATFORM_MXC_PWM
 	bool
+	default y if HAVE_PWM
 
 config IMX_HAVE_PLATFORM_MXC_RNGA
 	bool
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
index b0c4ae2..18cfd07 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
@@ -49,6 +49,15 @@ const struct imx_mxc_pwm_data imx51_mxc_pwm_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
+#ifdef CONFIG_SOC_IMX53
+const struct imx_mxc_pwm_data imx53_mxc_pwm_data[] __initconst = {
+#define imx53_mxc_pwm_data_entry(_id, _hwid)				\
+	imx_mxc_pwm_data_entry(MX53, _id, _hwid, SZ_16K)
+	imx53_mxc_pwm_data_entry(0, 1),
+	imx53_mxc_pwm_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_SOC_IMX53 */
+
 struct platform_device *__init imx_add_mxc_pwm(
 		const struct imx_mxc_pwm_data *data)
 {
diff --git a/arch/arm/plat-mxc/pwm.c b/arch/arm/plat-mxc/pwm.c
index 7a61ef8..61dd8fb 100644
--- a/arch/arm/plat-mxc/pwm.c
+++ b/arch/arm/plat-mxc/pwm.c
@@ -57,7 +57,8 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
 		return -EINVAL;
 
-	if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51()) {
+	if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51() ||
+		cpu_is_mx53()) {
 		unsigned long long c;
 		unsigned long period_cycles, duty_cycles, prescale;
 		u32 cr;
-- 
1.7.1
