From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 7 Jul 2015 15:17:45 +0800
Subject: [PATCH] clk: mediatek: Add MT8173 MMPLL change rate support
In-Reply-To: <1433222760-5924-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1433222760-5924-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1436253465.3526.85.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Does anyone have comments for this patch?


Best regards,

James

On Tue, 2015-06-02 at 13:26 +0800, James Liao wrote:
> MT8173 MMPLL frequency settings are different from common PLLs.
> It needs different post divider settings for some ranges of frequency.
> This patch add support for MT8173 MMPLL frequency setting, includes:
> 
> 1. Add div-rate table for PLLs.
> 2. Increase the max ost divider setting from 3 (/8) to 4 (/16).
> 3. Write postdiv and pcw settings at the same time.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mt8173.c | 24 +++++++++++++++++++++---
>  drivers/clk/mediatek/clk-mtk.h    |  1 +
>  drivers/clk/mediatek/clk-pll.c    | 37 +++++++++++++++++++++++++------------
>  3 files changed, 47 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
> index 357b080..821de7d 100644
> --- a/drivers/clk/mediatek/clk-mt8173.c
> +++ b/drivers/clk/mediatek/clk-mt8173.c
> @@ -779,8 +779,9 @@ CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8173-pericfg", mtk_pericfg_init);
>  
>  #define CON0_MT8173_RST_BAR	BIT(24)
>  
> -#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg, _pd_shift, \
> -			_tuner_reg, _pcw_reg, _pcw_shift) { \
> +#define PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
> +			_pd_reg, _pd_shift, _tuner_reg, _pcw_reg,	\
> +			_pcw_shift, _div_rate) {			\
>  		.id = _id,						\
>  		.name = _name,						\
>  		.reg = _reg,						\
> @@ -795,14 +796,31 @@ CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8173-pericfg", mtk_pericfg_init);
>  		.tuner_reg = _tuner_reg,				\
>  		.pcw_reg = _pcw_reg,					\
>  		.pcw_shift = _pcw_shift,				\
> +		.div_rate = _div_rate,					\
>  	}
>  
> +#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
> +			_pd_reg, _pd_shift, _tuner_reg, _pcw_reg,	\
> +			_pcw_shift)					\
> +		PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, \
> +			_pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift, \
> +			NULL)
> +
> +const unsigned long mmpll_div_rate[] = {
> +	MT8173_PLL_FMAX,
> +	1000000000,
> +	702000000,
> +	253500000,
> +	126750000,
> +	0,
> +};
> +
>  static const struct mtk_pll_data plls[] = {
>  	PLL(CLK_APMIXED_ARMCA15PLL, "armca15pll", 0x200, 0x20c, 0x00000001, 0, 21, 0x204, 24, 0x0, 0x204, 0),
>  	PLL(CLK_APMIXED_ARMCA7PLL, "armca7pll", 0x210, 0x21c, 0x00000001, 0, 21, 0x214, 24, 0x0, 0x214, 0),
>  	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x220, 0x22c, 0xf0000101, HAVE_RST_BAR, 21, 0x220, 4, 0x0, 0x224, 0),
>  	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x230, 0x23c, 0xfe000001, HAVE_RST_BAR, 7, 0x230, 4, 0x0, 0x234, 14),
> -	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x240, 0x24c, 0x00000001, 0, 21, 0x244, 24, 0x0, 0x244, 0),
> +	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x240, 0x24c, 0x00000001, 0, 21, 0x244, 24, 0x0, 0x244, 0, mmpll_div_rate),
>  	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x250, 0x25c, 0x00000001, 0, 21, 0x250, 4, 0x0, 0x254, 0),
>  	PLL(CLK_APMIXED_VENCPLL, "vencpll", 0x260, 0x26c, 0x00000001, 0, 21, 0x260, 4, 0x0, 0x264, 0),
>  	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x270, 0x27c, 0x00000001, 0, 21, 0x270, 4, 0x0, 0x274, 0),
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index 61035b9..645af7c 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -150,6 +150,7 @@ struct mtk_pll_data {
>  	int pcwbits;
>  	uint32_t pcw_reg;
>  	int pcw_shift;
> +	const unsigned long *div_rate;
>  };
>  
>  void __init mtk_clk_register_plls(struct device_node *node,
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index 44409e9..4680a09 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -90,20 +90,23 @@ static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
>  static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
>  		int postdiv)
>  {
> -	u32 con1, pd, val;
> +	u32 con1, val;
>  	int pll_en;
>  
> -	/* set postdiv */
> -	pd = readl(pll->pd_addr);
> -	pd &= ~(POSTDIV_MASK << pll->data->pd_shift);
> -	pd |= (ffs(postdiv) - 1) << pll->data->pd_shift;
> -	writel(pd, pll->pd_addr);
> -
>  	pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
>  
> -	/* set pcw */
> -	val = readl(pll->pcw_addr);
> +	/* set postdiv */
> +	val = readl(pll->pd_addr);
> +	val &= ~(POSTDIV_MASK << pll->data->pd_shift);
> +	val |= (ffs(postdiv) - 1) << pll->data->pd_shift;
> +
> +	/* postdiv and pcw need to set at the same time if on same register */
> +	if (pll->pd_addr != pll->pcw_addr) {
> +		writel(val, pll->pd_addr);
> +		val = readl(pll->pcw_addr);
> +	}
>  
> +	/* set pcw */
>  	val &= ~GENMASK(pll->data->pcw_shift + pll->data->pcwbits - 1,
>  			pll->data->pcw_shift);
>  	val |= pcw << pll->data->pcw_shift;
> @@ -135,16 +138,26 @@ static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
>  		u32 freq, u32 fin)
>  {
>  	unsigned long fmin = 1000 * MHZ;
> +	const unsigned long *div_rate = pll->data->div_rate;
>  	u64 _pcw;
>  	u32 val;
>  
>  	if (freq > pll->data->fmax)
>  		freq = pll->data->fmax;
>  
> -	for (val = 0; val < 4; val++) {
> +	if (div_rate) {
> +		for (val = 1; div_rate[val] != 0; val++) {
> +			if (freq > div_rate[val])
> +				break;
> +		}
> +		val--;
>  		*postdiv = 1 << val;
> -		if (freq * *postdiv >= fmin)
> -			break;
> +	} else {
> +		for (val = 0; val < 5; val++) {
> +			*postdiv = 1 << val;
> +			if ((u64)freq * *postdiv >= fmin)
> +				break;
> +		}
>  	}
>  
>  	/* _pcw = freq * postdiv / fin * 2^pcwfbits */
