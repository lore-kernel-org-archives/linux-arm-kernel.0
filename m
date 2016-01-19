From: lakshmi.sai.krishna.potthuri@xilinx.com (P L Sai Krishna)
Date: Tue, 19 Jan 2016 19:47:33 +0530
Subject: [LINUX PATCH 3/5] mmc: host: Added DT support to use SDIO in standard
 speed.
In-Reply-To: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
Message-ID: <1453213055-35563-3-git-send-email-lakshmis@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the controller is used in High Speed Mode (Zynq-7000 data output on
rising edge of the clock) the hold time requirement for the
JEDEC/MMC 4.41 Specification is NOT met.
In Standard Speed Mode (Zynq-7000 data output on falling edge of the clock)
an extra half clock period is added to the clock to out delay meeting the
hold time requirement.
This patch adds device tree property 'broken-mmc-highspeed' to sdhci node
to force the controller to use in standard speed as a workaround.

Signed-off-by: Emil Lenchak <emill@xilinx.com>
Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 3 +++
 drivers/mmc/host/sdhci.c       | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 223c5eb..37df5cb 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -102,6 +102,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+	if (of_get_property(np, "broken-mmc-highspeed", NULL))
+		host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
+
 	of_property_read_u32(np, "clock-frequency", &pltfm_host->clock);
 
 	if (of_find_property(np, "keep-power-in-suspend", NULL))
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8b064cd..5cc07d6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3114,7 +3114,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
 		mmc->caps &= ~MMC_CAP_CMD23;
 
-	if (caps[0] & SDHCI_CAN_DO_HISPD)
+	if ((caps[0] & SDHCI_CAN_DO_HISPD) &&
+		!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
-- 
2.1.2
