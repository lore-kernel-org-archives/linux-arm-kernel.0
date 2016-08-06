From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat,  6 Aug 2016 12:55:40 +0000
Subject: [PATCH RFC 3/3] mmc: mxs-mmc: Implement DDR support
In-Reply-To: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1470488140-10104-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements driver support for 3.3V DDR eMMCs.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/mxs-mmc.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index d839147..84019d5 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -71,6 +71,7 @@ struct mxs_mmc_host {
 	spinlock_t			lock;
 	int				sdio_irq_en;
 	bool				broken_cd;
+	bool				is_ddr;
 };
 
 static int mxs_mmc_get_cd(struct mmc_host *mmc)
@@ -411,6 +412,9 @@ static void mxs_mmc_adtc(struct mxs_mmc_host *host)
 		cmd0 |= BF_SSP(log2_blksz, CMD0_BLOCK_SIZE) |
 			BF_SSP(blocks - 1, CMD0_BLOCK_COUNT);
 	} else {
+		if (host->is_ddr)
+			cmd0 |= BM_SSP_CMD0_DBL_DATA_RATE_EN;
+
 		writel(data_size, ssp->base + HW_SSP_XFER_SIZE);
 		writel(BF_SSP(log2_blksz, BLOCK_SIZE_BLOCK_SIZE) |
 		       BF_SSP(blocks - 1, BLOCK_SIZE_BLOCK_COUNT),
@@ -499,6 +503,7 @@ static void mxs_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct mxs_mmc_host *host = mmc_priv(mmc);
+	struct mxs_ssp *ssp = &host->ssp;
 
 	if (ios->bus_width == MMC_BUS_WIDTH_8)
 		host->bus_width = 2;
@@ -509,6 +514,23 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (ios->clock)
 		mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
+
+	if (ssp_is_old(ssp))
+		return;
+
+	if (ios->timing == MMC_TIMING_MMC_DDR52) {
+		/*
+		 * ENGR00133481-1: In DDR mode the host send the data at
+		 * negative edge and the MMC receive the data at positive edge.
+		 */
+		host->is_ddr = true;
+		writel(BM_SSP_CTRL1_POLARITY, ssp->base +
+			HW_SSP_CTRL1(ssp) + STMP_OFFSET_REG_CLR);
+	} else {
+		host->is_ddr = false;
+		writel(BM_SSP_CTRL1_POLARITY, ssp->base + HW_SSP_CTRL1(ssp) +
+		       STMP_OFFSET_REG_SET);
+	}
 }
 
 static void mxs_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
-- 
1.7.9.5
