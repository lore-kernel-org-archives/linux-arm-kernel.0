From: tpiepho@impinj.com (Trent Piepho)
Date: Mon, 5 Nov 2018 18:11:36 +0000
Subject: [PATCH v3] PCI: imx6: Check for link training status in link up check
Message-ID: <20181105181117.23230-1-tpiepho@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eliminate imx6_pcie_link_up() so that the default handler,
dw_pcie_link_up(), is used instead.  The default handler has the correct
code, which checks for link up and also not still training.

This bug was fixed some time ago, but the fix was lost in the merge
commit 562df5c8521e ("Merge branch 'pci/host-designware' into next").

This was due to the interaction for two commits on either branch of the
merge.  Commit 4d107d3b5a68 ("PCI: imx6: Move link up check into
imx6_pcie_wait_for_link()"), changed imx6_pcie_wait_for_link() to poll
the link status register directly, checking for link up and not
training, and made imx6_pcie_link_up() only check the link up bit (once,
not a polling loop).

While commit commit 886bc5ceb5cc ("PCI: designware: Add generic
dw_pcie_wait_for_link()"), replaced the loop in
imx6_pcie_wait_for_link() with a call to a new dwc core function, which
polled imx6_pcie_link_up(), which still checked both link up and not
training in a loop.

When these two commits were merged, the version of
imx6_pcie_wait_for_link() from '886 was kept, which eliminated the link
training check placed there by '4d1.  But the version of
imx6_pcie_link_up() from '4d1 was kept, which eliminated the link
training check that had been there and was moved to
imx6_pcie_wait_for_link().

And the result was the link training check got lost for the imx6 driver.

Fixes: 562df5c8521e ("Merge branch 'pci/host-designware' into next")
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4a9a673b4777..975050a69494 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -80,8 +80,6 @@ struct imx6_pcie {
 #define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
 #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
-#define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
-#define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP		(1 << 4)
 
 #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
 #define PCIE_PHY_CTRL_DATA_LOC 0
@@ -641,12 +639,6 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static int imx6_pcie_link_up(struct dw_pcie *pci)
-{
-	return dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1) &
-			PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
-}
-
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
 };
@@ -679,7 +671,7 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 }
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-	.link_up = imx6_pcie_link_up,
+	/* No special ops needed, but pcie-designware still expects this struct */
 };
 
 static int imx6_pcie_probe(struct platform_device *pdev)
-- 
2.14.4
