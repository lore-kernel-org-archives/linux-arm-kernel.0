From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Thu, 26 Jan 2017 22:50:25 +0100
Subject: [PATCH 2/3] mmc: meson-gx: minor improvements in meson_mmc_set_ios
Message-ID: <4ec4f0af-c5c9-955c-6158-8c38aa61b358@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

val isn't used in the switch clause and afterwards there's an
identical statement. So remove it.

In case of an unexpected bus width the error message indicates
the intention to set the bus width to 4 and to go on.
So remove the return statement. This return statement also
conflicts with "setting to 4" because nothing would be set
actually before returning.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index cf071756..41c54e02 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -379,7 +379,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	meson_mmc_clk_set(host, ios->clock);
 
 	/* Bus width */
-	val = readl(host->regs + SD_EMMC_CFG);
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_1:
 		bus_width = CFG_BUS_WIDTH_1;
@@ -394,7 +393,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		dev_err(host->dev, "Invalid ios->bus_width: %u.  Setting to 4.\n",
 			ios->bus_width);
 		bus_width = CFG_BUS_WIDTH_4;
-		return;
 	}
 
 	val = readl(host->regs + SD_EMMC_CFG);
-- 
2.11.0
