From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 12 Feb 2014 14:41:20 +0100
Subject: [PATCH v3 06/11] watchdog: xilinx: Fix all printk messages
In-Reply-To: <bdd7c2c78dd491d02d1c1ae8a59b92b7a1a17ec6.1392212059.git.michal.simek@xilinx.com>
References: <bdd7c2c78dd491d02d1c1ae8a59b92b7a1a17ec6.1392212059.git.michal.simek@xilinx.com>
Message-ID: <431a55ec5ff9085997c7655f51be654848c23b2d.1392212059.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dev_ functions for printk messages.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

Changes in v3: None
Changes in v2: None

 drivers/watchdog/of_xilinx_wdt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index d28bd3f..c229cc4 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -10,8 +10,6 @@
  * 2 of the License, or (at your option) any later version.
  */

-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -42,7 +40,6 @@
 #define XWT_TIMER_FAILED            0xFFFFFFFF

 #define WATCHDOG_NAME     "Xilinx Watchdog"
-#define PFX WATCHDOG_NAME ": "

 struct xwdt_device {
 	void __iomem *base;
@@ -175,14 +172,16 @@ static int xwdt_probe(struct platform_device *pdev)
 					"clock-frequency", NULL);

 	if (pfreq == NULL) {
-		pr_warn("The watchdog clock frequency cannot be obtained!\n");
+		dev_warn(&pdev->dev,
+			 "The watchdog clock frequency cannot be obtained\n");
 		no_timeout = true;
 	}

 	tmptr = (u32 *)of_get_property(pdev->dev.of_node,
 					"xlnx,wdt-interval", NULL);
 	if (tmptr == NULL) {
-		pr_warn("Parameter \"xlnx,wdt-interval\" not found in device tree!\n");
+		dev_warn(&pdev->dev,
+			 "Parameter \"xlnx,wdt-interval\" not found\n");
 		no_timeout = true;
 	} else {
 		xdev->wdt_interval = *tmptr;
@@ -191,7 +190,8 @@ static int xwdt_probe(struct platform_device *pdev)
 	tmptr = (u32 *)of_get_property(pdev->dev.of_node,
 					"xlnx,wdt-enable-once", NULL);
 	if (tmptr == NULL) {
-		pr_warn("Parameter \"xlnx,wdt-enable-once\" not found in device tree!\n");
+		dev_warn(&pdev->dev,
+			 "Parameter \"xlnx,wdt-enable-once\" not found\n");
 		watchdog_set_nowayout(xilinx_wdt_wdd, true);
 	}

@@ -208,13 +208,13 @@ static int xwdt_probe(struct platform_device *pdev)

 	rc = xwdt_selftest(xdev);
 	if (rc == XWT_TIMER_FAILED) {
-		pr_err("SelfTest routine error!\n");
+		dev_err(&pdev->dev, "SelfTest routine error\n");
 		return rc;
 	}

 	rc = watchdog_register_device(xilinx_wdt_wdd);
 	if (rc) {
-		pr_err("cannot register watchdog (err=%d)\n", rc);
+		dev_err(&pdev->dev, "Cannot register watchdog (err=%d)\n", rc);
 		return rc;
 	}

--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/7a46ccec/attachment-0001.sig>
