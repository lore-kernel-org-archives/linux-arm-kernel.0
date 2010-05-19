From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Wed, 19 May 2010 11:34:43 +0200
Subject: [PATCH 2/2 v2] mx31_3ds: Support the keypad situated in the
	personality board
In-Reply-To: <1274261623.3123.8.camel@realization>
References: <1274261512.3123.6.camel@realization>
	<1274261623.3123.8.camel@realization>
Message-ID: <1274261683.3123.9.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---

This patch is built against the today mxc-master branch

 arch/arm/mach-mx3/mach-mx31_3ds.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 55d6117..58e5729 100644
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
+	MX31_PIN_KEY_ROW0_KEY_ROW0,
+	MX31_PIN_KEY_ROW1_KEY_ROW1,
+	MX31_PIN_KEY_ROW2_KEY_ROW2,
+	MX31_PIN_KEY_COL0_KEY_COL0,
+	MX31_PIN_KEY_COL1_KEY_COL1,
+	MX31_PIN_KEY_COL2_KEY_COL2,
+	MX31_PIN_KEY_COL3_KEY_COL3,
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
