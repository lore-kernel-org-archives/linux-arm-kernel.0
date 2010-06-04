From: jason77.wang@gmail.com (Jason Wang)
Date: Fri,  4 Jun 2010 22:09:27 +0800
Subject: [V3 6/7] mx51/keypad: add keypad support for i.MX51 platforms
In-Reply-To: <1275660568-7738-6-git-send-email-jason77.wang@gmail.com>
References: <1275660568-7738-1-git-send-email-jason77.wang@gmail.com>
	<1275660568-7738-2-git-send-email-jason77.wang@gmail.com>
	<1275660568-7738-3-git-send-email-jason77.wang@gmail.com>
	<1275660568-7738-4-git-send-email-jason77.wang@gmail.com>
	<1275660568-7738-5-git-send-email-jason77.wang@gmail.com>
	<1275660568-7738-6-git-send-email-jason77.wang@gmail.com>
Message-ID: <1275660568-7738-7-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add keypad controller device definition for all i.MX51 platforms,
add a dummy kpp clock for imx keypad driver and add keypad device
registration on i.MX51 3-stack board.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 arch/arm/mach-mx5/board-mx51_3ds.c |   61 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mx5/clock-mx51.c     |    5 +++
 arch/arm/mach-mx5/devices.c        |   19 +++++++++++
 arch/arm/mach-mx5/devices.h        |    1 +
 4 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index af0362c..49f576f 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -12,6 +12,7 @@
 
 #include <linux/irq.h>
 #include <linux/platform_device.h>
+#include <linux/input/matrix_keypad.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -47,6 +48,18 @@ static struct pad_desc mx51_3ds_pads[] = {
 
 	/* CPLD PARENT IRQ PIN */
 	MX51_PAD_GPIO_1_6__GPIO1_6,
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
@@ -67,6 +80,52 @@ static inline void mxc_init_imx_uart(void)
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
@@ -78,6 +137,8 @@ static void __init mxc_board_init(void)
 
 	if (!mxc_expio_init(MX51_CS5_BASE_ADDR, EXPIO_PARENT_INT))
 		platform_device_register(&smsc_lan9217_device);
+
+	mxc_init_keypad();
 }
 
 static void __init mx51_3ds_timer_init(void)
diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index d9f612d..60fced6 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -758,6 +758,10 @@ static struct clk gpt_32k_clk = {
 	.parent = &ckil_clk,
 };
 
+static struct clk kpp_clk = {
+	.id = 0,
+};
+
 #define DEFINE_CLOCK(name, i, er, es, gr, sr, p, s)	\
 	static struct clk name = {			\
 		.id		= i,			\
@@ -821,6 +825,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", ahb_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
+	_REGISTER_CLOCK("imx-keypad.0", NULL, kpp_clk)
 };
 
 static void clk_tree_init(void)
diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index 7130449..2aa4ea0 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -168,6 +168,25 @@ struct platform_device mxc_wdt = {
 	.resource = mxc_wdt_resources,
 };
 
+static struct resource mxc_kpp_resources[] = {
+	{
+		.start = MX51_MXC_INT_KPP,
+		.end = MX51_MXC_INT_KPP,
+		.flags = IORESOURCE_IRQ,
+	} , {
+		.start = MX51_KPP_BASE_ADDR,
+		.end = MX51_KPP_BASE_ADDR + 0x8 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device mxc_keypad_device = {
+	.name = "imx-keypad",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(mxc_kpp_resources),
+	.resource = mxc_kpp_resources,
+};
+
 static struct mxc_gpio_port mxc_gpio_ports[] = {
 	{
 		.chip.label = "gpio-0",
diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
index c879ae7..1fef140 100644
--- a/arch/arm/mach-mx5/devices.h
+++ b/arch/arm/mach-mx5/devices.h
@@ -6,3 +6,4 @@ extern struct platform_device mxc_usbdr_host_device;
 extern struct platform_device mxc_usbh1_device;
 extern struct platform_device mxc_usbdr_udc_device;
 extern struct platform_device mxc_wdt;
+extern struct platform_device mxc_keypad_device;
-- 
1.5.6.5
