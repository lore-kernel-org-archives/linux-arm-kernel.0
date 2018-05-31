From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 May 2018 12:06:45 +0100
Subject: Applied "ARM: pxa,
 regulator: fix building ezx e680" to the regulator tree
In-Reply-To: <20180530212514.346474-1-arnd@arndb.de>
Message-ID: <E1fOLPp-00023H-9S@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ARM: pxa, regulator: fix building ezx e680

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2b6c00c157c5bf80417f6b814f1088da2dc588ee Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 May 2018 23:24:58 +0200
Subject: [PATCH] ARM: pxa, regulator: fix building ezx e680

The reference to camera_supply_gpiod_table was added in the wrong function,
as observed from this randconfig build failure:

arch/arm/mach-pxa/ezx.c: In function 'e680_init':
arch/arm/mach-pxa/ezx.c:905:26: error: 'camera_supply_gpiod_table' undeclared (first use in this function)
  gpiod_add_lookup_table(&camera_supply_gpiod_table);

Fixes: 6059577cb28d ("regulator: fixed: Convert to use GPIO descriptor only")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/mach-pxa/ezx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 2b4bd6d94855..4f33eea73f9a 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -902,7 +902,6 @@ static void __init e680_init(void)
 
 	pxa_set_keypad_info(&e680_keypad_platform_data);
 
-	gpiod_add_lookup_table(&camera_supply_gpiod_table);
 	pwm_add_table(ezx_pwm_lookup, ARRAY_SIZE(ezx_pwm_lookup));
 	platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
 	platform_add_devices(ARRAY_AND_SIZE(e680_devices));
@@ -1132,6 +1131,7 @@ static void __init a910_init(void)
 	if (a910_camera_init() == 0)
 		pxa_set_camera_info(&a910_pxacamera_platform_data);
 
+	gpiod_add_lookup_table(&camera_supply_gpiod_table);
 	pwm_add_table(ezx_pwm_lookup, ARRAY_SIZE(ezx_pwm_lookup));
 	platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
 	platform_add_devices(ARRAY_AND_SIZE(a910_devices));
-- 
2.17.0
