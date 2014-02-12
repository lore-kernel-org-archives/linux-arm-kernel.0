From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 12 Feb 2014 14:34:35 +0100
Subject: [PATCH v3 04/11] watchdog: xilinx: Move no_timeout to probe function
In-Reply-To: <cover.1392212059.git.michal.simek@xilinx.com>
References: <cover.1392212059.git.michal.simek@xilinx.com>
Message-ID: <e1b370a86bbc9b389cfccfccce94014ff0d03788.1392212059.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

no_timeout should be local variable because it is used
only in probe function.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

Changes in v3: None
Changes in v2: None

 drivers/watchdog/of_xilinx_wdt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 7f371ed..1f7ad91 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -52,7 +52,6 @@ struct xwdt_device {
 static struct xwdt_device xdev;

 static  u32 timeout;
-static  u8  no_timeout;

 static  DEFINE_SPINLOCK(spinlock);

@@ -160,8 +159,7 @@ static int xwdt_probe(struct platform_device *pdev)
 	u32 *tmptr;
 	u32 *pfreq;
 	struct resource *res;
-
-	no_timeout = 0;
+	bool no_timeout = false;

 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	xdev.base = devm_ioremap_resource(&pdev->dev, res);
@@ -173,14 +171,14 @@ static int xwdt_probe(struct platform_device *pdev)

 	if (pfreq == NULL) {
 		pr_warn("The watchdog clock frequency cannot be obtained!\n");
-		no_timeout = 1;
+		no_timeout = true;
 	}

 	tmptr = (u32 *)of_get_property(pdev->dev.of_node,
 					"xlnx,wdt-interval", NULL);
 	if (tmptr == NULL) {
 		pr_warn("Parameter \"xlnx,wdt-interval\" not found in device tree!\n");
-		no_timeout = 1;
+		no_timeout = true;
 	} else {
 		xdev.wdt_interval = *tmptr;
 	}
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/334443b8/attachment.sig>
