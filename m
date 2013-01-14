From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 14 Jan 2013 22:16:08 +0800
Subject: [PATCH v4 2/3] usb: fsl_mxc_udc: replace MX35_IO_ADDRESS to ioremap
In-Reply-To: <1358172969-14898-1-git-send-email-peter.chen@freescale.com>
References: <1358172969-14898-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1358172969-14898-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As mach/hardware.h is deleted, we can't visit platform code at driver.
It has no phy driver to combine with this controller, so it has to use
ioremap to map phy address as a workaround.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/gadget/fsl_mxc_udc.c  |   27 +++++++++++++++++++++------
 drivers/usb/gadget/fsl_udc_core.c |    4 +++-
 drivers/usb/gadget/fsl_usb2_udc.h |    4 ++--
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
index 6df45f7..e505d60 100644
--- a/drivers/usb/gadget/fsl_mxc_udc.c
+++ b/drivers/usb/gadget/fsl_mxc_udc.c
@@ -23,7 +23,8 @@ static struct clk *mxc_per_clk;
 static struct clk *mxc_ipg_clk;
 
 /* workaround ENGcm09152 for i.MX35 */
-#define USBPHYCTRL_OTGBASE_OFFSET	0x608
+#define MX35_USBPHYCTRL_OFFSET		0x600
+#define USBPHYCTRL_OTGBASE_OFFSET	0x8
 #define USBPHYCTRL_EVDO			(1 << 23)
 
 int fsl_udc_clk_init(enum fsl_udc_type devtype, struct platform_device *pdev)
@@ -77,28 +78,42 @@ eclkrate:
 	return ret;
 }
 
-void fsl_udc_clk_finalize(enum fsl_udc_type devtype,
+int fsl_udc_clk_finalize(enum fsl_udc_type devtype,
 	struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
+	int ret = 0;
+
 	if (devtype == IMX35_UDC) {
 		unsigned int v;
+		struct resource *res = platform_get_resource
+			(pdev, IORESOURCE_MEM, 0);
+		void __iomem *phy_regs = ioremap(res->start +
+						MX35_USBPHYCTRL_OFFSET, 512);
+		if (!phy_regs) {
+			dev_err(&pdev->dev, "ioremap for phy address fails\n");
+			ret = -EINVAL;
+			goto ioremap_err;
+		}
 
 		/* workaround ENGcm09152 for i.MX35 */
 		if (pdata->workaround & FLS_USB2_WORKAROUND_ENGCM09152) {
-			v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
-					USBPHYCTRL_OTGBASE_OFFSET));
+			v = readl(phy_regs + USBPHYCTRL_OTGBASE_OFFSET);
 			writel(v | USBPHYCTRL_EVDO,
-				MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
-					USBPHYCTRL_OTGBASE_OFFSET));
+				phy_regs + USBPHYCTRL_OTGBASE_OFFSET);
 		}
+
+		iounmap(phy_regs);
 	}
 
+ioremap_err:
 	/* ULPI transceivers don't need usbpll */
 	if (pdata->phy_mode == FSL_USB2_PHY_ULPI) {
 		clk_disable_unprepare(mxc_per_clk);
 		mxc_per_clk = NULL;
 	}
+
+	return ret;
 }
 
 void fsl_udc_clk_release(void)
diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index c32119b..4391d49 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -2544,7 +2544,9 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 		dr_controller_setup(udc_controller);
 	}
 
-	fsl_udc_clk_finalize(udc_controller->devtype, pdev);
+	ret = fsl_udc_clk_finalize(udc_controller->devtype, pdev);
+	if (ret)
+		goto err_free_irq;
 
 	/* Setup gadget structure */
 	udc_controller->gadget.ops = &fsl_gadget_ops;
diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_usb2_udc.h
index bc1f6d0..7ead5f7 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.h
+++ b/drivers/usb/gadget/fsl_usb2_udc.h
@@ -594,7 +594,7 @@ static inline struct ep_queue_head *get_qh_by_ep(struct fsl_ep *ep)
 struct platform_device;
 #ifdef CONFIG_ARCH_MXC
 int fsl_udc_clk_init(enum fsl_udc_type devtype, struct platform_device *pdev);
-void fsl_udc_clk_finalize(enum fsl_udc_type devtype,
+int fsl_udc_clk_finalize(enum fsl_udc_type devtype,
 		struct platform_device *pdev);
 void fsl_udc_clk_release(void);
 #else
@@ -603,7 +603,7 @@ static inline int fsl_udc_clk_init(enum fsl_udc_type devtype,
 {
 	return 0;
 }
-static inline void fsl_udc_clk_finalize(enum fsl_udc_type devtype,
+static inline int fsl_udc_clk_finalize(enum fsl_udc_type devtype,
 		struct platform_device *pdev)
 {
 }
-- 
1.7.0.4
