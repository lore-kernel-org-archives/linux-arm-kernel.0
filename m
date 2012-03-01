From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 01 Mar 2012 14:40:03 +0900
Subject: [PATCH v2 2/2] USB: ehci-s5p: add DMA burst support
Message-ID: <000801ccf76d$c01e2a00$405a7e00$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA burst support is added to improve performance in EHCI data
transfer. The USB EHCI controller on Exynos SoCs can use INCR16,
INCR8, and INCR4 mode. These modes of INSNREG00 register should
be set in order to enable DMA burst transfer. This feature is
also related to AHB spec.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Cc: Sangwook Lee <sangwook.lee@linaro.org>
---
v2: change the definition name from EHCI_ENA_xxx to EHCI_INSNREG00_ENA_xxx.

drivers/usb/host/ehci-s5p.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-s5p.c b/drivers/usb/host/ehci-s5p.c
index 293f741..b337f72 100644
--- a/drivers/usb/host/ehci-s5p.c
+++ b/drivers/usb/host/ehci-s5p.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <plat/ehci.h>
 #include <plat/usb-phy.h>
+#include <mach/regs-usb-host.h>
 
 struct s5p_ehci_hcd {
 	struct device *dev;
@@ -128,6 +129,9 @@ static int __devinit s5p_ehci_probe(struct platform_device *pdev)
 	ehci->regs = hcd->regs +
 		HC_LENGTH(ehci, readl(&ehci->caps->hc_capbase));
 
+	/* DMA burst Enable */
+	writel(EHCI_INSNREG00_ENABLE_DMA_BURST, EHCI_INSNREG00(hcd->regs));
+
 	dbg_hcs_params(ehci, "reset");
 	dbg_hcc_params(ehci, "reset");
 
@@ -234,6 +238,9 @@ static int s5p_ehci_resume(struct device *dev)
 	if (pdata && pdata->phy_init)
 		pdata->phy_init(pdev, S5P_USB_PHY_HOST);
 
+	/* DMA burst Enable */
+	writel(EHCI_INSNREG00_ENABLE_DMA_BURST, EHCI_INSNREG00(hcd->regs));
+
 	if (time_before(jiffies, ehci->next_statechange))
 		msleep(100);
 
-- 
1.7.1
