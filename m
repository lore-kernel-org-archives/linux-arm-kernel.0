From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 11 May 2016 10:49:06 +0200
Subject: [PATCH 14/16] clk: sunxi-ng: Add N-K-M-P factor clock
In-Reply-To: <1462737711-10017-15-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-15-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160511104906.988800e89f99d24a81f3cb43@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  8 May 2016 22:01:49 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Introduce support for clocks that use a combination of two linear
> multipliers (N and K factors), one linear divider (M) and one power of two
> divider (P).
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi-ng/Makefile   |   1 +
>  drivers/clk/sunxi-ng/ccu_nkmp.c | 157 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu_nkmp.h |  43 +++++++++++
>  3 files changed, 201 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu_nkmp.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu_nkmp.h
> 
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index 2bb8bc22e907..c794f57b6fb1 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -9,6 +9,7 @@ obj-y += ccu_mp.o
>  obj-y += ccu_mux.o
>  obj-y += ccu_nk.o
>  obj-y += ccu_nkm.o
> +obj-y += ccu_nkmp.o
>  obj-y += ccu_nm.o
>  obj-y += ccu_p.o
>  obj-y += ccu_phase.o
> diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
> new file mode 100644
> index 000000000000..b7da00773cd6
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
	[snip]
> @@ -0,0 +1,157 @@
	[snip]
> +static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
> +			   unsigned long parent_rate)
> +{
> +	struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
> +	unsigned long n, k, m, p;
> +	unsigned long flags;
> +	u32 reg;
> +
> +	ccu_nkmp_find_best(parent_rate, rate,
> +			   1 << nkmp->n.width, 1 << nkmp->k.width,
> +			   1 << nkmp->m.width, (1 << nkmp->p.width) - 1,
> +			   &n, &k, &m, &p);
> +
> +	spin_lock_irqsave(nkmp->common.lock, flags);
> +
> +	reg = readl(nkmp->common.base + nkmp->common.reg);
> +	reg &= ~GENMASK(nkmp->n.width + nkmp->n.shift, nkmp->n.shift);
> +	reg &= ~GENMASK(nkmp->k.width + nkmp->k.shift, nkmp->k.shift);
> +	reg &= ~GENMASK(nkmp->m.width + nkmp->m.shift, nkmp->m.shift);
> +	reg &= ~GENMASK(nkmp->p.width + nkmp->p.shift, nkmp->p.shift);
> +
> +	reg |= (n - 1) << nkmp->m.shift;
> +	reg |= (k - 1) << nkmp->m.shift;

	reg |= (n - 1) << nkmp->n.shift;
	reg |= (k - 1) << nkmp->k.shift;

> +	reg |= (m - 1) << nkmp->m.shift;
> +	reg |= p << nkmp->p.shift;
> +
> +	writel(reg, nkmp->common.base + nkmp->common.reg);
> +
> +	spin_unlock_irqrestore(nkmp->common.lock, flags);
> +
> +	ccu_helper_wait_for_lock(&nkmp->common, nkmp->lock);
> +
> +	return 0;
> +}
	[snip]

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
