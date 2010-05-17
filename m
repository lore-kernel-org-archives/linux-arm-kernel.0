From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Mon, 17 May 2010 20:20:14 +0200
Subject: [PATCH 2/2] mx31_3ds: Support the keypad situated in the
	personality board
In-Reply-To: <1274120092.3578.34.camel@realization>
References: <1274120092.3578.34.camel@realization>
Message-ID: <1274120414.3578.36.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---

this patch is built over the today mxc-master branch 

 arch/arm/mach-mx3/mach-mx31_3ds.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 55d6117..745675b 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -28,6 +28,7 @@
 #include <linux/spi/spi.h>
 #include <linux/regulator/machine.h>
 #include <linux/fsl_devices.h>
+#include <linux/input/matrix_keypad.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -82,6 +83,35 @@ static int mx31_3ds_pins[] = {
 	MX31_PIN_USBOTG_DIR__USBOTG_DIR,
 	MX31_PIN_USBOTG_NXT__USBOTG_NXT,
 	MX31_PIN_USBOTG_STP__USBOTG_STP,
+	/*Keyboard*/
+	IOMUX_MODE(MX31_PIN_KEY_ROW0, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_KEY_ROW1, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_KEY_ROW2, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_KEY_COL0, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_KEY_COL1, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_KEY_COL2, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_KEY_COL3, IOMUX_CONFIG_FUNC),
+};
+
+/*
+ * Matrix keyboard
+ */
+
+static const uint32_t mx31_3ds_keymap[] = {
+	KEY(0, 0, KEY_UP),
+	KEY(0, 1, KEY_DOWN),
+	KEY(1, 0, KEY_RIGHT),
+	KEY(1, 1, KEY_LEFT),
+	KEY(1, 2, KEY_ENTER),
+	KEY(2, 0, KEY_F6),
+	KEY(2, 1, KEY_F8),
+	KEY(2, 2, KEY_F9),
+	KEY(2, 3, KEY_F10),
+};
+
+static struct matrix_keymap_data mx31_3ds_keymap_data = {
+	.keymap		= mx31_3ds_keymap,
+	.keymap_size	= ARRAY_SIZE(mx31_3ds_keymap),
 };
 
 /* Regulators */
@@ -367,6 +397,8 @@ static void __init mxc_board_init(void)
 	spi_register_board_info(mx31_3ds_spi_devs,
 						ARRAY_SIZE(mx31_3ds_spi_devs));
 
+	mxc_register_device(&imx_kpp_device, &mx31_3ds_keymap_data);
+
 	mx31_3ds_usbotg_init();
 	mxc_register_device(&mxc_otg_udc_device, &usbotg_pdata);
 
-- 
1.6.3.3
