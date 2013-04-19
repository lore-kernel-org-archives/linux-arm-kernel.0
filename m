From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 20 Apr 2013 01:59:18 +0400
Subject: [PATCH v5 4/9] rcar-phy: remove EHCI internal buffer setup
Message-ID: <201304200159.18768.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the EHCI internal  buffer setup is done by the platform code, we  can
remove  such code from this driver as it  never  really belonged here.  We also
no longer need the 2nd memory region now (2nd EHCI controller is simply missing
in e.g. R8A7778 SoC).

The patch has been tested on the Marzen and BOCK-W boards.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>

---
Changes since version 2:
- added a note about testing to the changelog;
- added ACKs from Simon Horman and Kuninori Morimoto.

Changes since the original posting:
- split R8A7779 SoC file change to a separate patch.

 drivers/usb/phy/rcar-phy.c |   28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

Index: renesas/drivers/usb/phy/rcar-phy.c
===================================================================
--- renesas.orig/drivers/usb/phy/rcar-phy.c
+++ renesas/drivers/usb/phy/rcar-phy.c
@@ -23,8 +23,6 @@
 #define USBEH0		0x080C
 #define USBOH0		0x081C
 #define USBCTL0		0x0858
-#define EIIBC1		0x0094
-#define EIIBC2		0x009C
 
 /* USBPCTRL1 */
 #define PHY_RST		(1 << 2)
@@ -40,7 +38,6 @@ struct rcar_usb_phy_priv {
 	spinlock_t lock;
 
 	void __iomem *reg0;
-	void __iomem *reg1;
 	int counter;
 };
 
@@ -59,7 +56,6 @@ static int rcar_usb_phy_init(struct usb_
 	struct rcar_usb_phy_priv *priv = usb_phy_to_priv(phy);
 	struct device *dev = phy->dev;
 	void __iomem *reg0 = priv->reg0;
-	void __iomem *reg1 = priv->reg1;
 	int i;
 	u32 val;
 	unsigned long flags;
@@ -97,19 +93,6 @@ static int rcar_usb_phy_init(struct usb_
 		iowrite32(0x00000000, (reg0 + USBPCTRL0));
 
 		/*
-		 * EHCI IP internal buffer setting
-		 * EHCI IP internal buffer enable
-		 *
-		 * These are recommended value of a datasheet
-		 * see [USB :: EHCI internal buffer setting]
-		 */
-		iowrite32(0x00ff0040, (reg0 + EIIBC1));
-		iowrite32(0x00ff0040, (reg1 + EIIBC1));
-
-		iowrite32(0x00000001, (reg0 + EIIBC2));
-		iowrite32(0x00000001, (reg1 + EIIBC2));
-
-		/*
 		 * Bus alignment settings
 		 */
 
@@ -145,14 +128,13 @@ static void rcar_usb_phy_shutdown(struct
 static int rcar_usb_phy_probe(struct platform_device *pdev)
 {
 	struct rcar_usb_phy_priv *priv;
-	struct resource *res0, *res1;
+	struct resource *res0;
 	struct device *dev = &pdev->dev;
-	void __iomem *reg0, *reg1;
+	void __iomem *reg0;
 	int ret;
 
 	res0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	res1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res0 || !res1) {
+	if (!res0) {
 		dev_err(dev, "Not enough platform resources\n");
 		return -EINVAL;
 	}
@@ -164,8 +146,7 @@ static int rcar_usb_phy_probe(struct pla
 	 * this driver can't use devm_request_and_ioremap(dev, res) here
 	 */
 	reg0 = devm_ioremap_nocache(dev, res0->start, resource_size(res0));
-	reg1 = devm_ioremap_nocache(dev, res1->start, resource_size(res1));
-	if (!reg0 || !reg1) {
+	if (!reg0) {
 		dev_err(dev, "ioremap error\n");
 		return -ENOMEM;
 	}
@@ -177,7 +158,6 @@ static int rcar_usb_phy_probe(struct pla
 	}
 
 	priv->reg0		= reg0;
-	priv->reg1		= reg1;
 	priv->counter		= 0;
 	priv->phy.dev		= dev;
 	priv->phy.label		= dev_name(dev);
