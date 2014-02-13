From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 13 Feb 2014 11:29:46 -0700
Subject: [PATCH] PCI: imx6: Fix link_up detection
In-Reply-To: <201402120836.16221.marex@denx.de>
References: <1392190075-23204-1-git-send-email-s.hauer@pengutronix.de>
 <201402120836.16221.marex@denx.de>
Message-ID: <52FD0F1A.4000208@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/12/2014 12:36 AM, Marek Vasut wrote:
> On Wednesday, February 12, 2014 at 08:27:55 AM, Sascha Hauer wrote:
>
> +CC Troy Kisky, since I think he submitted something similar some time ago
> already.
>
> Otherwise I agree this happens.
>
Sorry, I haven't submitted this yet, but was planning to today. Here's
what would have been sent.

 From 32c560d33fe2c3945d69f3396689f0abb76f7e1f Mon Sep 17 00:00:00 2001
From: Marek Vasut <marex@denx.de>
Date: Sat, 25 Jan 2014 14:22:48 -0700
Subject: [PATCH 1/1] pci-imx6.c: wait for retraining

This patch handles the case where the PCIe link is up and running, yet drops
into the LTSSM training mode. The link spends short time in the LTSSM training
mode, but the current code can misinterpret it as the link being stalled.
Waiting for the LTSSM training to complete fixes the issue.

Signed-off-by: Marek Vasut <marex@denx.de>
Tested-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
  drivers/pci/host/pci-imx6.c | 47 ++++++++++++++++++++++++++++++++-------------
  1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index e8663a8..ee08250 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -424,20 +424,40 @@ static void imx6_pcie_reset_phy(struct pcie_port *pp)
  
  static int imx6_pcie_link_up(struct pcie_port *pp)
  {
-	u32 rc, ltssm, rx_valid;
+	u32 rc, debug_r0, rx_valid;
+	int count = 5;
  
  	/*
-	 * Test if the PHY reports that the link is up and also that
-	 * the link training finished.  It might happen that the PHY
-	 * reports the link is already up, but the link training bit
-	 * is still set, so make sure to check the training is done
-	 * as well here.
+	 * Test if the PHY reports that the link is up and also that the LTSSM
+	 * training finished. There are three possible states of the link when
+	 * this code is called:
+	 * 1) The link is DOWN (unlikely)
+	 *     The link didn't come up yet for some reason. This usually means
+	 *     we have a real problem somewhere. Reset the PHY and exit. This
+	 *     state calls for inspection of the DEBUG registers.
+	 * 2) The link is UP, but still in LTSSM training
+	 *     Wait for the training to finish, which should take a very short
+	 *     time. If the training does not finish, we have a problem and we
+	 *     need to inspect the DEBUG registers. If the training does finish,
+	 *     the link is up and operating correctly.
+	 * 3) The link is UP and no longer in LTSSM training
+	 *     The link is up and operating correctly.
  	 */
-	rc = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
-	if ((rc & PCIE_PHY_DEBUG_R1_XMLH_LINK_UP) &&
-	    !(rc & PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING))
-		return 1;
-
+	while (1) {
+		rc = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
+		if (!(rc & PCIE_PHY_DEBUG_R1_XMLH_LINK_UP))
+			break;
+		if (!(rc & PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING))
+			return 1;
+		if (!count--)
+			break;
+		dev_dbg(pp->dev, "Link is up, but still in training\n");
+		/*
+		 * Wait a little bit, then re-check if the link finished
+		 * the training.
+		 */
+		usleep_range(1000, 2000);
+	}
  	/*
  	 * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
  	 * Wait 2ms (LTSSM timeout is 24ms, PHY lock is ~5us in gen2).
@@ -446,15 +466,16 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
  	 * to gen2 is stuck
  	 */
  	pcie_phy_read(pp->dbi_base, PCIE_PHY_RX_ASIC_OUT, &rx_valid);
-	ltssm = readl(pp->dbi_base + PCIE_PHY_DEBUG_R0) & 0x3F;
+	debug_r0 = readl(pp->dbi_base + PCIE_PHY_DEBUG_R0);
  
  	if (rx_valid & 0x01)
  		return 0;
  
-	if (ltssm != 0x0d)
+	if ((debug_r0 & 0x3f) != 0x0d)
  		return 0;
  
  	dev_err(pp->dev, "transition to gen2 is stuck, reset PHY!\n");
+	dev_dbg(pp->dev, "debug_r0=%08x debug_r1=%08x\n", debug_r0, rc);
  
  	imx6_pcie_reset_phy(pp);
  
-- 
1.8.1.2
