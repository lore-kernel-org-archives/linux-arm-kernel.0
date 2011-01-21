From: sundar.iyer@stericsson.com (Sundar Iyer)
Date: Fri, 21 Jan 2011 10:56:18 +0530
Subject: [PATCH 4/4] mach-ux500: add U8500 UIB platform data
In-Reply-To: <1295587578-14461-1-git-send-email-sundar.iyer@stericsson.com>
References: <1295587578-14461-1-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <1295587578-14461-5-git-send-email-sundar.iyer@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The U8500 UIB contains a Synaptics RMI touchpanel and
a matrix keyboard via the TC35893 port expander device.

Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500-u8500uib.c |   97 +++++++++++++++++++++++++++
 arch/arm/mach-ux500/board-mop500.c          |    3 +
 2 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-u8500uib.c b/arch/arm/mach-ux500/board-mop500-u8500uib.c
index 1091806..ec91d2e 100644
--- a/arch/arm/mach-ux500/board-mop500-u8500uib.c
+++ b/arch/arm/mach-ux500/board-mop500-u8500uib.c
@@ -6,10 +6,107 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/tc3589x.h>
+#include <linux/input/matrix_keypad.h>
+#include <../drivers/staging/ste_rmi4/synaptics_i2c_rmi4.h>
+
+#include <mach/gpio.h>
+#include <mach/irqs.h>
 
 #include "board-mop500.h"
 
+/*
+ * Synaptics RMI4 touchscreen interface on the NUIBs
+ */
+
+/*
+ * Descriptor structure.
+ * Describes the number of i2c devices on the bus that speak RMI.
+ */
+static struct synaptics_rmi4_platform_data rmi4_i2c_dev_platformdata = {
+	.name           = "synaptics_rmi4_i2c0",
+	.irq_number     = NOMADIK_GPIO_TO_IRQ(84),
+	.irq_type       = (IRQF_TRIGGER_FALLING | IRQF_SHARED),
+	.x_flip         = false,
+	.y_flip         = true,
+	.regulator_en   = false,
+};
+
+static struct i2c_board_info __initdata u8500_i2c3_devices_nuib[] = {
+	{
+		I2C_BOARD_INFO("synaptics_rmi4_i2c", 0x4B),
+		.platform_data = &rmi4_i2c_dev_platformdata,
+	},
+};
+
+/*
+ * TC35893
+ */
+static const unsigned int nuib_keymap[] = {
+	KEY(3, 1, KEY_END),
+	KEY(4, 1, KEY_POWER),
+	KEY(6, 4, KEY_VOLUMEDOWN),
+	KEY(4, 2, KEY_EMAIL),
+	KEY(3, 3, KEY_RIGHT),
+	KEY(2, 5, KEY_BACKSPACE),
+
+	KEY(6, 7, KEY_MENU),
+	KEY(5, 0, KEY_ENTER),
+	KEY(4, 3, KEY_0),
+	KEY(3, 4, KEY_DOT),
+	KEY(5, 2, KEY_UP),
+	KEY(3, 5, KEY_DOWN),
+
+	KEY(4, 5, KEY_SEND),
+	KEY(0, 5, KEY_BACK),
+	KEY(6, 2, KEY_VOLUMEUP),
+	KEY(1, 3, KEY_SPACE),
+	KEY(7, 6, KEY_LEFT),
+	KEY(5, 5, KEY_SEARCH),
+};
+
+static struct matrix_keymap_data nuib_keymap_data = {
+	.keymap         = nuib_keymap,
+	.keymap_size    = ARRAY_SIZE(nuib_keymap),
+};
+
+static struct tc3589x_keypad_platform_data tc35893_data = {
+	.krow = TC_KPD_ROWS,
+	.kcol = TC_KPD_COLUMNS,
+	.debounce_period = TC_KPD_DEBOUNCE_PERIOD,
+	.settle_time = TC_KPD_SETTLE_TIME,
+	.irqtype = IRQF_TRIGGER_FALLING,
+	.enable_wakeup = true,
+	.keymap_data    = &nuib_keymap_data,
+	.no_autorepeat  = true,
+};
+
+static struct tc3589x_platform_data tc3589x_keypad_data = {
+	.block = TC3589x_BLOCK_KEYPAD,
+	.keypad = &tc35893_data,
+	.irq_base = MOP500_EGPIO_IRQ_BASE,
+};
+
+static struct i2c_board_info __initdata mop500_i2c0_devices_nuib[] = {
+	{
+		I2C_BOARD_INFO("tc3589x", 0x44),
+		.platform_data = &tc3589x_keypad_data,
+		.irq = NOMADIK_GPIO_TO_IRQ(218),
+		.flags = I2C_CLIENT_WAKE,
+	},
+};
+
+
 void __init mop500_u8500uib_init(void)
 {
+	mop500_uib_i2c_add(3, u8500_i2c3_devices_nuib,
+			ARRAY_SIZE(u8500_i2c3_devices_nuib));
+
+	mop500_uib_i2c_add(0, mop500_i2c0_devices_nuib,
+			ARRAY_SIZE(mop500_i2c0_devices_nuib));
+
 }
 
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 1a839cc..fd6d509 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -77,6 +77,9 @@ static pin_cfg_t mop500_pins[] = {
 
 	/* STMPE1601 IRQ */
 	GPIO218_GPIO    | PIN_INPUT_PULLUP,
+
+	/* touch screen */
+	GPIO84_GPIO	| PIN_INPUT_PULLUP,
 };
 
 static struct ab8500_platform_data ab8500_platdata = {
-- 
1.7.2.dirty
