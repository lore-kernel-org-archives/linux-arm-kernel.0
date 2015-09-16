From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Wed, 16 Sep 2015 14:41:37 +0800
Subject: [RFC PATCH v8 02/10] mmc: dw_mmc: use macro for HCON register
 operations
In-Reply-To: <1442385625-26775-1-git-send-email-shawn.lin@rock-chips.com>
References: <1442385625-26775-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1442385697-28036-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add some macros for HCON register operations
to make code more readable.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 6 +++---
 drivers/mmc/host/dw_mmc.h | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 5d7a8729..100f56e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2674,7 +2674,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
 		* Check ADDR_CONFIG bit in HCON to find
 		* IDMAC address bus width
 		*/
-		addr_config = (mci_readl(host, HCON) >> 27) & 0x01;
+		addr_config = SDMMC_GET_ADDR_CONFIG(mci_readl(host, HCON));
 
 		if (addr_config == 1) {
 			/* host supports IDMAC in 64-bit address mode */
@@ -3051,7 +3051,7 @@ int dw_mci_probe(struct dw_mci *host)
 	 * Get the host data width - this assumes that HCON has been set with
 	 * the correct values.
 	 */
-	i = (mci_readl(host, HCON) >> 7) & 0x7;
+	i = SDMMC_GET_HDATA_WIDTH(mci_readl(host, HCON));
 	if (!i) {
 		host->push_data = dw_mci_push_data16;
 		host->pull_data = dw_mci_pull_data16;
@@ -3133,7 +3133,7 @@ int dw_mci_probe(struct dw_mci *host)
 	if (host->pdata->num_slots)
 		host->num_slots = host->pdata->num_slots;
 	else
-		host->num_slots = ((mci_readl(host, HCON) >> 1) & 0x1F) + 1;
+		host->num_slots = SDMMC_GET_SLOT_NUM(mci_readl(host, HCON));
 
 	/*
 	 * Enable interrupts for command done, data over, data empty,
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 811d467..f2a88d4 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -154,6 +154,9 @@
 #define DMA_INTERFACE_GDMA		(0x2)
 #define DMA_INTERFACE_NODMA		(0x3)
 #define SDMMC_GET_TRANS_MODE(x)		(((x)>>16) & 0x3)
+#define SDMMC_GET_SLOT_NUM(x)		((((x)>>1) & 0x1F) + 1)
+#define SDMMC_GET_HDATA_WIDTH(x)	(((x)>>7) & 0x7)
+#define SDMMC_GET_ADDR_CONFIG(x)	(((x)>>27) & 0x1)
 /* Internal DMAC interrupt defines */
 #define SDMMC_IDMAC_INT_AI		BIT(9)
 #define SDMMC_IDMAC_INT_NI		BIT(8)
-- 
2.3.7
