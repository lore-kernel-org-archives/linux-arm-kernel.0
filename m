From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 17 Sep 2015 14:47:14 +0200
Subject: [PATCH v2 6/9] pinctrl: rockchip: add support for the rk3036
In-Reply-To: <1442486060-1770-1-git-send-email-zhengxing@rock-chips.com>
References: <1442478540-15068-1-git-send-email-zhengxing@rock-chips.com>
 <1442486060-1770-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <3447784.I53PqELJZg@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 17. September 2015, 18:34:20 schrieb Xing Zheng:
> Add new type for rk3036 and many parts of pinctrl rk3036 are similar
> with rk2928's.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

very nice that the rk3036 pin-controller works with already established 
infrastructure :-)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> 
> Changes in v2: None
> 
>  .../bindings/pinctrl/rockchip,pinctrl.txt          |    1 +
>  drivers/pinctrl/pinctrl-rockchip.c                 |   17 +++++++++++++++++
> 2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
> b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt index
> 391ef4b..c73f2bb 100644
> --- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
> @@ -22,6 +22,7 @@ Required properties for iomux controller:
>    - compatible: one of "rockchip,rk2928-pinctrl",
> "rockchip,rk3066a-pinctrl" "rockchip,rk3066b-pinctrl",
> "rockchip,rk3188-pinctrl"
>  		       "rockchip,rk3288-pinctrl", "rockchip,rk3368-pinctrl"
> +		       "rockchip,rk3036-pinctrl"
>    - rockchip,grf: phandle referencing a syscon providing the
>  	 "general register files"
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> b/drivers/pinctrl/pinctrl-rockchip.c index c5246c0..9c49510 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -2089,6 +2089,21 @@ static struct rockchip_pin_ctrl rk2928_pin_ctrl = {
>  		.pull_calc_reg		= rk2928_calc_pull_reg_and_bit,
>  };
> 
> +static struct rockchip_pin_bank rk3036_pin_banks[] = {
> +	PIN_BANK(0, 32, "gpio0"),
> +	PIN_BANK(1, 32, "gpio1"),
> +	PIN_BANK(2, 32, "gpio2"),
> +};
> +
> +static struct rockchip_pin_ctrl rk3036_pin_ctrl = {
> +		.pin_banks		= rk3036_pin_banks,
> +		.nr_banks		= ARRAY_SIZE(rk3036_pin_banks),
> +		.label			= "RK3036-GPIO",
> +		.type			= RK2928,
> +		.grf_mux_offset		= 0xa8,
> +		.pull_calc_reg		= rk2928_calc_pull_reg_and_bit,
> +};
> +
>  static struct rockchip_pin_bank rk3066a_pin_banks[] = {
>  	PIN_BANK(0, 32, "gpio0"),
>  	PIN_BANK(1, 32, "gpio1"),
> @@ -2207,6 +2222,8 @@ static struct rockchip_pin_ctrl rk3368_pin_ctrl = {
>  static const struct of_device_id rockchip_pinctrl_dt_match[] = {
>  	{ .compatible = "rockchip,rk2928-pinctrl",
>  		.data = (void *)&rk2928_pin_ctrl },
> +	{ .compatible = "rockchip,rk3036-pinctrl",
> +		.data = (void *)&rk3036_pin_ctrl },
>  	{ .compatible = "rockchip,rk3066a-pinctrl",
>  		.data = (void *)&rk3066a_pin_ctrl },
>  	{ .compatible = "rockchip,rk3066b-pinctrl",
