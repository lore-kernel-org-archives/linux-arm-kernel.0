From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 30 Dec 2016 15:24:32 +0000
Subject: [PATCH 1/2] mmc: sdhci-iproc: Apply caps from bcm2835-mmc driver
In-Reply-To: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com>
References: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1483111474-29907-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the mmc module on bcm2835 neither provide a capabilities register nor 
free documentation we must rely on the downstream implementation [1].

So enable the following capabilities for bcm2835:

MMC_CAP_MMC_HIGHSPEED
MMC_CAP_SD_HIGHSPEED
MMC_CAP_DRIVER_TYPE_A
MMC_CAP_DRIVER_TYPE_C

[1] - https://github.com/raspberrypi/linux/blob/rpi-4.4.y/drivers/mmc/host/bcm2835-mmc.c

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/sdhci-iproc.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index d7046d6..30b3fdf 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -211,14 +211,17 @@ static void sdhci_iproc_writeb(struct sdhci_host *host, u8 val, int reg)
 static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
 	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
-		  SDHCI_QUIRK_MISSING_CAPS,
+		  SDHCI_QUIRK_MISSING_CAPS |
+		  SDHCI_QUIRK_NO_HISPD_BIT,
 	.ops = &sdhci_iproc_32only_ops,
 };
 
 static const struct sdhci_iproc_data bcm2835_data = {
 	.pdata = &sdhci_bcm2835_pltfm_data,
-	.caps = SDHCI_CAN_VDD_330,
-	.caps1 = 0x00000000,
+	.caps = SDHCI_CAN_VDD_330 |
+		SDHCI_CAN_DO_HISPD,
+	.caps1 = SDHCI_DRIVER_TYPE_A |
+		 SDHCI_DRIVER_TYPE_C,
 	.mmc_caps = 0x00000000,
 };
 
-- 
1.7.9.5
