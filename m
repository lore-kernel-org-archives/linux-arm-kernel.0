From: jason77.wang@gmail.com (Jason Wang)
Date: Wed, 14 Jul 2010 21:24:54 +0800
Subject: [PATCH V2 3/3] mx51_3ds: add keypad support on 3ds platform
In-Reply-To: <1279113894-10316-3-git-send-email-jason77.wang@gmail.com>
References: <1279113894-10316-1-git-send-email-jason77.wang@gmail.com>
	<1279113894-10316-2-git-send-email-jason77.wang@gmail.com>
	<1279113894-10316-3-git-send-email-jason77.wang@gmail.com>
Message-ID: <1279113894-10316-4-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add keymaps and imx_keypad device registration for imx51_3ds board.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 arch/arm/mach-mx5/board-mx51_3ds.c |   61 ++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index f6a338c..f95c2fd 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -12,6 +12,7 @@
 
 #include <linux/irq.h>
 #include <linux/platform_device.h>
+#include <linux/input/matrix_keypad.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -48,6 +49,18 @@ static struct pad_desc mx51_3ds_pads[] = {
 
 	/* CPLD PARENT IRQ PIN */
 	MX51_PAD_GPIO_1_6__GPIO_1_6,
+
+	/* KPP */
+	MX51_PAD_KEY_ROW0__KEY_ROW0,
+	MX51_PAD_KEY_ROW1__KEY_ROW1,
+	MX51_PAD_KEY_ROW2__KEY_ROW2,
+	MX51_PAD_KEY_ROW3__KEY_ROW3,
+	MX51_PAD_KEY_COL0__KEY_COL0,
+	MX51_PAD_KEY_COL1__KEY_COL1,
+	MX51_PAD_KEY_COL2__KEY_COL2,
+	MX51_PAD_KEY_COL3__KEY_COL3,
+	MX51_PAD_KEY_COL4__KEY_COL4,
+	MX51_PAD_KEY_COL5__KEY_COL5,
 };
 
 /* Serial ports */
@@ -68,6 +81,52 @@ static inline void mxc_init_imx_uart(void)
 }
 #endif /* SERIAL_IMX */
 
+#if defined(CONFIG_KEYBOARD_IMX) || defined(CONFIG_KEYBOARD_IMX_MODULE)
+static int mx51_3ds_board_keymap[] = {
+	KEY(0, 0, KEY_1),
+	KEY(0, 1, KEY_2),
+	KEY(0, 2, KEY_3),
+	KEY(0, 3, KEY_F1),
+	KEY(0, 4, KEY_UP),
+	KEY(0, 5, KEY_F2),
+
+	KEY(1, 0, KEY_4),
+	KEY(1, 1, KEY_5),
+	KEY(1, 2, KEY_6),
+	KEY(1, 3, KEY_LEFT),
+	KEY(1, 4, KEY_SELECT),
+	KEY(1, 5, KEY_RIGHT),
+
+	KEY(2, 0, KEY_7),
+	KEY(2, 1, KEY_8),
+	KEY(2, 2, KEY_9),
+	KEY(2, 3, KEY_F3),
+	KEY(2, 4, KEY_DOWN),
+	KEY(2, 5, KEY_F4),
+
+	KEY(3, 0, KEY_0),
+	KEY(3, 1, KEY_OK),
+	KEY(3, 2, KEY_ESC),
+	KEY(3, 3, KEY_ENTER),
+	KEY(3, 4, KEY_MENU),
+	KEY(3, 5, KEY_BACK)
+};
+
+static struct matrix_keymap_data mx51_3ds_map_data = {
+	.keymap		= mx51_3ds_board_keymap,
+	.keymap_size	= ARRAY_SIZE(mx51_3ds_board_keymap),
+};
+
+static void mxc_init_keypad(void)
+{
+	mxc_register_device(&mxc_keypad_device, &mx51_3ds_map_data);
+}
+#else
+static inline void mxc_init_keypad(void)
+{
+}
+#endif
+
 /*
  * Board specific initialization.
  */
@@ -80,6 +139,8 @@ static void __init mxc_board_init(void)
 	if (mxc_expio_init(MX51_CS5_BASE_ADDR, EXPIO_PARENT_INT))
 		printk(KERN_WARNING "Init of the debugboard failed, all "
 				    "devices on the board are unusable.\n");
+
+	mxc_init_keypad();
 }
 
 static void __init mx51_3ds_timer_init(void)
-- 
1.5.6.5
