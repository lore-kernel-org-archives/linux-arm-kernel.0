From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 May 2018 23:24:58 +0200
Subject: [PATCH] ARM: pxa, regulator: fix building ezx e680
Message-ID: <20180530212514.346474-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reference to camera_supply_gpiod_table was added in the wrong function,
as observed from this randconfig build failure:

arch/arm/mach-pxa/ezx.c: In function 'e680_init':
arch/arm/mach-pxa/ezx.c:905:26: error: 'camera_supply_gpiod_table' undeclared (first use in this function)
  gpiod_add_lookup_table(&camera_supply_gpiod_table);

Fixes: 6059577cb28d ("regulator: fixed: Convert to use GPIO descriptor only")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
2.9.0
