From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 10 Feb 2015 09:40:21 +0100
Subject: [PATCH 1/7] pinctrl: mediatek: emulate GPIO interrupt on
 both-edges
In-Reply-To: <1422339332-27498-2-git-send-email-chaotian.jing@mediatek.com>
References: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
 <1422339332-27498-2-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <20150210084021.GM10842@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jan 27, 2015 at 02:15:26PM +0800, Chaotian Jing wrote:
> From: Yingjoe Chen <yingjoe.chen@mediatek.com>
> 
> MTK EINT does not support generating interrupt on both edges.
> Emulate this by changing edge polarity while enable irq,
> set types and interrupt handling. This follows an example of
> drivers/gpio/gpio-mxc.c.
> 
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mt8135.c     |  3 ++
>  drivers/pinctrl/mediatek/pinctrl-mt8173.c     |  3 ++
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 76 +++++++++++++++++++++++++--
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  4 ++
>  4 files changed, 83 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8135.c b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
> index b6ee2b2..1296d6d 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt8135.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
> @@ -325,6 +325,9 @@ static const struct mtk_pinctrl_devdata mt8135_pinctrl_data = {
>  		.sens      = 0x140,
>  		.sens_set  = 0x180,
>  		.sens_clr  = 0x1c0,
> +		.soft      = 0x200,
> +		.soft_set  = 0x240,
> +		.soft_clr  = 0x280,
>  		.pol       = 0x300,
>  		.pol_set   = 0x340,
>  		.pol_clr   = 0x380,
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8173.c b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
> index 444d88d..717000e 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt8173.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
> @@ -278,6 +278,9 @@ static const struct mtk_pinctrl_devdata mt8173_pinctrl_data = {
>  		.sens      = 0x140,
>  		.sens_set  = 0x180,
>  		.sens_clr  = 0x1c0,
> +		.soft      = 0x200,
> +		.soft_set  = 0x240,
> +		.soft_clr  = 0x280,
>  		.pol       = 0x300,
>  		.pol_set   = 0x340,
>  		.pol_clr   = 0x380,
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index 109a882..820ce9e 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -792,6 +792,32 @@ static unsigned int mtk_eint_get_mask(struct mtk_pinctrl *pctl,
>  	return !!(readl(reg) & bit);
>  }
>  
> +static int mtk_eint_flip_edge(struct mtk_pinctrl *pctl, int hwirq)
> +{
> +	int start_level, curr_level;
> +	unsigned int reg_offset;
> +	const struct mtk_eint_offsets *eint_offsets = &(pctl->devdata->eint_offsets);
> +	u32 mask = 1 << (hwirq & 0x1f);
> +	u32 port = (hwirq >> 5) & eint_offsets->port_mask;
> +	void __iomem *reg = pctl->eint_reg_base + (port << 2);
> +	const struct mtk_desc_pin *pin;
> +
> +	pin = mtk_find_pin_by_eint_num(pctl, hwirq);
> +	curr_level = mtk_gpio_get(pctl->chip, pin->pin.number);
> +	do {
> +		start_level = curr_level;
> +		if (start_level)
> +			reg_offset = eint_offsets->pol_clr;
> +		else
> +			reg_offset = eint_offsets->pol_set;
> +		writel(mask, reg + reg_offset);
> +
> +		curr_level = mtk_gpio_get(pctl->chip, pin->pin.number);
> +	} while (start_level != curr_level);
> +
> +	return start_level;
> +}
> +
>  static void mtk_eint_mask(struct irq_data *d)
>  {
>  	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
> @@ -814,6 +840,9 @@ static void mtk_eint_unmask(struct irq_data *d)
>  			eint_offsets->mask_clr);
>  
>  	writel(mask, reg);
> +
> +	if (pctl->eint_dual_edges[d->hwirq])
> +		mtk_eint_flip_edge(pctl, d->hwirq);
>  }
>From looking at the code it seems to me that there is a bug. Consider
the following to happen:

	pin changes level, say high to low, triggers irq

	irq is masked by writel(mask, reg) in mtk_eint_mask

	mtk_eint_flip_edge gets curr_level = low

	pin goes up

	writel(mask, reg + eint_offsets->pol_set);

	oh, pin is high, so: writel(mask, reg + eint_offsets->pol_clr

So now you trigger the irq the next time when the pin goes down again.
But that means to missed to trigger on the "pin goes up" in the above
list, right?

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
