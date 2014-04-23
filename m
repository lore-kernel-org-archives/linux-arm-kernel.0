From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 23 Apr 2014 20:07:57 +0100
Subject: [PATCH 21/38] mmc: sdhci: hack up driver to make it more compliant
 with UHS-1
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Message-ID: <E1Wd2WT-0003vg-Ke@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch suggested by Dong Aisheng <dongas86@gmail.com>, this avoids
additional clock start/stop cycles during the transition to 1.8V
signalling mode.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 748333ba6e96..0bcef2d42da4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1507,12 +1507,6 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 			host->ops->set_clock(host, host->clock);
 		}
 
-
-		/* Reset SD Clock Enable */
-		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-		clk &= ~SDHCI_CLOCK_CARD_EN;
-		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-
 		if (host->ops->set_uhs_signaling)
 			host->ops->set_uhs_signaling(host, ios->timing);
 		else {
@@ -1546,9 +1540,6 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 			ios->drv_type = (preset & SDHCI_PRESET_DRV_MASK)
 				>> SDHCI_PRESET_DRV_SHIFT;
 		}
-
-		/* Re-enable SD Clock */
-		host->ops->set_clock(host, host->clock);
 	} else
 		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
@@ -1757,9 +1748,6 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 		ctrl |= SDHCI_CTRL_VDD_180;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
-		/* Wait for 5ms */
-		usleep_range(5000, 5500);
-
 		/* 1.8V regulator output should be stable within 5 ms */
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		if (ctrl & SDHCI_CTRL_VDD_180)
-- 
1.8.3.1
