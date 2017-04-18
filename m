From: petr.cvek@tul.cz (Petr Cvek)
Date: Wed, 19 Apr 2017 01:16:26 +0200
Subject: [PATCH 1/4] mmc: pxamci: Use the right flags for DMA callback init
In-Reply-To: <cover.1492492523.git.petr.cvek@tul.cz>
References: <cover.1492492523.git.petr.cvek@tul.cz>
Message-ID: <fbc663e3-4de5-7370-afa8-0f8747f50ca7@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMC_DATA_READ and the MMC_DATA_WRITE flags for the mmc request are not
mutually exclusive (two different bits). Change the callback initialization
code to use the proper one.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 drivers/mmc/host/pxamci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index c763b404510f..80bc8065b50f 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -235,7 +235,7 @@ static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
 		return;
 	}
 
-	if (!(data->flags & MMC_DATA_READ)) {
+	if (data->flags & MMC_DATA_WRITE) {
 		tx->callback = pxamci_dma_irq;
 		tx->callback_param = host;
 	}
-- 
2.11.0
