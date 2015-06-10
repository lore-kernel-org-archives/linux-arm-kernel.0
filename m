From: haibo.chen@freescale.com (Haibo Chen)
Date: Wed, 10 Jun 2015 16:50:42 +0800
Subject: [PATCH 4/6] mmc: sdhci-esdhc-imx: config watermater levles and burst
 lengths
In-Reply-To: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
References: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
Message-ID: <1433926244-29244-5-git-send-email-haibo.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX7D support eMMC HS400 mode, this mode can run in 8 bit,200MHZ
DDR mode. So the I/O speed improve a lot compare to SD3.0

The default burst length is 8, if we don't change this value, in
HS400 mode, when we do eMMC read operation, we can find that the
clock signal will stop for a period of time. This means the speed
of data moving on AHB bus is slower than I/O speed. So we should
improve the speed of data moving on AHB bus.

For imx7d usdhc, this patch set the burst length as 16, and set
watermater levle as 64. The test result is the clock signal has
no stop during the eMMC HS400 operation. For other imx usdhc, remain
the default value: burst length as 8, watermater level as 16.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index f7ec66e..1f0e0d9 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -239,6 +239,11 @@ static inline int is_imx6q_usdhc(struct pltfm_imx_data *data)
 	return data->socdata == &usdhc_imx6q_data;
 }
 
+static inline int is_imx7d_usdhc(struct pltfm_imx_data *data)
+{
+	return data->socdata == &usdhc_imx7d_data;
+}
+
 static inline int esdhc_is_usdhc(struct pltfm_imx_data *data)
 {
 	return !!(data->socdata->flags & ESDHC_FLAG_USDHC);
@@ -1075,7 +1080,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	 * to something insane.  Change it back here.
 	 */
 	if (esdhc_is_usdhc(imx_data)) {
-		writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
+		if (is_imx7d_usdhc(imx_data))
+			writel(0x10401040, host->ioaddr + ESDHC_WTMK_LVL);
+		else
+			writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
+
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
-- 
1.9.1
