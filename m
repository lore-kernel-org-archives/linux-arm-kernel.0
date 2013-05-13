From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 May 2013 21:07:35 +0400
Subject: [PATCH 13/15] ARM: clps711x: edb7211: Control LCD backlight via PWM
In-Reply-To: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
Message-ID: <1368464857-5038-16-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provide control LCD backlight via PWM. GPIO is used
only for switch backlight ON and OFF.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-edb7211.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-clps711x/board-edb7211.c b/arch/arm/mach-clps711x/board-edb7211.c
index 970f4e1..9dfb990 100644
--- a/arch/arm/mach-clps711x/board-edb7211.c
+++ b/arch/arm/mach-clps711x/board-edb7211.c
@@ -109,13 +109,14 @@ static struct plat_lcd_data edb7211_lcd_power_pdata = {
 
 static void edb7211_lcd_backlight_set_intensity(int intensity)
 {
-	gpio_set_value(EDB7211_LCDBL, intensity);
+	gpio_set_value(EDB7211_LCDBL, !!intensity);
+	clps_writel((clps_readl(PMPCON) & 0xf0ff) | (intensity << 8), PMPCON);
 }
 
 static struct generic_bl_info edb7211_lcd_backlight_pdata = {
 	.name			= "lcd-backlight.0",
 	.default_intensity	= 0x01,
-	.max_intensity		= 0x01,
+	.max_intensity		= 0x0f,
 	.set_bl_intensity	= edb7211_lcd_backlight_set_intensity,
 };
 
-- 
1.8.1.5
