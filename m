From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Mon, 13 Jan 2014 17:14:29 +0800
Subject: [PATCH 2/2] mmc: dw_mmc: k3: remove clk_table
In-Reply-To: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org>
References: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1389604469-8064-3-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove clk_table and directly use ios->clock as clock source rate.
Abstract init clock rate and max clock limitation in clk.c

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   14 -------
 drivers/mmc/host/dw_mmc-k3.c                       |   41 +-------------------
 2 files changed, 2 insertions(+), 53 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
index d7e2d7f159bb..b8653ea97957 100644
--- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
@@ -14,18 +14,6 @@ Required Properties:
 * compatible: should be one of the following.
   - "hisilicon,hi4511-dw-mshc": for controllers with hi4511 specific extentions.
 
-* clock-freq-table: should be the frequency (in Hz) array of the ciu clock
-	in each	supported mode.
-	0. CIU clock rate in Hz for DS mode
-	1. CIU clock rate in Hz for MMC HS mode
-	2. CIU clock rate in Hz for SD HS mode
-	3. CIU clock rate in Hz for SDR12 mode
-	4. CIU clock rate in Hz for SDR25 mode
-	5. CIU clock rate in Hz for SDR50 mode
-	6. CIU clock rate in Hz for SDR104 mode
-	7. CIU clock rate in Hz for DDR50 mode
-	8. CIU clock rate in Hz for HS200 mode
-
 Example:
 
 	/* for Hi3620 */
@@ -39,8 +27,6 @@ Example:
 		#size-cells = <0>;
 		clocks = <&mmc_clock HI3620_SD_CIUCLK>, <&clock HI3620_DDRC_PER_CLK>;
 		clock-names = "ciu", "biu";
-		clock-freq-table =
-		<25000000 0 50000000 25000000 50000000 100000000 0 50000000>;
 	};
 
 	/* Board portion */
diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 68e5e428e8f6..84e1a670f8c7 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -18,56 +18,19 @@
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
 
-#define MAX_NUMS	10
-struct dw_mci_k3_priv_data {
-	u32	clk_table[MAX_NUMS];
-};
-
 static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
-	struct dw_mci_k3_priv_data *priv = host->priv;
-	u32 rate = priv->clk_table[ios->timing];
 	int ret;
 
-	if (!rate) {
-		dev_warn(host->dev,
-			"no specified rate in timing %u\n", ios->timing);
-		return;
-	}
-
-	ret = clk_set_rate(host->ciu_clk, rate);
+	ret = clk_set_rate(host->ciu_clk, ios->clock);
 	if (ret)
-		dev_warn(host->dev, "failed to set clock rate %uHz\n", rate);
+		dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
 
 	host->bus_hz = clk_get_rate(host->ciu_clk);
 }
 
-static int dw_mci_k3_parse_dt(struct dw_mci *host)
-{
-	struct dw_mci_k3_priv_data *priv;
-	struct device_node *node = host->dev->of_node;
-	struct property *prop;
-	const __be32 *cur;
-	u32 val, num = 0;
-
-	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(host->dev, "mem alloc failed for private data\n");
-		return -ENOMEM;
-	}
-	host->priv = priv;
-
-	of_property_for_each_u32(node, "clock-freq-table", prop, cur, val) {
-		if (num >= MAX_NUMS)
-			break;
-		priv->clk_table[num++] = val;
-	}
-	return 0;
-}
-
 static const struct dw_mci_drv_data k3_drv_data = {
 	.set_ios		= dw_mci_k3_set_ios,
-	.parse_dt		= dw_mci_k3_parse_dt,
 };
 
 static const struct of_device_id dw_mci_k3_match[] = {
-- 
1.7.9.5
