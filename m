From: balbi@ti.com (Felipe Balbi)
Date: Thu, 7 Mar 2013 15:41:17 +0200
Subject: [PATCH v2] ARM: OMAP1: fix omap_udc registration
In-Reply-To: <1362663013-28794-1-git-send-email-aaro.koskinen@iki.fi>
References: <1362663013-28794-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20130307134117.GA16577@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 07, 2013 at 03:30:12PM +0200, Aaro Koskinen wrote:
> omap_udc platform device is not registered properly anymore:
> CONFIG_USB_GADGET_OMAP was deleted by 193ab2a6 (usb: gadget: allow
> multiple gadgets to be built) already in v3.1.
> 
> Fix by using CONFIG_USB_OMAP instead. Tested on Nokia 770 by checking
> that omap_udc is probed & working properly when built as a module.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
> 
> 	Patch history:
> 
> 	v2: use IS_ENABLED()
> 
> 	v1: http://marc.info/?t=136260886600006&r=1&w=2
> 
>  arch/arm/mach-omap1/include/mach/usb.h |    2 +-
>  arch/arm/mach-omap1/usb.c              |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/include/mach/usb.h b/arch/arm/mach-omap1/include/mach/usb.h
> index 753cd5c..45e5ac7 100644
> --- a/arch/arm/mach-omap1/include/mach/usb.h
> +++ b/arch/arm/mach-omap1/include/mach/usb.h
> @@ -2,7 +2,7 @@
>   * FIXME correct answer depends on hmc_mode,
>   * as does (on omap1) any nonzero value for config->otg port number
>   */
> -#ifdef	CONFIG_USB_GADGET_OMAP
> +#if IS_ENABLED(CONFIG_USB_OMAP)
>  #define	is_usb0_device(config)	1
>  #else
>  #define	is_usb0_device(config)	0
> diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
> index 1a1db59..4118db5 100644
> --- a/arch/arm/mach-omap1/usb.c
> +++ b/arch/arm/mach-omap1/usb.c
> @@ -123,7 +123,7 @@ omap_otg_init(struct omap_usb_config *config)
>  	syscon = omap_readl(OTG_SYSCON_1);
>  	syscon |= HST_IDLE_EN|DEV_IDLE_EN|OTG_IDLE_EN;
>  
> -#ifdef	CONFIG_USB_GADGET_OMAP
> +#if IS_ENABLED(CONFIG_USB_OMAP)
>  	if (config->otg || config->register_dev) {
>  		struct platform_device *udc_device = config->udc_device;
>  		int status;
> @@ -169,7 +169,7 @@ omap_otg_init(struct omap_usb_config *config)
>  void omap_otg_init(struct omap_usb_config *config) {}
>  #endif
>  
> -#ifdef	CONFIG_USB_GADGET_OMAP
> +#if IS_ENABLED(CONFIG_USB_OMAP)
>  
>  static struct resource udc_resources[] = {
>  	/* order is significant! */
> @@ -600,7 +600,7 @@ static void __init omap_1510_usb_init(struct omap_usb_config *config)
>  	while (!(omap_readw(ULPD_DPLL_CTRL) & DPLL_LOCK))
>  		cpu_relax();
>  
> -#ifdef	CONFIG_USB_GADGET_OMAP
> +#if IS_ENABLED(CONFIG_USB_OMAP)
>  	if (config->register_dev) {
>  		int status;
>  
> -- 
> 1.7.10.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130307/1728f246/attachment.sig>
