From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed,  1 Jun 2016 10:34:51 +0200
Subject: [PATCH 8/9] clocksource/drivers/st_lpc: Convert init function to
 return error
In-Reply-To: <1464770093-12667-1-git-send-email-daniel.lezcano@linaro.org>
References: <1464770093-12667-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1464770093-12667-9-git-send-email-daniel.lezcano@linaro.org>
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
 drivers/clocksource/clksrc_st_lpc.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/clksrc_st_lpc.c b/drivers/clocksource/clksrc_st_lpc.c
index 65ec467..c9022a9 100644
--- a/drivers/clocksource/clksrc_st_lpc.c
+++ b/drivers/clocksource/clksrc_st_lpc.c
@@ -92,7 +92,7 @@ static int __init st_clksrc_setup_clk(struct device_node *np)
 	return 0;
 }
 
-static void __init st_clksrc_of_register(struct device_node *np)
+static int __init st_clksrc_of_register(struct device_node *np)
 {
 	int ret;
 	uint32_t mode;
@@ -100,32 +100,36 @@ static void __init st_clksrc_of_register(struct device_node *np)
 	ret = of_property_read_u32(np, "st,lpc-mode", &mode);
 	if (ret) {
 		pr_err("clksrc-st-lpc: An LPC mode must be provided\n");
-		return;
+		return ret;
 	}
 
 	/* LPC can either run as a Clocksource or in RTC or WDT mode */
 	if (mode != ST_LPC_MODE_CLKSRC)
-		return;
+		return 0;
 
 	ddata.base = of_iomap(np, 0);
 	if (!ddata.base) {
 		pr_err("clksrc-st-lpc: Unable to map iomem\n");
-		return;
+		return -ENXIO;
 	}
 
-	if (st_clksrc_setup_clk(np)) {
+	ret = st_clksrc_setup_clk(np);
+	if (ret) {
 		iounmap(ddata.base);
-		return;
+		return ret;
 	}
 
-	if (st_clksrc_init()) {
+	ret = st_clksrc_init();
+	if (ret) {
 		clk_disable_unprepare(ddata.clk);
 		clk_put(ddata.clk);
 		iounmap(ddata.base);
-		return;
+		return ret;
 	}
 
 	pr_info("clksrc-st-lpc: clocksource initialised - running @ %luHz\n",
 		clk_get_rate(ddata.clk));
+
+	return ret;
 }
-CLOCKSOURCE_OF_DECLARE(ddata, "st,stih407-lpc", st_clksrc_of_register);
+CLOCKSOURCE_OF_DECLARE_RET(ddata, "st,stih407-lpc", st_clksrc_of_register);
-- 
1.9.1
