From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:31:16 +0200
Subject: [PATCH 57/92] clocksource/drivers/stm32: Convert init function to
 return error
In-Reply-To: <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467109911-11060-57-git-send-email-daniel.lezcano@linaro.org>
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
Acked-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 drivers/clocksource/timer-stm32.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index f3dcb76..d5bf352 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -98,7 +98,7 @@ static struct stm32_clock_event_ddata clock_event_ddata = {
 	},
 };
 
-static void __init stm32_clockevent_init(struct device_node *np)
+static int __init stm32_clockevent_init(struct device_node *np)
 {
 	struct stm32_clock_event_ddata *data = &clock_event_ddata;
 	struct clk *clk;
@@ -130,12 +130,14 @@ static void __init stm32_clockevent_init(struct device_node *np)
 
 	data->base = of_iomap(np, 0);
 	if (!data->base) {
+		ret = -ENXIO;
 		pr_err("failed to map registers for clockevent\n");
 		goto err_iomap;
 	}
 
 	irq = irq_of_parse_and_map(np, 0);
 	if (!irq) {
+		ret = -EINVAL;
 		pr_err("%s: failed to get irq.\n", np->full_name);
 		goto err_get_irq;
 	}
@@ -173,7 +175,7 @@ static void __init stm32_clockevent_init(struct device_node *np)
 	pr_info("%s: STM32 clockevent driver initialized (%d bits)\n",
 			np->full_name, bits);
 
-	return;
+	return ret;
 
 err_get_irq:
 	iounmap(data->base);
@@ -182,7 +184,7 @@ err_iomap:
 err_clk_enable:
 	clk_put(clk);
 err_clk_get:
-	return;
+	return ret;
 }
 
-CLOCKSOURCE_OF_DECLARE(stm32, "st,stm32-timer", stm32_clockevent_init);
+CLOCKSOURCE_OF_DECLARE_RET(stm32, "st,stm32-timer", stm32_clockevent_init);
-- 
1.9.1
