From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Mon, 28 Mar 2016 06:55:03 +0000
Subject: [PATCH] usb: host: xhci-plat: Make enum xhci_plat_type start at a
 non zero value
In-Reply-To: <20160326091050.GA7793@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1458917188-28452-1-git-send-email-peter.griffin@linaro.org>
 <87mvpm8pfl.fsf@ti.com> <87mvpmlc5e.fsf@free-electrons.com>
 <87io0a8nbd.fsf@ti.com>
 <20160326091050.GA7793@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <SG2PR06MB09190267848198365A7783A3D8860@SG2PR06MB0919.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Sent: Saturday, March 26, 2016 6:11 PM
< snip >
> > ps: there might be bugs there, but it's a holiday and I really shouldn't
> > be spending time on this right now ;-)
> 
> I'm also off on holiday now until Sunday 10th April... yay :-)
> >
> > Anyway, have fun testing. Let me know if it doesn't work.
> 
> I only have access to STi platforms which were broken by this change.
> Not any of the platforms which rely on the functionality which
> was introduced (although I can't see any reason why your patch wouldn't work).
> 
> Maybe Yoshihiro (on CC) could test this on the Renesas platforms and confirm?

Thank you for sending the email to me on CC.
I tested Felipe's patch on Renesas platfroms (R-Car Gen2 and Gen3) and I fixed the patch like the following.
However, my fixes patch might need to clean the code up more.

Changes from Felipe's patch:
- Change function names of xhci_rcar_init_quirk() to xhci_rcar_setup_quirk()
- Add setup_quirk() member and use it for rcar's function.
- Some minor fixes.

---
diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
index 1eefc98..1ea6c18 100644
--- a/drivers/usb/host/xhci-mvebu.c
+++ b/drivers/usb/host/xhci-mvebu.c
@@ -41,8 +41,9 @@ static void xhci_mvebu_mbus_config(void __iomem *base,
 	}
 }
 
-int xhci_mvebu_mbus_init_quirk(struct platform_device *pdev)
+int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
 {
+	struct platform_device *pdev = to_platform_device(hcd->self.controller);
 	struct resource	*res;
 	void __iomem *base;
 	const struct mbus_dram_target_info *dram;
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index d39d6bf..d28513a 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -47,43 +47,57 @@ static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
 	xhci->quirks |= XHCI_PLAT;
 }
 
+static void xhci_priv_plat_start(struct usb_hcd *hcd)
+{
+	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
+
+	if (priv->plat_start)
+		priv->plat_start(hcd);
+}
+
+static int xhci_priv_setup_quirk(struct usb_hcd *hcd)
+{
+	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
+
+	if (!priv->setup_quirk)
+		return 0;
+
+	return priv->setup_quirk(hcd);
+}
+
 /* called during probe() after chip reset completes */
 static int xhci_plat_setup(struct usb_hcd *hcd)
 {
 	int ret;
 
-	if (xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2) ||
-	    xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN3)) {
-		ret = xhci_rcar_init_quirk(hcd);
-		if (ret)
-			return ret;
-	}
+	ret = xhci_priv_setup_quirk(hcd);
+	if (ret)
+		return ret;
 
 	return xhci_gen_setup(hcd, xhci_plat_quirks);
 }
 
 static int xhci_plat_start(struct usb_hcd *hcd)
 {
-	if (xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2) ||
-	    xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN3))
-		xhci_rcar_start(hcd);
-
+	xhci_priv_plat_start(hcd);
 	return xhci_run(hcd);
 }
 
 #ifdef CONFIG_OF
 static const struct xhci_plat_priv xhci_plat_marvell_armada = {
-	.type = XHCI_PLAT_TYPE_MARVELL_ARMADA,
+	.init_quirk = xhci_mvebu_mbus_init_quirk,
 };
 
 static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen2 = {
-	.type = XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2,
 	.firmware_name = XHCI_RCAR_FIRMWARE_NAME_V1,
+	.setup_quirk = xhci_rcar_setup_quirk,
+	.plat_start = xhci_rcar_start,
 };
 
 static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 = {
-	.type = XHCI_PLAT_TYPE_RENESAS_RCAR_GEN3,
 	.firmware_name = XHCI_RCAR_FIRMWARE_NAME_V2,
+	.setup_quirk = xhci_rcar_setup_quirk,
+	.plat_start = xhci_rcar_start,
 };
 
 static const struct of_device_id usb_xhci_of_match[] = {
@@ -119,6 +133,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 {
 	struct device_node	*node = pdev->dev.of_node;
 	struct usb_xhci_pdata	*pdata = dev_get_platdata(&pdev->dev);
+	struct xhci_plat_priv	*priv;
 	const struct of_device_id *match;
 	const struct hc_driver	*driver;
 	struct xhci_hcd		*xhci;
@@ -178,18 +193,18 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	}
 
 	xhci = hcd_to_xhci(hcd);
+	priv = hcd_to_xhci_priv(hcd);
 	match = of_match_node(usb_xhci_of_match, node);
 	if (match) {
 		const struct xhci_plat_priv *priv_match = match->data;
-		struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
 
 		/* Just copy data for now */
 		if (priv_match)
 			*priv = *priv_match;
 	}
 
-	if (xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_MARVELL_ARMADA)) {
-		ret = xhci_mvebu_mbus_init_quirk(pdev);
+	if (priv->init_quirk) {
+		ret = priv->init_quirk(pdev);
 		if (ret)
 			goto disable_clk;
 	}
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 5a2e2e3..1d86d6d 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -13,27 +13,13 @@
 
 #include "xhci.h"	/* for hcd_to_xhci() */
 
-enum xhci_plat_type {
-	XHCI_PLAT_TYPE_MARVELL_ARMADA,
-	XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2,
-	XHCI_PLAT_TYPE_RENESAS_RCAR_GEN3,
-};
-
 struct xhci_plat_priv {
-	enum xhci_plat_type type;
 	const char *firmware_name;
+	void (*plat_start)(struct usb_hcd *);
+	int (*init_quirk)(struct platform_device *pdev);
+	int (*setup_quirk)(struct usb_hcd *);
 };
 
 #define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->priv)
 
-static inline bool xhci_plat_type_is(struct usb_hcd *hcd,
-				     enum xhci_plat_type type)
-{
-	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
-
-	if (priv && priv->type == type)
-		return true;
-	else
-		return false;
-}
 #endif	/* _XHCI_PLAT_H */
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index 623100e..7b2800c 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -81,11 +81,13 @@ void xhci_rcar_start(struct usb_hcd *hcd)
 	u32 temp;
 
 	if (hcd->regs != NULL) {
+		struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
+
 		/* Interrupt Enable */
 		temp = readl(hcd->regs + RCAR_USB3_INT_ENA);
 		temp |= RCAR_USB3_INT_ENA_VAL;
 		writel(temp, hcd->regs + RCAR_USB3_INT_ENA);
-		if (xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2))
+		if (!strcmp(priv->firmware_name, XHCI_RCAR_FIRMWARE_NAME_V1))
 			xhci_rcar_start_gen2(hcd);
 	}
 }
@@ -154,7 +156,7 @@ static int xhci_rcar_download_firmware(struct usb_hcd *hcd)
 }
 
 /* This function needs to initialize a "phy" of usb before */
-int xhci_rcar_init_quirk(struct usb_hcd *hcd)
+int xhci_rcar_setup_quirk(struct usb_hcd *hcd)
 {
 	/* If hcd->regs is NULL, we don't just call the following function */
 	if (!hcd->regs)
diff --git a/drivers/usb/host/xhci-rcar.h b/drivers/usb/host/xhci-rcar.h
index 2941a25..05cd539 100644
--- a/drivers/usb/host/xhci-rcar.h
+++ b/drivers/usb/host/xhci-rcar.h
@@ -16,13 +16,13 @@
 
 #if IS_ENABLED(CONFIG_USB_XHCI_RCAR)
 void xhci_rcar_start(struct usb_hcd *hcd);
-int xhci_rcar_init_quirk(struct usb_hcd *hcd);
+int xhci_rcar_setup_quirk(struct usb_hcd *hcd);
 #else
 static inline void xhci_rcar_start(struct usb_hcd *hcd)
 {
 }
 
-static inline int xhci_rcar_init_quirk(struct usb_hcd *hcd)
+static inline int xhci_rcar_setup_quirk(struct usb_hcd *hcd)
 {
 	return 0;
 }
