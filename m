From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 May 2012 11:16:53 +0530
Subject: [PATCH V3 5/8] SPEAr: clk: Add Fractional Synthesizer clock
In-Reply-To: <0362a8aa32b249be3139b74c688e0a79e0548061.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <0362a8aa32b249be3139b74c688e0a79e0548061.1335249846.git.viresh.kumar@st.com>
Message-ID: <4FA21BCD.8070406@st.com>
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

Another fixup:

---
 drivers/clk/spear/clk-frac-synth.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/spear/clk-frac-synth.c b/drivers/clk/spear/clk-frac-synth.c
index b2090f8..9915dbc 100644
--- a/drivers/clk/spear/clk-frac-synth.c
+++ b/drivers/clk/spear/clk-frac-synth.c
@@ -59,10 +59,9 @@ static long clk_frac_round_rate(struct clk_hw *hw, unsigned long drate,
                unsigned long *prate)
 {
        struct clk_frac *frac = to_clk_frac(hw);
-       unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
        int unused;
 
-       return clk_round_rate_index(hw, drate, parent_rate, frac_calc_rate,
+       return clk_round_rate_index(hw, drate, *prate, frac_calc_rate,
                        frac->rtbl_cnt, &unused);
 }
 
-- 
viresh
