From: net147@gmail.com (Jonathan Liu)
Date: Tue, 26 Sep 2017 21:42:09 +1000
Subject: [PATCH] usb: musb: sunxi: Explicitly release USB PHY on exit
In-Reply-To: <20170926113923.18181-1-net147@gmail.com>
References: <20170926113923.18181-1-net147@gmail.com>
Message-ID: <CANwerB3CK-0T2r4DbJo8vGnMHU_Qsa8JQE1HLfMocPcAgLh4Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26 September 2017 at 21:39, Jonathan Liu <net147@gmail.com> wrote:
> This fixes a kernel oops when unloading the driver due to usb_put_phy
> being called after usb_phy_generic_unregister when the device is
> detached. Calling usb_phy_generic_unregister causes x->dev->driver to
> be NULL in usb_put_phy and results in a NULL pointer dereference.
>
> As we are now explicitly managing the lifetime of usb_phy,
> devm_usb_get_phy is changed to usb_get_phy and we call usb_put_phy in
> the probe error path.
>
> Cc: stable at vger.kernel.org # v4.3+
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> ---
>  drivers/usb/musb/sunxi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
> index c9a09b5bb6e5..8eed61042103 100644
> --- a/drivers/usb/musb/sunxi.c
> +++ b/drivers/usb/musb/sunxi.c
> @@ -297,6 +297,8 @@ static int sunxi_musb_exit(struct musb *musb)
>         if (test_bit(SUNXI_MUSB_FL_HAS_SRAM, &glue->flags))
>                 sunxi_sram_release(musb->controller->parent);
>
> +       usb_put_phy(glue->xceiv);
> +
>         return 0;
>  }
>
> @@ -781,7 +783,7 @@ static int sunxi_musb_probe(struct platform_device *pdev)
>                 return PTR_ERR(glue->usb_phy);
>         }
>
> -       glue->xceiv = devm_usb_get_phy(&pdev->dev, USB_PHY_TYPE_USB2);
> +       glue->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
>         if (IS_ERR(glue->xceiv)) {
>                 ret = PTR_ERR(glue->xceiv);
>                 dev_err(&pdev->dev, "Error getting usb-phy %d\n", ret);
> @@ -803,11 +805,13 @@ static int sunxi_musb_probe(struct platform_device *pdev)
>         if (IS_ERR(glue->musb_pdev)) {
>                 ret = PTR_ERR(glue->musb_pdev);
>                 dev_err(&pdev->dev, "Error registering musb dev: %d\n", ret);
> -               goto err_unregister_usb_phy;
> +               goto err_put_usb_phy;
>         }
>
>         return 0;
>
> +err_put_usb_phy:
> +       usb_put_phy(glue->xceiv);
>  err_unregister_usb_phy:
>         usb_phy_generic_unregister(glue->usb_phy);
>         return ret;
> --
> 2.13.2
>

Another way I could fix this would be to check if x->dev->driver is
NULL before dereferencing in usb_put_phy but I am not sure if this
breaks any expectations in the USB subsystem...

Regards,
Jonathan
