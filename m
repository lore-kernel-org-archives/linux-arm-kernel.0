From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 19 Dec 2012 21:29:26 +0100
Subject: [PATCH 2/2] mxc: enable EHCI PER clock
In-Reply-To: <1355941777-99352-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1355941777-99352-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1355941777-99352-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20121219202926.GB19651@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 07:29:37PM +0100, Gwenhael Goavec-Merou wrote:
> EHCI PER clock (aka usb_div) must be enabled to have EHCI driver working.
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> ---
>  drivers/usb/host/ehci-mxc.c |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
> index ec7f5d2..8050631 100644
> --- a/drivers/usb/host/ehci-mxc.c
> +++ b/drivers/usb/host/ehci-mxc.c
> @@ -31,7 +31,7 @@
>  #define ULPI_VIEWPORT_OFFSET	0x170
>  
>  struct ehci_mxc_priv {
> -	struct clk *usbclk, *ahbclk, *phyclk;
> +	struct clk *usbclk, *ahbclk, *perclk, *phyclk;
>  	struct usb_hcd *hcd;
>  };
>  
> @@ -150,6 +150,13 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>  	}
>  	clk_prepare_enable(priv->ahbclk);
>  
> +	priv->perclk = devm_clk_get(&pdev->dev, "per");
> +	if (IS_ERR(priv->perclk)) {
> +		ret = PTR_ERR(priv->perclk);
> +		goto err_clk_per;
> +	}
> +	clk_prepare_enable(priv->perclk);

Have you checked this clock is present on all SoCs using this driver?

Other than that, +1 on using the chipidea driver as Fabio and Marek
already noted.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
