From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Oct 2012 14:20:59 -0700
Subject: [PATCH] ARM: OMAP1: usb: fix sparse warnings
In-Reply-To: <alpine.DEB.2.00.1210262051290.11258@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210262051290.11258@utopia.booyaka.com>
Message-ID: <20121026212059.GV11908@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121026 13:54]:
> 
> Resolve the following sparse warnings:
> 
> arch/arm/mach-omap1/usb.c:304:12: warning: symbol 'omap1_usb0_init' was not declared. Should it be static?
> arch/arm/mach-omap1/usb.c:412:12: warning: symbol 'omap1_usb1_init' was not declared. Should it be static?
> arch/arm/mach-omap1/usb.c:478:12: warning: symbol 'omap1_usb2_init' was not declared. Should it be static?
> 
> by declaring those functions as static.  Also remove the unneeded
> prototypes and related code from the plat/usb.h header file.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Felipe Balbi <balbi@ti.com>
> ---
> 
> Tony, care to take this one?

Let's apply just the usb.c changes on omap-for-v3.8/cleanup-headers
as plat/usb.h is now gone?

Regards,

Tony
 
>  arch/arm/mach-omap1/usb.c             |    6 +++---
>  arch/arm/plat-omap/include/plat/usb.h |   20 --------------------
>  2 files changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
> index 84267ed..104fed3 100644
> --- a/arch/arm/mach-omap1/usb.c
> +++ b/arch/arm/mach-omap1/usb.c
> @@ -301,7 +301,7 @@ static inline void otg_device_init(struct omap_usb_config *pdata)
>  
>  #endif
>  
> -u32 __init omap1_usb0_init(unsigned nwires, unsigned is_device)
> +static u32 __init omap1_usb0_init(unsigned nwires, unsigned is_device)
>  {
>  	u32	syscon1 = 0;
>  
> @@ -409,7 +409,7 @@ u32 __init omap1_usb0_init(unsigned nwires, unsigned is_device)
>  	return syscon1 << 16;
>  }
>  
> -u32 __init omap1_usb1_init(unsigned nwires)
> +static u32 __init omap1_usb1_init(unsigned nwires)
>  {
>  	u32	syscon1 = 0;
>  
> @@ -475,7 +475,7 @@ bad:
>  	return syscon1 << 20;
>  }
>  
> -u32 __init omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
> +static u32 __init omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
>  {
>  	u32	syscon1 = 0;
>  
> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
> index 87ee140..669baa1 100644
> --- a/arch/arm/plat-omap/include/plat/usb.h
> +++ b/arch/arm/plat-omap/include/plat/usb.h
> @@ -156,24 +156,4 @@ extern void ti81xx_musb_phy_power(u8 on);
>  #define USBPHY_OTGSESSEND_EN	(1 << 20)
>  #define USBPHY_DATA_POLARITY	(1 << 23)
>  
> -#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_USB)
> -u32 omap1_usb0_init(unsigned nwires, unsigned is_device);
> -u32 omap1_usb1_init(unsigned nwires);
> -u32 omap1_usb2_init(unsigned nwires, unsigned alt_pingroup);
> -#else
> -static inline u32 omap1_usb0_init(unsigned nwires, unsigned is_device)
> -{
> -	return 0;
> -}
> -static inline u32 omap1_usb1_init(unsigned nwires)
> -{
> -	return 0;
> -
> -}
> -static inline u32 omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
> -{
> -	return 0;
> -}
> -#endif
> -
>  #endif	/* __ASM_ARCH_OMAP_USB_H */
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
