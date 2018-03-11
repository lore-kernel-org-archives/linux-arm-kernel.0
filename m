From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 11 Mar 2018 20:29:00 -0300
Subject: [PATCH] soc: imx: gpcv2: Use kemdup() function
Message-ID: <1520810940-13590-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Use kmemdup() rather than duplicating its implementation.

Detected with Coccinelle script.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 9947598..6d3c0f2 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -322,13 +322,12 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		domain = kmalloc(sizeof(*domain), GFP_KERNEL);
+		domain = kmemdup(&imx7_pgc_domains[domain_index],
+				 sizeof(*domain), GFP_KERNEL);
 		if (!domain) {
 			of_node_put(np);
 			return -ENOMEM;
 		}
-		memcpy(domain, &imx7_pgc_domains[domain_index],
-		       sizeof(*domain));
 
 		domain->regmap = regmap;
 		domain->genpd.power_on  = imx7_gpc_pu_pgc_sw_pup_req;
-- 
2.7.4
