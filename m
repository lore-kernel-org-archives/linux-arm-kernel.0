From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Tue, 21 Mar 2017 11:45:21 +0530
Subject: [PATCH 3/5] clk: qcom: gdsc: Add support to control associated clks
In-Reply-To: <1490076923-20194-1-git-send-email-rnayak@codeaurora.org>
References: <1490076923-20194-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1490076923-20194-4-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The devices within a gdsc power domain, quite often have additional
clocks to be turned on/off along with the power domain itself.
Add support for this by specifying a list of clk_hw pointers
per gdsc which would be the clocks turned on/off along with the
powerdomain on/off callbacks.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gdsc.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/clk/qcom/gdsc.h |  8 ++++++++
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index a4f3580..e9e7442 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -12,15 +12,19 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/ktime.h>
+#include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
+#include "common.h"
 #include "gdsc.h"
 
 #define PWR_ON_MASK		BIT(31)
@@ -166,6 +170,27 @@ static inline void gdsc_assert_clamp_io(struct gdsc *sc)
 			   GMEM_CLAMP_IO_MASK, 1);
 }
 
+static int gdsc_clk_enable(struct gdsc *sc)
+{
+	int i, ret;
+
+	for (i = 0; i < sc->clk_count; i++) {
+		ret = clk_prepare_enable(sc->clks[i]);
+		if (ret)
+			pr_err("Failed to enable clock: %s\n",
+			       __clk_get_name(sc->clks[i]));
+	}
+	return ret;
+}
+
+static void gdsc_clk_disable(struct gdsc *sc)
+{
+	int i;
+
+	for (i = 0; i < sc->clk_count; i++)
+		clk_disable_unprepare(sc->clks[i]);
+}
+
 static int gdsc_enable(struct generic_pm_domain *domain)
 {
 	struct gdsc *sc = domain_to_gdsc(domain);
@@ -193,6 +218,9 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 	 */
 	udelay(1);
 
+	if (sc->clk_count)
+		gdsc_clk_enable(sc);
+
 	/* Turn on HW trigger mode if supported */
 	if (sc->flags & HW_CTRL) {
 		ret = gdsc_hwctrl(sc, true);
@@ -241,6 +269,9 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 			return ret;
 	}
 
+	if (sc->clk_count)
+		gdsc_clk_disable(sc);
+
 	if (sc->pwrsts & PWRSTS_OFF)
 		gdsc_clear_mem_on(sc);
 
@@ -254,7 +285,7 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	return 0;
 }
 
-static int gdsc_init(struct gdsc *sc)
+static int gdsc_init(struct device *dev, struct gdsc *sc)
 {
 	u32 mask, val;
 	int on, ret;
@@ -284,6 +315,19 @@ static int gdsc_init(struct gdsc *sc)
 	if (on < 0)
 		return on;
 
+	if (sc->clk_count) {
+		int i;
+
+		sc->clks = devm_kcalloc(dev, sc->clk_count, sizeof(*sc->clks),
+					GFP_KERNEL);
+		if (!sc->clks)
+			return -ENOMEM;
+
+		for (i = 0; i < sc->clk_count; i++)
+			sc->clks[i] = devm_clk_hw_get_clk(dev, sc->clk_hws[i],
+							  NULL);
+	}
+
 	/*
 	 * Votable GDSCs can be ON due to Vote from other masters.
 	 * If a Votable GDSC is ON, make sure we have a Vote.
@@ -327,7 +371,7 @@ int gdsc_register(struct gdsc_desc *desc,
 			continue;
 		scs[i]->regmap = regmap;
 		scs[i]->rcdev = rcdev;
-		ret = gdsc_init(scs[i]);
+		ret = gdsc_init(dev, scs[i]);
 		if (ret)
 			return ret;
 		data->domains[i] = &scs[i]->pd;
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 3964834..a7fd51b 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -17,6 +17,8 @@
 #include <linux/err.h>
 #include <linux/pm_domain.h>
 
+struct clk;
+struct clk_hw;
 struct regmap;
 struct reset_controller_dev;
 
@@ -32,6 +34,9 @@
  * @resets: ids of resets associated with this gdsc
  * @reset_count: number of @resets
  * @rcdev: reset controller
+ * @clk_count: number of gdsc clocks
+ * @clks: clk pointers for gdsc clocks
+ * @clk_hws: clk_hw pointers for gdsc clocks
  */
 struct gdsc {
 	struct generic_pm_domain	pd;
@@ -56,6 +61,9 @@ struct gdsc {
 	struct reset_controller_dev	*rcdev;
 	unsigned int			*resets;
 	unsigned int			reset_count;
+	unsigned int			clk_count;
+	struct clk			**clks;
+	struct clk_hw			*clk_hws[];
 };
 
 struct gdsc_desc {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
