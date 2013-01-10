From: rogerq@ti.com (Roger Quadros)
Date: Thu, 10 Jan 2013 18:51:24 +0200
Subject: [PATCH 04/14] usb: phy: nop: Handle power supply regulator for the PHY
In-Reply-To: <1357836694-30788-1-git-send-email-rogerq@ti.com>
References: <1357836694-30788-1-git-send-email-rogerq@ti.com>
Message-ID: <1357836694-30788-5-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We use "vcc" as the supply name for the PHY's power supply.
The power supply will be enabled during .init() and disabled
during .shutdown()

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/otg/nop-usb-xceiv.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
index 163f972..1c6db10 100644
--- a/drivers/usb/otg/nop-usb-xceiv.c
+++ b/drivers/usb/otg/nop-usb-xceiv.c
@@ -33,11 +33,13 @@
 #include <linux/usb/nop-usb-xceiv.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
+#include <linux/regulator/consumer.h>
 
 struct nop_usb_xceiv {
 	struct usb_phy		phy;
 	struct device		*dev;
 	struct clk		*clk;
+	struct regulator	*vcc;
 };
 
 static struct platform_device *pd;
@@ -70,6 +72,11 @@ static int nop_init(struct usb_phy *phy)
 {
 	struct nop_usb_xceiv *nop = dev_get_drvdata(phy->dev);
 
+	if (nop->vcc) {
+		if (regulator_enable(nop->vcc))
+			dev_err(phy->dev, "Failed to enable power\n");
+	}
+
 	if (nop->clk)
 		clk_enable(nop->clk);
 
@@ -82,6 +89,11 @@ static void nop_shutdown(struct usb_phy *phy)
 
 	if (nop->clk)
 		clk_disable(nop->clk);
+
+	if (nop->vcc) {
+		if (regulator_disable(nop->vcc))
+			dev_err(phy->dev, "Failed to disable power\n");
+	}
 }
 
 static int nop_set_peripheral(struct usb_otg *otg, struct usb_gadget *gadget)
@@ -157,6 +169,12 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
 		}
 	}
 
+	nop->vcc = devm_regulator_get(&pdev->dev, "vcc");
+	if (IS_ERR(nop->vcc)) {
+		dev_dbg(&pdev->dev, "Error getting vcc regulator\n");
+		nop->vcc = NULL;
+	}
+
 	nop->dev		= &pdev->dev;
 	nop->phy.dev		= nop->dev;
 	nop->phy.label		= "nop-xceiv";
-- 
1.7.4.1
