From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 5 Dec 2012 10:02:14 -0800
Subject: [PATCH 2/6 v8] clk, highbank: Prevent glitches in non-bypass
 reset mode
In-Reply-To: <1354726121-17190-3-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354726121-17190-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354726121-17190-3-git-send-email-mark.langsdorf@calxeda.com>
Message-ID: <CAPtuhTjsvSs5cif4yiDXwzET-hygqQk5yMn3WvqxiBHDgbpfcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 5, 2012 at 8:48 AM, Mark Langsdorf
<mark.langsdorf@calxeda.com> wrote:
> The highbank clock will glitch with the current code if the
> clock rate is reset without relocking the PLL. Program the PLL
> correctly to prevent glitches.
>
> Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: mturquette at linaro.org
> ---
> Changes from v6, v7
>         None.
> Changes from v5
>         Added Mike Turquette's ack.

It appears that my Ack has not been added to this version of the patch.

Regards,
Mike

> Changes from v4
>         None.
> Changes from v3
>         Changelog text and patch name now correspond to the actual patch.
>         was clk, highbank: remove non-bypass reset mode.
> Changes from v2
>         None.
> Changes from v1
>         Removed erroneous reformating.
>
>  drivers/clk/clk-highbank.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/clk-highbank.c b/drivers/clk/clk-highbank.c
> index 52fecad..3a0b723 100644
> --- a/drivers/clk/clk-highbank.c
> +++ b/drivers/clk/clk-highbank.c
> @@ -182,8 +182,10 @@ static int clk_pll_set_rate(struct clk_hw *hwclk, unsigned long rate,
>                 reg |= HB_PLL_EXT_ENA;
>                 reg &= ~HB_PLL_EXT_BYPASS;
>         } else {
> +               writel(reg | HB_PLL_EXT_BYPASS, hbclk->reg);
>                 reg &= ~HB_PLL_DIVQ_MASK;
>                 reg |= divq << HB_PLL_DIVQ_SHIFT;
> +               writel(reg | HB_PLL_EXT_BYPASS, hbclk->reg);
>         }
>         writel(reg, hbclk->reg);
>
> --
> 1.7.11.7
>
