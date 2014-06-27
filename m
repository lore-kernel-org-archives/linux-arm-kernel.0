From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Fri, 27 Jun 2014 15:25:05 +0200
Subject: [PATCH v2 08/14] drivers: clk: st: Add polarity bit indication
In-Reply-To: <1403875511-7710-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1403875511-7710-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1403875511-7710-9-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces polarity indication for pll power up bit
and for standby bit in order to have same code between stih416
and stih407 boards.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Acked-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/clk/st/clkgen-fsyn.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index a7e5db4..43936b6 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -67,6 +67,8 @@ struct clkgen_quadfs_data {
 	bool reset_present;
 	bool bwfilter_present;
 	bool lockstatus_present;
+	bool powerup_polarity;
+	bool standby_polarity;
 	bool nsdiv_present;
 	struct clkgen_field ndiv;
 	struct clkgen_field ref_bw;
@@ -308,7 +310,7 @@ static int quadfs_pll_enable(struct clk_hw *hw)
 	/*
 	 * Power up the PLL
 	 */
-	CLKGEN_WRITE(pll, npda, 1);
+	CLKGEN_WRITE(pll, npda, !pll->data->powerup_polarity);
 
 	if (pll->lock)
 		spin_unlock_irqrestore(pll->lock, flags);
@@ -335,7 +337,7 @@ static void quadfs_pll_disable(struct clk_hw *hw)
 	 * Powerdown the PLL and then put block into soft reset if we have
 	 * reset control.
 	 */
-	CLKGEN_WRITE(pll, npda, 0);
+	CLKGEN_WRITE(pll, npda, pll->data->powerup_polarity);
 
 	if (pll->data->reset_present)
 		CLKGEN_WRITE(pll, nreset, 0);
@@ -611,7 +613,7 @@ static int quadfs_fsynth_enable(struct clk_hw *hw)
 	if (fs->lock)
 		spin_lock_irqsave(fs->lock, flags);
 
-	CLKGEN_WRITE(fs, nsb[fs->chan], 1);
+	CLKGEN_WRITE(fs, nsb[fs->chan], !fs->data->standby_polarity);
 
 	if (fs->lock)
 		spin_unlock_irqrestore(fs->lock, flags);
@@ -631,7 +633,7 @@ static void quadfs_fsynth_disable(struct clk_hw *hw)
 	if (fs->lock)
 		spin_lock_irqsave(fs->lock, flags);
 
-	CLKGEN_WRITE(fs, nsb[fs->chan], 0);
+	CLKGEN_WRITE(fs, nsb[fs->chan], !fs->data->standby_polarity);
 
 	if (fs->lock)
 		spin_unlock_irqrestore(fs->lock, flags);
@@ -645,7 +647,7 @@ static int quadfs_fsynth_is_enabled(struct clk_hw *hw)
 	pr_debug("%s: %s enable bit = 0x%x\n",
 		 __func__, __clk_get_name(hw->clk), nsb);
 
-	return !!nsb;
+	return fs->data->standby_polarity ? !nsb : !!nsb;
 }
 
 #define P15			(uint64_t)(1 << 15)
-- 
1.9.1
