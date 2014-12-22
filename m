From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Mon, 22 Dec 2014 17:42:03 +0530
Subject: [PATCH v3 2/3] mmc: dw_mmc: exynos: don't use if clock isn't available
In-Reply-To: <1419250324-11743-1-git-send-email-alim.akhtar@samsung.com>
References: <1419250324-11743-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <1419250324-11743-3-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Seungwon Jeon <tgih.jun@samsung.com>

Add checking whether the clock is valid.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 509365c..556663f 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -127,9 +127,9 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
 static int dw_mci_exynos_setup_clock(struct dw_mci *host)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
-	unsigned long rate = clk_get_rate(host->ciu_clk);
 
-	host->bus_hz = rate / (priv->ciu_div + 1);
+	host->bus_hz /= (priv->ciu_div + 1);
+
 	return 0;
 }
 
@@ -232,8 +232,11 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 			mci_writel(host, CLKSEL, priv->sdr_timing);
 	}
 
-	/* Don't care if wanted clock is zero */
-	if (!wanted)
+	/*
+	 * Don't care if wanted clock is zero or
+	 * ciu clock is unavailable
+	 */
+	if (!wanted || IS_ERR(host->ciu_clk))
 		return;
 
 	/* Guaranteed minimum frequency for cclkin */
-- 
1.7.9.5
