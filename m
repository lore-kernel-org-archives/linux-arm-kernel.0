From: architt@codeaurora.org (Archit Taneja)
Date: Wed, 14 Mar 2018 11:40:43 +0530
Subject: [PATCH v5 12/36] drm/bridge: analogix_dp: Set PD_INC_BG first
 when powering up edp phy
In-Reply-To: <20180309222327.18689-13-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-13-enric.balletbo@collabora.com>
Message-ID: <c43cba93-6068-6a2d-3d0a-85057d5f8b10@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 10 March 2018 03:53 AM, Enric Balletbo i Serra wrote:
> From: zain wang <wzz@rock-chips.com>
> 
> Following the correct power up sequence:
> dp_pd=ff => dp_pd=7f => wait 10us => dp_pd=00
> 

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

> Cc: St?phane Marchesin <marcheu@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 10 ++++++++--
>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h |  3 +++
>   2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> index b47c5af43560..bb72f8b0e603 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -321,10 +321,16 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
>   		break;
>   	case POWER_ALL:
>   		if (enable) {
> -			reg = DP_PHY_PD | AUX_PD | CH3_PD | CH2_PD |
> -				CH1_PD | CH0_PD;
> +			reg = DP_ALL_PD;
>   			writel(reg, dp->reg_base + phy_pd_addr);
>   		} else {
> +			reg = DP_ALL_PD;
> +			writel(reg, dp->reg_base + phy_pd_addr);
> +			usleep_range(10, 15);
> +			reg &= ~DP_INC_BG;
> +			writel(reg, dp->reg_base + phy_pd_addr);
> +			usleep_range(10, 15);
> +
>   			writel(0x00, dp->reg_base + phy_pd_addr);
>   		}
>   		break;
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
> index 40200c652533..9602668669f4 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
> @@ -342,12 +342,15 @@
>   #define DP_PLL_REF_BIT_1_2500V			(0x7 << 0)
>   
>   /* ANALOGIX_DP_PHY_PD */
> +#define DP_INC_BG				(0x1 << 7)
> +#define DP_EXP_BG				(0x1 << 6)
>   #define DP_PHY_PD				(0x1 << 5)
>   #define AUX_PD					(0x1 << 4)
>   #define CH3_PD					(0x1 << 3)
>   #define CH2_PD					(0x1 << 2)
>   #define CH1_PD					(0x1 << 1)
>   #define CH0_PD					(0x1 << 0)
> +#define DP_ALL_PD				(0xff)
>   
>   /* ANALOGIX_DP_PHY_TEST */
>   #define MACRO_RST				(0x1 << 5)
> 
