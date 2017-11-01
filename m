From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 1 Nov 2017 11:32:43 -0400 (EDT)
Subject: [PATCH 1/2] usb: ehci-platform: use reset array API
In-Reply-To: <1509356120-21473-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <Pine.LNX.4.44L0.1711011118570.1770-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Oct 2017, Masahiro Yamada wrote:

> Generic drivers like this need to control arbitrary numbers of reset
> lines.  Instead of hard-coding the maximum number of resets, use the
> reset array API.  It can manage a bunch of resets behind the scene.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>  drivers/usb/host/ehci-platform.c | 33 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index f1908ea..64fd643 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -40,12 +40,11 @@
>  
>  #define DRIVER_DESC "EHCI generic platform driver"
>  #define EHCI_MAX_CLKS 4
> -#define EHCI_MAX_RSTS 4
>  #define hcd_to_ehci_priv(h) ((struct ehci_platform_priv *)hcd_to_ehci(h)->priv)
>  
>  struct ehci_platform_priv {
>  	struct clk *clks[EHCI_MAX_CLKS];
> -	struct reset_control *rsts[EHCI_MAX_RSTS];
> +	struct reset_control *rsts;
>  	struct phy **phys;
>  	int num_phys;
>  	bool reset_on_resume;
> @@ -151,7 +150,7 @@ static int ehci_platform_probe(struct platform_device *dev)
>  	struct usb_ehci_pdata *pdata = dev_get_platdata(&dev->dev);
>  	struct ehci_platform_priv *priv;
>  	struct ehci_hcd *ehci;
> -	int err, irq, phy_num, clk = 0, rst;
> +	int err, irq, phy_num, clk = 0;
>  
>  	if (usb_disabled())
>  		return -ENODEV;
> @@ -239,21 +238,13 @@ static int ehci_platform_probe(struct platform_device *dev)
>  		}
>  	}
>  
> -	for (rst = 0; rst < EHCI_MAX_RSTS; rst++) {
> -		priv->rsts[rst] = devm_reset_control_get_shared_by_index(
> -					&dev->dev, rst);
> -		if (IS_ERR(priv->rsts[rst])) {
> -			err = PTR_ERR(priv->rsts[rst]);
> -			if (err == -EPROBE_DEFER)
> -				goto err_reset;
> -			priv->rsts[rst] = NULL;
> -			break;
> -		}
> +	priv->rsts = devm_reset_control_array_get_optional_shared(&dev->dev);
> +	if (IS_ERR(priv->rsts))
> +		return PTR_ERR(priv->rsts);

You must not return.  Instead you should set err and jump to 
err_put_clks.

Alan Stern
