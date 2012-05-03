From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 May 2012 15:21:18 +0530
Subject: [PATCH V3 5/8] SPEAr: clk: Add Fractional Synthesizer clock
In-Reply-To: <0362a8aa32b249be3139b74c688e0a79e0548061.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <0362a8aa32b249be3139b74c688e0a79e0548061.1335249846.git.viresh.kumar@st.com>
Message-ID: <4FA25516.5050903@st.com>
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
> ---

Sorry for another fixup. Required due to Saravana's patch:
---
 drivers/clk/spear/clk-frac-synth.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/spear/clk-frac-synth.c b/drivers/clk/spear/clk-frac-synth.c
index 9915dbc..4dbdb3f 100644
--- a/drivers/clk/spear/clk-frac-synth.c
+++ b/drivers/clk/spear/clk-frac-synth.c
@@ -126,6 +126,7 @@ struct clk *clk_register_frac(const char *name, const char *parent_name,
                unsigned long flags, void __iomem *reg,
                struct frac_rate_tbl *rtbl, u8 rtbl_cnt, spinlock_t *lock)
 {
+       struct clk_init_data init;
        struct clk_frac *frac;
        struct clk *clk;
 
@@ -145,9 +146,15 @@ struct clk *clk_register_frac(const char *name, const char *parent_name,
        frac->rtbl = rtbl;
        frac->rtbl_cnt = rtbl_cnt;
        frac->lock = lock;
+       frac->hw.init = &init;
 
-       clk = clk_register(NULL, name, &clk_frac_ops, &frac->hw, &parent_name,
-                       1, flags);
+       init.name = name;
+       init.ops = &clk_frac_ops;
+       init.flags = flags;
+       init.parent_names = &parent_name;
+       init.num_parents = 1;
+
+       clk = clk_register(NULL, &frac->hw);
        if (!IS_ERR_OR_NULL(clk))
                return clk;
 

-- 
viresh
