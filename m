From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 29 Feb 2012 23:44:22 +0900
Subject: [PATCH 2/2] USB: ehci-s5p: add DMA burst support
Message-ID: <000201ccf6f0$a0498b20$e0dca160$%han@samsung.com>
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
 drivers/usb/host/ehci-s5p.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-s5p.c b/drivers/usb/host/ehci-s5p.c
index 293f741..465861b 100644
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
+	writel(EHCI_ENABLE_DMA_INCR, EHCI_INSNREG00(hcd->regs));
+
 	dbg_hcs_params(ehci, "reset");
 	dbg_hcc_params(ehci, "reset");
 
@@ -234,6 +238,9 @@ static int s5p_ehci_resume(struct device *dev)
 	if (pdata && pdata->phy_init)
 		pdata->phy_init(pdev, S5P_USB_PHY_HOST);
 
+	/* DMA burst Enable */
+	writel(EHCI_ENABLE_DMA_INCR, EHCI_INSNREG00(hcd->regs));
+
 	if (time_before(jiffies, ehci->next_statechange))
 		msleep(100);
 
-- 
1.7.1
