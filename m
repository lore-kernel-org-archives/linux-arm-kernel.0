From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 28 Mar 2016 13:10:25 +0200
Subject: [PATCH v6 3/6] rockchip: power-domain: add support for sub-power
 domains
In-Reply-To: <1457558578-22049-4-git-send-email-zhangqing@rock-chips.com>
References: <1457558578-22049-1-git-send-email-zhangqing@rock-chips.com>
 <1457558578-22049-4-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1669442.Kze2klao36@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 10. M?rz 2016, 05:22:55 schrieb Elaine Zhang:
> This patch adds support for making one power domain a sub-domain of
> other domain. This is useful for modeling power dependences,
> which needs to have more than one power domain enabled to be operational.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

applied to my armsoc/drivers branch for 4.7 [0] with some changes.

Please shout if things don't look right :-)

Apart from additional error outputs, I moved the of_put of parent in the
error case, as we shouldn't touch of_nodes we get as parameters. Instead
rockchip_pm_add_subdomain would already do that for subdomains and
rockchip_pm_domain_probe now also does it itself.

Also when rockchip_pm_add_subdomain for a sub-sub-domain fails
(in rockchip_pm_add_subdomain), we don't need to remove the parent
domain association, so I removed the return there.


Heiko

-------
diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 0181534..1fca9e5 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -380,10 +380,11 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 	for_each_child_of_node(parent, np) {
 		u32 idx;
 
-		if (of_property_read_u32(parent, "reg", &idx)) {
+		error = of_property_read_u32(parent, "reg", &idx);
+		if (error) {
 			dev_err(pmu->dev,
-				"%s: failed to retrieve domain id (reg)\n",
-				parent->name);
+				"%s: failed to retrieve domain id (reg): %d\n",
+				parent->name, error);
 			goto err_out;
 		}
 		parent_domain = pmu->genpd_data.domains[idx];
@@ -395,17 +396,19 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 			goto err_out;
 		}
 
-		if (of_property_read_u32(np, "reg", &idx)) {
+		error = of_property_read_u32(np, "reg", &idx);
+		if (error) {
 			dev_err(pmu->dev,
-				"%s: failed to retrieve domain id (reg)\n",
-				np->name);
+				"%s: failed to retrieve domain id (reg): %d\n",
+				np->name, error);
 			goto err_out;
 		}
 		child_domain = pmu->genpd_data.domains[idx];
 
-		if (pm_genpd_add_subdomain(parent_domain, child_domain)) {
-			dev_err(pmu->dev, "%s failed to add subdomain: %s\n",
-				parent_domain->name, child_domain->name);
+		error = pm_genpd_add_subdomain(parent_domain, child_domain);
+		if (error) {
+			dev_err(pmu->dev, "%s failed to add subdomain %s: %d\n",
+				parent_domain->name, child_domain->name, error);
 			goto err_out;
 		} else {
 			dev_dbg(pmu->dev, "%s add subdomain: %s\n",
@@ -414,16 +417,10 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 
-		error = rockchip_pm_add_subdomain(pmu, np);
-		if (error < 0)
-			goto rm_sub_domain;
+		rockchip_pm_add_subdomain(pmu, np);
 	}
 	return 0;
 
 err_out:
-	of_node_put(parent);
 	of_node_put(np);
-	return -EINVAL;
-rm_sub_domain:
-	pm_genpd_remove_subdomain(parent_domain, child_domain);
 	return error;
 }
 
@@ -498,6 +497,7 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 		if (error < 0) {
 			dev_err(dev, "failed to handle subdomain node %s: %d\n",
 				node->name, error);
+			of_node_put(node);
 			goto err_out;
 		}
 	}
-------


[0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v4.7-armsoc/drivers&id=6be05b5ec16132f3df3f1d857ab01e30f726b542
