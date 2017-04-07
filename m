From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri,  7 Apr 2017 17:34:32 +0200
Subject: [PATCH v2 1/2] clk: meson: mpll: fix division by zero in
 rate_from_params
In-Reply-To: <20170407153433.18640-1-jbrunet@baylibre.com>
References: <20170407153433.18640-1-jbrunet@baylibre.com>
Message-ID: <20170407153433.18640-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

According to the public datasheet all register bits in HHI_MPLL_CNTL7,
HHI_MPLL_CNTL8 and HHI_MPLL_CNTL9 default to zero. On all GX SoCs these
seem to be initialized by the bootloader to some default value.
However, on my Meson8 board they are not initialized, leading to a
division by zero in rate_from_params as the math is:
(parent_rate * SDM_DEN) / ((SDM_DEN * 0) + 0)

According to the datasheet, the minimum n2 value is 4. The rate provided
by the clock when n2 is less than this minimum is unpredictable. In such
case, we report an error.

Although the rate_from_params function was only introduced recently the
original bug has been there for much longer. It was only exposed
recently when the MPLL clocks were added to the Meson8b clock driver.

Fixes: 1c50da4f27 ("clk: meson: add mpll support")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/clk-mpll.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
index 540dabe5adad..d9462b505dcc 100644
--- a/drivers/clk/meson/clk-mpll.c
+++ b/drivers/clk/meson/clk-mpll.c
@@ -65,18 +65,21 @@
 #include "clkc.h"
 
 #define SDM_DEN 16384
-#define SDM_MIN 1
-#define SDM_MAX 16383
 #define N2_MIN	4
 #define N2_MAX	511
 
 #define to_meson_clk_mpll(_hw) container_of(_hw, struct meson_clk_mpll, hw)
 
-static unsigned long rate_from_params(unsigned long parent_rate,
+static long rate_from_params(unsigned long parent_rate,
 				      unsigned long sdm,
 				      unsigned long n2)
 {
-	return (parent_rate * SDM_DEN) / ((SDM_DEN * n2) + sdm);
+	unsigned long divisor = (SDM_DEN * n2) + sdm;
+
+	if (n2 < N2_MIN)
+		return -EINVAL;
+
+	return (parent_rate * SDM_DEN) / divisor;
 }
 
 static void params_from_rate(unsigned long requested_rate,
@@ -89,17 +92,13 @@ static void params_from_rate(unsigned long requested_rate,
 
 	if (div < N2_MIN) {
 		*n2 = N2_MIN;
-		*sdm = SDM_MIN;
+		*sdm = 0;
 	} else if (div > N2_MAX) {
 		*n2 = N2_MAX;
-		*sdm = SDM_MAX;
+		*sdm = SDM_DEN - 1;
 	} else {
 		*n2 = div;
 		*sdm = DIV_ROUND_UP(rem * SDM_DEN, requested_rate);
-		if (*sdm < SDM_MIN)
-			*sdm = SDM_MIN;
-		else if (*sdm > SDM_MAX)
-			*sdm = SDM_MAX;
 	}
 }
 
@@ -109,6 +108,7 @@ static unsigned long mpll_recalc_rate(struct clk_hw *hw,
 	struct meson_clk_mpll *mpll = to_meson_clk_mpll(hw);
 	struct parm *p;
 	unsigned long reg, sdm, n2;
+	long rate;
 
 	p = &mpll->sdm;
 	reg = readl(mpll->base + p->reg_off);
@@ -118,7 +118,11 @@ static unsigned long mpll_recalc_rate(struct clk_hw *hw,
 	reg = readl(mpll->base + p->reg_off);
 	n2 = PARM_GET(p->width, p->shift, reg);
 
-	return rate_from_params(parent_rate, sdm, n2);
+	rate = rate_from_params(parent_rate, sdm, n2);
+	if (rate < 0)
+		return 0;
+
+	return rate;
 }
 
 static long mpll_round_rate(struct clk_hw *hw,
-- 
2.9.3
