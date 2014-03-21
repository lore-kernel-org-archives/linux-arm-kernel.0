From: yuvaraj.cd@gmail.com (Yuvaraj Kumar C D)
Date: Fri, 21 Mar 2014 17:32:07 +0530
Subject: [PATCH] mmc: dw_mmc: Support setting the ciu-div on exynos
Message-ID: <1395403327-19713-1-git-send-email-yuvaraj.cd@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Doug Anderson <dianders@chromium.org>

The existing dw_mmc code for exynos5250/exynos5420 read the ciu-div
property from the device tree and used it in calculations, but didn't
actually ever set it in hardware.  That means that if the hardware
value set by the firmware didn't match what was in the device tree
that we'd be clocking things incorrectly.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 3423c5e..07392ac 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -28,6 +28,7 @@
 #define SDMMC_CLKSEL_CCLK_SAMPLE(x)	(((x) & 7) << 0)
 #define SDMMC_CLKSEL_CCLK_DRIVE(x)	(((x) & 7) << 16)
 #define SDMMC_CLKSEL_CCLK_DIVIDER(x)	(((x) & 7) << 24)
+#define SDMMC_CLKSEL_GET_SAMPLE(x)      (((x) >> 0) & 0x7)
 #define SDMMC_CLKSEL_GET_DRV_WD3(x)	(((x) >> 16) & 0x7)
 #define SDMMC_CLKSEL_TIMING(x, y, z)	(SDMMC_CLKSEL_CCLK_SAMPLE(x) |	\
 					SDMMC_CLKSEL_CCLK_DRIVE(y) |	\
@@ -118,6 +119,12 @@ static int dw_mci_exynos_setup_clock(struct dw_mci *host)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
 	unsigned long rate = clk_get_rate(host->ciu_clk);
+	u32 clksel = mci_readl(host, CLKSEL);
+
+	clksel = SDMMC_CLKSEL_TIMING(SDMMC_CLKSEL_GET_SAMPLE(clksel),
+				     SDMMC_CLKSEL_GET_DRV_WD3(clksel),
+				     priv->ciu_div);
+	mci_writel(host, CLKSEL, clksel);
 
 	host->bus_hz = rate / (priv->ciu_div + 1);
 	return 0;
-- 
1.7.10.4
