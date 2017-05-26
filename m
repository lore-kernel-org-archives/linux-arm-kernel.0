From: s-anna@ti.com (Suman Anna)
Date: Fri, 26 May 2017 15:21:37 -0500
Subject: [PATCH 1/4] remoteproc/davinci: Switch to
 platform_get_resource_byname()
In-Reply-To: <20170526202140.10472-1-s-anna@ti.com>
References: <20170526202140.10472-1-s-anna@ti.com>
Message-ID: <20170526202140.10472-2-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The davinci remoteproc driver currently uses the platform_get_resource()
API for retrieving the IOMEM resources. Switch this function to use the
platform_get_resource_byname() API instead in preparation for adding the
DT support so that the binding can be agnostic of the IOMEM resource
order.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index c7ad818f7a48..0919176b52c1 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -195,12 +195,14 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	bootreg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	bootreg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "host1cfg");
 	bootreg = devm_ioremap_resource(dev, bootreg_res);
 	if (IS_ERR(bootreg))
 		return PTR_ERR(bootreg);
 
-	chipsig_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	chipsig_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "chipsig");
 	chipsig = devm_ioremap_resource(dev, chipsig_res);
 	if (IS_ERR(chipsig))
 		return PTR_ERR(chipsig);
-- 
2.12.0
