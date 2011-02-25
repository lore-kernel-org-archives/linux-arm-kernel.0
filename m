From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 25 Feb 2011 13:49:57 +0100
Subject: [PATCH 1/2] mx3/eukrea_mbimxsd-baseboard: fix gpio request
Message-ID: <1298638198-4175-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

without this patch, we get :
------------[ cut here ]------------
WARNING: at drivers/gpio/gpiolib.c:99 gpio_ensure_requested+0x4c/0x104()
autorequest GPIO-4
.../...
[<c01bcfb0>] (platform_lcd_set_power+0x34/0x40) from [<c033954c>] (platform_lcd_probe+0xb8/0xd8)

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
index 8076147..3f67eb6 100644
--- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
@@ -167,7 +167,7 @@ static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 
 #define GPIO_LED1	IMX_GPIO_NR(3, 29)
 #define GPIO_SWITCH1	IMX_GPIO_NR(3, 25)
-#define GPIO_LCDPWR	(4)
+#define GPIO_LCDPWR	IMX_GPIO_NR(1, 4)
 
 static void eukrea_mbimxsd_lcd_power_set(struct plat_lcd_data *pd,
 				   unsigned int power)
@@ -301,7 +301,6 @@ void __init eukrea_mbimxsd35_baseboard_init(void)
 
 	gpio_request(GPIO_LCDPWR, "LCDPWR");
 	gpio_direction_output(GPIO_LCDPWR, 1);
-	gpio_free(GPIO_LCDPWR);
 
 	i2c_register_board_info(0, eukrea_mbimxsd_i2c_devices,
 				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
-- 
1.7.4
