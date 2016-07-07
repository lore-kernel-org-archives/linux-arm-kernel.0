From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  7 Jul 2016 10:01:31 +0200
Subject: [PATCH 58/93] clocksource/drivers/sun5i: Convert init function to
 return error
In-Reply-To: <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
References: <577E0BED.3020608@linaro.org>
 <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467878526-1238-58-git-send-email-daniel.lezcano@linaro.org>
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
 drivers/clocksource/timer-sun5i.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 24c83f9..f0a3ffb 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -311,33 +311,42 @@ err_free:
 	return ret;
 }
 
-static void __init sun5i_timer_init(struct device_node *node)
+static int __init sun5i_timer_init(struct device_node *node)
 {
 	struct reset_control *rstc;
 	void __iomem *timer_base;
 	struct clk *clk;
-	int irq;
+	int irq, ret;
 
 	timer_base = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (IS_ERR(timer_base))
-		panic("Can't map registers");
+	if (IS_ERR(timer_base)) {
+		pr_err("Can't map registers");
+		return PTR_ERR(timer_base);;
+	}
 
 	irq = irq_of_parse_and_map(node, 0);
-	if (irq <= 0)
-		panic("Can't parse IRQ");
+	if (irq <= 0) {
+		pr_err("Can't parse IRQ");
+		return -EINVAL;
+	}
 
 	clk = of_clk_get(node, 0);
-	if (IS_ERR(clk))
-		panic("Can't get timer clock");
+	if (IS_ERR(clk)) {
+		pr_err("Can't get timer clock");
+		return PTR_ERR(clk);
+	}
 
 	rstc = of_reset_control_get(node, NULL);
 	if (!IS_ERR(rstc))
 		reset_control_deassert(rstc);
 
-	sun5i_setup_clocksource(node, timer_base, clk, irq);
-	sun5i_setup_clockevent(node, timer_base, clk, irq);
+	ret = sun5i_setup_clocksource(node, timer_base, clk, irq);
+	if (ret)
+		return ret;
+
+	return sun5i_setup_clockevent(node, timer_base, clk, irq);
 }
-CLOCKSOURCE_OF_DECLARE(sun5i_a13, "allwinner,sun5i-a13-hstimer",
-		       sun5i_timer_init);
-CLOCKSOURCE_OF_DECLARE(sun7i_a20, "allwinner,sun7i-a20-hstimer",
-		       sun5i_timer_init);
+CLOCKSOURCE_OF_DECLARE_RET(sun5i_a13, "allwinner,sun5i-a13-hstimer",
+			   sun5i_timer_init);
+CLOCKSOURCE_OF_DECLARE_RET(sun7i_a20, "allwinner,sun7i-a20-hstimer",
+			   sun5i_timer_init);
-- 
1.9.1
