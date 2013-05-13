From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 13 May 2013 01:51:37 -0400
Subject: [PATCh V10 06/12] usb: mv_u3d: usb phy drivers for phy operation
In-Reply-To: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
References: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1368424303-10629-7-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phy_init and phy_deinit APIs are removed from the pdata.
Directly get the phy driver and invoke the callbacks of phy
drivers for phy initialization and shutdown.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/gadget/mv_u3d.h      |    3 +-
 drivers/usb/gadget/mv_u3d_core.c |   54 ++++++++++++++-----------------------
 2 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/gadget/mv_u3d.h b/drivers/usb/gadget/mv_u3d.h
index e32a787..0a0c7e3 100644
--- a/drivers/usb/gadget/mv_u3d.h
+++ b/drivers/usb/gadget/mv_u3d.h
@@ -251,7 +251,6 @@ struct mv_u3d {
 	struct mv_u3d_cap_regs __iomem	*cap_regs;
 	struct mv_u3d_op_regs __iomem	*op_regs;
 	struct mv_u3d_vuc_regs __iomem	*vuc_regs;
-	void __iomem			*phy_regs;
 
 	unsigned int			max_eps;
 	struct mv_u3d_ep_context	*ep_context;
@@ -283,6 +282,8 @@ struct mv_u3d {
 	struct mv_usb_addon_irq *vbus;
 	unsigned int		power;
 
+	struct usb_phy		*phy;
+
 	struct clk		*clk;
 };
 
diff --git a/drivers/usb/gadget/mv_u3d_core.c b/drivers/usb/gadget/mv_u3d_core.c
index 58288e9..bb92c5b 100644
--- a/drivers/usb/gadget/mv_u3d_core.c
+++ b/drivers/usb/gadget/mv_u3d_core.c
@@ -24,6 +24,7 @@
 #include <linux/device.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
+#include <linux/usb/phy.h>
 #include <linux/pm.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -1109,7 +1110,6 @@ static int mv_u3d_controller_reset(struct mv_u3d *u3d)
 
 static int mv_u3d_enable(struct mv_u3d *u3d)
 {
-	struct mv_usb_platform_data *pdata = u3d->dev->platform_data;
 	int retval;
 
 	if (u3d->active)
@@ -1122,14 +1122,12 @@ static int mv_u3d_enable(struct mv_u3d *u3d)
 
 	dev_dbg(u3d->dev, "enable u3d\n");
 	clk_enable(u3d->clk);
-	if (pdata->phy_init) {
-		retval = pdata->phy_init(u3d->phy_regs);
-		if (retval) {
-			dev_err(u3d->dev,
-				"init phy error %d\n", retval);
-			clk_disable(u3d->clk);
-			return retval;
-		}
+	retval = usb_phy_init(u3d->phy);
+	if (retval) {
+		dev_err(u3d->dev,
+			"init phy error %d\n", retval);
+		clk_disable(u3d->clk);
+		return retval;
 	}
 	u3d->active = 1;
 
@@ -1138,11 +1136,9 @@ static int mv_u3d_enable(struct mv_u3d *u3d)
 
 static void mv_u3d_disable(struct mv_u3d *u3d)
 {
-	struct mv_usb_platform_data *pdata = u3d->dev->platform_data;
 	if (u3d->clock_gating && u3d->active) {
 		dev_dbg(u3d->dev, "disable u3d\n");
-		if (pdata->phy_deinit)
-			pdata->phy_deinit(u3d->phy_regs);
+		usb_phy_shutdown(u3d->phy);
 		clk_disable(u3d->clk);
 		u3d->active = 0;
 	}
@@ -1246,7 +1242,6 @@ static int mv_u3d_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver)
 {
 	struct mv_u3d *u3d = container_of(g, struct mv_u3d, gadget);
-	struct mv_usb_platform_data *pdata = u3d->dev->platform_data;
 	unsigned long flags;
 
 	if (u3d->driver)
@@ -1256,8 +1251,7 @@ static int mv_u3d_start(struct usb_gadget *g,
 
 	if (!u3d->clock_gating) {
 		clk_enable(u3d->clk);
-		if (pdata->phy_init)
-			pdata->phy_init(u3d->phy_regs);
+		usb_phy_init(u3d->phy);
 	}
 
 	/* hook up the driver ... */
@@ -1277,7 +1271,6 @@ static int mv_u3d_stop(struct usb_gadget *g,
 		struct usb_gadget_driver *driver)
 {
 	struct mv_u3d *u3d = container_of(g, struct mv_u3d, gadget);
-	struct mv_usb_platform_data *pdata = u3d->dev->platform_data;
 	unsigned long flags;
 
 	u3d->vbus_valid_detect = 0;
@@ -1285,8 +1278,7 @@ static int mv_u3d_stop(struct usb_gadget *g,
 
 	/* enable clock to access controller register */
 	clk_enable(u3d->clk);
-	if (pdata->phy_init)
-		pdata->phy_init(u3d->phy_regs);
+	usb_phy_init(u3d->phy);
 
 	mv_u3d_controller_stop(u3d);
 	/* stop all usb activities */
@@ -1294,8 +1286,7 @@ static int mv_u3d_stop(struct usb_gadget *g,
 	mv_u3d_stop_activity(u3d, driver);
 	mv_u3d_disable(u3d);
 
-	if (pdata->phy_deinit)
-		pdata->phy_deinit(u3d->phy_regs);
+	usb_phy_shutdown(u3d->phy);
 	clk_disable(u3d->clk);
 
 	spin_unlock_irqrestore(&u3d->lock, flags);
@@ -1827,7 +1818,7 @@ static int mv_u3d_probe(struct platform_device *dev)
 		goto err_get_clk;
 	}
 
-	r = platform_get_resource_byname(dev, IORESOURCE_MEM, "capregs");
+	r = platform_get_resource_byname(dev, IORESOURCE_MEM, 0);
 	if (!r) {
 		dev_err(&dev->dev, "no I/O memory resource defined\n");
 		retval = -ENODEV;
@@ -1846,15 +1837,14 @@ static int mv_u3d_probe(struct platform_device *dev)
 			(unsigned long) u3d->cap_regs);
 	}
 
-	/* we will access controller register, so enable the u3d controller */
-	clk_enable(u3d->clk);
+	u3d->phy = devm_usb_get_phy(&dev->dev, USB_PHY_TYPE_USB3);
+	if (IS_ERR_OR_NULL(u3d->phy))
+		goto err_u3d_enable;
 
-	if (pdata->phy_init) {
-		retval = pdata->phy_init(u3d->phy_regs);
-		if (retval) {
-			dev_err(&dev->dev, "init phy error %d\n", retval);
-			goto err_u3d_enable;
-		}
+	retval = usb_phy_init(u3d->phy);
+	if (retval) {
+		dev_err(&dev->dev, "init phy error %d\n", retval);
+		goto err_u3d_enable;
 	}
 
 	u3d->op_regs = (struct mv_u3d_op_regs __iomem *)(u3d->cap_regs
@@ -1872,8 +1862,7 @@ static int mv_u3d_probe(struct platform_device *dev)
 	mv_u3d_controller_stop(u3d);
 	iowrite32(0xFFFFFFFF, &u3d->vuc_regs->intrcause);
 
-	if (pdata->phy_deinit)
-		pdata->phy_deinit(u3d->phy_regs);
+	usb_phy_shutdown(u3d->phy);
 	clk_disable(u3d->clk);
 
 	size = u3d->max_eps * sizeof(struct mv_u3d_ep_context) * 2;
@@ -1988,8 +1977,7 @@ err_alloc_trb_pool:
 	dma_free_coherent(&dev->dev, u3d->ep_context_size,
 		u3d->ep_context, u3d->ep_context_dma);
 err_alloc_ep_context:
-	if (pdata->phy_deinit)
-		pdata->phy_deinit(u3d->phy_regs);
+	usb_phy_shutdown(u3d->phy);
 	clk_disable(u3d->clk);
 err_u3d_enable:
 	iounmap(u3d->cap_regs);
-- 
1.7.4.1
