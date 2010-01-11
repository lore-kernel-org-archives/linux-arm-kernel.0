From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jan 2010 22:04:09 +0800
Subject: [PATCH 01/16] [ARM] pxa/tosa: make use of the matrix keypad driver
In-Reply-To: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
References: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1263218664-11546-2-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/tosa.c |  117 ++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 98 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index c854c16..ad55279 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -32,6 +32,7 @@
 #include <linux/gpio.h>
 #include <linux/pda_power.h>
 #include <linux/spi/spi.h>
+#include <linux/input/matrix_keypad.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -131,24 +132,24 @@ static unsigned long tosa_pin_config[] = {
 	GPIO45_BTUART_RTS,
 
 	/* Keybd */
-	GPIO58_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO59_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO60_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO61_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO62_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO63_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO64_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO65_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO66_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO67_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO68_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO69_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO70_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO71_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO72_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO73_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO74_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO75_GPIO | MFP_LPM_DRIVE_LOW,
+	GPIO58_GPIO | MFP_LPM_DRIVE_LOW,	/* Column 0 */
+	GPIO59_GPIO | MFP_LPM_DRIVE_LOW,	/* Column 1 */
+	GPIO60_GPIO | MFP_LPM_DRIVE_LOW,	/* Column 2 */
+	GPIO61_GPIO | MFP_LPM_DRIVE_LOW,	/* Column 3 */
+	GPIO62_GPIO | MFP_LPM_DRIVE_LOW,	/* Column 4 */
+	GPIO63_GPIO | MFP_LPM_DRIVE_LOW,	/* Column 5 */
+	GPIO64_GPIO | MFP_LPM_DRIVE_LOW,	/* Column 6 */
+	GPIO65_GPIO | MFP_LPM_DRIVE_LOW,	/* Column 7 */
+	GPIO66_GPIO | MFP_LPM_DRIVE_LOW,	/* Column 8 */
+	GPIO67_GPIO | MFP_LPM_DRIVE_LOW,	/* Column 9 */
+	GPIO68_GPIO | MFP_LPM_DRIVE_LOW,	/* Column 10 */
+	GPIO69_GPIO | MFP_LPM_DRIVE_LOW,	/* Row 0 */
+	GPIO70_GPIO | MFP_LPM_DRIVE_LOW,	/* Row 1 */
+	GPIO71_GPIO | MFP_LPM_DRIVE_LOW,	/* Row 2 */
+	GPIO72_GPIO | MFP_LPM_DRIVE_LOW,	/* Row 3 */
+	GPIO73_GPIO | MFP_LPM_DRIVE_LOW,	/* Row 4 */
+	GPIO74_GPIO | MFP_LPM_DRIVE_LOW,	/* Row 5 */
+	GPIO75_GPIO | MFP_LPM_DRIVE_LOW,	/* Row 6 */
 
 	/* SPI */
 	GPIO81_SSP2_CLK_OUT,
@@ -411,9 +412,87 @@ static struct platform_device tosa_power_device = {
 /*
  * Tosa Keyboard
  */
+static const uint32_t tosakbd_keymap[] = {
+	KEY(0, 2, KEY_W),
+	KEY(0, 6, KEY_K),
+	KEY(0, 7, KEY_BACKSPACE),
+	KEY(0, 8, KEY_P),
+	KEY(1, 1, KEY_Q),
+	KEY(1, 2, KEY_E),
+	KEY(1, 3, KEY_T),
+	KEY(1, 4, KEY_Y),
+	KEY(1, 6, KEY_O),
+	KEY(1, 7, KEY_I),
+	KEY(1, 8, KEY_COMMA),
+	KEY(2, 1, KEY_A),
+	KEY(2, 2, KEY_D),
+	KEY(2, 3, KEY_G),
+	KEY(2, 4, KEY_U),
+	KEY(2, 6, KEY_L),
+	KEY(2, 7, KEY_ENTER),
+	KEY(2, 8, KEY_DOT),
+	KEY(3, 1, KEY_Z),
+	KEY(3, 2, KEY_C),
+	KEY(3, 3, KEY_V),
+	KEY(3, 4, KEY_J),
+	KEY(3, 5, TOSA_KEY_ADDRESSBOOK),
+	KEY(3, 6, TOSA_KEY_CANCEL),
+	KEY(3, 7, TOSA_KEY_CENTER),
+	KEY(3, 8, TOSA_KEY_OK),
+	KEY(3, 9, KEY_LEFTSHIFT),
+	KEY(4, 1, KEY_S),
+	KEY(4, 2, KEY_R),
+	KEY(4, 3, KEY_B),
+	KEY(4, 4, KEY_N),
+	KEY(4, 5, TOSA_KEY_CALENDAR),
+	KEY(4, 6, TOSA_KEY_HOMEPAGE),
+	KEY(4, 7, KEY_LEFTCTRL),
+	KEY(4, 8, TOSA_KEY_LIGHT),
+	KEY(4, 10, KEY_RIGHTSHIFT),
+	KEY(5, 1, KEY_TAB),
+	KEY(5, 2, KEY_SLASH),
+	KEY(5, 3, KEY_H),
+	KEY(5, 4, KEY_M),
+	KEY(5, 5, TOSA_KEY_MENU),
+	KEY(5, 7, KEY_UP),
+	KEY(5, 11, TOSA_KEY_FN),
+	KEY(6, 1, KEY_X),
+	KEY(6, 2, KEY_F),
+	KEY(6, 3, KEY_SPACE),
+	KEY(6, 4, KEY_APOSTROPHE),
+	KEY(6, 5, TOSA_KEY_MAIL),
+	KEY(6, 6, KEY_LEFT),
+	KEY(6, 7, KEY_DOWN),
+	KEY(6, 8, KEY_RIGHT),
+};
+
+static struct matrix_keymap_data tosakbd_keymap_data = {
+	.keymap		= tosakbd_keymap,
+	.keymap_size	= ARRAY_SIZE(tosakbd_keymap),
+};
+
+static const int tosakbd_col_gpios[] =
+			{ 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68 };
+static const int tosakbd_row_gpios[] =
+			{ 69, 70, 71, 72, 73, 74, 75 };
+
+static struct matrix_keypad_platform_data tosakbd_pdata = {
+	.keymap_data		= &tosakbd_keymap_data,
+	.row_gpios		= tosakbd_row_gpios,
+	.col_gpios		= tosakbd_col_gpios,
+	.num_row_gpios		= ARRAY_SIZE(tosakbd_row_gpios),
+	.num_col_gpios		= ARRAY_SIZE(tosakbd_col_gpios),
+	.col_scan_delay_us	= 10,
+	.debounce_ms		= 10,
+	.wakeup			= 1,
+};
+
 static struct platform_device tosakbd_device = {
-	.name		= "tosa-keyboard",
+	.name		= "matrix-keypad",
 	.id		= -1,
+	.dev		= {
+		.platform_data = &tosakbd_pdata,
+	},
 };
 
 static struct gpio_keys_button tosa_gpio_keys[] = {
-- 
1.6.3.3
