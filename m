From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 11 Feb 2014 07:55:50 +0100
Subject: [PATCH v2 07/11] watchdog: xilinx: Use of_property_read_u32
In-Reply-To: <f298edd222c57b0ce1ebad3ae50c3f715406c631.1392101734.git.michal.simek@xilinx.com>
References: <f298edd222c57b0ce1ebad3ae50c3f715406c631.1392101734.git.michal.simek@xilinx.com>
Message-ID: <7aa6e41032ebad0ffb2e1df20beb4f00e38d29e2.1392101734.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use of_property_read_u32 functions to clean probe function.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Fix enable_once logic
- Change patch subject

 drivers/watchdog/of_xilinx_wdt.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index c229cc4..bb03e5b 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -147,8 +147,7 @@ static u32 xwdt_selftest(struct xwdt_device *xdev)
 static int xwdt_probe(struct platform_device *pdev)
 {
 	int rc;
-	u32 *tmptr;
-	u32 *pfreq;
+	u32 pfreq, enable_once = 0;
 	struct resource *res;
 	struct xwdt_device *xdev;
 	bool no_timeout = false;
@@ -168,32 +167,29 @@ static int xwdt_probe(struct platform_device *pdev)
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
+	if (rc)
 		dev_warn(&pdev->dev,
 			 "Parameter \"xlnx,wdt-enable-once\" not found\n");
+
+	if (enable_once)
 		watchdog_set_nowayout(xilinx_wdt_wdd, true);
-	}

 /*
  *  Twice of the 2^wdt_interval / freq  because the first wdt overflow is
@@ -201,7 +197,7 @@ static int xwdt_probe(struct platform_device *pdev)
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140211/88c5386c/attachment-0001.sig>
