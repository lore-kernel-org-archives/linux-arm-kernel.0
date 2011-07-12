From: richard.zhu@linaro.org (Richard Zhu)
Date: Tue, 12 Jul 2011 18:13:29 +0800
Subject: [PATCH V3] mmc: Enable the ADMA2 on esdhc imx driver
Message-ID: <1310465609-4516-1-git-send-email-richard.zhu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eanble the ADMA2 mode on freescale esdhc imx driver,
tested on MX25, MX51 and MX53.

Only ADMA2 mode is enabled, MX25/35 can't support the ADMA2 mode.
So this patch is only used to enable the ADMA2 for MX51/53 platforms.

The ADMA2 mode supported or not can be distinguished by the
bit20 of Capability Register(offset 0x40) and bit9-8 of
HOST PROTOCOL Register(offset 0x28) in FSL eSDHC module.

BTW:Here are the definition of the Bit9~8 DMAS of HOST PROTOCOL
Reg(offset 0x28). The bit9 couldn't be set to 1 when the SOC can't
support ADMA2. This bit is used to make a double check that the ADMA2
is supported or not in this patch, since the bit20 of Capability Reg
is broken on SOCs.
DMAS definitions:
00: No DMA or Simple DMA is selected
01: ADMA1 is selected
10: ADMA2 is selected
11: reserved

Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   45 ++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a19967d..46092c7 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -31,6 +31,14 @@
 #define SDHCI_VENDOR_SPEC		0xC0
 #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
 
+/*
+ * There is INT DMA ERR mis-match between eSDHC and STD SDHC SPEC
+ * Bit25 is used in STD SPEC, and is reserved in fsl eSDHC design,
+ * but bit28 is used as the INT DMA ERR in fsl eSDHC design.
+ * Define this macro DMA error INT for fsl eSDHC
+ */
+#define  SDHCI_INT_VENDOR_SPEC_DMA_ERR	0x10000000
+
 #define ESDHC_FLAG_GPIO_FOR_CD_WP	(1 << 0)
 /*
  * The CMDTYPE of the CMD register (offset 0xE) should be set to
@@ -62,6 +70,7 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	u32 dma_mode;
 
 	/* fake CARD_PRESENT flag on mx25/35 */
 	u32 val = readl(host->ioaddr + reg);
@@ -80,6 +89,30 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 			val |= SDHCI_CARD_PRESENT;
 	}
 
+	if (unlikely(reg == SDHCI_CAPABILITIES)) {
+		/* In FSL esdhc IC module, only bit20 is used to indicate the
+		 * ADMA2 capability of esdhc, but this bit is messed up on some
+		 * SOCs (e.x MX25, this bit is set, but it can't support the
+		 * ADMA2 actually). So readout HOST_CONTROl register to make a
+		 * double check that the ADMA2 is supported or not.
+		 */
+		dma_mode = readl(host->ioaddr + SDHCI_HOST_CONTROL) >> 5;
+		dma_mode &= SDHCI_CTRL_DMA_MASK;
+
+		if ((val & SDHCI_CAN_DO_ADMA1)
+				&& (dma_mode > SDHCI_CTRL_ADMA1)) {
+			val &= ~SDHCI_CAN_DO_ADMA1;
+			val |= SDHCI_CAN_DO_ADMA2;
+		}
+	}
+
+	if (unlikely(reg == SDHCI_INT_STATUS)) {
+		if (val & SDHCI_INT_VENDOR_SPEC_DMA_ERR) {
+			val &= ~SDHCI_INT_VENDOR_SPEC_DMA_ERR;
+			val |= SDHCI_INT_ADMA_ERROR;
+		}
+	}
+
 	return val;
 }
 
@@ -105,6 +138,13 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 			writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
 	}
 
+	if (unlikely((reg == SDHCI_INT_ENABLE)
+				|| (reg == SDHCI_SIGNAL_ENABLE))) {
+		if (val & SDHCI_INT_ADMA_ERROR) {
+			val &= ~SDHCI_INT_ADMA_ERROR;
+			val |= SDHCI_INT_VENDOR_SPEC_DMA_ERR;
+		}
+	}
 	writel(val, host->ioaddr + reg);
 }
 
@@ -322,9 +362,10 @@ static void esdhc_pltfm_exit(struct sdhci_host *host)
 }
 
 struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
-	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA
+	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_HISPD_BIT
+			| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
+			| SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC
 			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,
-	/* ADMA has issues. Might be fixable */
 	.ops = &sdhci_esdhc_ops,
 	.init = esdhc_pltfm_init,
 	.exit = esdhc_pltfm_exit,
-- 
1.7.1
