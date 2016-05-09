From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 9 May 2016 09:24:21 +0200
Subject: [PATCH 12/16] clk: sunxi-ng: Add N-M-factor clock support
In-Reply-To: <1462737711-10017-13-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-13-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160509092421.a36252139fd6b00b2cd32f24@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  8 May 2016 22:01:47 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Introduce support for clocks that multiply and divide using linear factors.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi-ng/Makefile |   1 +
>  drivers/clk/sunxi-ng/ccu_nm.c | 103 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu_nm.h |  41 +++++++++++++++++
>  3 files changed, 145 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu_nm.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu_nm.h
	[snip]
> diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
> new file mode 100644
> index 000000000000..268637db137b
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu_nm.c
> @@ -0,0 +1,103 @@
	[snip]
> +static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
> +			      unsigned long *parent_rate)
> +{
> +	struct ccu_nm *nm = hw_to_ccu_nm(hw);
> +	unsigned long n, m;
> +
> +	rational_best_approximation(rate, *parent_rate,
> +				    nm->n.width, nm->m.width, &n, &m);

Should be
			1 << nm->n.width, 1 << nm->m.width, &n, &m);

> +
> +	return *parent_rate * n / m;
> +}
> +
> +static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
> +			   unsigned long parent_rate)
> +{
> +	struct ccu_nm *nm = hw_to_ccu_nm(hw);
> +	unsigned long flags;
> +	unsigned long n, m;
> +	u32 reg;
> +
> +	rational_best_approximation(rate, parent_rate,
> +				    nm->n.width, nm->m.width, &n, &m);

Idem

> +
> +	spin_lock_irqsave(nm->common.lock, flags);
> +
> +	reg = readl(nm->common.base + nm->common.reg);
> +	reg &= ~GENMASK(nm->n.width + nm->n.shift, nm->n.shift);
> +	reg &= ~GENMASK(nm->m.width + nm->m.shift, nm->m.shift);
> +
> +	writel(reg | ((m - 1) << nm->m.shift) | ((n - 1) << nm->n.shift),
> +	       nm->common.base + nm->common.reg);
> +
> +	spin_unlock_irqrestore(nm->common.lock, flags);
> +
> +	ccu_helper_wait_for_lock(&nm->common, nm->lock);
> +
> +	return 0;
> +}
> +
> +const struct clk_ops ccu_nm_ops = {
> +	.disable	= ccu_nm_disable,
> +	.enable		= ccu_nm_enable,
> +	.is_enabled	= ccu_nm_is_enabled,
> +
> +	.recalc_rate	= ccu_nm_recalc_rate,
> +	.round_rate	= ccu_nm_round_rate,
> +	.set_rate	= ccu_nm_set_rate,
> +};
	[snip]

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
