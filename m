From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 11 Aug 2015 08:41:32 +0000
Subject: [PATCH 1/2] mmc: core: enable CMD19 tuning for DDR50 mode
Message-ID: <1439282492-6274-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Weijun Yang <york.yang@csr.com>

As SD Specifications Part1 Physical Layer Specification Version
3.01 says, CMD19 tuning is available for unlocked cards in transfer
state of 1.8V signaling mode. The small difference between v3.00
and 3.01 spec means that CMD19 tuning is also available for DDR50
mode.

Signed-off-by: Weijun Yang <york.yang@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/mmc/core/sd.c    | 1 +
 drivers/mmc/host/sdhci.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 4e7366a..a1ed24d 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -629,6 +629,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 	 */
 	if (!mmc_host_is_spi(card->host) &&
 	    (card->sd_bus_speed == UHS_SDR50_BUS_SPEED ||
+	     card->sd_bus_speed == UHS_DDR50_BUS_SPEED ||
 	     card->sd_bus_speed == UHS_SDR104_BUS_SPEED))
 		err = mmc_execute_tuning(card);
 out:
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1dbe932..812c19b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1891,6 +1891,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		break;
 
 	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_UHS_DDR50:
 		break;
 
 	case MMC_TIMING_UHS_SDR50:
-- 
1.9.1
