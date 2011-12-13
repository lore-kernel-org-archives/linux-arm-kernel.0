From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 13 Dec 2011 23:48:04 +0800
Subject: [PATCH 2/4] mmc: mxs-mmc: fix the dma_transfer_direction migration
In-Reply-To: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1323791286-29574-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 05f5799 (mmc-host: move to dma_transfer_direction) left out
the DMA_NONE, in turn breaks the driver as below.

[    0.650000] mxs-mmc mxs-mmc.0: initialized
[    0.650000] mxs-mmc mxs-mmc.1: initialized
[    0.690000] mxs-dma mxs-dma-apbh: maximum bytes for sg entry exceeded: -55906
7475 > 65280
[    0.690000] mxs-mmc mxs-mmc.0: mxs_mmc_ac: failed to prep dma

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/mxs-mmc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 571c9ff..93c18aa 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -357,6 +357,7 @@ static void mxs_mmc_bc(struct mxs_mmc_host *host)
 	host->ssp_pio_words[1] = cmd0;
 	host->ssp_pio_words[2] = cmd1;
 	host->dma_dir = DMA_NONE;
+	host->slave_dirn = DMA_TRANS_NONE;
 	desc = mxs_mmc_prep_dma(host, 0);
 	if (!desc)
 		goto out;
@@ -396,6 +397,7 @@ static void mxs_mmc_ac(struct mxs_mmc_host *host)
 	host->ssp_pio_words[1] = cmd0;
 	host->ssp_pio_words[2] = cmd1;
 	host->dma_dir = DMA_NONE;
+	host->slave_dirn = DMA_TRANS_NONE;
 	desc = mxs_mmc_prep_dma(host, 0);
 	if (!desc)
 		goto out;
@@ -514,6 +516,7 @@ static void mxs_mmc_adtc(struct mxs_mmc_host *host)
 	host->ssp_pio_words[1] = cmd0;
 	host->ssp_pio_words[2] = cmd1;
 	host->dma_dir = DMA_NONE;
+	host->slave_dirn = DMA_TRANS_NONE;
 	desc = mxs_mmc_prep_dma(host, 0);
 	if (!desc)
 		goto out;
-- 
1.7.4.1
