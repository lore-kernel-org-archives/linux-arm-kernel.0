From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 10 Jan 2018 08:16:07 -0800
Subject: [PATCH 1/2] soc: imx: gpcv2: Do not pass static memory as platform
 data
Message-ID: <20180110161608.13015-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platform device core assumes the ownership of dev.platform_data as
well as that it is dynamically allocated and it will try to kfree it
as a part of platform_device_release(). Change the code to pass
kzalloc'ed chunk of memory instead of a pointer to a static memory to
avoid causing a BUG() when calling platform_device_put().

The problem can be reproduced by artificially enabling the error path
of platform_device_add() call (around line 357).

Note that this change also allows us to constify imx7_pgc_domains,
since we no longer need to be able to modify it.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

This patch is a follow up to fix one of the bugs discussed in
lkml.kernel.org/r/3f836677c6e98aaf01bc1ac8c3410083 at agner.ch

 drivers/soc/imx/gpcv2.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index afc7ecc3c187..001b64afa5c1 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -18,6 +18,7 @@
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 #include <dt-bindings/power/imx7-power.h>
 
 #define GPC_LPCR_A7_BSC			0x000
@@ -155,7 +156,7 @@ static int imx7_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
 	return imx7_gpc_pu_pgc_sw_pxx_req(genpd, false);
 }
 
-static struct imx7_pgc_domain imx7_pgc_domains[] = {
+static const struct imx7_pgc_domain imx7_pgc_domains[] = {
 	[IMX7_POWER_DOMAIN_MIPI_PHY] = {
 		.genpd = {
 			.name      = "mipi-phy",
@@ -321,7 +322,14 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		domain = &imx7_pgc_domains[domain_index];
+		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+		if (!domain) {
+			of_node_put(np);
+			return -ENOMEM;
+		}
+		memcpy(domain, &imx7_pgc_domains[domain_index],
+		       sizeof(*domain));
+
 		domain->regmap = regmap;
 		domain->genpd.power_on  = imx7_gpc_pu_pgc_sw_pup_req;
 		domain->genpd.power_off = imx7_gpc_pu_pgc_sw_pdn_req;
@@ -330,6 +338,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 						domain_index);
 		if (!pd_pdev) {
 			dev_err(dev, "Failed to allocate platform device\n");
+			kfree(domain);
 			of_node_put(np);
 			return -ENOMEM;
 		}
-- 
2.14.3
