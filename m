From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 31 Jan 2014 15:18:12 +0100
Subject: [PATCH 03/10] watchdog: xilinx: Simplify probe and remove functions
In-Reply-To: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
Message-ID: <578455fd630e70b5de8bae6091568f05e7769057.1391177880.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_ helper function to simplify probe and error path.
Move ioremap to the beginning of probe function.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/watchdog/of_xilinx_wdt.c | 41 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index aca9bab..7f371ed 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -12,6 +12,7 @@

 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -44,7 +45,6 @@
 #define PFX WATCHDOG_NAME ": "

 struct xwdt_device {
-	struct resource  res;
 	void __iomem *base;
 	u32 wdt_interval;
 };
@@ -159,9 +159,15 @@ static int xwdt_probe(struct platform_device *pdev)
 	int rc;
 	u32 *tmptr;
 	u32 *pfreq;
+	struct resource *res;

 	no_timeout = 0;

+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	xdev.base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(xdev.base))
+		return PTR_ERR(xdev.base);
+
 	pfreq = (u32 *)of_get_property(pdev->dev.of_node,
 					"clock-frequency", NULL);

@@ -170,12 +176,6 @@ static int xwdt_probe(struct platform_device *pdev)
 		no_timeout = 1;
 	}

-	rc = of_address_to_resource(pdev->dev.of_node, 0, &xdev.res);
-	if (rc) {
-		pr_warn("invalid address!\n");
-		return rc;
-	}
-
 	tmptr = (u32 *)of_get_property(pdev->dev.of_node,
 					"xlnx,wdt-interval", NULL);
 	if (tmptr == NULL) {
@@ -199,50 +199,27 @@ static int xwdt_probe(struct platform_device *pdev)
 	if (!no_timeout)
 		timeout = 2 * ((1<<xdev.wdt_interval) / *pfreq);

-	if (!request_mem_region(xdev.res.start,
-			xdev.res.end - xdev.res.start + 1, WATCHDOG_NAME)) {
-		rc = -ENXIO;
-		pr_err("memory request failure!\n");
-		goto err_out;
-	}
-
-	xdev.base = ioremap(xdev.res.start, xdev.res.end - xdev.res.start + 1);
-	if (xdev.base == NULL) {
-		rc = -ENOMEM;
-		pr_err("ioremap failure!\n");
-		goto release_mem;
-	}
-
 	rc = xwdt_selftest();
 	if (rc == XWT_TIMER_FAILED) {
 		pr_err("SelfTest routine error!\n");
-		goto unmap_io;
+		return rc;
 	}

 	rc = watchdog_register_device(&xilinx_wdt_wdd);
 	if (rc) {
 		pr_err("cannot register watchdog (err=%d)\n", rc);
-		goto unmap_io;
+		return rc;
 	}

 	dev_info(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds\n",
 		 xdev.base, timeout);

 	return 0;
-
-unmap_io:
-	iounmap(xdev.base);
-release_mem:
-	release_mem_region(xdev.res.start, resource_size(&xdev.res));
-err_out:
-	return rc;
 }

 static int xwdt_remove(struct platform_device *dev)
 {
 	watchdog_unregister_device(&xilinx_wdt_wdd);
-	iounmap(xdev.base);
-	release_mem_region(xdev.res.start, resource_size(&xdev.res));

 	return 0;
 }
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140131/50c6e59b/attachment-0001.sig>
