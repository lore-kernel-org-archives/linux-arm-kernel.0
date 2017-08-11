From: yinbo.zhu@nxp.com (yinbo.zhu at nxp.com)
Date: Fri, 11 Aug 2017 17:59:56 +0800
Subject: [PATCH 2/3] usb: dwc3 : Add support for USB snooping
Message-ID: <1502445596-33716-1-git-send-email-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajesh Bhagat <rajesh.bhagat@freescale.com>

Add support for USB3 snooping by asserting bits
in register DWC3_GSBUSCFG0 for data and descriptor

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Signed-off-by: Rajesh Bhagat <rajesh.bhagat@freescale.com>
Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
---
 drivers/usb/dwc3/core.c | 71 ++++++++++++++++++++++++++++++++++++-------------
 drivers/usb/dwc3/core.h |  3 +++
 drivers/usb/dwc3/host.c |  8 +++++-
 3 files changed, 63 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 02a534a..b51b0d8 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -90,6 +90,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 
 		if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
 			mode = USB_DR_MODE_HOST;
+
 		else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
 			mode = USB_DR_MODE_PERIPHERAL;
 	}
@@ -305,14 +306,27 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
  */
 static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
 {
-	struct dwc3_event_buffer *evt;
+	int                     num;
+	int                     i;
+
+	num = DWC3_NUM_INT(dwc->hwparams.hwparams1);
+	dwc->num_event_buffers = num;
+
+	dwc->ev_buffs = devm_kzalloc(dwc->dev, sizeof(*dwc->ev_buffs) * num,
+			GFP_KERNEL);
+	if (!dwc->ev_buffs)
+		return -ENOMEM;
 
-	evt = dwc3_alloc_one_event_buffer(dwc, length);
-	if (IS_ERR(evt)) {
-		dev_err(dwc->dev, "can't allocate event buffer\n");
-		return PTR_ERR(evt);
+	for (i = 0; i < num; i++) {
+		struct dwc3_event_buffer        *evt;
+
+		evt = dwc3_alloc_one_event_buffer(dwc, length);
+		if (IS_ERR(evt)) {
+			dev_err(dwc->dev, "can't allocate event buffer\n");
+			return PTR_ERR(evt);
+		}
+		dwc->ev_buffs[i] = evt;
 	}
-	dwc->ev_buf = evt;
 
 	return 0;
 }
@@ -325,17 +339,25 @@ static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned length)
  */
 static int dwc3_event_buffers_setup(struct dwc3 *dwc)
 {
-	struct dwc3_event_buffer	*evt;
-
-	evt = dwc->ev_buf;
-	evt->lpos = 0;
-	dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(0),
-			lower_32_bits(evt->dma));
-	dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0),
-			upper_32_bits(evt->dma));
-	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
-			DWC3_GEVNTSIZ_SIZE(evt->length));
-	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
+	struct dwc3_event_buffer        *evt;
+	int                             n;
+
+	for (n = 0; n < dwc->num_event_buffers; n++) {
+		evt = dwc->ev_buffs[n];
+		dev_dbg(dwc->dev, "Event buf %p dma %08llx length %d\n",
+				evt->buf, (unsigned long long) evt->dma,
+				evt->length);
+
+		evt->lpos = 0;
+
+		dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(n),
+				lower_32_bits(evt->dma));
+		dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(n),
+				upper_32_bits(evt->dma));
+		dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(n),
+				DWC3_GEVNTSIZ_SIZE(evt->length));
+		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(n), 0);
+	}
 
 	return 0;
 }
@@ -1181,6 +1203,7 @@ static void dwc3_check_params(struct dwc3 *dwc)
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
+	struct device_node      *node = dev->of_node;
 	struct resource		*res;
 	struct dwc3		*dwc;
 
@@ -1188,7 +1211,6 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	void __iomem		*regs;
 
-	struct device_node      *node = dev->of_node;
 	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
 	if (!dwc)
 		return -ENOMEM;
@@ -1260,6 +1282,19 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
+	/* Change burst beat and outstanding pipelined transfers requests */
+	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0,
+		(dwc3_readl(dwc->regs, DWC3_GSBUSCFG0) & ~0xff) | 0xf);
+	dwc3_writel(dwc->regs, DWC3_GSBUSCFG1,
+		dwc3_readl(dwc->regs, DWC3_GSBUSCFG1) | 0xf00);
+
+	/* Enable Snooping */
+	if (node && of_dma_is_coherent(node)) {
+		dwc3_writel(dwc->regs, DWC3_GSBUSCFG0,
+		dwc3_readl(dwc->regs, DWC3_GSBUSCFG0) | 0x22220000);
+		dev_dbg(dev, "enabled snooping for usb\n");
+	}
+
 	ret = dwc3_get_dr_mode(dwc);
 	if (ret)
 		goto err3;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index b83388f..e075665 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -29,6 +29,7 @@
 #include <linux/debugfs.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/of_address.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -913,6 +914,7 @@ struct dwc3 {
 	struct platform_device	*xhci;
 	struct resource		xhci_resources[DWC3_XHCI_RESOURCES_NUM];
 
+	struct dwc3_event_buffer **ev_buffs;
 	struct dwc3_event_buffer *ev_buf;
 	struct dwc3_ep		*eps[DWC3_ENDPOINTS_NUM];
 
@@ -946,6 +948,7 @@ struct dwc3 {
 	u32			incrx_type[2];
 	u32			irq_gadget;
 	u32			nr_scratch;
+	u32			num_event_buffers;
 	u32			u1u2;
 	u32			maximum_speed;
 
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 3e85616..0f2b86c 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -93,8 +93,14 @@ int dwc3_host_init(struct dwc3 *dwc)
 		dma_set_coherent_mask(&xhci->dev, dwc->dev->coherent_dma_mask);
 
 	xhci->dev.parent = dwc->dev;
-
 	xhci->dev.dma_mask = dwc->dev->dma_mask;
+	xhci->dev.dma_parms     = dwc->dev->dma_parms;
+
+	/* set DMA operations */
+	if (dwc->dev->of_node && of_dma_is_coherent(dwc->dev->of_node)) {
+		xhci->dev.archdata.dma_ops = dwc->dev->archdata.dma_ops;
+		dev_dbg(dwc->dev, "set dma_ops for usb\n");
+	}
 
 	dwc->xhci = xhci;
 
-- 
2.1.0.27.g96db324
