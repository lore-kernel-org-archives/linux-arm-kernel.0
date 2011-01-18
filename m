From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 18 Jan 2011 10:04:04 -0800
Subject: [PATCH] drivers: mmc: msm: update to new arm pfn_to_dma API
Message-ID: <1295373844-27713-1-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The page_to_dma() API call was removed. It caused this build
failure,

linux-2.6/drivers/mmc/host/msm_sdcc.c: In function 'msmsdcc_config_dma':
linux-2.6/drivers/mmc/host/msm_sdcc.c:391: error: implicit declaration of function 'page_to_dma'

This updates to the new usage which is pfn_to_dma().

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 drivers/mmc/host/msm_sdcc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index a5c7049..a46b9a8 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -388,8 +388,9 @@ static int msmsdcc_config_dma(struct msmsdcc_host *host, struct mmc_data *data)
 		box->cmd = CMD_MODE_BOX;
 
 	/* Initialize sg dma address */
-	sg->dma_address = page_to_dma(mmc_dev(host->mmc), sg_page(sg))
-				+ sg->offset;
+	sg->dma_address = pfn_to_dma(mmc_dev(host->mmc),
+				     page_to_pfn(sg_page(sg)))
+				     + sg->offset;
 
 	if (i == (host->dma.num_ents - 1))
 			box->cmd |= CMD_LC;
-- 
1.7.0.4

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
