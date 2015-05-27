From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 27 May 2015 18:13:26 +0800
Subject: [PATCH 1/6] mmc: sdhci-esdhc-imx: merge the same register check into
 one place
In-Reply-To: <1432721611-31214-1-git-send-email-aisheng.dong@freescale.com>
References: <1432721611-31214-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <1432721611-31214-2-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In esdhc_writel_le() function, there's duplicated checking of the same
register as follows:
"if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE))".
Merge them into one and remove the duplicated one.

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ef290a5..0c89293 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -313,6 +313,11 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 			data |= ESDHC_CTRL_D3CD;
 			writel(data, host->ioaddr + SDHCI_HOST_CONTROL);
 		}
+
+		if (val & SDHCI_INT_ADMA_ERROR) {
+			val &= ~SDHCI_INT_ADMA_ERROR;
+			val |= ESDHC_INT_VENDOR_SPEC_DMA_ERR;
+		}
 	}
 
 	if (unlikely((imx_data->socdata->flags & ESDHC_FLAG_MULTIBLK_NO_INT)
@@ -333,13 +338,6 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 			}
 	}
 
-	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)) {
-		if (val & SDHCI_INT_ADMA_ERROR) {
-			val &= ~SDHCI_INT_ADMA_ERROR;
-			val |= ESDHC_INT_VENDOR_SPEC_DMA_ERR;
-		}
-	}
-
 	writel(val, host->ioaddr + reg);
 }
 
-- 
1.9.1
