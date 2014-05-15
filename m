From: dianders@chromium.org (Doug Anderson)
Date: Thu, 15 May 2014 11:18:44 -0700
Subject: [PATCH v4 3/8] clk: samsung: add infrastructure to register cpu
 clocks
In-Reply-To: <1400029876-5830-4-git-send-email-thomas.ab@samsung.com>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
 <1400029876-5830-4-git-send-email-thomas.ab@samsung.com>
Message-ID: <CAD=FV=XmVNwwZY_LM6Za-p7gg6CPh1mGj=BoWvG0Q-Cx9L_A9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Tue, May 13, 2014 at 6:11 PM, Thomas Abraham <ta.omasab@gmail.com> wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> +static int exynos4210_armclk_pre_rate_change(struct clk_notifier_data *ndata,
> +                       struct exynos_cpuclk *armclk, void __iomem *base)
> +{
> +       struct exynos4210_armclk_data *armclk_data = armclk->data;
> +       unsigned long alt_prate = clk_get_rate(armclk->alt_parent);
> +       unsigned long alt_div, div0, div1, tdiv0, mux_reg;
> +       unsigned long cur_armclk_rate, timeout;
> +       unsigned long flags;
> +
> +       /* find out the divider values to use for clock data */
> +       while (armclk_data->prate != ndata->new_rate) {
> +               if (armclk_data->prate == 0)
> +                       return -EINVAL;
> +               armclk_data++;
> +       }
> +
> +       div0 = armclk_data->div0;
> +       div1 = armclk_data->div1;
> +       if (readl(base + SRC_CPU) & EXYNOS4210_MUX_HPM_MASK) {
> +               div1 = readl(base + DIV_CPU1) & EXYNOS4210_DIV1_HPM_MASK;
> +               div1 |= ((armclk_data->div1) & ~EXYNOS4210_DIV1_HPM_MASK);
> +       }
> +
> +       /*
> +        * if the new and old parent clock speed is less than the clock speed
> +        * of the alternate parent, then it should be ensured that at no point
> +        * the armclk speed is more than the old_prate until the dividers are
> +        * set.
> +        */
> +       tdiv0 = readl(base + DIV_CPU0);
> +       cur_armclk_rate = ndata->old_rate / EXYNOS4210_ARM_DIV1(tdiv0) /
> +                               EXYNOS4210_ARM_DIV2(tdiv0);
> +       if (alt_prate > cur_armclk_rate) {
> +               alt_div = _calc_div(alt_prate, cur_armclk_rate);
> +               _exynos4210_set_armclk_div(base, alt_div);
> +               div0 |= alt_div;

Don't you need to up the voltage here, too?  ...I haven't reviewed
this whole patch (so perhaps it's elsewhere in the patch or in the
series), but I stumbled upon this while trying to solve a different
problem and figured I'd check...

-Doug
