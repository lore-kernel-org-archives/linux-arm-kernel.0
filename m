From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Thu, 14 Apr 2016 14:20:20 +0800
Subject: [PATCH v2 2/2] rockchip: power-domain: support qos save and restore
In-Reply-To: <1460614820-18865-1-git-send-email-zhangqing@rock-chips.com>
References: <1460614820-18865-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1460614820-18865-3-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

support qos save and restore when power domain on/off.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/soc/rockchip/pm_domains.c | 104 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index ac729fe42cc9..58218143da54 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -46,10 +46,20 @@ struct rockchip_pmu_info {
 	const struct rockchip_domain_info *domain_info;
 };
 
+#define MAX_QOS_REGS_NUM	5
+#define QOS_PRIORITY		0x08
+#define QOS_MODE		0x0c
+#define QOS_BANDWIDTH		0x10
+#define QOS_SATURATION		0x14
+#define QOS_EXTCONTROL		0x18
+
 struct rockchip_pm_domain {
 	struct generic_pm_domain genpd;
 	const struct rockchip_domain_info *info;
 	struct rockchip_pmu *pmu;
+	int num_qos;
+	struct regmap **qos_regmap;
+	u32 *qos_save_regs[MAX_QOS_REGS_NUM];
 	int num_clks;
 	struct clk *clks[];
 };
@@ -118,6 +128,55 @@ static int rockchip_pmu_set_idle_request(struct rockchip_pm_domain *pd,
 	return 0;
 }
 
+static int rockchip_pmu_save_qos(struct rockchip_pm_domain *pd)
+{
+	int i;
+
+	for (i = 0; i < pd->num_qos; i++) {
+		regmap_read(pd->qos_regmap[i],
+			    QOS_PRIORITY,
+			    &pd->qos_save_regs[0][i]);
+		regmap_read(pd->qos_regmap[i],
+			    QOS_MODE,
+			    &pd->qos_save_regs[1][i]);
+		regmap_read(pd->qos_regmap[i],
+			    QOS_BANDWIDTH,
+			    &pd->qos_save_regs[2][i]);
+		regmap_read(pd->qos_regmap[i],
+			    QOS_SATURATION,
+			    &pd->qos_save_regs[3][i]);
+		regmap_read(pd->qos_regmap[i],
+			    QOS_EXTCONTROL,
+			    &pd->qos_save_regs[4][i]);
+	}
+	return 0;
+}
+
+static int rockchip_pmu_restore_qos(struct rockchip_pm_domain *pd)
+{
+	int i;
+
+	for (i = 0; i < pd->num_qos; i++) {
+		regmap_write(pd->qos_regmap[i],
+			     QOS_PRIORITY,
+			     pd->qos_save_regs[0][i]);
+		regmap_write(pd->qos_regmap[i],
+			     QOS_MODE,
+			     pd->qos_save_regs[1][i]);
+		regmap_write(pd->qos_regmap[i],
+			     QOS_BANDWIDTH,
+			     pd->qos_save_regs[2][i]);
+		regmap_write(pd->qos_regmap[i],
+			     QOS_SATURATION,
+			     pd->qos_save_regs[3][i]);
+		regmap_write(pd->qos_regmap[i],
+			     QOS_EXTCONTROL,
+			     pd->qos_save_regs[4][i]);
+	}
+
+	return 0;
+}
+
 static bool rockchip_pmu_domain_is_on(struct rockchip_pm_domain *pd)
 {
 	struct rockchip_pmu *pmu = pd->pmu;
@@ -161,7 +220,7 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 			clk_enable(pd->clks[i]);
 
 		if (!power_on) {
-			/* FIXME: add code to save AXI_QOS */
+			rockchip_pmu_save_qos(pd);
 
 			/* if powering down, idle request to NIU first */
 			rockchip_pmu_set_idle_request(pd, true);
@@ -173,7 +232,7 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 			/* if powering up, leave idle mode */
 			rockchip_pmu_set_idle_request(pd, false);
 
-			/* FIXME: add code to restore AXI_QOS */
+			rockchip_pmu_restore_qos(pd);
 		}
 
 		for (i = pd->num_clks - 1; i >= 0; i--)
@@ -241,9 +300,10 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 {
 	const struct rockchip_domain_info *pd_info;
 	struct rockchip_pm_domain *pd;
+	struct device_node *qos_node;
 	struct clk *clk;
 	int clk_cnt;
-	int i;
+	int i, j;
 	u32 id;
 	int error;
 
@@ -303,6 +363,44 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 			clk, node->name);
 	}
 
+	pd->num_qos = of_count_phandle_with_args(node, "pm_qos",
+						 NULL);
+
+	if (pd->num_qos < 0) {
+		dev_err(pmu->dev,
+			"the qos node num is error qos_num = %d\n",
+			pd->num_qos);
+		error = pd->num_qos;
+		goto err_out;
+	}
+
+	pd->qos_regmap = devm_kcalloc(pmu->dev, pd->num_qos,
+				      sizeof(*pd->qos_regmap), GFP_KERNEL);
+	if (!pd->qos_regmap)
+		return -ENOMEM;
+
+	for (j = 0; j < MAX_QOS_REGS_NUM; j++) {
+		pd->qos_save_regs[j] = devm_kcalloc(pmu->dev, pd->num_qos,
+						    sizeof(u32), GFP_KERNEL);
+		if (!pd->qos_save_regs[j])
+			return -ENOMEM;
+	}
+
+	for (j = 0; j < pd->num_qos; j++) {
+		qos_node = of_parse_phandle(node, "pm_qos", j);
+		if (!qos_node) {
+			error = -ENODEV;
+			goto err_out;
+		}
+		pd->qos_regmap[j] = syscon_node_to_regmap(qos_node);
+		if (IS_ERR(pd->qos_regmap[j])) {
+			error = -ENODEV;
+			of_node_put(qos_node);
+			goto err_out;
+		}
+		of_node_put(qos_node);
+	}
+
 	error = rockchip_pd_power(pd, true);
 	if (error) {
 		dev_err(pmu->dev,
-- 
1.9.1
