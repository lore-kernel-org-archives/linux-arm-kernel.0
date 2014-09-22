From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 22 Sep 2014 17:12:04 +0800
Subject: [PATCH v2 1/8] mmc: sdhci-esdhc-imx: remove duplicated lines
In-Reply-To: <1411377131-19741-1-git-send-email-b29396@freescale.com>
References: <1411377131-19741-1-git-send-email-b29396@freescale.com>
Message-ID: <1411377131-19741-2-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is already the same register check above, no need the later one.
Move them into one place and delete the later one.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 587ee0e..256c901 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -315,6 +315,11 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
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
@@ -335,13 +340,6 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
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
1.7.8
