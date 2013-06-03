From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Jun 2013 00:03:38 +0200
Subject: [PATCH] clocksource: armada-xp: always register local_timer_ops
Message-ID: <3039627.dHjlxm4JCV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The call to local_timer_register is hidden behind an #ifdef, which
turns the armada_370_xp_local_timer_ops into a potentially unused
variable, causing this warning:

time-armada-370-xp.c:208:31: warning: 'armada_370_xp_local_timer_ops' defined but not used [-Wunused-variable]
 static struct local_timer_ops armada_370_xp_local_timer_ops __cpuinitdata = {
                               ^

Since local_timer_register() itself doesn't do anything, just removing
the #ifdef makes the code look nicer and gets rid of the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
---

Please apply for 3.11

diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index 47a6730..4cd8520 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -294,8 +294,6 @@ void __init armada_370_xp_timer_init(void)
 				percpu_armada_370_xp_evt);
 	if (!res) {
 		enable_percpu_irq(armada_370_xp_clkevt.irq, 0);
-#ifdef CONFIG_LOCAL_TIMERS
 		local_timer_register(&armada_370_xp_local_timer_ops);
-#endif
 	}
 }
