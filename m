From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 11 Mar 2018 20:19:42 -0300
Subject: [PATCH] soc: imx: gpc: Use kemdup() function
Message-ID: <1520810382-13341-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Use kmemdup() rather than duplicating its implementation.

Detected with Coccinelle script.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/soc/imx/gpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 196f17b..cc3bad8 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -444,12 +444,12 @@ static int imx_gpc_probe(struct platform_device *pdev)
 			if (domain_index >= of_id_data->num_domains)
 				continue;
 
-			domain = kmalloc(sizeof(*domain), GFP_KERNEL);
+			domain = kmemdup(&imx_gpc_domains[domain_index],
+					 sizeof(*domain), GFP_KERNEL);
 			if (!domain) {
 				of_node_put(np);
 				return -ENOMEM;
 			}
-			memcpy(domain, &imx_gpc_domains[domain_index], sizeof(*domain));
 			domain->regmap = regmap;
 			domain->ipg_rate_mhz = ipg_rate_mhz;
 
-- 
2.7.4
