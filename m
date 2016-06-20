From: groeck@google.com (Guenter Roeck)
Date: Mon, 20 Jun 2016 12:23:59 -0700
Subject: [PATCH v3 01/15] phy: rockchip-emmc: give DLL some extra time to
 be ready
In-Reply-To: <1466445414-11974-2-git-send-email-dianders@chromium.org>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
 <1466445414-11974-2-git-send-email-dianders@chromium.org>
Message-ID: <CABXOdTeQhOSUeX+-as_6S5H1mnVnyBsEDU9ZsiC97Yb+qWiFew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 10:56 AM, Douglas Anderson
<dianders@chromium.org> wrote:
> From: Shawn Lin <shawn.lin@rock-chips.com>
>
> According to the databook, 10.2us is the max time for dll to be ready to
> work. However in testing, some chips need 20us for dll to be ready. This

Nitpick, but description (20uS) and code (more than 25 uS) don't match.

> patch adds some extra margin for dllrdy to be ready, fixing our
> -ETIMEDOUT issues.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Changes in v3:
> - Add Brian's PHY patches into my series
>
> Changes in v2: None
>
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
> --
> 2.8.0.rc3.226.g39d4020
>
