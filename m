From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri, 18 Mar 2016 15:17:24 +0800
Subject: [PATCH v1 2/2] rockchip: power-domain: support qos save and restore
In-Reply-To: <1458285444-31129-1-git-send-email-zhangqing@rock-chips.com>
References: <1458285444-31129-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1458285444-31129-3-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

support qos save and restore when power domain on/off.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/soc/rockchip/pm_domains.c | 87 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 18aee6b..c5f4be6 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -45,10 +45,21 @@ struct rockchip_pmu_info {
 	const struct rockchip_domain_info *domain_info;
 };
 
+#define MAX_QOS_NODE_NUM	20
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
+	struct regmap *qos_regmap[MAX_QOS_NODE_NUM];
+	u32 qos_save_regs[MAX_QOS_NODE_NUM][MAX_QOS_REGS_NUM];
 	int num_clks;
 	struct clk *clks[];
 };
@@ -111,6 +122,55 @@ static int rockchip_pmu_set_idle_request(struct rockchip_pm_domain *pd,
 	return 0;
 }
 
+static int rockchip_pmu_save_qos(struct rockchip_pm_domain *pd)
+{
+	int i;
+
+	for (i = 0; i < pd->num_qos; i++) {
+		regmap_read(pd->qos_regmap[i],
+			    QOS_PRIORITY,
+			    &pd->qos_save_regs[i][0]);
+		regmap_read(pd->qos_regmap[i],
+			    QOS_MODE,
+			    &pd->qos_save_regs[i][1]);
+		regmap_read(pd->qos_regmap[i],
+			    QOS_BANDWIDTH,
+			    &pd->qos_save_regs[i][2]);
+		regmap_read(pd->qos_regmap[i],
+			    QOS_SATURATION,
+			    &pd->qos_save_regs[i][3]);
+		regmap_read(pd->qos_regmap[i],
+			    QOS_EXTCONTROL,
+			    &pd->qos_save_regs[i][4]);
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
+			     pd->qos_save_regs[i][0]);
+		regmap_write(pd->qos_regmap[i],
+			     QOS_MODE,
+			     pd->qos_save_regs[i][1]);
+		regmap_write(pd->qos_regmap[i],
+			     QOS_BANDWIDTH,
+			     pd->qos_save_regs[i][2]);
+		regmap_write(pd->qos_regmap[i],
+			     QOS_SATURATION,
+			     pd->qos_save_regs[i][3]);
+		regmap_write(pd->qos_regmap[i],
+			     QOS_EXTCONTROL,
+			     pd->qos_save_regs[i][4]);
+	}
+
+	return 0;
+}
+
 static bool rockchip_pmu_domain_is_on(struct rockchip_pm_domain *pd)
 {
 	struct rockchip_pmu *pmu = pd->pmu;
@@ -147,7 +207,7 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 			clk_enable(pd->clks[i]);
 
 		if (!power_on) {
-			/* FIXME: add code to save AXI_QOS */
+			rockchip_pmu_save_qos(pd);
 
 			/* if powering down, idle request to NIU first */
 			rockchip_pmu_set_idle_request(pd, true);
@@ -159,7 +219,7 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 			/* if powering up, leave idle mode */
 			rockchip_pmu_set_idle_request(pd, false);
 
-			/* FIXME: add code to restore AXI_QOS */
+			rockchip_pmu_restore_qos(pd);
 		}
 
 		for (i = pd->num_clks - 1; i >= 0; i--)
@@ -227,9 +287,10 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
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
 
@@ -289,6 +350,26 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 			clk, node->name);
 	}
 
+	pd->num_qos = of_count_phandle_with_args(node, "pm_qos",
+						 NULL);
+	if (pd->num_qos > MAX_QOS_NODE_NUM) {
+		dev_err(pmu->dev,
+			"the qos node num is overflow qos_num = %d\n",
+			pd->num_qos);
+		error = -EINVAL;
+		goto err_out;
+	}
+
+	for (j = 0; j < pd->num_qos; j++) {
+		qos_node = of_parse_phandle(node, "pm_qos", j);
+		if (!qos_node) {
+			error = -ENODEV;
+			goto err_out;
+		}
+		pd->qos_regmap[j] = syscon_node_to_regmap(qos_node);
+		of_node_put(qos_node);
+	}
+
 	error = rockchip_pd_power(pd, true);
 	if (error) {
 		dev_err(pmu->dev,
-- 
1.9.1
