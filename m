From: groeck@google.com (Guenter Roeck)
Date: Sat, 30 Sep 2017 03:38:18 -0700
Subject: [PATCH] phy: rockchip-typec: Check for errors from
 tcphy_phy_init()
In-Reply-To: <20170929235846.1913-1-dianders@chromium.org>
References: <20170929235846.1913-1-dianders@chromium.org>
Message-ID: <CABXOdTdukST-8tRh6Z2mRTFYwseiknEzB7FL+uiz_PxYrYYjgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 4:58 PM, Douglas Anderson <dianders@chromium.org> wrote:
> The function tcphy_phy_init() could return an error but the callers
> weren't checking the return value.  They should.  In at least one case
> while testing I saw the message "wait pma ready timeout" which
> indicates that tcphy_phy_init() really could return an error and we
> should account for it.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/phy/rockchip/phy-rockchip-typec.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
> index 4d2c57f21d76..38831eebc934 100644
> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c
> @@ -685,8 +685,11 @@ static int rockchip_usb3_phy_power_on(struct phy *phy)
>         if (tcphy->mode == new_mode)
>                 goto unlock_ret;
>
> -       if (tcphy->mode == MODE_DISCONNECT)
> -               tcphy_phy_init(tcphy, new_mode);
> +       if (tcphy->mode == MODE_DISCONNECT) {
> +               ret = tcphy_phy_init(tcphy, new_mode);
> +               if (ret)
> +                       goto unlock_ret;
> +       }
>
>         /* wait TCPHY for pipe ready */
>         for (timeout = 0; timeout < 100; timeout++) {
> @@ -760,10 +763,12 @@ static int rockchip_dp_phy_power_on(struct phy *phy)
>          */
>         if (new_mode == MODE_DFP_DP && tcphy->mode != MODE_DISCONNECT) {
>                 tcphy_phy_deinit(tcphy);
> -               tcphy_phy_init(tcphy, new_mode);
> +               ret = tcphy_phy_init(tcphy, new_mode);
>         } else if (tcphy->mode == MODE_DISCONNECT) {
> -               tcphy_phy_init(tcphy, new_mode);
> +               ret = tcphy_phy_init(tcphy, new_mode);
>         }
> +       if (ret)
> +               goto unlock_ret;
>
>         ret = readx_poll_timeout(readl, tcphy->base + DP_MODE_CTL,
>                                  val, val & DP_MODE_A2, 1000,
> --
> 2.14.2.822.g60be5d43e6-goog
>
