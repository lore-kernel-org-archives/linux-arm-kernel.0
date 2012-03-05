From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 05 Mar 2012 10:40:14 +0900
Subject: [PATCH v3] USB: ehci-s5p: add DMA burst support
Message-ID: <006101ccfa70$e94e5d90$bbeb18b0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA burst support is added to improve performance in EHCI data
transfer. The USB EHCI controller on Exynos SoCs can use INCR16,
INCR8, and INCR4 mode. These modes of INSNREG00 register should
be set in order to enable DMA burst transfer. This feature is
also related to AHB spec.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Sangwook Lee <sangwook.lee@linaro.org>
---
v3: move the register definitions to ehci-s5p.c
v2: change the definition name from EHCI_ENA_xxx to EHCI_INSNREG00_ENA_xxx.

 drivers/usb/host/ehci-s5p.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-s5p.c b/drivers/usb/host/ehci-s5p.c
index 293f741..f098e2a 100644
--- a/drivers/usb/host/ehci-s5p.c
+++ b/drivers/usb/host/ehci-s5p.c
@@ -17,6 +17,15 @@
 #include <plat/ehci.h>
 #include <plat/usb-phy.h>
 
+#define EHCI_INSNREG00(base)			(base + 0x90)
+#define EHCI_INSNREG00_ENA_INCR16		(0x1 << 25)
+#define EHCI_INSNREG00_ENA_INCR8		(0x1 << 24)
+#define EHCI_INSNREG00_ENA_INCR4		(0x1 << 23)
+#define EHCI_INSNREG00_ENA_INCRX_ALIGN		(0x1 << 22)
+#define EHCI_INSNREG00_ENABLE_DMA_BURST	\
+	(EHCI_INSNREG00_ENA_INCR16 | EHCI_INSNREG00_ENA_INCR8 |	\
+	 EHCI_INSNREG00_ENA_INCR4 | EHCI_INSNREG00_ENA_INCRX_ALIGN)
+
 struct s5p_ehci_hcd {
 	struct device *dev;
 	struct usb_hcd *hcd;
@@ -128,6 +137,9 @@ static int __devinit s5p_ehci_probe(struct platform_device *pdev)
 	ehci->regs = hcd->regs +
 		HC_LENGTH(ehci, readl(&ehci->caps->hc_capbase));
 
+	/* DMA burst Enable */
+	writel(EHCI_INSNREG00_ENABLE_DMA_BURST, EHCI_INSNREG00(hcd->regs));
+
 	dbg_hcs_params(ehci, "reset");
 	dbg_hcc_params(ehci, "reset");
 
@@ -234,6 +246,9 @@ static int s5p_ehci_resume(struct device *dev)
 	if (pdata && pdata->phy_init)
 		pdata->phy_init(pdev, S5P_USB_PHY_HOST);
 
+	/* DMA burst Enable */
+	writel(EHCI_INSNREG00_ENABLE_DMA_BURST, EHCI_INSNREG00(hcd->regs));
+
 	if (time_before(jiffies, ehci->next_statechange))
 		msleep(100);
 
-- 
1.7.1
