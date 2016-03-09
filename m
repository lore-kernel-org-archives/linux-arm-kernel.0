From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Thu, 10 Mar 2016 05:00:38 +0800
Subject: [PATCH v6 3/6] rockchip: power-domain: add support for sub-power
 domains
In-Reply-To: <1457557241-21297-1-git-send-email-zhangqing@rock-chips.com>
References: <1457557241-21297-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1457557241-21297-4-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for making one power domain a sub-domain of
other domain. This is useful for modeling power dependences,
which needs to have more than one power domain enabled to be operational.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/soc/rockchip/pm_domains.c | 64 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 0465a06..e4ae94f 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -370,6 +370,63 @@ static void rockchip_configure_pd_cnt(struct rockchip_pmu *pmu,
 	regmap_write(pmu->regmap, domain_reg_offset + 4, count);
 }
 
+static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
+				     struct device_node *parent)
+{
+	struct device_node *np;
+	struct generic_pm_domain *child_domain, *parent_domain;
+	int error;
+
+	for_each_child_of_node(parent, np) {
+		u32 idx = ~0;
+
+		if (of_property_read_u32(parent, "reg", &idx)) {
+			dev_err(pmu->dev,
+				"%s: failed to retrieve domain id (reg)\n",
+				parent->name);
+			goto err_out;
+		}
+		parent_domain = pmu->genpd_data.domains[idx];
+
+		error = rockchip_pm_add_one_domain(pmu, np);
+		if (error) {
+			dev_err(pmu->dev, "failed to handle node %s: %d\n",
+				np->name, error);
+			goto err_out;
+		}
+
+		if (of_property_read_u32(np, "reg", &idx)) {
+			dev_err(pmu->dev,
+				"%s: failed to retrieve domain id (reg)\n",
+				np->name);
+			goto err_out;
+		}
+		child_domain = pmu->genpd_data.domains[idx];
+
+		if (pm_genpd_add_subdomain(parent_domain, child_domain)) {
+			dev_err(pmu->dev, "%s failed to add subdomain: %s\n",
+				parent_domain->name, child_domain->name);
+			goto err_out;
+		} else {
+			dev_dbg(pmu->dev, "%s add subdomain: %s\n",
+				parent_domain->name, child_domain->name);
+		}
+
+		error = rockchip_pm_add_subdomain(pmu, np);
+		if (error < 0)
+			goto rm_sub_domain;
+	}
+	return 0;
+
+err_out:
+	of_node_put(parent);
+	of_node_put(np);
+	return -EINVAL;
+rm_sub_domain:
+	pm_genpd_remove_subdomain(parent_domain, child_domain);
+	return error;
+}
+
 static int rockchip_pm_domain_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -440,6 +497,13 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 			of_node_put(node);
 			goto err_out;
 		}
+
+		error = rockchip_pm_add_subdomain(pmu, node);
+		if (error < 0) {
+			dev_err(dev, "failed to handle subdomain node %s: %d\n",
+				node->name, error);
+			goto err_out;
+		}
 	}
 
 	if (error) {
-- 
1.9.1
