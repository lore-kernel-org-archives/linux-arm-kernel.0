From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 May 2012 11:17:25 +0530
Subject: [PATCH V3 3/8] SPEAr: clk: Add VCO-PLL Synthesizer clock
In-Reply-To: <bc76d68ff5c11be5750c6e65ce5c4b94bb9f7382.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <bc76d68ff5c11be5750c6e65ce5c4b94bb9f7382.1335249846.git.viresh.kumar@st.com>
Message-ID: <4FA21BED.50700@st.com>
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
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Another fixup:

---
 drivers/clk/spear/clk-vco-pll.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/spear/clk-vco-pll.c b/drivers/clk/spear/clk-vco-pll.c
index e661273..318b04e 100644
--- a/drivers/clk/spear/clk-vco-pll.c
+++ b/drivers/clk/spear/clk-vco-pll.c
@@ -183,10 +183,9 @@ static long clk_vco_round_rate(struct clk_hw *hw, unsigned long drate,
                unsigned long *prate)
 {
        struct clk_vco *vco = to_clk_vco(hw);
-       unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
        int unused;
 
-       return clk_round_rate_index(hw, drate, parent_rate, vco_calc_rate,
+       return clk_round_rate_index(hw, drate, *prate, vco_calc_rate,
                        vco->rtbl_cnt, &unused);
 }
 
-- 
viresh
