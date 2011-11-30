From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 30 Nov 2011 12:43:10 -0800
Subject: [RFC V1 3/8] clk: Add support for simple dividers
In-Reply-To: <1322046755-13511-4-git-send-email-richard.zhao@linaro.org>
References: <1322046755-13511-1-git-send-email-richard.zhao@linaro.org>
 <1322046755-13511-4-git-send-email-richard.zhao@linaro.org>
Message-ID: <CAPtuhThdt3Q63r_mP7aanXdgLH1si2pHfRr_Yg1GRhREqdDmfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 3:12 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
> +#define account_for_rounding_errors ? ?1
> +
> +static int clk_divider_bestdiv(struct clk *clk, unsigned long rate,
> + ? ? ? ? ? ? ? unsigned long *best_parent_rate)
> +{
> + ? ? ? struct clk_divider *divider = to_clk_divider(clk);
> + ? ? ? int i, bestdiv = 0;
> + ? ? ? unsigned long parent_rate, best = 0, now, maxdiv;
> +
> + ? ? ? maxdiv = (1 << divider->width);
> +
> + ? ? ? if (divider->flags & CLK_DIVIDER_FLAG_ONE_BASED)
> + ? ? ? ? ? ? ? maxdiv--;
> +
> + ? ? ? if (!(clk->flags & CLK_PARENT_SET_RATE)) {
> + ? ? ? ? ? ? ? parent_rate = clk->parent->rate;
> + ? ? ? ? ? ? ? bestdiv = parent_rate / rate;
> + ? ? ? ? ? ? ? bestdiv = bestdiv == 0 ? 1 : bestdiv;
> + ? ? ? ? ? ? ? bestdiv = bestdiv > maxdiv ? maxdiv : bestdiv;
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> +
> + ? ? ? /*
> + ? ? ? ?* The maximum divider we can use without overflowing
> + ? ? ? ?* unsigned long in rate * i below
> + ? ? ? ?*/
> + ? ? ? maxdiv = min(ULONG_MAX / rate, maxdiv);
> +
> + ? ? ? for (i = 1; i <= maxdiv; i++) {
> + ? ? ? ? ? ? ? parent_rate = clk_round_rate(clk->parent,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (rate + account_for_rounding_errors) * i);

How about just ((rate + 1) * i) with a comment above explaining why?
This removes the awkward #define above.

Also, I'd like to roll this into clk-basic.c for the V4 series.  Any objections?

Thanks,
Mike
