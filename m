From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 13 Mar 2011 17:19:17 +0200
Subject: [PATCH v2 1/6] ARM: PXA: Z2: Use only power button as wake source
In-Reply-To: <1300029562-8400-1-git-send-email-anarsoul@gmail.com>
References: <1300029562-8400-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1300029562-8400-2-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's very easy to press some keypad key when Z2 is closed,
so to prevent unexpected wakeups, use only 'Power' key to wake
Z2 from sleep.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-pxa/z2.c |   32 +++++++++++++++++++++++---------
 1 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index aaf8837..19bbb7d 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -91,13 +91,13 @@ static unsigned long z2_pin_config[] = {
 	GPIO47_STUART_TXD,
 
 	/* Keypad */
-	GPIO100_KP_MKIN_0	| WAKEUP_ON_LEVEL_HIGH,
-	GPIO101_KP_MKIN_1	| WAKEUP_ON_LEVEL_HIGH,
-	GPIO102_KP_MKIN_2	| WAKEUP_ON_LEVEL_HIGH,
-	GPIO34_KP_MKIN_3	| WAKEUP_ON_LEVEL_HIGH,
-	GPIO38_KP_MKIN_4	| WAKEUP_ON_LEVEL_HIGH,
-	GPIO16_KP_MKIN_5	| WAKEUP_ON_LEVEL_HIGH,
-	GPIO17_KP_MKIN_6	| WAKEUP_ON_LEVEL_HIGH,
+	GPIO100_KP_MKIN_0,
+	GPIO101_KP_MKIN_1,
+	GPIO102_KP_MKIN_2,
+	GPIO34_KP_MKIN_3,
+	GPIO38_KP_MKIN_4,
+	GPIO16_KP_MKIN_5,
+	GPIO17_KP_MKIN_6,
 	GPIO103_KP_MKOUT_0,
 	GPIO104_KP_MKOUT_1,
 	GPIO105_KP_MKOUT_2,
@@ -427,8 +427,22 @@ static inline void z2_mkp_init(void) {}
  ******************************************************************************/
 #if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
 static struct gpio_keys_button z2_pxa_buttons[] = {
-	{KEY_POWER, GPIO1_ZIPITZ2_POWER_BUTTON, 0, "Power Button" },
-	{KEY_CLOSE, GPIO98_ZIPITZ2_LID_BUTTON, 0, "Lid Button" },
+	{
+		.code		= KEY_POWER,
+		.gpio		= GPIO1_ZIPITZ2_POWER_BUTTON,
+		.active_low	= 0,
+		.desc		= "Power Button",
+		.wakeup		= 1,
+		.type		= EV_KEY,
+	},
+	{
+		.code		= KEY_CLOSE,
+		.gpio		= GPIO98_ZIPITZ2_LID_BUTTON,
+		.active_low	= 0,
+		.desc		= "Lid Button",
+		.wakeup		= 0
+		.type		= EV_KEY,
+	},
 };
 
 static struct gpio_keys_platform_data z2_pxa_keys_data = {
-- 
1.7.4.1
