From: architt@codeaurora.org (Archit Taneja)
Date: Wed, 14 Mar 2018 11:53:20 +0530
Subject: [PATCH v5 17/36] drm/bridge: analogix_dp: Fix AUX_PD bit for
 Rockchip
In-Reply-To: <20180309222327.18689-18-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-18-enric.balletbo@collabora.com>
Message-ID: <0b27e434-92fd-0033-9a45-a87170de2da1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 10 March 2018 03:53 AM, Enric Balletbo i Serra wrote:
> From: zain wang <wzz@rock-chips.com>
> 
> There are some different bits between Rockchip and Exynos in register
> "AUX_PD". This patch fixes the incorrect operations about it.

You mean the register ANALOGIX_DP_PHY_PD/ANALOGIX_DP_PD, right? AUX_PD
sounds like just one of the fields of the register.

With that,

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 117 ++++++++++++----------
>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h |   2 +
>   2 files changed, 65 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> index bb72f8b0e603..dee1ba109b5f 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -248,76 +248,85 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
>   {
>   	u32 reg;
>   	u32 phy_pd_addr = ANALOGIX_DP_PHY_PD;
> +	u32 mask;
>   
>   	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
>   		phy_pd_addr = ANALOGIX_DP_PD;
>   
>   	switch (block) {
>   	case AUX_BLOCK:
> -		if (enable) {
> -			reg = readl(dp->reg_base + phy_pd_addr);
> -			reg |= AUX_PD;
> -			writel(reg, dp->reg_base + phy_pd_addr);
> -		} else {
> -			reg = readl(dp->reg_base + phy_pd_addr);
> -			reg &= ~AUX_PD;
> -			writel(reg, dp->reg_base + phy_pd_addr);
> -		}
> +		if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
> +			mask = RK_AUX_PD;
> +		else
> +			mask = AUX_PD;
> +
> +		reg = readl(dp->reg_base + phy_pd_addr);
> +		if (enable)
> +			reg |= mask;
> +		else
> +			reg &= ~mask;
> +		writel(reg, dp->reg_base + phy_pd_addr);
>   		break;
>   	case CH0_BLOCK:
> -		if (enable) {
> -			reg = readl(dp->reg_base + phy_pd_addr);
> -			reg |= CH0_PD;
> -			writel(reg, dp->reg_base + phy_pd_addr);
> -		} else {
> -			reg = readl(dp->reg_base + phy_pd_addr);
> -			reg &= ~CH0_PD;
> -			writel(reg, dp->reg_base + phy_pd_addr);
> -		}
> +		mask = CH0_PD;
> +		reg = readl(dp->reg_base + phy_pd_addr);
> +
> +		if (enable)
> +			reg |= mask;
> +		else
> +			reg &= ~mask;
> +		writel(reg, dp->reg_base + phy_pd_addr);
>   		break;
>   	case CH1_BLOCK:
> -		if (enable) {
> -			reg = readl(dp->reg_base + phy_pd_addr);
> -			reg |= CH1_PD;
> -			writel(reg, dp->reg_base + phy_pd_addr);
> -		} else {
> -			reg = readl(dp->reg_base + phy_pd_addr);
> -			reg &= ~CH1_PD;
> -			writel(reg, dp->reg_base + phy_pd_addr);
> -		}
> +		mask = CH1_PD;
> +		reg = readl(dp->reg_base + phy_pd_addr);
> +
> +		if (enable)
> +			reg |= mask;
> +		else
> +			reg &= ~mask;
> +		writel(reg, dp->reg_base + phy_pd_addr);
>   		break;
>   	case CH2_BLOCK:
> -		if (enable) {
> -			reg = readl(dp->reg_base + phy_pd_addr);
> -			reg |= CH2_PD;
> -			writel(reg, dp->reg_base + phy_pd_addr);
> -		} else {
> -			reg = readl(dp->reg_base + phy_pd_addr);
> -			reg &= ~CH2_PD;
> -			writel(reg, dp->reg_base + phy_pd_addr);
> -		}
> +		mask = CH2_PD;
> +		reg = readl(dp->reg_base + phy_pd_addr);
> +
> +		if (enable)
> +			reg |= mask;
> +		else
> +			reg &= ~mask;
> +		writel(reg, dp->reg_base + phy_pd_addr);
>   		break;
>   	case CH3_BLOCK:
> -		if (enable) {
> -			reg = readl(dp->reg_base + phy_pd_addr);
> -			reg |= CH3_PD;
> -			writel(reg, dp->reg_base + phy_pd_addr);
> -		} else {
> -			reg = readl(dp->reg_base + phy_pd_addr);
> -			reg &= ~CH3_PD;
> -			writel(reg, dp->reg_base + phy_pd_addr);
> -		}
> +		mask = CH3_PD;
> +		reg = readl(dp->reg_base + phy_pd_addr);
> +
> +		if (enable)
> +			reg |= mask;
> +		else
> +			reg &= ~mask;
> +		writel(reg, dp->reg_base + phy_pd_addr);
>   		break;
>   	case ANALOG_TOTAL:
> -		if (enable) {
> -			reg = readl(dp->reg_base + phy_pd_addr);
> -			reg |= DP_PHY_PD;
> -			writel(reg, dp->reg_base + phy_pd_addr);
> -		} else {
> -			reg = readl(dp->reg_base + phy_pd_addr);
> -			reg &= ~DP_PHY_PD;
> -			writel(reg, dp->reg_base + phy_pd_addr);
> -		}
> +		/*
> +		 * There is no bit named DP_PHY_PD, so We used DP_INC_BG
> +		 * to power off everything instead of DP_PHY_PD in
> +		 * Rockchip
> +		 */
> +		if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
> +			mask = DP_INC_BG;
> +		else
> +			mask = DP_PHY_PD;
> +
> +		reg = readl(dp->reg_base + phy_pd_addr);
> +		if (enable)
> +			reg |= mask;
> +		else
> +			reg &= ~mask;
> +
> +		writel(reg, dp->reg_base + phy_pd_addr);
> +		if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
> +			usleep_range(10, 15);
>   		break;
>   	case POWER_ALL:
>   		if (enable) {
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
> index 9602668669f4..b633a4a5082a 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
> @@ -345,7 +345,9 @@
>   #define DP_INC_BG				(0x1 << 7)
>   #define DP_EXP_BG				(0x1 << 6)
>   #define DP_PHY_PD				(0x1 << 5)
> +#define RK_AUX_PD				(0x1 << 5)
>   #define AUX_PD					(0x1 << 4)
> +#define RK_PLL_PD				(0x1 << 4)
>   #define CH3_PD					(0x1 << 3)
>   #define CH2_PD					(0x1 << 2)
>   #define CH1_PD					(0x1 << 1)
> 
