From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Jan 2015 16:24:10 +0100
Subject: [PATCH] usb: phy-generic: Don't fail on missing gpio reset
In-Reply-To: <1422323129-20969-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1422323129-20969-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1488241.JRB4nxvr9q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 26 January 2015 17:45:29 Soren Brinkmann wrote:
> diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
> index dd05254241fb..a73d4c738f0b 100644
> --- a/drivers/usb/phy/phy-generic.c
> +++ b/drivers/usb/phy/phy-generic.c
> @@ -241,10 +241,8 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop,
>  
>         if (err == -EPROBE_DEFER)
>                 return -EPROBE_DEFER;
> -       if (err) {
> -               dev_err(dev, "Error requesting RESET GPIO\n");
> -               return err;
> -       }
> +       if (err)
> +               nop->gpiod_reset = NULL;

You might want to distinguish between a missing property and a
reset gpio that was specified but for some reason cannot be used.

	Arnd
