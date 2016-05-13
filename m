From: dianders@chromium.org (Doug Anderson)
Date: Fri, 13 May 2016 15:01:56 -0700
Subject: [PATCH 1/4] phy: rockchip-emmc: give DLL some extra time to be
 ready
In-Reply-To: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
References: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
Message-ID: <CAD=FV=WxWz4wyFPJ=gt7bzQb-cvkASB2aRm+e-2wPrUQ6ZaSEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 12, 2016 at 3:43 PM, Brian Norris <briannorris@chromium.org> wrote:
> From: Shawn Lin <shawn.lin@rock-chips.com>
>
> According to the databook, 10.2us is the max time for dll to be ready to
> work. However in testing, some chips need 20us for dll to be ready. This
> patch adds some extra margin for dllrdy to be ready, fixing our
> -ETIMEDOUT issues.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/phy/phy-rockchip-emmc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
> index 6ebcf3e41c46..48cbe691a889 100644
> --- a/drivers/phy/phy-rockchip-emmc.c
> +++ b/drivers/phy/phy-rockchip-emmc.c
> @@ -119,10 +119,11 @@ static int rockchip_emmc_phy_power(struct rockchip_emmc_phy *rk_phy,
>                                    PHYCTRL_ENDLL_MASK,
>                                    PHYCTRL_ENDLL_SHIFT));
>         /*
> -        * After enable analog DLL circuits, we need extra 10.2us
> -        * for dll to be ready for work.
> +        * After enable analog DLL circuits, we need an extra 10.2us
> +        * for dll to be ready for work. But according to testing, we
> +        * find some chips need more than 25us.
>          */
> -       udelay(11);
> +       udelay(30);
>         regmap_read(rk_phy->reg_base,
>                     rk_phy->reg_offset + GRF_EMMCPHY_STATUS,
>                     &dllrdy);

Seems sane.  This is a "random delay" but you've documented it well,
and an extra 19 microseconds won't be the end of the world.

If we truly trusted the "DLLRDY" bit we could actually do a loop here,
but it's probably not worth it...

Reviewed-by: Douglas Anderson <dianders@chromium.org>
