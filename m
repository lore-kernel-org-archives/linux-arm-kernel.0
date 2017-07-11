From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 11 Jul 2017 15:46:38 +0530
Subject: [RESEND PATCH] bus: omap-ocp2scp: Fix error handling in
 omap_ocp2scp_probe
Message-ID: <20170711101638.2233-1-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The error handling code in omap_ocp2scp_probe fails to invoke
pm_runtime_disable and fails to initialize return value in
certain cases. Fix it here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/bus/omap-ocp2scp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/omap-ocp2scp.c b/drivers/bus/omap-ocp2scp.c
index bf500e0e7362..77791f3dcfc6 100644
--- a/drivers/bus/omap-ocp2scp.c
+++ b/drivers/bus/omap-ocp2scp.c
@@ -70,8 +70,10 @@ static int omap_ocp2scp_probe(struct platform_device *pdev)
 	if (!of_device_is_compatible(np, "ti,am437x-ocp2scp")) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		regs = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(regs))
-			goto err0;
+		if (IS_ERR(regs)) {
+			ret = PTR_ERR(regs);
+			goto err1;
+		}
 
 		pm_runtime_get_sync(&pdev->dev);
 		reg = readl_relaxed(regs + OCP2SCP_TIMING);
@@ -83,6 +85,9 @@ static int omap_ocp2scp_probe(struct platform_device *pdev)
 
 	return 0;
 
+err1:
+	pm_runtime_disable(&pdev->dev);
+
 err0:
 	device_for_each_child(&pdev->dev, NULL, ocp2scp_remove_devices);
 
-- 
2.11.0
