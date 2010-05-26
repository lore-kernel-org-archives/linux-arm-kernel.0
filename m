From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 26 May 2010 15:12:11 +0300
Subject: [PATCH 2/2] mx25pdk: add keypad support
In-Reply-To: <412553643c3238bcb6c86020406f4438e30eda29.1274875750.git.baruch@tkos.co.il>
References: <412553643c3238bcb6c86020406f4438e30eda29.1274875750.git.baruch@tkos.co.il>
Message-ID: <7acf0cf0ba4663071245e7c01cddcc39a8719d07.1274875750.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The keymap is taken from the Freescale supplied kernel.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-mx25/mach-mx25pdk.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/mach-mx25pdk.c b/arch/arm/mach-mx25/mach-mx25pdk.c
index 83d7410..4a57f68 100644
--- a/arch/arm/mach-mx25/mach-mx25pdk.c
+++ b/arch/arm/mach-mx25/mach-mx25pdk.c
@@ -24,6 +24,7 @@
 #include <linux/gpio.h>
 #include <linux/fec.h>
 #include <linux/platform_device.h>
+#include <linux/input/matrix_keypad.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -80,6 +81,16 @@ static struct pad_desc mx25pdk_pads[] = {
 	MX25_PAD_LSCLK__LSCLK,
 	MX25_PAD_OE_ACD__OE_ACD,
 	MX25_PAD_CONTRAST__CONTRAST,
+
+	/* Keypad */
+	MX25_PAD_KPP_ROW0__KPP_ROW0,
+	MX25_PAD_KPP_ROW1__KPP_ROW1,
+	MX25_PAD_KPP_ROW2__KPP_ROW2,
+	MX25_PAD_KPP_ROW3__KPP_ROW3,
+	MX25_PAD_KPP_COL0__KPP_COL0,
+	MX25_PAD_KPP_COL1__KPP_COL1,
+	MX25_PAD_KPP_COL2__KPP_COL2,
+	MX25_PAD_KPP_COL3__KPP_COL3,
 };
 
 static struct fec_platform_data mx25_fec_pdata = {
@@ -137,6 +148,30 @@ static struct imx_fb_platform_data mx25pdk_fb_pdata = {
 	.dmacr		= 0x00020010,
 };
 
+static const uint32_t mx25pdk_keymap[] = {
+	KEY(0, 0, KEY_UP),
+	KEY(0, 1, KEY_DOWN),
+	KEY(0, 2, KEY_VOLUMEDOWN),
+	KEY(0, 3, KEY_HOME),
+	KEY(1, 0, KEY_RIGHT),
+	KEY(1, 1, KEY_LEFT),
+	KEY(1, 2, KEY_ENTER),
+	KEY(1, 3, KEY_VOLUMEUP),
+	KEY(2, 0, KEY_F6),
+	KEY(2, 1, KEY_F8),
+	KEY(2, 2, KEY_F9),
+	KEY(2, 3, KEY_F10),
+	KEY(3, 0, KEY_F1),
+	KEY(3, 1, KEY_F2),
+	KEY(3, 2, KEY_F3),
+	KEY(3, 3, KEY_POWER),
+};
+
+static struct matrix_keymap_data mx25pdk_keymap_data = {
+	.keymap		= mx25pdk_keymap,
+	.keymap_size	= ARRAY_SIZE(mx25pdk_keymap),
+};
+
 static void __init mx25pdk_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx25pdk_pads,
@@ -150,6 +185,7 @@ static void __init mx25pdk_init(void)
 
 	mx25pdk_fec_reset();
 	mxc_register_device(&mx25_fec_device, &mx25_fec_pdata);
+	mxc_register_device(&mx25_kpp_device, &mx25pdk_keymap_data);
 }
 
 static void __init mx25pdk_timer_init(void)
-- 
1.7.1
