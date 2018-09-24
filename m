From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 24 Sep 2018 16:13:23 +0200
Subject: [PATCH] phy: rockchip-usb: add usb-uart setup for rk3188
In-Reply-To: <20180828085610.28904-1-heiko@sntech.de>
References: <20180828085610.28904-1-heiko@sntech.de>
Message-ID: <2960494.bBbcRnOUuH@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

Am Dienstag, 28. August 2018, 10:56:10 CEST schrieb Heiko Stuebner:
> The rk3188 also supports bringing the uart2 out through
> the usb dm+dp pins, so add the necessary setup for it.
> 
> rk3066 does not seem to support usb-uart functionality and this
> particular phy was only used on older Rockchip socs, so this leaves
> room for a bit of cleanup as well, as there most likely won't be new
> additions in the driver.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

could you take a look at this change if you find the time please?


Thanks
Heiko

> ---
>  drivers/phy/rockchip/phy-rockchip-usb.c | 141 ++++++++++++++++--------
>  1 file changed, 95 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-usb.c b/drivers/phy/rockchip/phy-rockchip-usb.c
> index 3378eeb7a562..456fa703e4f0 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usb.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usb.c
> @@ -36,7 +36,22 @@ static int enable_usb_uart;
>  #define HIWORD_UPDATE(val, mask) \
>  		((val) | (mask) << 16)
>  
> -#define UOC_CON0_SIDDQ BIT(13)
> +#define UOC_CON0					0x00
> +#define UOC_CON0_SIDDQ					BIT(13)
> +#define UOC_CON0_DISABLE				BIT(4)
> +#define UOC_CON0_COMMON_ON_N				BIT(0)
> +
> +#define UOC_CON2					0x08
> +#define UOC_CON2_SOFT_CON_SEL				BIT(2)
> +
> +#define UOC_CON3					0x0c
> +/* bits present on rk3188 and rk3288 phys */
> +#define UOC_CON3_UTMI_TERMSEL_FULLSPEED			BIT(5)
> +#define UOC_CON3_UTMI_XCVRSEELCT_FSTRANSC		(1 << 3)
> +#define UOC_CON3_UTMI_XCVRSEELCT_MASK			(3 << 3)
> +#define UOC_CON3_UTMI_OPMODE_NODRIVING			(1 << 1)
> +#define UOC_CON3_UTMI_OPMODE_MASK			(3 << 1)
> +#define UOC_CON3_UTMI_SUSPENDN				BIT(0)
>  
>  struct rockchip_usb_phys {
>  	int reg;
> @@ -46,7 +61,8 @@ struct rockchip_usb_phys {
>  struct rockchip_usb_phy_base;
>  struct rockchip_usb_phy_pdata {
>  	struct rockchip_usb_phys *phys;
> -	int (*init_usb_uart)(struct regmap *grf);
> +	int (*init_usb_uart)(struct regmap *grf,
> +			     const struct rockchip_usb_phy_pdata *pdata);
>  	int usb_uart_phy;
>  };
>  
> @@ -313,28 +329,88 @@ static const struct rockchip_usb_phy_pdata rk3066a_pdata = {
>  	},
>  };
>  
> +static int __init rockchip_init_usb_uart_common(struct regmap *grf,
> +				const struct rockchip_usb_phy_pdata *pdata)
> +{
> +	int regoffs = pdata->phys[pdata->usb_uart_phy].reg;
> +	int ret;
> +	u32 val;
> +
> +	/*
> +	 * COMMON_ON and DISABLE settings are described in the TRM,
> +	 * but were not present in the original code.
> +	 * Also disable the analog phy components to save power.
> +	 */
> +	val = HIWORD_UPDATE(UOC_CON0_COMMON_ON_N
> +				| UOC_CON0_DISABLE
> +				| UOC_CON0_SIDDQ,
> +			    UOC_CON0_COMMON_ON_N
> +				| UOC_CON0_DISABLE
> +				| UOC_CON0_SIDDQ);
> +	ret = regmap_write(grf, regoffs + UOC_CON0, val);
> +	if (ret)
> +		return ret;
> +
> +	val = HIWORD_UPDATE(UOC_CON2_SOFT_CON_SEL,
> +			    UOC_CON2_SOFT_CON_SEL);
> +	ret = regmap_write(grf, regoffs + UOC_CON2, val);
> +	if (ret)
> +		return ret;
> +
> +	val = HIWORD_UPDATE(UOC_CON3_UTMI_OPMODE_NODRIVING
> +				| UOC_CON3_UTMI_XCVRSEELCT_FSTRANSC
> +				| UOC_CON3_UTMI_TERMSEL_FULLSPEED,
> +			    UOC_CON3_UTMI_SUSPENDN
> +				| UOC_CON3_UTMI_OPMODE_MASK
> +				| UOC_CON3_UTMI_XCVRSEELCT_MASK
> +				| UOC_CON3_UTMI_TERMSEL_FULLSPEED);
> +	ret = regmap_write(grf, UOC_CON3, val);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +#define RK3188_UOC0_CON0				0x10c
> +#define RK3188_UOC0_CON0_BYPASSSEL			BIT(9)
> +#define RK3188_UOC0_CON0_BYPASSDMEN			BIT(8)
> +
> +/*
> + * Enable the bypass of uart2 data through the otg usb phy.
> + * See description of rk3288-variant for details.
> + */
> +static int __init rk3188_init_usb_uart(struct regmap *grf,
> +				const struct rockchip_usb_phy_pdata *pdata)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret = rockchip_init_usb_uart_common(grf, pdata);
> +	if (ret)
> +		return ret;
> +
> +	val = HIWORD_UPDATE(RK3188_UOC0_CON0_BYPASSSEL
> +				| RK3188_UOC0_CON0_BYPASSDMEN,
> +			    RK3188_UOC0_CON0_BYPASSSEL
> +				| RK3188_UOC0_CON0_BYPASSDMEN);
> +	ret = regmap_write(grf, RK3188_UOC0_CON0, val);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static const struct rockchip_usb_phy_pdata rk3188_pdata = {
>  	.phys = (struct rockchip_usb_phys[]){
>  		{ .reg = 0x10c, .pll_name = "sclk_otgphy0_480m" },
>  		{ .reg = 0x11c, .pll_name = "sclk_otgphy1_480m" },
>  		{ /* sentinel */ }
>  	},
> +	.init_usb_uart = rk3188_init_usb_uart,
> +	.usb_uart_phy = 0,
>  };
>  
> -#define RK3288_UOC0_CON0				0x320
> -#define RK3288_UOC0_CON0_COMMON_ON_N			BIT(0)
> -#define RK3288_UOC0_CON0_DISABLE			BIT(4)
> -
> -#define RK3288_UOC0_CON2				0x328
> -#define RK3288_UOC0_CON2_SOFT_CON_SEL			BIT(2)
> -
>  #define RK3288_UOC0_CON3				0x32c
> -#define RK3288_UOC0_CON3_UTMI_SUSPENDN			BIT(0)
> -#define RK3288_UOC0_CON3_UTMI_OPMODE_NODRIVING		(1 << 1)
> -#define RK3288_UOC0_CON3_UTMI_OPMODE_MASK		(3 << 1)
> -#define RK3288_UOC0_CON3_UTMI_XCVRSEELCT_FSTRANSC	(1 << 3)
> -#define RK3288_UOC0_CON3_UTMI_XCVRSEELCT_MASK		(3 << 3)
> -#define RK3288_UOC0_CON3_UTMI_TERMSEL_FULLSPEED		BIT(5)
>  #define RK3288_UOC0_CON3_BYPASSDMEN			BIT(6)
>  #define RK3288_UOC0_CON3_BYPASSSEL			BIT(7)
>  
> @@ -353,40 +429,13 @@ static const struct rockchip_usb_phy_pdata rk3188_pdata = {
>   *
>   * The actual code in the vendor kernel does some things differently.
>   */
> -static int __init rk3288_init_usb_uart(struct regmap *grf)
> +static int __init rk3288_init_usb_uart(struct regmap *grf,
> +				const struct rockchip_usb_phy_pdata *pdata)
>  {
>  	u32 val;
>  	int ret;
>  
> -	/*
> -	 * COMMON_ON and DISABLE settings are described in the TRM,
> -	 * but were not present in the original code.
> -	 * Also disable the analog phy components to save power.
> -	 */
> -	val = HIWORD_UPDATE(RK3288_UOC0_CON0_COMMON_ON_N
> -				| RK3288_UOC0_CON0_DISABLE
> -				| UOC_CON0_SIDDQ,
> -			    RK3288_UOC0_CON0_COMMON_ON_N
> -				| RK3288_UOC0_CON0_DISABLE
> -				| UOC_CON0_SIDDQ);
> -	ret = regmap_write(grf, RK3288_UOC0_CON0, val);
> -	if (ret)
> -		return ret;
> -
> -	val = HIWORD_UPDATE(RK3288_UOC0_CON2_SOFT_CON_SEL,
> -			    RK3288_UOC0_CON2_SOFT_CON_SEL);
> -	ret = regmap_write(grf, RK3288_UOC0_CON2, val);
> -	if (ret)
> -		return ret;
> -
> -	val = HIWORD_UPDATE(RK3288_UOC0_CON3_UTMI_OPMODE_NODRIVING
> -				| RK3288_UOC0_CON3_UTMI_XCVRSEELCT_FSTRANSC
> -				| RK3288_UOC0_CON3_UTMI_TERMSEL_FULLSPEED,
> -			    RK3288_UOC0_CON3_UTMI_SUSPENDN
> -				| RK3288_UOC0_CON3_UTMI_OPMODE_MASK
> -				| RK3288_UOC0_CON3_UTMI_XCVRSEELCT_MASK
> -				| RK3288_UOC0_CON3_UTMI_TERMSEL_FULLSPEED);
> -	ret = regmap_write(grf, RK3288_UOC0_CON3, val);
> +	ret = rockchip_init_usb_uart_common(grf, pdata);
>  	if (ret)
>  		return ret;
>  
> @@ -516,7 +565,7 @@ static int __init rockchip_init_usb_uart(void)
>  		return PTR_ERR(grf);
>  	}
>  
> -	ret = data->init_usb_uart(grf);
> +	ret = data->init_usb_uart(grf, data);
>  	if (ret) {
>  		pr_err("%s: could not init usb_uart, %d\n", __func__, ret);
>  		enable_usb_uart = 0;
> 
