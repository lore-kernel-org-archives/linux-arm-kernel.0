From: rogerq@ti.com (Roger Quadros)
Date: Fri, 18 Jan 2013 14:17:09 +0200
Subject: [PATCH v8 06/22] mfd: omap-usb-tll: introduce and use mode_needs_tll()
In-Reply-To: <1358511445-26656-1-git-send-email-rogerq@ti.com>
References: <1358511445-26656-1-git-send-email-rogerq@ti.com>
Message-ID: <1358511445-26656-7-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a handy macro to check if the port requires the
USB TLL module or not. Use it to Enable the TLL module and manage
the clocks.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/omap-usb-tll.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 4ce134b..6a43391 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -95,6 +95,10 @@
 
 #define is_ehci_tll_mode(x)	(x == OMAP_EHCI_PORT_MODE_TLL)
 
+/* only PHY and UNUSED modes don't need TLL */
+#define omap_usb_mode_needs_tll(x)	((x != OMAP_USBHS_PORT_MODE_UNUSED) &&\
+					 (x != OMAP_EHCI_PORT_MODE_PHY))
+
 struct usbtll_omap {
 	int					nch;	/* num. of channels */
 	struct usbhs_omap_platform_data		*pdata;
@@ -211,6 +215,7 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 	unsigned long				flags;
 	int					ret = 0;
 	int					i, ver;
+	bool needs_tll;
 
 	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
 
@@ -281,12 +286,11 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 
 	spin_lock_irqsave(&tll->lock, flags);
 
-	if (is_ehci_tll_mode(pdata->port_mode[0]) ||
-	    is_ehci_tll_mode(pdata->port_mode[1]) ||
-	    is_ehci_tll_mode(pdata->port_mode[2]) ||
-	    is_ohci_port(pdata->port_mode[0]) ||
-	    is_ohci_port(pdata->port_mode[1]) ||
-	    is_ohci_port(pdata->port_mode[2])) {
+	needs_tll = false;
+	for (i = 0; i < tll->nch; i++)
+		needs_tll |= omap_usb_mode_needs_tll(pdata->port_mode[i]);
+
+	if (needs_tll) {
 
 		/* Program Common TLL register */
 		reg = usbtll_read(base, OMAP_TLL_SHARED_CONF);
@@ -374,7 +378,7 @@ static int usbtll_runtime_resume(struct device *dev)
 	spin_lock_irqsave(&tll->lock, flags);
 
 	for (i = 0; i < tll->nch; i++) {
-		if (is_ehci_tll_mode(pdata->port_mode[i])) {
+		if (omap_usb_mode_needs_tll(pdata->port_mode[i])) {
 			int r;
 
 			if (!tll->ch_clk[i])
@@ -410,7 +414,7 @@ static int usbtll_runtime_suspend(struct device *dev)
 	spin_lock_irqsave(&tll->lock, flags);
 
 	for (i = 0; i < tll->nch; i++) {
-		if (is_ehci_tll_mode(pdata->port_mode[i])) {
+		if (omap_usb_mode_needs_tll(pdata->port_mode[i])) {
 			if (tll->ch_clk[i])
 				clk_disable(tll->ch_clk[i]);
 		}
-- 
1.7.4.1
