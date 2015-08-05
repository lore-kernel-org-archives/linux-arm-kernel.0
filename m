From: haibo.chen@freescale.com (Haibo Chen)
Date: Wed, 5 Aug 2015 18:38:42 +0800
Subject: [PATCH v4 6/6] mmc: sdhci-esdhc-imx: set back the burst_length_enable
 bit to 1
In-Reply-To: <1438771122-8601-1-git-send-email-haibo.chen@freescale.com>
References: <1438771122-8601-1-git-send-email-haibo.chen@freescale.com>
Message-ID: <1438771122-8601-7-git-send-email-haibo.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we find that if a usdhc is choosed to boot system, then ROM
code will set the burst length enable bit of this usdhc as 0.

This will make performance drop a lot if this usdhc's burst length is
configed. So this patch set back the burst_length_enable bit as 1,
which is the default value, and means burst length is enabled for INCR.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 97aa944..3334762 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -32,6 +32,7 @@
 #include "sdhci-esdhc.h"
 
 #define	ESDHC_CTRL_D3CD			0x08
+#define ESDHC_BURST_LEN_EN_INCR		(1 << 27)
 /* VENDOR SPEC register */
 #define ESDHC_VENDOR_SPEC		0xc0
 #define  ESDHC_VENDOR_SPEC_SDIO_QUIRK	(1 << 1)
@@ -1165,6 +1166,21 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
+		/*
+		 * ROM code will change the bit burst_length_enable setting
+		 * to zero if this usdhc is choosed to boot system. Change
+		 * it back here, otherwise it will impact the performance a
+		 * lot. This bit is used to enable/disable the burst length
+		 * for the external AHB2AXI bridge, it's usefully especially
+		 * for INCR transfer because without burst length indicator,
+		 * the AHB2AXI bridge does not know the burst length in
+		 * advance. And without burst length indicator, AHB INCR
+		 * transfer can only be converted to singles on the AXI side.
+		 */
+		writel(readl(host->ioaddr + SDHCI_HOST_CONTROL)
+			| ESDHC_BURST_LEN_EN_INCR,
+			host->ioaddr + SDHCI_HOST_CONTROL);
+
 		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
 			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
 
-- 
1.9.1
