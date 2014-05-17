From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 17 May 2014 20:46:01 +0800
Subject: [PATCH] ahci: imx: PLL clock needs 100us to settle down
Message-ID: <1400330761-2432-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit e783c51 (ahci: imx: software workaround for phy reset issue
in resume) calls imx_sata_phy_reset() to reset phy immediately after
SATA MPLL is enabled.  It seems working fine mostly, but fails in some
case as below.

...
ahci-imx 2200000.sata: failed to reset phy: -110
ahci-imx: probe of 2200000.sata failed with error -110

After talking to the designer, we learnt that when enabling i.MX6Q SATA
MPLL, we need to wait 100us for it to settle down for safety.  Add this
required delay to fix above failure.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Tejun,

Sorry for that I did not catch it when I was working on the phy reset
issue in the first place.  I used to test the driver with a 32GiB and
64GiB SanDisk SSDs, and did not run into this issue.  But it gets
exposed on a 8GiB SSD I got to play recently.

Shawn

 drivers/ata/ahci_imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 5824d99..8befeb6 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -258,6 +258,8 @@ static int imx_sata_enable(struct ahci_host_priv *hpriv)
 				   IMX6Q_GPR13_SATA_MPLL_CLK_EN,
 				   IMX6Q_GPR13_SATA_MPLL_CLK_EN);
 
+		usleep_range(100, 200);
+
 		ret = imx_sata_phy_reset(hpriv);
 		if (ret) {
 			dev_err(dev, "failed to reset phy: %d\n", ret);
-- 
1.8.3.2
