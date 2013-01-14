From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 14 Jan 2013 10:42:22 -0700
Subject: [PATCH] ARM: at91: fix board-rm9200-dt after sys_timer conversion
Message-ID: <1358185342-7518-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joachim Eastwood <manabian@gmail.com>

After "ARM: delete struct sys_timer" board-rm9200-dt
fails compilation with the following error:

  CC      arch/arm/mach-at91/board-rm9200-dt.o
arch/arm/mach-at91/board-rm9200-dt.c:50:2: error: unknown field 'timer' specified in initializer
arch/arm/mach-at91/board-rm9200-dt.c:50:13: error: 'at91rm9200_timer' undeclared here (not in a function)
make[1]: *** [arch/arm/mach-at91/board-rm9200-dt.o] Error 1
make: *** [arch/arm/mach-at91] Error 2

This is a fall out from the timer conversion. Fix it by
converting board-rm9200-dt to use new timer init
function as well.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Olof, Arnd, another fix for the timer-cleanup branch in arm-soc.

 arch/arm/mach-at91/board-rm9200-dt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/board-rm9200-dt.c b/arch/arm/mach-at91/board-rm9200-dt.c
index 5f9ce3d..3fcb662 100644
--- a/arch/arm/mach-at91/board-rm9200-dt.c
+++ b/arch/arm/mach-at91/board-rm9200-dt.c
@@ -47,7 +47,7 @@ static const char *at91rm9200_dt_board_compat[] __initdata = {
 };
 
 DT_MACHINE_START(at91rm9200_dt, "Atmel AT91RM9200 (Device Tree)")
-	.timer		= &at91rm9200_timer,
+	.init_time      = at91rm9200_timer_init,
 	.map_io		= at91_map_io,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= at91rm9200_dt_initialize,
-- 
1.7.10.4
