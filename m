From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:30:41 +0200
Subject: [PATCH 22/92] clocksource/drivers/armv7m_systick: Convert init
 function to return error
In-Reply-To: <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467109911-11060-22-git-send-email-daniel.lezcano@linaro.org>
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
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 drivers/clocksource/armv7m_systick.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/armv7m_systick.c b/drivers/clocksource/armv7m_systick.c
index addfd2c..2b55410 100644
--- a/drivers/clocksource/armv7m_systick.c
+++ b/drivers/clocksource/armv7m_systick.c
@@ -21,7 +21,7 @@
 
 #define SYSTICK_LOAD_RELOAD_MASK 0x00FFFFFF
 
-static void __init system_timer_of_register(struct device_node *np)
+static int __init system_timer_of_register(struct device_node *np)
 {
 	struct clk *clk = NULL;
 	void __iomem *base;
@@ -31,22 +31,26 @@ static void __init system_timer_of_register(struct device_node *np)
 	base = of_iomap(np, 0);
 	if (!base) {
 		pr_warn("system-timer: invalid base address\n");
-		return;
+		return -ENXIO;
 	}
 
 	ret = of_property_read_u32(np, "clock-frequency", &rate);
 	if (ret) {
 		clk = of_clk_get(np, 0);
-		if (IS_ERR(clk))
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
 			goto out_unmap;
+		}
 
 		ret = clk_prepare_enable(clk);
 		if (ret)
 			goto out_clk_put;
 
 		rate = clk_get_rate(clk);
-		if (!rate)
+		if (!rate) {
+			ret = -EINVAL;
 			goto out_clk_disable;
+		}
 	}
 
 	writel_relaxed(SYSTICK_LOAD_RELOAD_MASK, base + SYST_RVR);
@@ -64,7 +68,7 @@ static void __init system_timer_of_register(struct device_node *np)
 
 	pr_info("ARM System timer initialized as clocksource\n");
 
-	return;
+	return 0;
 
 out_clk_disable:
 	clk_disable_unprepare(clk);
@@ -73,7 +77,9 @@ out_clk_put:
 out_unmap:
 	iounmap(base);
 	pr_warn("ARM System timer register failed (%d)\n", ret);
+
+	return ret;
 }
 
-CLOCKSOURCE_OF_DECLARE(arm_systick, "arm,armv7m-systick",
+CLOCKSOURCE_OF_DECLARE_RET(arm_systick, "arm,armv7m-systick",
 			system_timer_of_register);
-- 
1.9.1
