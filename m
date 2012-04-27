From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 27 Apr 2012 10:15:20 +0530
Subject: [PATCH V3 4/8] SPEAr: clk: Add Auxiliary Synthesizer clock
In-Reply-To: <73afd5e86c8311a04c5d2d21419e3eaa45eafec4.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <73afd5e86c8311a04c5d2d21419e3eaa45eafec4.1335249846.git.viresh.kumar@st.com>
Message-ID: <4F9A2460.50607@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2012 12:20 PM, Viresh KUMAR wrote:
> All SPEAr SoC's contain Auxiliary Synthesizers. Their Fout is derived based on
> values of eq, x and y.
> 
> Fout from synthesizer can be given from two equations:
> Fout1 = (Fin * X/Y)/2		EQ1
> Fout2 = Fin * X/Y		EQ2
> 
> This patch adds in support for this type of clock.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

    fixup! SPEAr: clk: Add Auxiliary Synthesizer clock
---
 drivers/clk/spear/clk-aux-synth.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/spear/clk-aux-synth.c b/drivers/clk/spear/clk-aux-synth.c
index e01a350..c199e78 100644
--- a/drivers/clk/spear/clk-aux-synth.c
+++ b/drivers/clk/spear/clk-aux-synth.c
@@ -56,10 +56,11 @@ static long clk_aux_round_rate(struct clk_hw *hw, unsigned long drate,
                unsigned long *prate)
 {
        struct clk_aux *aux = to_clk_aux(hw);
+       unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
        int unused;
 
-       return clk_round_rate_index(hw, drate, aux_calc_rate, aux->rtbl_cnt,
-                       &unused);
+       return clk_round_rate_index(hw, drate, parent_rate, aux_calc_rate,
+                       aux->rtbl_cnt, &unused);
 }
 
 static unsigned long clk_aux_recalc_rate(struct clk_hw *hw,
@@ -96,14 +97,16 @@ static unsigned long clk_aux_recalc_rate(struct clk_hw *hw,
 }
 
 /* Configures new clock rate of aux */
-static int clk_aux_set_rate(struct clk_hw *hw, unsigned long drate)
+static int clk_aux_set_rate(struct clk_hw *hw, unsigned long drate,
+                               unsigned long prate)
 {
        struct clk_aux *aux = to_clk_aux(hw);
        struct aux_rate_tbl *rtbl = aux->rtbl;
        unsigned long val, flags = 0;
        int i;
 
-       clk_round_rate_index(hw, drate, aux_calc_rate, aux->rtbl_cnt, &i);
+       clk_round_rate_index(hw, drate, prate, aux_calc_rate, aux->rtbl_cnt,
+                       &i);
 
        if (aux->lock)
                spin_lock_irqsave(aux->lock, flags);

-- 
viresh
