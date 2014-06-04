From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Jun 2014 17:32:47 +0200
Subject: [PATCH] clk: st: avoid build warnings
Message-ID: <10904360.yBfDy9q35b@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver prints some variables in debugging output when
their contents are undefined.

drivers/clk/st/clkgen-fsyn.c: In function 'quadfs_pll_fs660c32_round_rate':
drivers/clk/st/clkgen-fsyn.c:419:93: warning: 'params.sdiv' may be used uninitialized in this function [-Wmaybe-uninitialized]
  pr_debug("%s: %s new rate %ld [sdiv=0x%x,md=0x%x,pe=0x%x,nsdiv3=%u]\n",
                                                                                             ^
drivers/clk/st/clkgen-fsyn.c:414:16: note: 'params.sdiv' was declared here
  struct stm_fs params;
                ^

This removes them from the output.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index 4f53ee0..1d2ecfe 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -416,12 +416,6 @@ static long quadfs_pll_fs660c32_round_rate(struct clk_hw *hw, unsigned long rate
 	if (!clk_fs660c32_vco_get_params(*prate, rate, &params))
 		clk_fs660c32_vco_get_rate(*prate, &params, &rate);
 
-	pr_debug("%s: %s new rate %ld [sdiv=0x%x,md=0x%x,pe=0x%x,nsdiv3=%u]\n",
-		 __func__, __clk_get_name(hw->clk),
-		 rate, (unsigned int)params.sdiv,
-		 (unsigned int)params.mdiv,
-		 (unsigned int)params.pe, (unsigned int)params.nsdiv);
-
 	return rate;
 }
 
@@ -439,9 +433,8 @@ static int quadfs_pll_fs660c32_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!clk_fs660c32_vco_get_params(parent_rate, rate, &params))
 		clk_fs660c32_vco_get_rate(parent_rate, &params, &hwrate);
 
-	pr_debug("%s: %s new rate %ld [ndiv=0x%x]\n",
-		 __func__, __clk_get_name(hw->clk),
-		 hwrate, (unsigned int)params.ndiv);
+	pr_debug("%s: %s new rate %ld\n",
+		 __func__, __clk_get_name(hw->clk), hwrate);
 
 	if (!hwrate)
 		return -EINVAL;
