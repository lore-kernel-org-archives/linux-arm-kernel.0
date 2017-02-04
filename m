From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Sat, 4 Feb 2017 22:03:55 +0100
Subject: [PATCH 1/2] clk: scpi: RfC - Allow to ignore invalid SCPI DVFS clock
 rates
In-Reply-To: <3b60654a-88b6-6262-396e-a058ade1c586@gmail.com>
References: <3b60654a-88b6-6262-396e-a058ade1c586@gmail.com>
Message-ID: <d7b8f9db-7512-646c-bb96-ef74e7266661@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce an optional property "clock-max-frequency" for SCPI DVFS
clocks. All frequencies for the respective clock exceeding this
threshold will be ignored.

This is useful on systems where the firmware offers too optimistic
clock rates causing instabilities and crashes.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 Documentation/devicetree/bindings/arm/arm,scpi.txt |  7 +++++++
 drivers/clk/clk-scpi.c                             | 15 ++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
index 40183197..7582dd2e 100644
--- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
@@ -56,6 +56,13 @@ Other required properties for all clocks(all from common clock binding):
 	node. It can be non linear and hence provide the mapping of identifiers
 	into the clock-output-names array.
 
+For DVFS SCPI clocks a further optional property is supported to deal with
+SCPI DVFS clocks where some firmware-provided clocks rates are too optimistic
+and cause stability issues.
+
+- clock-max-frequency : Ignore all firmware-provided frequencies above this
+			threshold. Value 0 means no threshold.
+
 SRAM and Shared Memory for SCPI
 -------------------------------
 
diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
index 96d37175..fc99bb6e 100644
--- a/drivers/clk/clk-scpi.c
+++ b/drivers/clk/clk-scpi.c
@@ -27,6 +27,7 @@
 
 struct scpi_clk {
 	u32 id;
+	u32 max_freq;
 	struct clk_hw hw;
 	struct scpi_dvfs_info *info;
 	struct scpi_ops *scpi_ops;
@@ -36,6 +37,11 @@ struct scpi_clk {
 
 static struct platform_device *cpufreq_dev;
 
+static inline bool invalid_freq(struct scpi_clk *clk, u32 freq)
+{
+	return clk->max_freq && freq > clk->max_freq;
+}
+
 static unsigned long scpi_clk_recalc_rate(struct clk_hw *hw,
 					  unsigned long parent_rate)
 {
@@ -79,6 +85,8 @@ static int __scpi_dvfs_round_rate(struct scpi_clk *clk, unsigned long rate)
 
 	for (idx = 0; idx < clk->info->count; idx++, opp++) {
 		ftmp = opp->freq;
+		if (invalid_freq(clk, ftmp))
+			continue;
 		if (ftmp >= (u32)rate) {
 			if (ftmp <= fmax)
 				fmax = ftmp;
@@ -118,7 +126,7 @@ static int __scpi_find_dvfs_index(struct scpi_clk *clk, unsigned long rate)
 	const struct scpi_opp *opp = clk->info->opps;
 
 	for (idx = 0; idx < max_opp; idx++, opp++)
-		if (opp->freq == rate)
+		if (opp->freq == rate && !invalid_freq(clk, opp->freq))
 			return idx;
 	return -EINVAL;
 }
@@ -165,6 +173,7 @@ scpi_clk_ops_init(struct device *dev, const struct of_device_id *match,
 		sclk->info = sclk->scpi_ops->dvfs_get_info(sclk->id);
 		if (IS_ERR(sclk->info))
 			return PTR_ERR(sclk->info);
+		max = sclk->max_freq;
 	} else if (init.ops == &scpi_clk_ops) {
 		if (sclk->scpi_ops->clk_get_range(sclk->id, &min, &max) || !max)
 			return -EINVAL;
@@ -244,6 +253,10 @@ static int scpi_clk_add(struct device *dev, struct device_node *np,
 
 		sclk->id = val;
 
+		if (match->data == &scpi_dvfs_ops)
+			of_property_read_u32_index(np, "clock-max-frequency",
+						   idx, &sclk->max_freq);
+
 		err = scpi_clk_ops_init(dev, match, sclk, name);
 		if (err)
 			dev_err(dev, "failed to register clock '%s'\n", name);
-- 
2.11.0
