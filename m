From: mark.brown314@gmail.com (Mark F. Brown)
Date: Tue,  7 Sep 2010 22:56:47 -0400
Subject: [PATCH 3/3] ARM: pxa168/teton bga: add board support for i2c and
	rtc-ds1337
In-Reply-To: <1283914607-10570-1-git-send-email-mark.brown314@gmail.com>
References: <1283914607-10570-1-git-send-email-mark.brown314@gmail.com>
Message-ID: <1283914607-10570-4-git-send-email-mark.brown314@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
---
 arch/arm/mach-mmp/teton_bga.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index bbeda5c..8e5801c 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -22,6 +22,7 @@
 #include <mach/gpio.h>
 #include <linux/input.h>
 #include <plat/pxa27x_keypad.h>
+#include <linux/i2c.h>
 
 #include "common.h"
 
@@ -35,6 +36,10 @@ static unsigned long teton_bga_pin_config[] __initdata = {
 	GPIO110_KP_MKIN0,
 	GPIO111_KP_MKOUT7,
 	GPIO112_KP_MKOUT6,
+
+	/* i2c bus */
+	GPIO105_CI2C_SDA,
+	GPIO106_CI2C_SCL,
 };
 
 static unsigned int teton_bga_matrix_key_map[] = {
@@ -52,6 +57,10 @@ static struct pxa27x_keypad_platform_data teton_bga_keypad_info __initdata = {
 	.debounce_interval      = 30,
 };
 
+static struct i2c_board_info teton_bga_i2c_info[] __initdata = {
+	{ I2C_BOARD_INFO("ds1337", 0x68), },
+};
+
 static void __init teton_bga_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(teton_bga_pin_config));
@@ -59,6 +68,7 @@ static void __init teton_bga_init(void)
 	/* on-chip devices */
 	pxa168_add_uart(1);
 	pxa168_add_keypad(&teton_bga_keypad_info);
+	pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(teton_bga_i2c_info));
 }
 
 MACHINE_START(TETON_BGA, "PXA168-based Teton BGA Development Platform")
-- 
1.7.0.4
