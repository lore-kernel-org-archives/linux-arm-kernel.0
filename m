From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 15 Feb 2017 00:36:56 +0100
Subject: [PATCH 10/14] phy: meson8b-usb2: simplify optional reset handling
In-Reply-To: <20170130114116.22089-10-p.zabel@pengutronix.de>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
 <20170130114116.22089-10-p.zabel@pengutronix.de>
Message-ID: <CAFBinCAASGS19naW76vfynRj4Fg4KjpHcwGr5h+pWZae47rwRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

sorry for the late reply.
unfortunately my GXBB board (which is supported by the driver below) is dead.
I CC'ed Jerome Brunet - maybe he can give it a go on one of his (GXBB) boards.

On Mon, Jan 30, 2017 at 12:41 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> As of commit bb475230b8e5 ("reset: make optional functions really
> optional"), the reset framework API calls use NULL pointers to describe
> optional, non-present reset controls.
>
> This allows to return errors from devm_reset_control_get_optional_shared
> and to call reset_control_reset unconditionally.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

(based on reading the code along with the highly appreciated changes
from bb475230b8e5)

> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/phy-meson8b-usb2.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/phy/phy-meson8b-usb2.c b/drivers/phy/phy-meson8b-usb2.c
> index 33c9f4ba157d1..87168f1fe3af6 100644
> --- a/drivers/phy/phy-meson8b-usb2.c
> +++ b/drivers/phy/phy-meson8b-usb2.c
> @@ -141,12 +141,10 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
>         struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
>         int ret;
>
> -       if (!IS_ERR_OR_NULL(priv->reset)) {
> -               ret = reset_control_reset(priv->reset);
> -               if (ret) {
> -                       dev_err(&phy->dev, "Failed to trigger USB reset\n");
> -                       return ret;
> -               }
> +       ret = reset_control_reset(priv->reset);
> +       if (ret) {
> +               dev_err(&phy->dev, "Failed to trigger USB reset\n");
> +               return ret;
>         }
>
>         ret = clk_prepare_enable(priv->clk_usb_general);
> @@ -241,7 +239,7 @@ static int phy_meson8b_usb2_probe(struct platform_device *pdev)
>                 return PTR_ERR(priv->clk_usb);
>
>         priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> -       if (PTR_ERR(priv->reset) == -EPROBE_DEFER)
> +       if (PTR_ERR(priv->reset))
>                 return PTR_ERR(priv->reset);
>
>         priv->dr_mode = of_usb_get_dr_mode_by_phy(pdev->dev.of_node, -1);
> --
> 2.11.0
>
