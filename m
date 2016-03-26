From: peter.griffin@linaro.org (Peter Griffin)
Date: Sat, 26 Mar 2016 09:10:50 +0000
Subject: [PATCH] usb: host: xhci-plat: Make enum xhci_plat_type start at
 a non zero value
In-Reply-To: <87io0a8nbd.fsf@ti.com>
References: <1458917188-28452-1-git-send-email-peter.griffin@linaro.org>
 <87mvpm8pfl.fsf@ti.com> <87mvpmlc5e.fsf@free-electrons.com>
 <87io0a8nbd.fsf@ti.com>
Message-ID: <20160326091050.GA7793@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Fri, 25 Mar 2016, Felipe Balbi wrote:

> 
> Hi,
> 
> Gregory CLEMENT <gregory.clement@free-electrons.com> writes:
> >> Peter Griffin <peter.griffin@linaro.org> writes:
> >>> Otherwise generic-xhci and xhci-platform which have no data get wrongly
> >>> detected as XHCI_PLAT_TYPE_MARVELL_ARMADA by xhci_plat_type_is().
> >>>
> >>> This fixes a regression in v4.5 for STiH407 family SoC's which use the
> >>> synopsis dwc3 IP, whereby the disable_clk error path gets taken due to
> >>> wrongly being detected as XHCI_PLAT_TYPE_MARVELL_ARMADA and the hcd never
> >>> gets added.
> >>>
> >>> I suspect this will also fix other dwc3 DT platforms such as Exynos,
> >>> although I've only tested on STih410 SoC.
> >>>
> >>> Fixes: 4efb2f694114 ("usb: host: xhci-plat: add struct xhci_plat_priv")
> >>> Cc: stable at vger.kernel.org
> >>> Cc: gregory.clement at free-electrons.com
> >>> Cc: yoshihiro.shimoda.uh at renesas.com
> >>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> >>> ---
> >>>  drivers/usb/host/xhci-plat.h | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
> >>> index 5a2e2e3..529c3c4 100644
> >>> --- a/drivers/usb/host/xhci-plat.h
> >>> +++ b/drivers/usb/host/xhci-plat.h
> >>> @@ -14,7 +14,7 @@
> >>>  #include "xhci.h"	/* for hcd_to_xhci() */
> >>>  
> >>>  enum xhci_plat_type {
> >>> -	XHCI_PLAT_TYPE_MARVELL_ARMADA,
> >>> +	XHCI_PLAT_TYPE_MARVELL_ARMADA = 1,
> >>>  	XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2,
> >>>  	XHCI_PLAT_TYPE_RENESAS_RCAR_GEN3,
> >>
> >> aren't these platforms using device tree ? Why aren't these just
> >> different compatible strings ?
> >
> > According to 4efb2f69411456d35051e9047c15157c9a5ba217 "usb: host:
> > xhci-plat: add struct xhci_plat_priv" :
> >
> > This patch adds struct xhci_plat_priv to simplify the code to match
> > platform specific variables. For now, this patch adds a member "type" in
> > the structure
> 
> that's fine but the answer doesn't exactly match my question ;-)
> 
> My point is that this enum shouldn't be necessary at all. We have
> compatible flags to make these checks instead. How about below ?
> (untested, uncompiled, yada yada yada). Note that we DON'T need this
> xhci_plat_type trickery, just need to be a little bit smarter about how
> we use driver_data:

Your solution certainly looks more elegant.

> 
> diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
> index 1eefc988192d..1ea6c18b74f3 100644
> --- a/drivers/usb/host/xhci-mvebu.c
> +++ b/drivers/usb/host/xhci-mvebu.c
> @@ -41,8 +41,9 @@ static void xhci_mvebu_mbus_config(void __iomem *base,
>  	}
>  }
>  
> -int xhci_mvebu_mbus_init_quirk(struct platform_device *pdev)
> +int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
>  {
> +	struct platform_device *pdev = to_platform_device(hcd->self.controller);
>  	struct resource	*res;
>  	void __iomem *base;
>  	const struct mbus_dram_target_info *dram;
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 5c15e9bc5f7a..adb77c60a9ae 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -47,43 +47,56 @@ static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
>  	xhci->quirks |= XHCI_PLAT;
>  }
>  
> +static void xhci_priv_plat_start(struct usb_hcd *hcd)
> +{
> +	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
> +
> +	if (priv->plat_start)
> +		priv->plat_start(hcd);
> +}
> +
> +static int xhci_priv_init_quirk(struct usb_hcd *hcd)
> +{
> +	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
> +
> +	if (!priv->init_quirk)
> +		return 0;
> +
> +	return priv->init_quirk(hcd);
> +}
> +
>  /* called during probe() after chip reset completes */
>  static int xhci_plat_setup(struct usb_hcd *hcd)
>  {
>  	int ret;
>  
> -	if (xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2) ||
> -	    xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN3)) {
> -		ret = xhci_rcar_init_quirk(hcd);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = xhci_priv_init_quirk(hcd);
> +	if (ret)
> +		return ret;
>  
>  	return xhci_gen_setup(hcd, xhci_plat_quirks);
>  }
>  
>  static int xhci_plat_start(struct usb_hcd *hcd)
>  {
> -	if (xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2) ||
> -	    xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN3))
> -		xhci_rcar_start(hcd);
> -
> +	xhci_priv_plat_start(hcd);
>  	return xhci_run(hcd);
>  }
>  
>  #ifdef CONFIG_OF
>  static const struct xhci_plat_priv xhci_plat_marvell_armada = {
> -	.type = XHCI_PLAT_TYPE_MARVELL_ARMADA,
> +	.init_quirk = xhci_mvebu_mbus_init_quirk,
>  };
>  
>  static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen2 = {
> -	.type = XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2,
>  	.firmware_name = XHCI_RCAR_FIRMWARE_NAME_V1,
> +	.init_quirk = xhci_rcar_init_quirk,
>  };
>  
>  static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 = {
> -	.type = XHCI_PLAT_TYPE_RENESAS_RCAR_GEN3,
>  	.firmware_name = XHCI_RCAR_FIRMWARE_NAME_V2,
> +	.init_quirk = xhci_rcar_init_quirk,
> +	.plat_start = xhci_rcar_start,
>  };
>  
>  static const struct of_device_id usb_xhci_of_match[] = {
> diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
> index 5a2e2e3936c4..c4d565980832 100644
> --- a/drivers/usb/host/xhci-plat.h
> +++ b/drivers/usb/host/xhci-plat.h
> @@ -13,27 +13,13 @@
>  
>  #include "xhci.h"	/* for hcd_to_xhci() */
>  
> -enum xhci_plat_type {
> -	XHCI_PLAT_TYPE_MARVELL_ARMADA,
> -	XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2,
> -	XHCI_PLAT_TYPE_RENESAS_RCAR_GEN3,
> -};
> -
>  struct xhci_plat_priv {
>  	enum xhci_plat_type type;
>  	const char *firmware_name;
> +	void (*plat_start)(struct usb_hcd *);
> +	int (*init_quirk)(struct usb_hcd *);
>  };
>  
>  #define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->priv)
>  
> -static inline bool xhci_plat_type_is(struct usb_hcd *hcd,
> -				     enum xhci_plat_type type)
> -{
> -	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
> -
> -	if (priv && priv->type == type)
> -		return true;
> -	else
> -		return false;
> -}
>  #endif	/* _XHCI_PLAT_H */
> 
> ps: there might be bugs there, but it's a holiday and I really shouldn't
> be spending time on this right now ;-)

I'm also off on holiday now until Sunday 10th April... yay :-)
> 
> Anyway, have fun testing. Let me know if it doesn't work.

I only have access to STi platforms which were broken by this change.
Not any of the platforms which rely on the functionality which
was introduced (although I can't see any reason why your patch wouldn't work).

Maybe Yoshihiro (on CC) could test this on the Renesas platforms and confirm?

regards,

Peter.
