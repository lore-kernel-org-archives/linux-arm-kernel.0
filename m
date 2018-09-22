From: linux.amoon@gmail.com (Anand Moon)
Date: Sat, 22 Sep 2018 07:57:32 +0000
Subject: [PATCHv4 6/6] mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing
 for USH-I mode
In-Reply-To: <20180922075732.946-1-linux.amoon@gmail.com>
References: <20180922075732.946-1-linux.amoon@gmail.com>
Message-ID: <20180922075732.946-2-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add tuning for sdr and ddr timing for USH-I mode sdr104/sdr50/ddr50
for host controller.

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
No changes from previous patch
---
 drivers/mmc/host/dw_mmc-exynos.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index ab47b018716a..d46c3439b508 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -253,6 +253,8 @@ static void dw_mci_exynos_config_hs400(struct dw_mci *host, u32 timing)
 	if (timing == MMC_TIMING_MMC_HS400) {
 		dqs |= DATA_STROBE_EN;
 		strobe = DQS_CTRL_RD_DELAY(strobe, priv->dqs_delay);
+	} else if (timing == MMC_TIMING_UHS_SDR104) {
+		dqs &= 0xffffff00;
 	} else {
 		dqs &= ~DATA_STROBE_EN;
 	}
@@ -312,6 +314,15 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 		if (ios->bus_width == MMC_BUS_WIDTH_8)
 			wanted <<= 1;
 		break;
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_UHS_SDR50:
+		clksel = (priv->sdr_timing & 0xfff8ffff) |
+			(priv->ciu_div << 16);
+		break;
+	case MMC_TIMING_UHS_DDR50:
+		clksel = (priv->ddr_timing & 0xfff8ffff) |
+			(priv->ciu_div << 16);
+		break;
 	default:
 		clksel = priv->sdr_timing;
 	}
-- 
2.17.1
