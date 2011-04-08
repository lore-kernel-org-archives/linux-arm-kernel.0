From: marc@cpdesign.com.au (Marc Reilly)
Date: Fri, 8 Apr 2011 20:30:17 +1000
Subject: [PATCH] ARM: imx: fix usb related build failure for mach-vpr200
In-Reply-To: <1302257029-17397-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1302257029-17397-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <201104082030.17792.marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Many thanks...

> 
> by just applying the change to mach-vpr200.c that the other machine files
> got by 4bd597b.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> this is based on a tree that have mach-mx3 moved to mach-imx, so this patch
> might not apply to your tree. Then you need to patch
> arch/arm/mach-mx3/mach-vpr200.c.
> 

I haven't had time to absorb and test those changes, but... 

> 
>  arch/arm/mach-imx/mach-vpr200.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-vpr200.c
> b/arch/arm/mach-imx/mach-vpr200.c index 84100c6..d74e347 100644
> --- a/arch/arm/mach-imx/mach-vpr200.c
> +++ b/arch/arm/mach-imx/mach-vpr200.c
> @@ -246,11 +246,16 @@ static const struct fsl_usb2_platform_data
> otg_device_pdata __initconst = { .workaround	=
> FLS_USB2_WORKAROUND_ENGCM09152,
>  };
> 
> +static int vpr200_usbh_init(struct platform_device *pdev)
> +{
> +	return mx35_initialize_usb_hw(pdev->id,
> +			MXC_EHCI_INTERFACE_SINGLE_UNI | MXC_EHCI_INTERNAL_PHY);
> +}
> +
>  /* USB HOST config */
>  static const struct mxc_usbh_platform_data usb_host_pdata __initconst = {
> -	.portsc		= MXC_EHCI_MODE_SERIAL,
> -	.flags		= MXC_EHCI_INTERFACE_SINGLE_UNI |
> -			  MXC_EHCI_INTERNAL_PHY,
> +	.init = vpr200_usbh_init,
> +	.portsc = MXC_EHCI_MODE_SERIAL,
>  };
> 

This looks exactly like my fix after I pulled imx-for-2.6.39 the other day, 
procured also by copying the other board files :)

Acked-by: Marc Reilly <marc@cpdesign.com.au>

Cheers
Marc
