From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon, 22 Jan 2018 07:07:48 -0800
Subject: [PATCH v2 2/2] soc: imx: gpc: Do not pass static memory as platform
 data
In-Reply-To: <20180122150748.1742-1-andrew.smirnov@gmail.com>
References: <20180122150748.1742-1-andrew.smirnov@gmail.com>
Message-ID: <20180122150748.1742-2-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platform device core assumes the ownership of dev.platform_data as
well as that it is dynamically allocated and it will try to kfree it
as a part of platform_device_release(). Change the code to pass
kzalloc'ed chunk of memory instead of a pointer to a static memory to
avoid causing a BUG() when calling platform_device_put().

The problem can be reproduced by artificially enabling the error path
of platform_device_add() call (around line 452).

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Changes since [v1]:

    - Replaced devm_kzalloc() with devm_kmalloc() as per suggestion from Stefan

[1] lkml.kernel.org/r/20180110161608.13015-2-andrew.smirnov at gmail.com


 drivers/soc/imx/gpc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 47e7aa963dbb..769aae647fed 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -18,6 +18,7 @@
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 
 #define GPC_CNTR		0x000
 
@@ -428,13 +429,19 @@ static int imx_gpc_probe(struct platform_device *pdev)
 			if (domain_index >= of_id_data->num_domains)
 				continue;
 
-			domain = &imx_gpc_domains[domain_index];
+			domain = kmalloc(sizeof(*domain), GFP_KERNEL);
+			if (!domain) {
+				of_node_put(np);
+				return -ENOMEM;
+			}
+			memcpy(domain, &imx_gpc_domains[domain_index], sizeof(*domain));
 			domain->regmap = regmap;
 			domain->ipg_rate_mhz = ipg_rate_mhz;
 
 			pd_pdev = platform_device_alloc("imx-pgc-power-domain",
 							domain_index);
 			if (!pd_pdev) {
+				kfree(domain);
 				of_node_put(np);
 				return -ENOMEM;
 			}
-- 
2.14.3
