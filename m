From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 31 Jan 2014 15:18:16 +0100
Subject: [PATCH 07/10] watchdog: xilinx: Fix OF binding
In-Reply-To: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
Message-ID: <26d172891694e4041e73b7dae85a1848adf38034.1391177880.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use of_property_read_u32 functions to clean OF probing.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/watchdog/of_xilinx_wdt.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index c229cc4..475440a6 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -147,8 +147,7 @@ static u32 xwdt_selftest(struct xwdt_device *xdev)
 static int xwdt_probe(struct platform_device *pdev)
 {
 	int rc;
-	u32 *tmptr;
-	u32 *pfreq;
+	u32 pfreq, enable_once;
 	struct resource *res;
 	struct xwdt_device *xdev;
 	bool no_timeout = false;
@@ -168,28 +167,24 @@ static int xwdt_probe(struct platform_device *pdev)
 	if (IS_ERR(xdev->base))
 		return PTR_ERR(xdev->base);

-	pfreq = (u32 *)of_get_property(pdev->dev.of_node,
-					"clock-frequency", NULL);
-
-	if (pfreq == NULL) {
+	rc = of_property_read_u32(pdev->dev.of_node, "clock-frequency", &pfreq);
+	if (rc) {
 		dev_warn(&pdev->dev,
 			 "The watchdog clock frequency cannot be obtained\n");
 		no_timeout = true;
 	}

-	tmptr = (u32 *)of_get_property(pdev->dev.of_node,
-					"xlnx,wdt-interval", NULL);
-	if (tmptr == NULL) {
+	rc = of_property_read_u32(pdev->dev.of_node, "xlnx,wdt-interval",
+				  &xdev->wdt_interval);
+	if (rc) {
 		dev_warn(&pdev->dev,
 			 "Parameter \"xlnx,wdt-interval\" not found\n");
 		no_timeout = true;
-	} else {
-		xdev->wdt_interval = *tmptr;
 	}

-	tmptr = (u32 *)of_get_property(pdev->dev.of_node,
-					"xlnx,wdt-enable-once", NULL);
-	if (tmptr == NULL) {
+	rc = of_property_read_u32(pdev->dev.of_node, "xlnx,wdt-enable-once",
+				  &enable_once);
+	if (!rc && enable_once) {
 		dev_warn(&pdev->dev,
 			 "Parameter \"xlnx,wdt-enable-once\" not found\n");
 		watchdog_set_nowayout(xilinx_wdt_wdd, true);
@@ -201,7 +196,7 @@ static int xwdt_probe(struct platform_device *pdev)
  */
 	if (!no_timeout)
 		xilinx_wdt_wdd->timeout = 2 * ((1 << xdev->wdt_interval) /
-					  *pfreq);
+					  pfreq);

 	spin_lock_init(&xdev->spinlock);
 	watchdog_set_drvdata(xilinx_wdt_wdd, xdev);
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140131/c88189ee/attachment.sig>
