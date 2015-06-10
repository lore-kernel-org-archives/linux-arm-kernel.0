From: haibo.chen@freescale.com (Haibo Chen)
Date: Wed, 10 Jun 2015 16:50:43 +0800
Subject: [PATCH 5/6] mmc: sdhci-esdhc-imx: set back the burst_length_enable
 bit to 1
In-Reply-To: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
References: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
Message-ID: <1433926244-29244-6-git-send-email-haibo.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we find that if a usdhc is choosed to boot system, then ROM
code will set the burst length enable bit of this usdhc as 0.

This will make performance drop a lot if this usdhc's burst length is
16. So this patch set back the burst_length_enable bit as 1, which is
the default value, and means burst length is enabled for INCR.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 1f0e0d9..e6a1995 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -32,6 +32,7 @@
 #include "sdhci-esdhc.h"
 
 #define	ESDHC_CTRL_D3CD			0x08
+#define ESDHC_BURST_LEN_EN_INCR		(1 << 27)
 /* VENDOR SPEC register */
 #define ESDHC_VENDOR_SPEC		0xc0
 #define  ESDHC_VENDOR_SPEC_SDIO_QUIRK	(1 << 1)
@@ -1088,6 +1089,16 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
+		/*
+		 * ROM code will change the burst_length_enable setting to
+		 * zero if this usdhc is choosed to boot system. Change it
+		 * back here, otherwise it will impact the performance a
+		 * lot if the burst length is 16.
+		 */
+		writel(readl(host->ioaddr + SDHCI_HOST_CONTROL)
+			| ESDHC_BURST_LEN_EN_INCR,
+			host->ioaddr + SDHCI_HOST_CONTROL);
+
 		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
 			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
 
-- 
1.9.1
