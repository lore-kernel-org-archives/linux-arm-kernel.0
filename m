From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 14 Jan 2013 18:12:40 +0800
Subject: [PATCH v3 2/3] usb: fsl_mxc_udc: replace MX35_IO_ADDRESS to ioremap
In-Reply-To: <1358158361-25550-1-git-send-email-peter.chen@freescale.com>
References: <1358158361-25550-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1358158361-25550-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As mach/hardware.h is deleted, we can't visit platform code at driver.
It has no phy driver to combine with this controller, so it has to use
ioremap to map phy address as a workaround.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/gadget/fsl_mxc_udc.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
index 6df45f7..0e858e6 100644
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
@@ -83,15 +84,16 @@ void fsl_udc_clk_finalize(enum fsl_udc_type devtype,
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
 	if (devtype == IMX35_UDC) {
 		unsigned int v;
+		void __iomem *phy_regs = ioremap((unsigned long)pdata->regs +
+						MX35_USBPHYCTRL_OFFSET, 512);
 
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
+		iounmap(phy_regs);
 	}
 
 	/* ULPI transceivers don't need usbpll */
-- 
1.7.0.4
