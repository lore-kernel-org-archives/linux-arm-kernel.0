From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 12 Oct 2010 10:18:04 +0200
Subject: [PATCH 2/2] mx51: add resources for SD/MMC on i.MX51
In-Reply-To: <1286868685-7825-2-git-send-email-eric@eukrea.com>
References: <20101011170405.GC476@pengutronix.de>
	<1286868685-7825-2-git-send-email-eric@eukrea.com>
Message-ID: <20101012081804.GD29673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

great you pick up this topic.

On Tue, Oct 12, 2010 at 09:31:25AM +0200, Eric B?nard wrote:
> the attached patch allows SD to work on i.MX51 with Wolfram's drivers
> Tested on i.MX51.
> 
> Based on original patch from: Richard Zhu <r65037@freescale.com>
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
>  arch/arm/mach-mx5/clock-mx51.c              |  102 ++++++++++++++++++++++++++-
>  arch/arm/mach-mx5/devices-imx51.h           |    9 +++
>  arch/arm/plat-mxc/include/mach/iomux-mx51.h |   45 ++++++++----
>  3 files changed, 140 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
> index 7deb683..9e8b268 100644
> --- a/arch/arm/mach-mx5/clock-mx51.c
> +++ b/arch/arm/mach-mx5/clock-mx51.c
> @@ -41,6 +41,34 @@ static struct clk usboh3_clk;
>  
>  #define MAX_DPLL_WAIT_TRIES	1000 /* 1000 * udelay(1) = 1ms */
>  
> +static void __calc_pre_post_dividers(u32 div, u32 *pre, u32 *post)
> +{
I asked for a comment here.  E.g. valid ranges of pre and post and the
task solved here (I assume it's "Find pre and post with pre * post =
div"?).

> +	if (div >= 512) {
> +		*pre = 8;
> +		*post = 64;
> +	} else if (div >= 8) {
> +		u32 min_pre, temp_pre, old_err, err;
> +		min_pre = (div - 1) / 64 + 1;
		min_pre = DIV_ROUND_UP(div, 64); ?

> +		old_err = 8;
> +		for (temp_pre = 8; temp_pre >= min_pre; temp_pre--) {
> +			err = div % temp_pre;
> +			if (err == 0) {
> +				*pre = temp_pre;
> +				break;
> +			}
> +			err = temp_pre - err;
> +			if (err < old_err) {
> +				old_err = err;
> +				*pre = temp_pre;
> +			}
> +		}
> +		*post = (div + *pre - 1) / *pre;
		*post = DIV_ROUND_UP(div, *pre);

I don't know if DIV_ROUND_UP is sensible, maybe use DIV_ROUND_CLOSEST?
I'd look into that when the comment above is in place.

> +	} else {
> +		*pre = div;
> +		*post = 1;
> +	}
> +}
> +
>  static void _clk_ccgr_setclk(struct clk *clk, unsigned mode)
>  {
>  	u32 reg = __raw_readl(clk->enable_reg);
> @@ -772,7 +800,7 @@ static struct clk emi_slow_clk = {
>  	.get_rate = clk_emi_slow_get_rate,
>  };
>  
> -#define DEFINE_CLOCK1(name, i, er, es, pfx, p, s)	\
> +#define DEFINE_CLOCK_CCGR(name, i, er, es, pfx, p, s)	\
This is IMHO a good idea, but it should go in a seperate patch.  These
clock changes are very sensible and so a working bisection is important
here.

>  	static struct clk name = {			\
>  		.id		= i,			\
>  		.enable_reg	= er,			\
> @@ -787,6 +815,20 @@ static struct clk emi_slow_clk = {
>  		.secondary	= s,			\
>  	}
>  
> +#define DEFINE_CLOCK_MAX(name, i, er, es, pfx, p, s)	\
> +	static struct clk name = {			\
> +		.id		= i,			\
> +		.enable_reg	= er,			\
> +		.enable_shift	= es,			\
> +		.get_rate	= pfx##_get_rate,	\
> +		.set_rate	= pfx##_set_rate,	\
> +		.set_parent	= pfx##_set_parent,	\
> +		.enable		= _clk_max_enable,	\
> +		.disable	= _clk_max_disable,	\
> +		.parent		= p,			\
> +		.secondary	= s,			\
> +	}
> +
>  #define CLK_GET_RATE(name, nr, bitsname)				\
>  static unsigned long clk_##name##_get_rate(struct clk *clk)		\
>  {									\
> @@ -817,6 +859,33 @@ static int clk_##name##_set_parent(struct clk *clk, struct clk *parent)	\
>  	return 0;							\
>  }
>  
> +#define CLK_SET_RATE(name, nr, bitsname)				\
> +static int clk_##name##_set_rate(struct clk *clk, unsigned long rate)	\
> +{									\
> +	u32 reg, div, parent_rate;					\
> +	u32 pre = 0, post = 0;						\
> +									\
> +	parent_rate = clk_get_rate(clk->parent);			\
> +	div = parent_rate / rate;					\
> +									\
> +	if ((parent_rate / div) != rate)				\
> +		return -EINVAL;						\
> +									\
> +	__calc_pre_post_dividers(div, &pre, &post);			\
> +									\
> +	/* Set sdhc1 clock divider */					\
> +	reg = __raw_readl(MXC_CCM_CSCDR##nr) &				\
> +		~(MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PRED_MASK	\
> +		| MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PODF_MASK);	\
> +	reg |= (post - 1) <<						\
> +		MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PODF_OFFSET;	\
> +	reg |= (pre - 1) <<						\
> +		MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PRED_OFFSET;	\
> +	__raw_writel(reg, MXC_CCM_CSCDR##nr);				\
> +									\
> +	return 0;							\
> +}
> +
>  /* UART */
>  CLK_GET_RATE(uart, 1, UART)
>  CLK_SET_PARENT(uart, 1, UART)
> @@ -847,6 +916,15 @@ static struct clk ecspi_main_clk = {
>  	.set_parent = clk_ecspi_set_parent,
>  };
>  
> +/* eSDHC */
> +CLK_GET_RATE(esdhc1, 1, ESDHC1_MSHC1)
> +CLK_SET_PARENT(esdhc1, 1, ESDHC1_MSHC1)
> +CLK_SET_RATE(esdhc1, 1, ESDHC1_MSHC1)
> +
> +CLK_GET_RATE(esdhc2, 1, ESDHC2_MSHC2)
> +CLK_SET_PARENT(esdhc2, 1, ESDHC2_MSHC2)
> +CLK_SET_RATE(esdhc2, 1, ESDHC2_MSHC2)
> +
>  #define DEFINE_CLOCK_FULL(name, i, er, es, gr, sr, e, d, p, s)		\
>  	static struct clk name = {					\
>  		.id		= i,					\
> @@ -900,7 +978,7 @@ DEFINE_CLOCK(fec_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG12_OFFSET,
>  	NULL,  NULL, &ipg_clk, NULL);
>  
>  /* NFC */
> -DEFINE_CLOCK1(nfc_clk, 0, MXC_CCM_CCGR5, MXC_CCM_CCGRx_CG10_OFFSET,
> +DEFINE_CLOCK_CCGR(nfc_clk, 0, MXC_CCM_CCGR5, MXC_CCM_CCGRx_CG10_OFFSET,
>  	clk_nfc, &emi_slow_clk, NULL);
>  
>  /* SSI */
> @@ -935,6 +1013,16 @@ DEFINE_CLOCK(cspi_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG13_OFFSET,
>  DEFINE_CLOCK(sdma_clk, 1, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG15_OFFSET,
>  		NULL, NULL, &ahb_clk, NULL);
>  
> +/* eSDHC */
> +DEFINE_CLOCK_FULL(esdhc1_ipg_clk, 0, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG0_OFFSET,
> +	NULL,  NULL, _clk_max_enable, _clk_max_disable, &ipg_clk, NULL);
> +DEFINE_CLOCK_MAX(esdhc1_clk, 0, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG1_OFFSET,
> +	clk_esdhc1, &pll2_sw_clk, &esdhc1_ipg_clk);
> +DEFINE_CLOCK_FULL(esdhc2_ipg_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG2_OFFSET,
> +	NULL,  NULL, _clk_max_enable, _clk_max_disable, &ipg_clk, NULL);
> +DEFINE_CLOCK_MAX(esdhc2_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG3_OFFSET,
> +	clk_esdhc2, &pll2_sw_clk, &esdhc2_ipg_clk);
> +
>  #define _REGISTER_CLOCK(d, n, c) \
>         { \
>  		.dev_id = d, \
> @@ -968,6 +1056,8 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("imx51-ecspi.0", NULL, ecspi1_clk)
>  	_REGISTER_CLOCK("imx51-ecspi.1", NULL, ecspi2_clk)
>  	_REGISTER_CLOCK("imx51-cspi.0", NULL, cspi_clk)
> +	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
> +	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
>  };
>  
>  static void clk_tree_init(void)
> @@ -1011,6 +1101,14 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
>  	/* set the usboh3_clk parent to pll2_sw_clk */
>  	clk_set_parent(&usboh3_clk, &pll2_sw_clk);
>  
> +	/* Set SDHC parents to be PLL2 */
> +	clk_set_parent(&esdhc1_clk, &pll2_sw_clk);
> +	clk_set_parent(&esdhc2_clk, &pll2_sw_clk);
> +
> +	/* set SDHC root clock as 166.25MHZ*/
> +	clk_set_rate(&esdhc1_clk, 166250000);
> +	clk_set_rate(&esdhc2_clk, 166250000);
> +
>  	/* System timer */
>  	mxc_timer_init(&gpt_clk, MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR),
>  		MX51_MXC_INT_GPT);
> diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
> index c233379..547432d 100644
> --- a/arch/arm/mach-mx5/devices-imx51.h
> +++ b/arch/arm/mach-mx5/devices-imx51.h
> @@ -36,3 +36,12 @@ extern const struct imx_spi_imx_data imx51_cspi_data __initconst;
>  extern const struct imx_spi_imx_data imx51_ecspi_data[] __initconst;
>  #define imx51_add_ecspi(id, pdata)	\
>  	imx_add_spi_imx(&imx51_ecspi_data[id], pdata)
> +
> +#define imx51_add_esdhc0(pdata)	\
> +	imx_add_esdhc(0, MX51_MMC_SDHC1_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC1, pdata)
> +#define imx51_add_esdhc1(pdata)	\
> +	imx_add_esdhc(1, MX51_MMC_SDHC2_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC2, pdata)
> +#define imx51_add_esdhc2(pdata)	\
> +	imx_add_esdhc(2, MX51_MMC_SDHC3_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC3, pdata)
> +#define imx51_add_esdhc3(pdata)	\
> +	imx_add_esdhc(3, MX51_MMC_SDHC4_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC4, pdata)
I'd prefer to have these values in a struct.  This makes calling the
function much cheaper.  Look above, imx51_add_ecspi uses it.

> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> index 5160f10..c5adb42 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
Changes to this file deserve to be in a seperate patch, too.

> @@ -47,6 +47,9 @@ typedef enum iomux_config {
>  				PAD_CTL_SRE_FAST)
>  #define MX51_ECSPI_PAD_CTRL	(PAD_CTL_HYS | PAD_CTL_PKE | PAD_CTL_DSE_HIGH | \
>  				PAD_CTL_SRE_FAST)
> +#define MX51_SDHCI_PAD_CTRL 	(PAD_CTL_DSE_HIGH | PAD_CTL_PUS_47K_UP | \
> +				PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_SRE_FAST | \
> +				PAD_CTL_DVS)
>  
>  #define MX51_PAD_CTRL_1	(PAD_CTL_SRE_FAST | PAD_CTL_DSE_HIGH | \
>  					PAD_CTL_PUE | PAD_CTL_PKE | PAD_CTL_HYS)
> @@ -333,26 +336,39 @@ typedef enum iomux_config {
>  #define MX51_PAD_DISP2_DAT13__DISP2_DAT13       IOMUX_PAD(0x790, 0x388, 0, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_DISP2_DAT14__DISP2_DAT14       IOMUX_PAD(0x794, 0x38C, 0, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_DISP2_DAT15__DISP2_DAT15       IOMUX_PAD(0x798, 0x390, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD1_CMD__SD1_CMD               IOMUX_PAD(0x79C, 0x394, 0, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_SD1_CMD__SD1_CMD		IOMUX_PAD(0x79C, 0x394, IOMUX_CONFIG_SION, 0x0, 0, \
> +							MX51_SDHCI_PAD_CTRL)
>  #define MX51_PAD_SD1_CMD__AUD5_RXFS             IOMUX_PAD(0x79C, 0x394, 1, 0x8e0, 1, NO_PAD_CTRL)
> -#define MX51_PAD_SD1_CLK__SD1_CLK               IOMUX_PAD(0x7A0, 0x398, 0, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_SD1_CLK__SD1_CLK		IOMUX_PAD(0x7A0, 0x398, IOMUX_CONFIG_SION, 0x0, 0, \
> +							MX51_SDHCI_PAD_CTRL | PAD_CTL_HYS)
>  #define MX51_PAD_SD1_CLK__AUD5_RXC              IOMUX_PAD(0x7A0, 0x398, 1, 0x8dc, 1, NO_PAD_CTRL)
> -#define MX51_PAD_SD1_DATA0__SD1_DATA0           IOMUX_PAD(0x7A4, 0x39C, 0, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_SD1_DATA0__SD1_DATA0		IOMUX_PAD(0x7A4, 0x39C, IOMUX_CONFIG_SION, 0x0, 0, \
> +							MX51_SDHCI_PAD_CTRL)
>  #define MX51_PAD_SD1_DATA0__AUD5_TXD            IOMUX_PAD(0x7A4, 0x39C, 1, 0x8d8, 2, NO_PAD_CTRL)
> -#define MX51_PAD_SD1_DATA1__SD1_DATA1           IOMUX_PAD(0x7A8, 0x3A0, 0, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_SD1_DATA1__SD1_DATA1		IOMUX_PAD(0x7A8, 0x3A0, IOMUX_CONFIG_SION, 0x0, 0, \
> +							MX51_SDHCI_PAD_CTRL)
>  #define MX51_PAD_SD1_DATA1__AUD5_RXD            IOMUX_PAD(0x7A8, 0x3A0, 1, 0x8d4, 2, NO_PAD_CTRL)
> -#define MX51_PAD_SD1_DATA2__SD1_DATA2           IOMUX_PAD(0x7AC, 0x3A4, 0, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_SD1_DATA2__SD1_DATA2		IOMUX_PAD(0x7AC, 0x3A4, IOMUX_CONFIG_SION, 0x0, 0, \
> +							MX51_SDHCI_PAD_CTRL)
>  #define MX51_PAD_SD1_DATA2__AUD5_TXC            IOMUX_PAD(0x7AC, 0x3A4, 1, 0x8e4, 2, NO_PAD_CTRL)
> -#define MX51_PAD_SD1_DATA3__SD1_DATA3           IOMUX_PAD(0x7B0, 0x3A8, 0, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_SD1_DATA3__SD1_DATA3		IOMUX_PAD(0x7B0, 0x3A8, IOMUX_CONFIG_SION, 0x0, 0, \
> +							MX51_SDHCI_PAD_CTRL)
>  #define MX51_PAD_SD1_DATA3__AUD5_TXFS           IOMUX_PAD(0x7B0, 0x3A8, 1, 0x8e8, 2, NO_PAD_CTRL)
> +#define MX51_PAD_SD2_CMD__SD2_CMD		IOMUX_PAD(0x7BC, 0x3B4, IOMUX_CONFIG_SION, 0x0, 1, \
> +							MX51_SDHCI_PAD_CTRL)
> +#define MX51_PAD_SD2_CLK__SD2_CLK		IOMUX_PAD(0x7C0, 0x3B8, IOMUX_CONFIG_SION, 0x0, 0, \
> +							MX51_SDHCI_PAD_CTRL | PAD_CTL_HYS)
> +#define MX51_PAD_SD2_DATA0__SD2_DATA0		IOMUX_PAD(0x7C4, 0x3BC, IOMUX_CONFIG_SION, 0x0, 0, \
> +							MX51_SDHCI_PAD_CTRL)
> +#define MX51_PAD_SD2_DATA1__SD2_DATA1		IOMUX_PAD(0x7C8, 0x3C0, IOMUX_CONFIG_SION, 0x0, 0, \
> +							MX51_SDHCI_PAD_CTRL)
> +#define MX51_PAD_SD2_DATA2__SD2_DATA2		IOMUX_PAD(0x7CC, 0x3C4, IOMUX_CONFIG_SION, 0x0, 0, \
> +							MX51_SDHCI_PAD_CTRL)
> +#define MX51_PAD_SD2_DATA3__SD2_DATA3		IOMUX_PAD(0x7D0, 0x3C8, IOMUX_CONFIG_SION, 0x0, 0, \
> +							MX51_SDHCI_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_0__GPIO_1_0		IOMUX_PAD(0x7B4, 0x3AC, 1, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_GPIO_1_1__GPIO_1_1		IOMUX_PAD(0x7B8, 0x3B0, 1, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD2_CMD__SD2_CMD               IOMUX_PAD(0x7BC, 0x3B4, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD2_CLK__SD2_CLK               IOMUX_PAD(0x7C0, 0x3B8, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD2_DATA0__SD2_DATA0           IOMUX_PAD(0x7C4, 0x3BC, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD2_DATA1__SD2_DATA1           IOMUX_PAD(0x7C8, 0x3C0, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD2_DATA2__SD2_DATA2           IOMUX_PAD(0x7CC, 0x3C4, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD2_DATA3__SD2_DATA3           IOMUX_PAD(0x7D0, 0x3C8, 0, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_1__GPIO_1_1		IOMUX_PAD(0x7B8, 0x3B0, IOMUX_CONFIG_GPIO, 0x0, 0, \
> +							MX51_SDHCI_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_2__GPIO_1_2		IOMUX_PAD(0x7D4, 0x3CC, 0, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_2__I2C2_SCL		IOMUX_PAD(0x7D4, 0x3CC, (2 | IOMUX_CONFIG_SION), \
>  							0x9b8,   3, MX51_I2C_PAD_CTRL)
> @@ -361,7 +377,8 @@ typedef enum iomux_config {
>  							0x9bc,   3, MX51_I2C_PAD_CTRL)
>  #define MX51_PAD_PMIC_INT_REQ__PMIC_INT_REQ	IOMUX_PAD(0x7FC, 0x3D4, 0, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_4__GPIO_1_4		IOMUX_PAD(0x804, 0x3D8, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_GPIO_1_5__GPIO_1_5		IOMUX_PAD(0x808, 0x3DC, 0, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_5__GPIO_1_5		IOMUX_PAD(0x808, 0x3DC, IOMUX_CONFIG_GPIO, 0x0, 1, \
> +							NO_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_6__GPIO_1_6		IOMUX_PAD(0x80C, 0x3E0, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_7__GPIO_1_7		IOMUX_PAD(0x810, 0x3E4, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_8__GPIO_1_8		IOMUX_PAD(0x814, 0x3E8, 0, 0x0,   1, MX51_GPIO_PAD_CTRL)
> -- 
> 1.7.0.4
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
