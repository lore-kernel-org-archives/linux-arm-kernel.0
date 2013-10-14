From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 14 Oct 2013 16:23:40 +0800
Subject: [PATCH 1/5] mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_NO_DMAS_BITS
In-Reply-To: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
References: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1381739024-24924-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like the use of the flag ESDHC_FLAG_MULTIBLK_NO_INT, let's add
another flag ESDHC_FLAG_NO_DMAS_BITS to tell the quirk that PROCTL
register has no DMAS bits, and set it for i.MX25 ESDHC.

While at it, let's use BIT() macro for ESDHC_FLAG_MULTIBLK_NO_INT as
well.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b9899e9..e046917 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -73,6 +73,11 @@
 #define ESDHC_INT_VENDOR_SPEC_DMA_ERR	(1 << 28)
 
 /*
+ * There is no DMAS bits in PROCTL register, e.g. the ESDHC on i.MX25 gets
+ * DMAS bits PROCTL[9:8] as reserved.
+ */
+#define ESDHC_FLAG_NO_DMAS_BITS		BIT(0)
+/*
  * The CMDTYPE of the CMD register (offset 0xE) should be set to
  * "11" when the STOP CMD12 is issued on imx53 to abort one
  * open ended multi-blk IO. Otherwise the TC INT wouldn't
@@ -83,7 +88,7 @@
  * As a result, the TC flag is not asserted and SW  received timeout
  * exeception. Bit1 of Vendor Spec registor is used to fix it.
  */
-#define ESDHC_FLAG_MULTIBLK_NO_INT	(1 << 1)
+#define ESDHC_FLAG_MULTIBLK_NO_INT	BIT(1)
 
 enum imx_esdhc_type {
 	IMX25_ESDHC,
@@ -433,7 +438,7 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 		/* ensure the endianness */
 		new_val |= ESDHC_HOST_CONTROL_LE;
 		/* bits 8&9 are reserved on mx25 */
-		if (!is_imx25_esdhc(imx_data)) {
+		if (!(imx_data->flags & ESDHC_FLAG_NO_DMAS_BITS)) {
 			/* DMA mode bits are shifted */
 			new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
 		}
@@ -857,6 +862,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	imx_data->devtype = pdev->id_entry->driver_data;
 	pltfm_host->priv = imx_data;
 
+	if (is_imx25_esdhc(imx_data))
+		imx_data->flags |= ESDHC_FLAG_NO_DMAS_BITS;
+
 	imx_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx_data->clk_ipg)) {
 		err = PTR_ERR(imx_data->clk_ipg);
-- 
1.7.9.5
