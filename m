From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed,  1 Jun 2016 10:34:47 +0200
Subject: [PATCH 4/9] clocksource/drivers/mkt_timer: Convert init function to
 return error
In-Reply-To: <1464770093-12667-1-git-send-email-daniel.lezcano@linaro.org>
References: <1464770093-12667-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1464770093-12667-5-git-send-email-daniel.lezcano@linaro.org>
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
---
 drivers/clocksource/mtk_timer.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
index 7e583f8..432a2c0 100644
--- a/drivers/clocksource/mtk_timer.c
+++ b/drivers/clocksource/mtk_timer.c
@@ -181,7 +181,7 @@ static void mtk_timer_enable_irq(struct mtk_clock_event_device *evt, u8 timer)
 			evt->gpt_base + GPT_IRQ_EN_REG);
 }
 
-static void __init mtk_timer_init(struct device_node *node)
+static int __init mtk_timer_init(struct device_node *node)
 {
 	struct mtk_clock_event_device *evt;
 	struct resource res;
@@ -190,7 +190,7 @@ static void __init mtk_timer_init(struct device_node *node)
 
 	evt = kzalloc(sizeof(*evt), GFP_KERNEL);
 	if (!evt)
-		return;
+		return -ENOMEM;
 
 	evt->dev.name = "mtk_tick";
 	evt->dev.rating = 300;
@@ -248,7 +248,7 @@ static void __init mtk_timer_init(struct device_node *node)
 
 	mtk_timer_enable_irq(evt, GPT_CLK_EVT);
 
-	return;
+	return 0;
 
 err_clk_disable:
 	clk_disable_unprepare(clk);
@@ -262,5 +262,7 @@ err_mem:
 	release_mem_region(res.start, resource_size(&res));
 err_kzalloc:
 	kfree(evt);
+
+	return -EINVAL;
 }
-CLOCKSOURCE_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_timer_init);
+CLOCKSOURCE_OF_DECLARE_RET(mtk_mt6577, "mediatek,mt6577-timer", mtk_timer_init);
-- 
1.9.1
