From: rogerio.pimentel@freescale.com (Rogerio Pimentel)
Date: Tue, 19 Oct 2010 14:02:57 -0200
Subject: [PATCH] MX51 Babbage: Add Keypad support to MX51 Babbage
Message-ID: <4CBDC131.4090609@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Keypad support to MX51 Babbage.

Keypad is provided by an expansion board connected to J1 connector.

Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>

---
  arch/arm/mach-mx5/board-mx51_babbage.c |   39 
++++++++++++++++++++++++++++++++
  1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c 
b/arch/arm/mach-mx5/board-mx51_babbage.c
index 23ee4a4..cbe81f6 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -18,6 +18,7 @@
  #include <linux/io.h>
  #include <linux/fsl_devices.h>
  #include <linux/fec.h>
+#include <linux/input/matrix_keypad.h>

  #include <mach/common.h>
  #include <mach/hardware.h>
@@ -112,6 +113,16 @@ static struct pad_desc mx51babbage_pads[] = {

      /* FEC PHY reset line */
      MX51_PAD_EIM_A20__GPIO_2_14,
+
+    /* Keypad */
+    MX51_PAD_KEY_ROW0__KEY_ROW0,
+    MX51_PAD_KEY_ROW1__KEY_ROW1,
+    MX51_PAD_KEY_ROW2__KEY_ROW2,
+    MX51_PAD_KEY_ROW3__KEY_ROW3,
+    MX51_PAD_KEY_COL0__KEY_COL0,
+    MX51_PAD_KEY_COL1__KEY_COL1,
+    MX51_PAD_KEY_COL2__KEY_COL2,
+    MX51_PAD_KEY_COL3__KEY_COL3,
  };

  /* Serial ports */
@@ -140,6 +151,33 @@ static struct imxi2c_platform_data 
babbage_hsi2c_data = {
      .bitrate = 400000,
  };

+static int mx51babbage_keymap[] = {
+    KEY(0, 0, KEY_UP),
+    KEY(0, 1, KEY_DOWN),
+    KEY(0, 2, KEY_MENU),
+    KEY(0, 3, KEY_BACK),
+
+    KEY(1, 0, KEY_RIGHT),
+    KEY(1, 1, KEY_LEFT),
+    KEY(1, 2, KEY_SELECT),
+    KEY(1, 3, KEY_ENTER),
+
+    KEY(2, 0, KEY_F1),
+    KEY(2, 1, KEY_F3),
+    KEY(2, 2, KEY_1),
+    KEY(2, 3, KEY_3),
+
+    KEY(3, 0, KEY_F2),
+    KEY(3, 1, KEY_F4),
+    KEY(3, 2, KEY_2),
+    KEY(3, 3, KEY_4),
+};
+
+static struct matrix_keymap_data mx51babbage_map_data = {
+    .keymap        = mx51babbage_keymap,
+    .keymap_size    = ARRAY_SIZE(mx51babbage_keymap),
+};
+
  static int gpio_usbh1_active(void)
  {
      struct pad_desc usbh1stp_gpio = MX51_PAD_USBH1_STP__GPIO_1_27;
@@ -291,6 +329,7 @@ static void __init mxc_board_init(void)
      imx51_add_imx_i2c(0, &babbage_i2c_data);
      imx51_add_imx_i2c(1, &babbage_i2c_data);
      mxc_register_device(&mxc_hsi2c_device, &babbage_hsi2c_data);
+    mxc_register_device(&mxc_keypad_device, &mx51babbage_map_data);

      if (otg_mode_host)
          mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
-- 
1.7.0.4
