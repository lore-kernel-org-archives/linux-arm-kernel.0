From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 May 2012 15:19:47 +0530
Subject: [PATCH V3 3/8] SPEAr: clk: Add VCO-PLL Synthesizer clock
In-Reply-To: <bc76d68ff5c11be5750c6e65ce5c4b94bb9f7382.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <bc76d68ff5c11be5750c6e65ce5c4b94bb9f7382.1335249846.git.viresh.kumar@st.com>
Message-ID: <4FA254BB.5050308@st.com>
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
> ---

Sorry for another fixup. Required due to Saravana's patch:

---
 drivers/clk/spear/clk-vco-pll.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/spear/clk-vco-pll.c b/drivers/clk/spear/clk-vco-pll.c
index 318b04e..dcd4bdf 100644
--- a/drivers/clk/spear/clk-vco-pll.c
+++ b/drivers/clk/spear/clk-vco-pll.c
@@ -282,6 +282,7 @@ struct clk *clk_register_vco_pll(const char *vco_name, const char *pll_name,
        struct clk_vco *vco;
        struct clk_pll *pll;
        struct clk *vco_clk, *tpll_clk, *tvco_gate_clk;
+       struct clk_init_data vco_init, pll_init;
        const char **vco_parent_name;
 
        if (!vco_name || !pll_name || !parent_name || !mode_reg || !cfg_reg ||
@@ -308,7 +309,10 @@ struct clk *clk_register_vco_pll(const char *vco_name, const char *pll_name,
        vco->rtbl = rtbl;
        vco->rtbl_cnt = rtbl_cnt;
        vco->lock = lock;
+       vco->hw.init = &vco_init;
+
        pll->vco = vco;
+       pll->hw.init = &pll_init;
 
        if (vco_gate_name) {
                tvco_gate_clk = clk_register_gate(NULL, vco_gate_name,
@@ -323,13 +327,23 @@ struct clk *clk_register_vco_pll(const char *vco_name, const char *pll_name,
                vco_parent_name = &parent_name;
        }
 
-       vco_clk = clk_register(NULL, vco_name, &clk_vco_ops, &vco->hw,
-                       vco_parent_name, 1, flags);
+       vco_init.name = vco_name;
+       vco_init.ops = &clk_vco_ops;
+       vco_init.flags = flags;
+       vco_init.parent_names = vco_parent_name;
+       vco_init.num_parents = 1;
+
+       pll_init.name = pll_name;
+       pll_init.ops = &clk_pll_ops;
+       pll_init.flags = CLK_SET_RATE_PARENT;
+       pll_init.parent_names = &vco_name;
+       pll_init.num_parents = 1;

-- 
viresh
