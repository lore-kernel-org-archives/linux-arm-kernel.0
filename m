From: Frank.Li@freescale.com (Frank Li)
Date: Tue, 15 Mar 2011 17:04:10 +0800
Subject: [PATCH 1/1 v3] ARM: mx53_loco: Add GPIO Keypad support
Message-ID: <1300179850-12183-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
v3: remove <linux/gpio_keys.h>
    add const __initconst

 arch/arm/mach-mx5/Kconfig           |    1 +
 arch/arm/mach-mx5/board-mx53_loco.c |   25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 83ee088..159340d 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -165,6 +165,7 @@ config MACH_MX53_LOCO
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select IMX_HAVE_PLATFORM_GPIO_KEYS
 	help
 	  Include support for MX53 LOCO platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 0a18f8d..10a1bea 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -36,6 +36,9 @@
 #include "crm_regs.h"
 #include "devices-imx53.h"
 
+#define MX53_LOCO_POWER			IMX_GPIO_NR(1, 8)
+#define MX53_LOCO_UI1			IMX_GPIO_NR(2, 14)
+#define MX53_LOCO_UI2			IMX_GPIO_NR(2, 15)
 #define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
 
 static iomux_v3_cfg_t mx53_loco_pads[] = {
@@ -180,6 +183,27 @@ static iomux_v3_cfg_t mx53_loco_pads[] = {
 	MX53_PAD_GPIO_8__GPIO1_8,
 };
 
+#define GPIO_BUTTON(gpio_num, ev_code, act_low, descr, wake)	\
+{								\
+	.gpio		= gpio_num,				\
+	.type		= EV_KEY,				\
+	.code		= ev_code,				\
+	.active_low	= act_low,				\
+	.desc		= "btn " descr,				\
+	.wakeup		= wake,					\
+}
+
+static const struct gpio_keys_button loco_buttons[] __initconst = {
+	GPIO_BUTTON(MX53_LOCO_POWER, KEY_POWER, 1, "power", 0),
+	GPIO_BUTTON(MX53_LOCO_UI1, KEY_VOLUMEUP, 1, "volume-up", 0),
+	GPIO_BUTTON(MX53_LOCO_UI2, KEY_VOLUMEDOWN, 1, "volume-down", 0),
+};
+
+static const struct gpio_keys_platform_data loco_button_data __initconst = {
+	.buttons        = loco_buttons,
+	.nbuttons       = ARRAY_SIZE(loco_buttons),
+};
+
 static inline void mx53_loco_fec_reset(void)
 {
 	int ret;
@@ -215,6 +239,7 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
 	imx53_add_sdhci_esdhc_imx(0, NULL);
 	imx53_add_sdhci_esdhc_imx(2, NULL);
+	imx_add_gpio_keys(&loco_button_data);
 }
 
 static void __init mx53_loco_timer_init(void)
-- 
1.7.1
