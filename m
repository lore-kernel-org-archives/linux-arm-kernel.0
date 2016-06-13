From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Mon, 13 Jun 2016 15:58:41 +0800
Subject: [PATCH 01/11] phy: rockchip-emmc: Increase lock time allowance
In-Reply-To: <1465339484-969-2-git-send-email-dianders@chromium.org>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-2-git-send-email-dianders@chromium.org>
Message-ID: <3e19ff54-ee4a-c208-e137-1c0f8022f6b3@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/6/8 6:44, Douglas Anderson wrote:
> Previous PHY code waited a fixed amount of time for the DLL to lock at
> power on time.  Unfortunately, the time for the DLL to lock is actually
> a bit more dynamic and can be longer if the card clock is slower.
>
> Instead of waiting a fixed 30 us, let's now dynamically wait until the
> lock bit gets set.  We'll wait up to 10 ms which should be OK even if
> the card clock is at the super slow 100 kHz.
>

mmc stack limit the min freq to 200k when initializing the card.
So 5ms is enough, but it's ok to set the max timeout to 10ms as we
can break out if locked.

> On its own, this change makes the PHY power on code a little more
> robust.  Before this change the PHY was relying on the eMMC code to make
> sure the PHY was only powered on when the card clock was set to at least
> 50 MHz before, though this reliance wasn't documented anywhere.
>
> This change will be even more useful in future changes where we actually
> need to be able to wait for a DLL lock at slower clock speeds.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>  drivers/phy/phy-rockchip-emmc.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
> index a69f53630e67..8336053aea5c 100644
> --- a/drivers/phy/phy-rockchip-emmc.c
> +++ b/drivers/phy/phy-rockchip-emmc.c
> @@ -85,6 +85,7 @@ static int rockchip_emmc_phy_power(struct rockchip_emmc_phy *rk_phy,
>  {
>  	unsigned int caldone;
>  	unsigned int dllrdy;
> +	unsigned long timeout;
>
>  	/*
>  	 * Keep phyctrl_pdb and phyctrl_endll low to allow
> @@ -137,15 +138,25 @@ static int rockchip_emmc_phy_power(struct rockchip_emmc_phy *rk_phy,
>  				   PHYCTRL_ENDLL_MASK,
>  				   PHYCTRL_ENDLL_SHIFT));
>  	/*
> -	 * After enable analog DLL circuits, we need an extra 10.2us
> -	 * for dll to be ready for work. But according to testing, we
> -	 * find some chips need more than 25us.
> +	 * After enabling analog DLL circuits docs say that we need 10.2 us if
> +	 * our source clock is at 50 MHz and that lock time scales linearly
> +	 * with clock speed.  If we are powering on the PHY and the card clock
> +	 * is super slow (like 100 kHZ) this could take as long as 5.1 ms.

5.1ms is by calculation or test?

> +	 * Hopefully we won't be running at 100 kHz, but we should still make
> +	 * sure we wait long enough.
>  	 */
> -	udelay(30);
> -	regmap_read(rk_phy->reg_base,
> -		    rk_phy->reg_offset + GRF_EMMCPHY_STATUS,
> -		    &dllrdy);
> -	dllrdy = (dllrdy >> PHYCTRL_DLLRDY_SHIFT) & PHYCTRL_DLLRDY_MASK;
> +	timeout = jiffies + msecs_to_jiffies(10);
> +	do {
> +		udelay(1);
> +
> +		regmap_read(rk_phy->reg_base,
> +			rk_phy->reg_offset + GRF_EMMCPHY_STATUS,
> +			&dllrdy);
> +		dllrdy = (dllrdy >> PHYCTRL_DLLRDY_SHIFT) & PHYCTRL_DLLRDY_MASK;
> +		if (dllrdy == PHYCTRL_DLLRDY_DONE)
> +			break;
> +	} while (!time_after(jiffies, timeout));
> +
>  	if (dllrdy != PHYCTRL_DLLRDY_DONE) {
>  		pr_err("rockchip_emmc_phy_power: dllrdy timeout.\n");
>  		return -ETIMEDOUT;
>


-- 
Best Regards
Shawn Lin
