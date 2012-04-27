From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 27 Apr 2012 10:15:48 +0530
Subject: [PATCH V3 5/8] SPEAr: clk: Add Fractional Synthesizer clock
In-Reply-To: <0362a8aa32b249be3139b74c688e0a79e0548061.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <0362a8aa32b249be3139b74c688e0a79e0548061.1335249846.git.viresh.kumar@st.com>
Message-ID: <4F9A247C.8070902@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2012 12:20 PM, Viresh KUMAR wrote:
> All SPEAr SoC's contain Fractional Synthesizers. Their Fout is derived from
> following equations:
> 
> Fout = Fin / (2 * div) (division factor)
> div is 17 bits:-
>      0-13 (fractional part)
>      14-16 (integer part)
>      div is (16-14 bits).(13-0 bits) (in binary)
> 
>      Fout = Fin/(2 * div)
>      Fout = ((Fin / 10000)/(2 * div)) * 10000
>      Fout = (2^14 * (Fin / 10000)/(2^14 * (2 * div))) * 10000
>      Fout = (((Fin / 10000) << 14)/(2 * (div << 14))) * 10000
> 
> div << 14 is simply 17 bit value written@register.
> 
> This patch adds in support for this type of clock.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

    fixup! SPEAr: clk: Add Fractional Synthesizer clock
---
 drivers/clk/spear/clk-frac-synth.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/spear/clk-frac-synth.c b/drivers/clk/spear/clk-frac-synth.c
index c6ccdab..b2090f8 100644
--- a/drivers/clk/spear/clk-frac-synth.c
+++ b/drivers/clk/spear/clk-frac-synth.c
@@ -59,10 +59,11 @@ static long clk_frac_round_rate(struct clk_hw *hw, unsigned long drate,
                unsigned long *prate)
 {
        struct clk_frac *frac = to_clk_frac(hw);
+       unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
        int unused;
 
-       return clk_round_rate_index(hw, drate, frac_calc_rate, frac->rtbl_cnt,
-                       &unused);
+       return clk_round_rate_index(hw, drate, parent_rate, frac_calc_rate,
+                       frac->rtbl_cnt, &unused);
 }
 
 static unsigned long clk_frac_recalc_rate(struct clk_hw *hw,
@@ -92,14 +93,16 @@ static unsigned long clk_frac_recalc_rate(struct clk_hw *hw,
 }
 
 /* Configures new clock rate of frac */
-static int clk_frac_set_rate(struct clk_hw *hw, unsigned long drate)
+static int clk_frac_set_rate(struct clk_hw *hw, unsigned long drate,
+                               unsigned long prate)
 {
        struct clk_frac *frac = to_clk_frac(hw);
        struct frac_rate_tbl *rtbl = frac->rtbl;
        unsigned long flags = 0, val;
        int i;
 
-       clk_round_rate_index(hw, drate, frac_calc_rate, frac->rtbl_cnt, &i);
+       clk_round_rate_index(hw, drate, prate, frac_calc_rate, frac->rtbl_cnt,
+                       &i);
 
        if (frac->lock)
                spin_lock_irqsave(frac->lock, flags);

-- 
viresh
