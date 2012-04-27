From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 27 Apr 2012 10:16:17 +0530
Subject: [PATCH V3 6/8] SPEAr: clk: Add General Purpose Timer Synthesizer
 clock
In-Reply-To: <91fe5296600bd8ca55f9b7e0a1fd32e1a072f817.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <91fe5296600bd8ca55f9b7e0a1fd32e1a072f817.1335249846.git.viresh.kumar@st.com>
Message-ID: <4F9A2499.6090705@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2012 12:20 PM, Viresh KUMAR wrote:
> All SPEAr SoC's contain GPT Synthesizers. Their Fout is derived from
> following equations:
> 
> Fout= Fin/((2 ^ (N+1)) * (M+1))
> 
> This patch adds in support for this type of clock.

    fixup! SPEAr: clk: Add General Purpose Timer Synthesizer clock
---
 drivers/clk/spear/clk-gpt-synth.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/spear/clk-gpt-synth.c b/drivers/clk/spear/clk-gpt-synth.c
index 514539c..f3b252a 100644
--- a/drivers/clk/spear/clk-gpt-synth.c
+++ b/drivers/clk/spear/clk-gpt-synth.c
@@ -46,10 +46,11 @@ static long clk_gpt_round_rate(struct clk_hw *hw, unsigned long drate,
                unsigned long *prate)
 {
        struct clk_gpt *gpt = to_clk_gpt(hw);
+       unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
        int unused;
 
-       return clk_round_rate_index(hw, drate, gpt_calc_rate, gpt->rtbl_cnt,
-                       &unused);
+       return clk_round_rate_index(hw, drate, parent_rate, gpt_calc_rate,
+                       gpt->rtbl_cnt, &unused);
 }
 
 static unsigned long clk_gpt_recalc_rate(struct clk_hw *hw,
@@ -77,14 +78,16 @@ static unsigned long clk_gpt_recalc_rate(struct clk_hw *hw,
 }
 
 /* Configures new clock rate of gpt */
-static int clk_gpt_set_rate(struct clk_hw *hw, unsigned long drate)
+static int clk_gpt_set_rate(struct clk_hw *hw, unsigned long drate,
+                               unsigned long prate)
 {
        struct clk_gpt *gpt = to_clk_gpt(hw);
        struct gpt_rate_tbl *rtbl = gpt->rtbl;
        unsigned long flags = 0, val;
        int i;
 
-       clk_round_rate_index(hw, drate, gpt_calc_rate, gpt->rtbl_cnt, &i);
+       clk_round_rate_index(hw, drate, prate, gpt_calc_rate, gpt->rtbl_cnt,
+                       &i);
 
        if (gpt->lock)
                spin_lock_irqsave(gpt->lock, flags);

-- 
viresh
