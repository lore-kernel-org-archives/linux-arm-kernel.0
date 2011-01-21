From: prakity@marvell.com (Philip Rakity)
Date: Fri, 21 Jan 2011 11:24:54 -0800
Subject: [PATCH] sdhci: remove support for quirks in sdhci-pxa.c -- not used
Message-ID: <84414D02-98FC-417B-A03B-8F76CC5717AE@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


remove support for platform specific SD quirks. They are
not used today.

New method coming in future patch using platform specific
files in mmc/host

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |    2 --
 drivers/mmc/host/sdhci-pxa.c           |    3 ---
 2 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/include/plat/sdhci.h
index bd6ac06..3f73f1f 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -23,12 +23,10 @@
 /*
  * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
  * @max_speed: the maximum speed supported
- * @quirks: quirks of specific device
  * @flags: flags for platform requirement
  */
 struct sdhci_pxa_platdata {
 	unsigned int	max_speed;
-	unsigned int	quirks;
 	unsigned int	flags;
 	unsigned short	adjust_clocks;
 	unsigned short	clk_select;
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 8c60d5c..ed044a8 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -121,9 +121,6 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
 	host->irq = irq;
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
-	if (pdata->quirks)
-		host->quirks |= pdata->quirks;
-
 	/* If slot design supports 8 bit data, indicate this to MMC. */
 	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
-- 
1.7.0.4
