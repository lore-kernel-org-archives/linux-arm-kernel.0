From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 20 Jun 2016 18:41:26 +0530
Subject: [PATCH 1/4] phy: rockchip-emmc: give DLL some extra time to be
 ready
In-Reply-To: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
References: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
Message-ID: <5767EB7E.3040606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 13 May 2016 04:13 AM, Brian Norris wrote:
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> According to the databook, 10.2us is the max time for dll to be ready to
> work. However in testing, some chips need 20us for dll to be ready. This
> patch adds some extra margin for dllrdy to be ready, fixing our
> -ETIMEDOUT issues.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/phy-rockchip-emmc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
> index 6ebcf3e41c46..48cbe691a889 100644
> --- a/drivers/phy/phy-rockchip-emmc.c
> +++ b/drivers/phy/phy-rockchip-emmc.c
> @@ -119,10 +119,11 @@ static int rockchip_emmc_phy_power(struct rockchip_emmc_phy *rk_phy,
>  				   PHYCTRL_ENDLL_MASK,
>  				   PHYCTRL_ENDLL_SHIFT));
>  	/*
> -	 * After enable analog DLL circuits, we need extra 10.2us
> -	 * for dll to be ready for work.
> +	 * After enable analog DLL circuits, we need an extra 10.2us
> +	 * for dll to be ready for work. But according to testing, we
> +	 * find some chips need more than 25us.
>  	 */
> -	udelay(11);
> +	udelay(30);
>  	regmap_read(rk_phy->reg_base,
>  		    rk_phy->reg_offset + GRF_EMMCPHY_STATUS,
>  		    &dllrdy);
> 
