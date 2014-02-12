From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 12 Feb 2014 14:41:25 +0100
Subject: [PATCH v3 11/11] watchdog: xilinx: Remove no_timeout variable
In-Reply-To: <bdd7c2c78dd491d02d1c1ae8a59b92b7a1a17ec6.1392212059.git.michal.simek@xilinx.com>
References: <bdd7c2c78dd491d02d1c1ae8a59b92b7a1a17ec6.1392212059.git.michal.simek@xilinx.com>
Message-ID: <e0612677b5e59221ff4d91da27f261f2b7bbea66.1392212059.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove no_timeout variable and check variables
directly.

Suggested-by: Rob Herring <robherring2@gmail.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

Changes in v3: None
Changes in v2:
- New patch in this series

 drivers/watchdog/of_xilinx_wdt.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 9dd16cf..c7fb85e 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -147,10 +147,9 @@ static u32 xwdt_selftest(struct xwdt_device *xdev)
 static int xwdt_probe(struct platform_device *pdev)
 {
 	int rc;
-	u32 pfreq, enable_once = 0;
+	u32 pfreq = 0, enable_once = 0;
 	struct resource *res;
 	struct xwdt_device *xdev;
-	bool no_timeout = false;
 	struct watchdog_device *xilinx_wdt_wdd;

 	xdev = devm_kzalloc(&pdev->dev, sizeof(*xdev), GFP_KERNEL);
@@ -168,19 +167,15 @@ static int xwdt_probe(struct platform_device *pdev)
 		return PTR_ERR(xdev->base);

 	rc = of_property_read_u32(pdev->dev.of_node, "clock-frequency", &pfreq);
-	if (rc) {
+	if (rc)
 		dev_warn(&pdev->dev,
 			 "The watchdog clock frequency cannot be obtained\n");
-		no_timeout = true;
-	}

 	rc = of_property_read_u32(pdev->dev.of_node, "xlnx,wdt-interval",
 				  &xdev->wdt_interval);
-	if (rc) {
+	if (rc)
 		dev_warn(&pdev->dev,
 			 "Parameter \"xlnx,wdt-interval\" not found\n");
-		no_timeout = true;
-	}

 	rc = of_property_read_u32(pdev->dev.of_node, "xlnx,wdt-enable-once",
 				  &enable_once);
@@ -194,7 +189,7 @@ static int xwdt_probe(struct platform_device *pdev)
 	 * Twice of the 2^wdt_interval / freq  because the first wdt overflow is
 	 * ignored (interrupt), reset is only generated at second wdt overflow
 	 */
-	if (!no_timeout)
+	if (pfreq && xdev->wdt_interval)
 		xilinx_wdt_wdd->timeout = 2 * ((1 << xdev->wdt_interval) /
 					  pfreq);

--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/2bdc6693/attachment-0001.sig>
