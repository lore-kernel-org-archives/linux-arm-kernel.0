From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Tue, 23 Jun 2015 16:09:22 +0200
Subject: [PATCH 4/9] drivers: clk: st: Fix FSYN channel values
In-Reply-To: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1435068567-30995-5-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the value for disabling the FSYN channel clock.
The 'is_enabled' returned value is also fixed.

Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 drivers/clk/st/clkgen-fsyn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index e7e6782..9e26099 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -489,7 +489,7 @@ static int quadfs_pll_is_enabled(struct clk_hw *hw)
 	struct st_clk_quadfs_pll *pll = to_quadfs_pll(hw);
 	u32 npda = CLKGEN_READ(pll, npda);
 
-	return !!npda;
+	return pll->data->powerup_polarity ? !npda : !!npda;
 }
 
 static int clk_fs660c32_vco_get_rate(unsigned long input, struct stm_fs *fs,
@@ -774,7 +774,7 @@ static void quadfs_fsynth_disable(struct clk_hw *hw)
 	if (fs->lock)
 		spin_lock_irqsave(fs->lock, flags);
 
-	CLKGEN_WRITE(fs, nsb[fs->chan], !fs->data->standby_polarity);
+	CLKGEN_WRITE(fs, nsb[fs->chan], fs->data->standby_polarity);
 
 	if (fs->lock)
 		spin_unlock_irqrestore(fs->lock, flags);
-- 
1.9.1
