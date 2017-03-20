From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Mon, 20 Mar 2017 14:15:42 +0800
Subject: [PATCH 3/8] soc: imx: gpc: fix domain_index sanity check issue
In-Reply-To: <1489990547-1510-1-git-send-email-aisheng.dong@nxp.com>
References: <1489990547-1510-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1489990547-1510-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARRAY_SIZE(imx_gpc_domains) represents all power domains supported
by different SoCs. Driver should use SoC specific of_id_data->num_domains
instead to do power domain index sanity check.
e.g. MX6Q supports two power domains while MX6SL supports three.

Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/soc/imx/gpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 7e6a672..ba6e7ab 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -413,7 +413,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 				of_node_put(np);
 				return ret;
 			}
-			if (domain_index >= ARRAY_SIZE(imx_gpc_domains))
+			if (domain_index >= of_id_data->num_domains)
 				continue;
 
 			domain = &imx_gpc_domains[domain_index];
-- 
2.7.4
