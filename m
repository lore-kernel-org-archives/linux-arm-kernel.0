From: m.purski@samsung.com (Maciej Purski)
Date: Mon, 19 Feb 2018 16:44:06 +0100
Subject: [PATCH 8/8] [media] s5p-mfc: Use clk bulk API
In-Reply-To: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
References: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
 <CGME20180219154503eucas1p1c8893411994bd1152d0ce5b386118416@eucas1p1.samsung.com>
Message-ID: <1519055046-2399-9-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using bulk clk functions simplifies the driver's code. Use devm_clk_bulk
functions instead of iterating over an array of clks.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_common.h |  6 ++--
 drivers/media/platform/s5p-mfc/s5p_mfc_pm.c     | 41 +++++++++----------------
 2 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
index 76119a8..da3f0b3 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
@@ -192,9 +192,9 @@ struct s5p_mfc_buf {
  * struct s5p_mfc_pm - power management data structure
  */
 struct s5p_mfc_pm {
-	struct clk	*clock_gate;
-	const char * const *clk_names;
-	struct clk	*clocks[MFC_MAX_CLOCKS];
+	struct clk		*clock_gate;
+	const char * const	*clk_names;
+	struct clk_bulk_data	*clocks;
 	int		num_clocks;
 	bool		use_clock_gating;
 
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c b/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
index eb85ced..857f6ea 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
@@ -24,7 +24,7 @@ static atomic_t clk_ref;
 
 int s5p_mfc_init_pm(struct s5p_mfc_dev *dev)
 {
-	int i;
+	int ret;
 
 	pm = &dev->pm;
 	p_dev = dev;
@@ -35,17 +35,17 @@ int s5p_mfc_init_pm(struct s5p_mfc_dev *dev)
 	pm->clock_gate = NULL;
 
 	/* clock control */
-	for (i = 0; i < pm->num_clocks; i++) {
-		pm->clocks[i] = devm_clk_get(pm->device, pm->clk_names[i]);
-		if (IS_ERR(pm->clocks[i])) {
-			mfc_err("Failed to get clock: %s\n",
-				pm->clk_names[i]);
-			return PTR_ERR(pm->clocks[i]);
-		}
-	}
+	pm->clocks = devm_clk_bulk_alloc(pm->device, pm->num_clocks,
+					 pm->clk_names);
+	if (IS_ERR(pm->clocks))
+		return PTR_ERR(pm->clocks);
+
+	ret = devm_clk_bulk_get(pm->device, pm->num_clocks, pm->clocks);
+	if (ret < 0)
+		return ret;
 
 	if (dev->variant->use_clock_gating)
-		pm->clock_gate = pm->clocks[0];
+		pm->clock_gate = pm->clocks[0].clk;
 
 	pm_runtime_enable(pm->device);
 	atomic_set(&clk_ref, 0);
@@ -75,43 +75,32 @@ void s5p_mfc_clock_off(void)
 
 int s5p_mfc_power_on(void)
 {
-	int i, ret = 0;
+	int ret = 0;
 
 	ret = pm_runtime_get_sync(pm->device);
 	if (ret < 0)
 		return ret;
 
 	/* clock control */
-	for (i = 0; i < pm->num_clocks; i++) {
-		ret = clk_prepare_enable(pm->clocks[i]);
-		if (ret < 0) {
-			mfc_err("clock prepare failed for clock: %s\n",
-				pm->clk_names[i]);
-			i++;
-			goto err;
-		}
-	}
+	ret = clk_bulk_prepare_enable(pm->num_clocks, pm->clocks);
+	if (ret < 0)
+		goto err;
 
 	/* prepare for software clock gating */
 	clk_disable(pm->clock_gate);
 
 	return 0;
 err:
-	while (--i > 0)
-		clk_disable_unprepare(pm->clocks[i]);
 	pm_runtime_put(pm->device);
 	return ret;
 }
 
 int s5p_mfc_power_off(void)
 {
-	int i;
-
 	/* finish software clock gating */
 	clk_enable(pm->clock_gate);
 
-	for (i = 0; i < pm->num_clocks; i++)
-		clk_disable_unprepare(pm->clocks[i]);
+	clk_bulk_disable_unprepare(pm->num_clocks, pm->clocks);
 
 	return pm_runtime_put_sync(pm->device);
 }
-- 
2.7.4
