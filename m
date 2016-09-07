From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 7 Sep 2016 14:45:21 +0800
Subject: [PATCH v2 4/7] clk: sunxi-ng: Add N-class clocks support
In-Reply-To: <20160906121837.7517-5-maxime.ripard@free-electrons.com>
References: <20160906121837.7517-1-maxime.ripard@free-electrons.com>
 <20160906121837.7517-5-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67tM_3Q81=Mb1Nf0cja+oxBjJi=6mhkkpnvRM2i0BAmiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2016 at 8:18 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Add support for the class with a single factor, N, being a multiplier.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---

[...]

> diff --git a/drivers/clk/sunxi-ng/ccu_mult.c b/drivers/clk/sunxi-ng/ccu_mult.c
> new file mode 100644
> index 000000000000..119b190c0eb5
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu_mult.c

[...]

> +static int ccu_mult_set_rate(struct clk_hw *hw, unsigned long rate,
> +                          unsigned long parent_rate)
> +{
> +       struct ccu_mult *cm = hw_to_ccu_mult(hw);
> +       unsigned long flags;
> +       unsigned int n;
> +       u32 reg;
> +
> +       ccu_mux_helper_adjust_parent_for_prediv(&cm->common, &cm->mux, -1,
> +                                               &parent_rate);
> +

Git complains about extra whitespace here.
You can keep my ack after fixing it.

ChenYu

> +       ccu_mult_find_best(parent_rate, rate, 1 << cm->mult.width, &n);
> +
> +       spin_lock_irqsave(cm->common.lock, flags);
> +
> +       reg = readl(cm->common.base + cm->common.reg);
> +       reg &= ~GENMASK(cm->mult.width + cm->mult.shift - 1, cm->mult.shift);
> +
> +       writel(reg | ((n - 1) << cm->mult.shift),
> +              cm->common.base + cm->common.reg);
> +
> +       spin_unlock_irqrestore(cm->common.lock, flags);
> +
> +       return 0;
> +}
