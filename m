From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:30:44 +0200
Subject: [PATCH 25/92] clocksource/drivers/clksrc-dbx500: Convert init
 function to return error
In-Reply-To: <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467109911-11060-25-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init functions do not return any error. They behave as the following:

  - panic, thus leading to a kernel crash while another timer may work and
       make the system boot up correctly

  or

  - print an error and let the caller unaware if the state of the system

Change that by converting the init functions to return an error conforming
to the CLOCKSOURCE_OF_RET prototype.

Proper error handling (rollback, errno value) will be changed later case
by case, thus this change just return back an error or success in the init
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/clksrc-dbx500-prcmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index dfad6eb..5a59d29 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -64,7 +64,7 @@ static u64 notrace dbx500_prcmu_sched_clock_read(void)
 
 #endif
 
-static void __init clksrc_dbx500_prcmu_init(struct device_node *node)
+static int __init clksrc_dbx500_prcmu_init(struct device_node *node)
 {
 	clksrc_dbx500_timer_base = of_iomap(node, 0);
 
@@ -84,7 +84,7 @@ static void __init clksrc_dbx500_prcmu_init(struct device_node *node)
 #ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
 	sched_clock_register(dbx500_prcmu_sched_clock_read, 32, RATE_32K);
 #endif
-	clocksource_register_hz(&clocksource_dbx500_prcmu, RATE_32K);
+	return clocksource_register_hz(&clocksource_dbx500_prcmu, RATE_32K);
 }
-CLOCKSOURCE_OF_DECLARE(dbx500_prcmu, "stericsson,db8500-prcmu-timer-4",
+CLOCKSOURCE_OF_DECLARE_RET(dbx500_prcmu, "stericsson,db8500-prcmu-timer-4",
 		       clksrc_dbx500_prcmu_init);
-- 
1.9.1
