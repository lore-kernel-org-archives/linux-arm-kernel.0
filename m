From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Mon, 5 Mar 2018 22:39:04 +0800
Subject: [PATCH] soc: rockchip: disable jtag switching for RK3128 SoCs
In-Reply-To: <20180302122031.17426-1-heiko@sntech.de>
References: <20180302122031.17426-1-heiko@sntech.de>
Message-ID: <7020f92d-cc0e-745e-713b-3aa847b7e939@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/3/2 20:20, Heiko Stuebner wrote:
> From: Xiao Yao <xiaoyao@rock-chips.com>
> 
> Disable IO function switching between sdmmc and jtag
> for RK3128 SoCs.
> 

I acked this on the vendor kernel tree, so FWIW:

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Hope this is one of the final patches for that, as I would
revive IO function switching between sdmmc and jtag for newer
SoCs after addressing the problem from HW level.



> Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   drivers/soc/rockchip/grf.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
> index dd81b87d79f0..96882ffde67e 100644
> --- a/drivers/soc/rockchip/grf.c
> +++ b/drivers/soc/rockchip/grf.c
> @@ -43,6 +43,17 @@ static const struct rockchip_grf_info rk3036_grf __initconst = {
>   	.num_values = ARRAY_SIZE(rk3036_defaults),
>   };
>   
> +#define RK3128_GRF_SOC_CON0		0x140
> +
> +static const struct rockchip_grf_value rk3128_defaults[] __initconst = {
> +	{ "jtag switching", RK3128_GRF_SOC_CON0, HIWORD_UPDATE(0, 1, 8) },
> +};
> +
> +static const struct rockchip_grf_info rk3128_grf __initconst = {
> +	.values = rk3128_defaults,
> +	.num_values = ARRAY_SIZE(rk3128_defaults),
> +};
> +
>   #define RK3228_GRF_SOC_CON6		0x418
>   
>   static const struct rockchip_grf_value rk3228_defaults[] __initconst = {
> @@ -102,6 +113,9 @@ static const struct of_device_id rockchip_grf_dt_match[] __initconst = {
>   	{
>   		.compatible = "rockchip,rk3036-grf",
>   		.data = (void *)&rk3036_grf,
> +	}, {
> +		.compatible = "rockchip,rk3128-grf",
> +		.data = (void *)&rk3128_grf,
>   	}, {
>   		.compatible = "rockchip,rk3228-grf",
>   		.data = (void *)&rk3228_grf,
> 


-- 
Best Regards
Shawn Lin
