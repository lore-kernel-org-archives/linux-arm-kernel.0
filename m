From: yinbo.zhu@nxp.com (yinbo.zhu at nxp.com)
Date: Mon, 30 Oct 2017 15:58:52 +0800
Subject: [PATCH] mmc: sdhci-of-esdhc: fix eMMC couldn't work after kexec
Message-ID: <20171030075852.7695-1-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "yinbo.zhu" <yinbo.zhu@nxp.com>

The bit TB_EN in tuning block control register
(TBCTL) is not reset by software reset for all.
So must clear it before initialize eSDHC again.

Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc.h    | 1 +
 drivers/mmc/host/sdhci-of-esdhc.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index 98898a309a36..800ffb3794ef 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -59,6 +59,7 @@
 /* Tuning Block Control Register */
 #define ESDHC_TBCTL			0x120
 #define ESDHC_TB_EN			0x00000004
+#define ESDHC_TB_DIS			(0x1 << 2)
 
 /* Control Register for DMA transfer */
 #define ESDHC_DMA_SYSCTL		0x40c
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 4b0f375bdfd8..77ac9dee32a2 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -784,6 +784,9 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
 	pltfm_host = sdhci_priv(host);
 	esdhc = sdhci_pltfm_priv(pltfm_host);
 
+	val = sdhci_readl(host, ESDHC_TBCTL);
+	val &= ~ESDHC_TB_DIS;
+	sdhci_writel(host, val, ESDHC_TBCTL);
 	host_ver = sdhci_readw(host, SDHCI_HOST_VERSION);
 	esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
 			     SDHCI_VENDOR_VER_SHIFT;
-- 
2.14.1
