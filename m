From: viresh.kumar@linaro.org (viresh kumar)
Date: Mon, 9 Jul 2012 12:04:07 +0100
Subject: [PATCH 5/6] Clk: SPEAr1340: fix sys clock parent source and
 corresponding mask value
In-Reply-To: <1341829866-26091-5-git-send-email-shiraz.hashim@st.com>
References: <1341829866-26091-1-git-send-email-shiraz.hashim@st.com>
 <1341829866-26091-5-git-send-email-shiraz.hashim@st.com>
Message-ID: <CAOh2x=n9dOaxW7hibg3M5XYTtbMkyrvUMt0ORKzWLULxUNtXEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 9, 2012 at 11:31 AM, Shiraz Hashim <shiraz.hashim@st.com> wrote:
> From: Vipul Kumar Samar <vipulkumar.samar@st.com>
>
> sys_clk have multiple parents and selection of parent is depends on

s/ is//

> sys_clk_ctrl register (bit no. 23:25) with possible values,
>
>    0XX: pll1_clk
>    10X: sys_synth_clk
>    110: pll2_clk
>    111: pll3_clk
>
> Update sys_clk parent array accordingly (ex. 0:3-pll1_clk) and
> fix mask value to 7.
>
> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
> ---
>  drivers/clk/spear/spear1340_clock.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
> index e69c542..b3b56de 100644
> --- a/drivers/clk/spear/spear1340_clock.c
> +++ b/drivers/clk/spear/spear1340_clock.c
> @@ -25,7 +25,7 @@
>         #define SPEAR1340_HCLK_SRC_SEL_SHIFT    27
>         #define SPEAR1340_HCLK_SRC_SEL_MASK     1
>         #define SPEAR1340_SCLK_SRC_SEL_SHIFT    23
> -       #define SPEAR1340_SCLK_SRC_SEL_MASK     3
> +       #define SPEAR1340_SCLK_SRC_SEL_MASK     7

AFAICR, Mask represents number of bits and not the actual mask.
Can you check that again?

>  /* PLL related registers and bit values */
>  #define SPEAR1340_PLL_CFG                      (VA_MISC_BASE + 0x210)
> @@ -369,8 +369,8 @@ static struct frac_rate_tbl gen_rtbl[] = {
>
>  /* clock parents */
>  static const char *vco_parents[] = { "osc_24m_clk", "osc_25m_clk", };
> -static const char *sys_parents[] = { "none", "pll1_clk", "none", "none",
> -       "sys_synth_clk", "none", "pll2_clk", "pll3_clk", };
> +static const char *sys_parents[] = { "pll1_clk", "pll1_clk", "pll1_clk",
> +       "pll1_clk", "sys_synth_clk", "sys_synth_clk", "pll2_clk", "pll3_clk", };

Don't know what would be the implication of this?

@Mike: Can you please tell us what should we do in such cases?

--
viresh
