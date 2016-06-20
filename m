From: groeck@google.com (Guenter Roeck)
Date: Mon, 20 Jun 2016 12:29:45 -0700
Subject: [PATCH v3 05/15] phy: rockchip-emmc: Increase lock time allowance
In-Reply-To: <1466445414-11974-6-git-send-email-dianders@chromium.org>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
 <1466445414-11974-6-git-send-email-dianders@chromium.org>
Message-ID: <CABXOdTeO8--Rk2k8tk62uiPa6T=ZoDZjBQwMHyWpNBwJo2pinA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 10:56 AM, Douglas Anderson
<dianders@chromium.org> wrote:
> Previous PHY code waited a fixed amount of time for the DLL to lock at
> power on time.  Unfortunately, the time for the DLL to lock is actually
> a bit more dynamic and can be longer if the card clock is slower.
>
> Instead of waiting a fixed 30 us, let's now dynamically wait until the
> lock bit gets set.  We'll wait up to 10 ms which should be OK even if
> the card clock is at the super slow 100 kHz.
>

10 ms active delay (no sleep) is actually quite long. Can this code sleep ?

> On its own, this change makes the PHY power on code a little more
> robust.  Before this change the PHY was relying on the eMMC code to make
> sure the PHY was only powered on when the card clock was set to at least
> 50 MHz before, though this reliance wasn't documented anywhere.
>
> This change will be even more useful in future changes where we actually
> need to be able to wait for a DLL lock at slower clock speeds.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Changes in v3:
> - Add collected tags
>
> Changes in v2:
> - Indicate that 5.1 ms is calculated (Shawn).
>
>  drivers/phy/phy-rockchip-emmc.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
> index a69f53630e67..2d059c046978 100644
> --- a/drivers/phy/phy-rockchip-emmc.c
> +++ b/drivers/phy/phy-rockchip-emmc.c
> @@ -85,6 +85,7 @@ static int rockchip_emmc_phy_power(struct rockchip_emmc_phy *rk_phy,
>  {
>         unsigned int caldone;
>         unsigned int dllrdy;
> +       unsigned long timeout;
>
>         /*
>          * Keep phyctrl_pdb and phyctrl_endll low to allow
> @@ -137,15 +138,26 @@ static int rockchip_emmc_phy_power(struct rockchip_emmc_phy *rk_phy,
>                                    PHYCTRL_ENDLL_MASK,
>                                    PHYCTRL_ENDLL_SHIFT));
>         /*
> -        * After enable analog DLL circuits, we need an extra 10.2us
> -        * for dll to be ready for work. But according to testing, we
> -        * find some chips need more than 25us.
> +        * After enabling analog DLL circuits docs say that we need 10.2 us if
> +        * our source clock is at 50 MHz and that lock time scales linearly
> +        * with clock speed.  If we are powering on the PHY and the card clock
> +        * is super slow (like 100 kHZ) this could take as long as 5.1 ms as
> +        * per the math: 10.2 us * (50000000 Hz / 100000 Hz) => 5.1 ms
> +        * Hopefully we won't be running at 100 kHz, but we should still make
> +        * sure we wait long enough.
>          */
> -       udelay(30);
> -       regmap_read(rk_phy->reg_base,
> -                   rk_phy->reg_offset + GRF_EMMCPHY_STATUS,
> -                   &dllrdy);
> -       dllrdy = (dllrdy >> PHYCTRL_DLLRDY_SHIFT) & PHYCTRL_DLLRDY_MASK;
> +       timeout = jiffies + msecs_to_jiffies(10);
> +       do {
> +               udelay(1);
> +
> +               regmap_read(rk_phy->reg_base,
> +                       rk_phy->reg_offset + GRF_EMMCPHY_STATUS,
> +                       &dllrdy);
> +               dllrdy = (dllrdy >> PHYCTRL_DLLRDY_SHIFT) & PHYCTRL_DLLRDY_MASK;
> +               if (dllrdy == PHYCTRL_DLLRDY_DONE)
> +                       break;
> +       } while (!time_after(jiffies, timeout));
> +
>         if (dllrdy != PHYCTRL_DLLRDY_DONE) {
>                 pr_err("rockchip_emmc_phy_power: dllrdy timeout.\n");
>                 return -ETIMEDOUT;
> --
> 2.8.0.rc3.226.g39d4020
>
