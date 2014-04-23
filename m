From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 23 Apr 2014 20:07:11 +0100
Subject: [PATCH 12/38] mmc: sdhci: avoid sync'ing the SG if there's no
 misalignment
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Message-ID: <E1Wd2Vj-0003v5-Hh@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On read, we don't need to sync the whole scatterlist and then check
whether any segments need copying - if we check first, we avoid
potentially expensive cache handling.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7e2f24ac579b..078bf43b4aae 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -602,6 +602,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 	u8 *align;
 	char *buffer;
 	unsigned long flags;
+	bool has_unaligned;
 
 	if (data->flags & MMC_DATA_READ)
 		direction = DMA_FROM_DEVICE;
@@ -614,7 +615,15 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 	dma_unmap_single(mmc_dev(host->mmc), host->align_addr,
 		128 * 4, direction);
 
-	if (data->flags & MMC_DATA_READ) {
+	/* Do a quick scan of the SG list for any unaligned mappings */
+	has_unaligned = false;
+	for_each_sg(data->sg, sg, host->sg_count, i)
+		if (sg_dma_address(sg) & 3) {
+			has_unaligned = true;
+			break;
+		}
+
+	if (has_unaligned && data->flags & MMC_DATA_READ) {
 		dma_sync_sg_for_cpu(mmc_dev(host->mmc), data->sg,
 			data->sg_len, direction);
 
-- 
1.8.3.1
