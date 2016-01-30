From: david.wu@rock-chips.com (David Wu)
Date: Sat, 30 Jan 2016 20:01:45 +0800
Subject: [PATCH] PM / AVS: rockchip-io: add GRF and PMUGRF types to distinguish
Message-ID: <1454155305-55516-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As rk3368 contained two separated iodomain areas, this was
determined to use which regmap base address.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 drivers/power/avs/rockchip-io-domain.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs/rockchip-io-domain.c
index 8099456..b17aeb7 100644
--- a/drivers/power/avs/rockchip-io-domain.c
+++ b/drivers/power/avs/rockchip-io-domain.c
@@ -47,6 +47,11 @@
 #define RK3368_SOC_CON15_FLASH0		BIT(14)
 #define RK3368_SOC_FLASH_SUPPLY_NUM	2
 
+enum rockchip_iodomain_grf_type {
+	GRF,
+	PMUGRF
+};
+
 struct rockchip_iodomain;
 
 /**
@@ -54,6 +59,7 @@ struct rockchip_iodomain;
  */
 struct rockchip_iodomain_soc_data {
 	int grf_offset;
+	enum rockchip_iodomain_grf_type type;
 	const char *supply_names[MAX_SUPPLIES];
 	void (*init)(struct rockchip_iodomain *iod);
 };
@@ -67,7 +73,7 @@ struct rockchip_iodomain_supply {
 
 struct rockchip_iodomain {
 	struct device *dev;
-	struct regmap *grf;
+	struct regmap *base;
 	struct rockchip_iodomain_soc_data *soc_data;
 	struct rockchip_iodomain_supply supplies[MAX_SUPPLIES];
 };
@@ -86,7 +92,7 @@ static int rockchip_iodomain_write(struct rockchip_iodomain_supply *supply,
 	/* apply hiword-mask */
 	val |= (BIT(supply->idx) << 16);
 
-	ret = regmap_write(iod->grf, iod->soc_data->grf_offset, val);
+	ret = regmap_write(iod->base, iod->soc_data->grf_offset, val);
 	if (ret)
 		dev_err(iod->dev, "Couldn't write to GRF\n");
 
@@ -157,7 +163,7 @@ static void rk3288_iodomain_init(struct rockchip_iodomain *iod)
 	 * instead of a special gpio.
 	 */
 	val = RK3288_SOC_CON2_FLASH0 | (RK3288_SOC_CON2_FLASH0 << 16);
-	ret = regmap_write(iod->grf, RK3288_SOC_CON2, val);
+	ret = regmap_write(iod->base, RK3288_SOC_CON2, val);
 	if (ret < 0)
 		dev_warn(iod->dev, "couldn't update flash0 ctrl\n");
 }
@@ -176,7 +182,7 @@ static void rk3368_iodomain_init(struct rockchip_iodomain *iod)
 	 * instead of a special gpio.
 	 */
 	val = RK3368_SOC_CON15_FLASH0 | (RK3368_SOC_CON15_FLASH0 << 16);
-	ret = regmap_write(iod->grf, RK3368_SOC_CON15, val);
+	ret = regmap_write(iod->base, RK3368_SOC_CON15, val);
 	if (ret < 0)
 		dev_warn(iod->dev, "couldn't update flash0 ctrl\n");
 }
@@ -187,6 +193,7 @@ static void rk3368_iodomain_init(struct rockchip_iodomain *iod)
  */
 static const struct rockchip_iodomain_soc_data soc_data_rk3188 = {
 	.grf_offset = 0x104,
+	.type = GRF,
 	.supply_names = {
 		NULL,
 		NULL,
@@ -209,6 +216,7 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3188 = {
 
 static const struct rockchip_iodomain_soc_data soc_data_rk3288 = {
 	.grf_offset = 0x380,
+	.type = GRF,
 	.supply_names = {
 		"lcdc",		/* LCDC_VDD */
 		"dvp",		/* DVPIO_VDD */
@@ -226,6 +234,7 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3288 = {
 
 static const struct rockchip_iodomain_soc_data soc_data_rk3368 = {
 	.grf_offset = 0x900,
+	.type = GRF,
 	.supply_names = {
 		NULL,		/* reserved */
 		"dvp",		/* DVPIO_VDD */
@@ -242,6 +251,7 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3368 = {
 
 static const struct rockchip_iodomain_soc_data soc_data_rk3368_pmu = {
 	.grf_offset = 0x100,
+	.type = PMUGRF,
 	.supply_names = {
 		NULL,
 		NULL,
@@ -293,10 +303,16 @@ static int rockchip_iodomain_probe(struct platform_device *pdev)
 	match = of_match_node(rockchip_iodomain_match, np);
 	iod->soc_data = (struct rockchip_iodomain_soc_data *)match->data;
 
-	iod->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
-	if (IS_ERR(iod->grf)) {
-		dev_err(&pdev->dev, "couldn't find grf regmap\n");
-		return PTR_ERR(iod->grf);
+	if (iod->soc_data->type == PMUGRF)
+		iod->base = syscon_regmap_lookup_by_phandle(
+				np, "rockchip,pmugrf");
+	else
+		iod->base = syscon_regmap_lookup_by_phandle(
+				np, "rockchip,grf");
+	if (IS_ERR(iod->base)) {
+		dev_err(&pdev->dev, "couldn't find %s regmap\n",
+			(iod->soc_data->type == PMUGRF) ? "pmugrf" : "grf");
+		return PTR_ERR(iod->base);
 	}
 
 	for (i = 0; i < MAX_SUPPLIES; i++) {
-- 
1.9.1
