From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 30 Dec 2016 15:24:33 +0000
Subject: [PATCH 2/2] mmc: sdhci-iproc: Increase max_blk_size for bcm2835
In-Reply-To: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com>
References: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1483111474-29907-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the BCM2835 datasheet the maximum block size for the
eMMC module is restricted to the internal data FIFO which is 1024 byte.
But this is still an improvement to the default of 512 byte.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/sdhci-iproc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 30b3fdf..3275d49 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -218,7 +218,9 @@ static void sdhci_iproc_writeb(struct sdhci_host *host, u8 val, int reg)
 
 static const struct sdhci_iproc_data bcm2835_data = {
 	.pdata = &sdhci_bcm2835_pltfm_data,
-	.caps = SDHCI_CAN_VDD_330 |
+	.caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
+			& SDHCI_MAX_BLOCK_MASK) |
+		SDHCI_CAN_VDD_330 |
 		SDHCI_CAN_DO_HISPD,
 	.caps1 = SDHCI_DRIVER_TYPE_A |
 		 SDHCI_DRIVER_TYPE_C,
-- 
1.7.9.5
