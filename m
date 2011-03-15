From: Frank.Li@freescale.com (Frank Li)
Date: Tue, 15 Mar 2011 10:58:20 +0800
Subject: [PATCH 1/1] ARM: mx53_loco: Add GPIO Keypad support
Message-ID: <1300157900-21171-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_loco.c |   44 +++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 0a18f8d..4f948bb 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -23,6 +23,7 @@
 #include <linux/fec.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/gpio_keys.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
@@ -36,6 +37,9 @@
 #include "crm_regs.h"
 #include "devices-imx53.h"
 
+#define LOCO_NONKEY			IMX_GPIO_NR(1, 8)
+#define LOCO_UI1			IMX_GPIO_NR(2, 14)
+#define LOCO_UI2			IMX_GPIO_NR(2, 15)
 #define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
 
 static iomux_v3_cfg_t mx53_loco_pads[] = {
@@ -180,6 +184,45 @@ static iomux_v3_cfg_t mx53_loco_pads[] = {
 	MX53_PAD_GPIO_8__GPIO1_8,
 };
 
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
+#define GPIO_BUTTON(gpio_num, ev_code, act_low, descr, wake)    \
+{                                                               \
+        .gpio           = gpio_num,                             \
+	.type           = EV_KEY,                               \
+	.code           = ev_code,                              \
+	.active_low     = act_low,                              \
+	.desc           = "btn " descr,                         \
+	.wakeup         = wake,                                 \
+}
+
+static struct gpio_keys_button loco_buttons[] = {
+	GPIO_BUTTON(LOCO_NONKEY, KEY_POWER, 1, "power", 0),
+	GPIO_BUTTON(LOCO_UI1, KEY_VOLUMEUP, 1, "volume-up", 0),
+	GPIO_BUTTON(LOCO_UI2, KEY_VOLUMEDOWN, 1, "volume-down", 0),
+};
+
+static struct gpio_keys_platform_data loco_button_data = {
+	.buttons        = loco_buttons,
+	.nbuttons       = ARRAY_SIZE(loco_buttons),
+};
+
+static struct platform_device loco_button_device = {
+	.name           = "gpio-keys",
+	.id             = -1,
+	.num_resources  = 0,
+	.dev            = {
+		.platform_data = &loco_button_data,
+	}
+};
+
+static void __init loco_add_device_buttons(void)
+{
+	platform_device_register(&loco_button_device);
+}
+#else
+static void __init loco_add_device_buttons(void) {}
+#endif
+
 static inline void mx53_loco_fec_reset(void)
 {
 	int ret;
@@ -215,6 +258,7 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
 	imx53_add_sdhci_esdhc_imx(0, NULL);
 	imx53_add_sdhci_esdhc_imx(2, NULL);
+	loco_add_device_buttons();
 }
 
 static void __init mx53_loco_timer_init(void)
-- 
1.7.1
