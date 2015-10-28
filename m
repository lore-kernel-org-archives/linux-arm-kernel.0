From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 28 Oct 2015 08:53:32 +0100
Subject: [PATCH v5 3/8] clk: rockchip: add clock controller for rk3036
In-Reply-To: <1445833539-6484-4-git-send-email-zhengxing@rock-chips.com>
References: <1445833539-6484-1-git-send-email-zhengxing@rock-chips.com>
 <1445833539-6484-4-git-send-email-zhengxing@rock-chips.com>
Message-ID: <2173913.nTv0xun882@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 26. Oktober 2015, 12:25:34 schrieb Xing Zheng:
> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
> index dc8ecb2..4b79f34 100644
> --- a/drivers/clk/rockchip/clk.h
> +++ b/drivers/clk/rockchip/clk.h
> @@ -2,6 +2,9 @@
>   * Copyright (c) 2014 MundoReader S.L.
>   * Author: Heiko Stuebner <heiko@sntech.de>
>   *
> + * Copyright (c) 2015 Rockchip Electronics Co. Ltd.
> + * Author: Xing Zheng <zhengxing@rock-chips.com>
> + *
>   * based on
>   *
>   * samsung/clk.h
> @@ -40,6 +43,13 @@ struct clk;
>  #define RK2928_SOFTRST_CON(x)	((x) * 0x4 + 0x110)
>  #define RK2928_MISC_CON		0x134
>  
> +#define RK3036_SDMMC_CON0		0x144
> +#define RK3036_SDMMC_CON1		0x148
> +#define RK3036_SDIO_CON0		0x14c
> +#define RK3036_SDIO_CON1		0x150
> +#define RK3036_EMMC_CON0		0x154
> +#define RK3036_EMMC_CON1		0x158
> +
>  #define RK3288_PLL_CON(x)		RK2928_PLL_CON(x)
>  #define RK3288_MODE_CON			0x50
>  #define RK3288_CLKSEL_CON(x)		((x) * 0x4 + 0x60)
> @@ -74,9 +84,22 @@ struct clk;
>  #define RK3368_EMMC_CON1		0x41c
>  
>  enum rockchip_pll_type {
> +	pll_rk3036,
>  	pll_rk3066,
>  };
>  
> +#define RK3036_PLL_RATE(_rate, _refdiv, _fbdiv, _postdiv1,	\
> +			_postdiv2, _dsmpd, _frac)		\
> +{								\
> +	.rate	= _rate##U,					\
> +	.fbdiv = _fbdiv,					\
> +	.postdiv1 = _postdiv1,					\
> +	.refdiv = _refdiv,					\
> +	.postdiv2 = _postdiv2,					\
> +	.dsmpd = _dsmpd,					\
> +	.frac = _frac,						\
> +}
> +
>  #define RK3066_PLL_RATE(_rate, _nr, _nf, _no)	\
>  {						\
>  	.rate	= _rate##U,			\
> @@ -101,6 +124,13 @@ struct rockchip_pll_rate_table {
>  	unsigned int nf;
>  	unsigned int no;
>  	unsigned int nb;
> +	/* for RK3036 */
> +	unsigned int fbdiv;
> +	unsigned int postdiv1;
> +	unsigned int refdiv;
> +	unsigned int postdiv2;
> +	unsigned int dsmpd;
> +	unsigned int frac;
>  };
>  
>  /**

the changes to our clk.h should be part of the addition of the pll itself
(your current patch4) and that patch should then trade places with
this one, so you add the complete pll type first and this clock controller
afterwards.


Heiko
