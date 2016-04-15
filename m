From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sat, 16 Apr 2016 01:29:37 +0800
Subject: [PATCH 13/23] mmc: sdhci-esdhc-imx: restore watermark level setting
 after resume
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1460741387-23815-14-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we config the watermark_level register only in probe.
This will cause the mmc write operation timeout issue after system
resume back in LPSR mode. Because in LPSR mode, after system resume
back, the watermark_level register(0x44) changes to 0x08000880, which
set the write watermark level as 0, and set the read watermark level
as 128. This value is incorrect.

This patch restores the setting of watermark level register after
system resume back.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6fef6bc..4c28fbb 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1261,6 +1261,11 @@ static int sdhci_esdhc_suspend(struct device *dev)
 
 static int sdhci_esdhc_resume(struct device *dev)
 {
+	struct sdhci_host *host = dev_get_drvdata(dev);
+
+	/* restore watermark setting in case it's lost in low power mode */
+	writel(0x10401040, host->ioaddr + ESDHC_WTMK_LVL);
+
 	return sdhci_pltfm_resume(dev);
 }
 
-- 
1.9.1
