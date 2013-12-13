From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 13 Dec 2013 20:59:39 +0100
Subject: [PATCH CRITICAL] ARM: s3c64xx: dt: Fix boot failure due to double
 clock initialization
Message-ID: <1386964779-29457-1-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit

4178bac ARM: call of_clk_init from default time_init handler

added implicit call to of_clk_init() from default time_init callback,
but it did not change platforms calling it from other callbacks, despite
of not having custom time_init callbacks. This caused double clock
initialization on such platforms, leading to boot failures. An example
of such platform is mach-s3c64xx.

This patch fixes boot failure on s3c64xx by dropping custom init_irq
callback, which had a call to of_clk_init() and moving system reset
initialization to init_machine callback. This allows us to have
clocks initialized properly without a need to have custom init_time or
init_irq callbacks.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

NOTE: This is a critical boot regression fix for mach-s3c64xx that
should be merged for next 3.13-rc release.

diff --git a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
index 7eb9a10..2fddf38 100644
--- a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
+++ b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
@@ -8,8 +8,6 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/clk-provider.h>
-#include <linux/irqchip.h>
 #include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
@@ -48,15 +46,9 @@ static void __init s3c64xx_dt_map_io(void)
 		panic("SoC is not S3C64xx!");
 }
 
-static void __init s3c64xx_dt_init_irq(void)
-{
-	of_clk_init(NULL);
-	samsung_wdt_reset_of_init();
-	irqchip_init();
-};
-
 static void __init s3c64xx_dt_init_machine(void)
 {
+	samsung_wdt_reset_of_init();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
@@ -79,7 +71,6 @@ DT_MACHINE_START(S3C6400_DT, "Samsung S3C64xx (Flattened Device Tree)")
 	/* Maintainer: Tomasz Figa <tomasz.figa@gmail.com> */
 	.dt_compat	= s3c64xx_dt_compat,
 	.map_io		= s3c64xx_dt_map_io,
-	.init_irq	= s3c64xx_dt_init_irq,
 	.init_machine	= s3c64xx_dt_init_machine,
 	.restart        = s3c64xx_dt_restart,
 MACHINE_END
-- 
1.8.5.1
