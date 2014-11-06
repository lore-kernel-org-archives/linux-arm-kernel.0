From: balbi@ti.com (Felipe Balbi)
Date: Thu, 6 Nov 2014 11:36:05 -0600
Subject: [PATCH 1/2] usb: dwc3: core: enable phy suspend quirk on non-FPGA
Message-ID: <1415295366-593-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as it turns out, at least AM437x silicon (non-FPGA)
needs to enable PHY suspend quirk. So let's allow
for PHY suspend quirk to be used with non-FPGA
builds too.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/dwc3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8ae42b8..25ddc39 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -404,7 +404,7 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->tx_de_emphasis_quirk)
 		reg |= DWC3_GUSB3PIPECTL_TX_DEEPH(dwc->tx_de_emphasis);
 
-	if (dwc->dis_u3_susphy_quirk && dwc->is_fpga)
+	if (dwc->dis_u3_susphy_quirk)
 		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
 
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
@@ -422,7 +422,7 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->revision > DWC3_REVISION_194A)
 		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
 
-	if (dwc->dis_u2_susphy_quirk && dwc->is_fpga)
+	if (dwc->dis_u2_susphy_quirk)
 		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-- 
2.1.0.GIT
