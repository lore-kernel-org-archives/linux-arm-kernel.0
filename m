From: balbi@ti.com (Felipe Balbi)
Date: Wed, 26 Nov 2014 14:27:35 -0600
Subject: [PATCH] arm: omap2: rx51-peripherals: fix build warning
Message-ID: <1417033655-32332-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 68a3c04 ([media] ARM: OMAP2: RX-51: update
si4713 platform data) updated board-rx51-peripherals.c
so that si4713 could be easily used on DT boot, but
it ended up introducing a build warning whenever
si4713 isn't enabled.

This patches fixes that warning:

arch/arm/mach-omap2/board-rx51-peripherals.c:1000:36: warning: \
	?rx51_si4713_platform_data? defined but not used [-Wunused-variable]
 static struct si4713_platform_data rx51_si4713_platform_data = {

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index d18a5cf..bda20c5 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -997,9 +997,11 @@ static struct aic3x_pdata rx51_aic3x_data2 = {
 	.gpio_reset = 60,
 };
 
+#if IS_ENABLED(CONFIG_I2C_SI4713) && IS_ENABLED(CONFIG_PLATFORM_SI4713)
 static struct si4713_platform_data rx51_si4713_platform_data = {
 	.is_platform_device = true
 };
+#endif
 
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
 #if IS_ENABLED(CONFIG_I2C_SI4713) && IS_ENABLED(CONFIG_PLATFORM_SI4713)
-- 
2.1.0.GIT
