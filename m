From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 28 Sep 2012 18:23:14 +0530
Subject: [PATCH 5/6] usb: dwc3-omap: Minor fixes to get dt working
In-Reply-To: <1348836795-4783-1-git-send-email-kishon@ti.com>
References: <1348836795-4783-1-git-send-email-kishon@ti.com>
Message-ID: <1348836795-4783-6-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Includes few minor fixes in dwc3-omap like populating the compatible
string in a correct way, extracting the utmi-mode property properly and
changing the index of get_irq since irq of core is removed from hwmod
entry.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 7ae4d73..e3d9a5f 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -277,7 +277,7 @@ static int __devinit dwc3_omap_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, omap);
 
-	irq = platform_get_irq(pdev, 1);
+	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "missing IRQ resource\n");
 		return -EINVAL;
@@ -335,7 +335,7 @@ static int __devinit dwc3_omap_probe(struct platform_device *pdev)
 
 	utmi_mode = of_get_property(node, "utmi-mode", &size);
 	if (utmi_mode && size == sizeof(*utmi_mode)) {
-		reg |= *utmi_mode;
+		reg |= be32_to_cpup(utmi_mode);
 	} else {
 		if (!pdata) {
 			dev_dbg(dev, "missing platform data\n");
@@ -403,7 +403,7 @@ static int __devexit dwc3_omap_remove(struct platform_device *pdev)
 
 static const struct of_device_id of_dwc3_matach[] = {
 	{
-		"ti,dwc3",
+		.compatible =	"ti,dwc3"
 	},
 	{ },
 };
-- 
1.7.10.4
