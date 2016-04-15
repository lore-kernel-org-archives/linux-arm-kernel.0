From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sat, 16 Apr 2016 01:29:43 +0800
Subject: [PATCH 19/23] mmc: sdhci-esdhc-imx: enable hw auto retuning for
 MAN_TUNING
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1460741387-23815-20-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Indicating hw auto retuning support for mx6qdl in the fake caps_1
register and enable auto retuning in post_tuning process after
tuning completes.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a582a83..07b1144 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -301,7 +301,8 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 				/* imx6q/dl does not have cap_1 register, fake one */
 				val = SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_SDR104
 					| SDHCI_SUPPORT_SDR50
-					| SDHCI_USE_SDR50_TUNING;
+					| SDHCI_USE_SDR50_TUNING
+					| (SDHCI_TUNING_MODE_3 << SDHCI_RETUNING_MODE_SHIFT);
 
 			if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
 				val |= SDHCI_SUPPORT_HS400;
@@ -471,10 +472,13 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
 		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
 			new_val = readl(host->ioaddr + ESDHC_MIX_CTRL);
-			if (val & SDHCI_CTRL_TUNED_CLK)
+			if (val & SDHCI_CTRL_TUNED_CLK) {
 				new_val |= ESDHC_MIX_CTRL_SMPCLK_SEL;
-			else
+				new_val |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
+			} else {
 				new_val &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
+				new_val &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
+			}
 			writel(new_val , host->ioaddr + ESDHC_MIX_CTRL);
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
 			u32 v = readl(host->ioaddr + SDHCI_ACMD12_ERR);
@@ -760,6 +764,7 @@ static void esdhc_post_tuning(struct sdhci_host *host)
 
 	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
 	reg &= ~ESDHC_MIX_CTRL_EXE_TUNE;
+	reg |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
 	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
 }
 
-- 
1.9.1
