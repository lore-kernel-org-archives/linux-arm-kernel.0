From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Feb 2013 11:22:47 +0200
Subject: [PATCH v2 05/30] usb: phy: nop: Handle RESET for the PHY
In-Reply-To: <1359372631-8180-6-git-send-email-rogerq@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
 <1359372631-8180-6-git-send-email-rogerq@ti.com>
Message-ID: <20130205092247.GN32118@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 01:30:06PM +0200, Roger Quadros wrote:
> We expect the RESET line to be modeled as a regulator with supply
> name "reset". The regulator should be modeled such that enabling
> the regulator brings the PHY device out of RESET and disabling the
> regulator holds the device in RESET.
> 
> They PHY will be held in RESET in .shutdown() and brought out of
> RESET in .init().
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/usb/otg/nop-usb-xceiv.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
> index 0a9628c..3060ed0 100644
> --- a/drivers/usb/otg/nop-usb-xceiv.c
> +++ b/drivers/usb/otg/nop-usb-xceiv.c
> @@ -40,6 +40,7 @@ struct nop_usb_xceiv {
>  	struct device		*dev;
>  	struct clk		*clk;
>  	struct regulator	*vcc;
> +	struct regulator	*reset;
>  };
>  
>  static struct platform_device *pd;
> @@ -80,6 +81,12 @@ static int nop_init(struct usb_phy *phy)
>  	if (!IS_ERR(nop->clk))
>  		clk_enable(nop->clk);
>  
> +	if (!IS_ERR(nop->reset)) {
> +		/* De-assert RESET */
> +		if (regulator_enable(nop->reset))
> +			dev_err(phy->dev, "Failed to de-assert reset\n");
> +	}
> +
>  	return 0;
>  }
>  
> @@ -87,6 +94,12 @@ static void nop_shutdown(struct usb_phy *phy)
>  {
>  	struct nop_usb_xceiv *nop = dev_get_drvdata(phy->dev);
>  
> +	if (!IS_ERR(nop->reset)) {
> +		/* Assert RESET */
> +		if (regulator_disable(nop->reset))
> +			dev_err(phy->dev, "Failed to assert reset\n");
> +	}
> +
>  	if (!IS_ERR(nop->clk))
>  		clk_disable(nop->clk);
>  
> @@ -171,6 +184,12 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
>  					PTR_ERR(nop->vcc));
>  	}
>  
> +	nop->reset = devm_regulator_get(&pdev->dev, "reset");
> +	if (IS_ERR(nop->reset)) {
> +		dev_dbg(&pdev->dev, "Error getting reset regulator: %ld\n",
> +					PTR_ERR(nop->reset));
> +	}
> +
>  	nop->dev		= &pdev->dev;
>  	nop->phy.dev		= nop->dev;
>  	nop->phy.label		= "nop-xceiv";
> -- 
> 1.7.4.1
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/c1be955c/attachment.sig>
