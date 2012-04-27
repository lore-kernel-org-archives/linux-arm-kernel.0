From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 27 Apr 2012 10:14:46 +0530
Subject: [PATCH V3 3/8] SPEAr: clk: Add VCO-PLL Synthesizer clock
In-Reply-To: <bc76d68ff5c11be5750c6e65ce5c4b94bb9f7382.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <bc76d68ff5c11be5750c6e65ce5c4b94bb9f7382.1335249846.git.viresh.kumar@st.com>
Message-ID: <4F9A243E.9070505@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2012 12:20 PM, Viresh KUMAR wrote:
> All SPEAr SoC's contain PLLs. Their Fout is derived based on following equations
> 
> - In normal mode
>   vco = (2 * M[15:8] * Fin)/N
> 
> - In Dithered mode
>   vco = (2 * M[15:0] * Fin)/(256 * N)
> 
> pll_rate = vco/2^p
> 
> vco and pll are very closely bound to each other,
> "vco needs to program: mode, m & n" and "pll needs to program p",
> both share common enable/disable logic and registers.
> 
> This patch adds in support for this type of clock.

    fixup! SPEAr: clk: Add VCO-PLL Synthesizer clock
---
 drivers/clk/spear/clk-vco-pll.c |   14 +++++++++-----
 drivers/clk/spear/clk.c         |    4 ++--
 drivers/clk/spear/clk.h         |    3 ++-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/spear/clk-vco-pll.c b/drivers/clk/spear/clk-vco-pll.c
index 9efa30d..e661273 100644
--- a/drivers/clk/spear/clk-vco-pll.c
+++ b/drivers/clk/spear/clk-vco-pll.c
@@ -141,7 +141,8 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw, unsigned long
        return parent_rate / (1 << p);
 }
 
-static int clk_pll_set_rate(struct clk_hw *hw, unsigned long drate)
+static int clk_pll_set_rate(struct clk_hw *hw, unsigned long drate,
+                               unsigned long prate)
 {
        struct clk_pll *pll = to_clk_pll(hw);
        struct pll_rate_tbl *rtbl = pll->vco->rtbl;
@@ -182,10 +183,11 @@ static long clk_vco_round_rate(struct clk_hw *hw, unsigned long drate,
                unsigned long *prate)
 {
        struct clk_vco *vco = to_clk_vco(hw);
+       unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
        int unused;
 
-       return clk_round_rate_index(hw, drate, vco_calc_rate, vco->rtbl_cnt,
-                       &unused);
+       return clk_round_rate_index(hw, drate, parent_rate, vco_calc_rate,
+                       vco->rtbl_cnt, &unused);
 }
 
 static unsigned long clk_vco_recalc_rate(struct clk_hw *hw,
@@ -226,14 +228,16 @@ static unsigned long clk_vco_recalc_rate(struct clk_hw *hw,
 }
 
 /* Configures new clock rate of vco */
-static int clk_vco_set_rate(struct clk_hw *hw, unsigned long drate)
+static int clk_vco_set_rate(struct clk_hw *hw, unsigned long drate,
+                               unsigned long prate)
 {
        struct clk_vco *vco = to_clk_vco(hw);
        struct pll_rate_tbl *rtbl = vco->rtbl;
        unsigned long flags = 0, val;
        int i;
 
-       clk_round_rate_index(hw, drate, vco_calc_rate, vco->rtbl_cnt, &i);
+       clk_round_rate_index(hw, drate, prate, vco_calc_rate, vco->rtbl_cnt,
+                       &i);
 
        if (vco->lock)
                spin_lock_irqsave(vco->lock, flags);
diff --git a/drivers/clk/spear/clk.c b/drivers/clk/spear/clk.c
index 74f6acc..376d4e5 100644
--- a/drivers/clk/spear/clk.c
+++ b/drivers/clk/spear/clk.c
@@ -14,10 +14,10 @@
 #include "clk.h"
 
 long clk_round_rate_index(struct clk_hw *hw, unsigned long drate,
-               clk_calc_rate calc_rate, u8 rtbl_cnt, int *index)
+               unsigned long parent_rate, clk_calc_rate calc_rate, u8 rtbl_cnt,
+               int *index)
 {
        unsigned long prev_rate, rate = 0;
-       unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
 
        for (*index = 0; *index < rtbl_cnt; (*index)++) {
                prev_rate = rate;
diff --git a/drivers/clk/spear/clk.h b/drivers/clk/spear/clk.h
index ee17994..3321c46 100644
--- a/drivers/clk/spear/clk.h
+++ b/drivers/clk/spear/clk.h
@@ -128,6 +128,7 @@ struct clk *clk_register_vco_pll(const char *vco_name, const char *pll_name,
                struct clk **vco_gate_clk);
 
 long clk_round_rate_index(struct clk_hw *hw, unsigned long drate,
-               clk_calc_rate calc_rate, u8 rtbl_cnt, int *index);
+               unsigned long parent_rate, clk_calc_rate calc_rate, u8 rtbl_cnt,
+               int *index);
 
 #endif /* __SPEAR_CLK_H */


-- 
viresh
