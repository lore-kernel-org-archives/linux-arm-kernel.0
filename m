From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Nov 2013 10:37:42 -0800
Subject: [PATCH] include/linux/usb/usb_phy_gen_xceiv.h: check built-in
 or module for swithing usb_nop_xceiv_register() implementation
In-Reply-To: <52679D19.903@asianux.com>
References: <52679D19.903@asianux.com>
Message-ID: <20131114183742.GN10317@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Chen Gang <gang.chen@asianux.com> [131023 02:57]:
> When CONFIG_NOP_USB_XCEIV is as 'm', usb_nop_xceiv_register() will be
> exported when the related module is loaded. So for built-in source
> code, still need use the empty one.
> 
> Or it will can not pass compiling, the related error (for arm, with 
> allmodconfig):
> 
>   arch/arm/mach-omap2/built-in.o: In function `omap3_evm_init':
>   arch/arm/mach-omap2/board-omap3evm.c:703: undefined reference to `usb_nop_xceiv_register'
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Added Felipe to cc, he should probably deal with this one.

Regards,

Tony

> ---
>  include/linux/usb/usb_phy_gen_xceiv.h |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/usb/usb_phy_gen_xceiv.h b/include/linux/usb/usb_phy_gen_xceiv.h
> index f9a7e7b..8515958 100644
> --- a/include/linux/usb/usb_phy_gen_xceiv.h
> +++ b/include/linux/usb/usb_phy_gen_xceiv.h
> @@ -12,7 +12,8 @@ struct usb_phy_gen_xceiv_platform_data {
>  	unsigned int needs_reset:1;
>  };
>  
> -#if IS_ENABLED(CONFIG_NOP_USB_XCEIV)
> +#if IS_BUILTIN(CONFIG_NOP_USB_XCEIV) || \
> +	(IS_MODULE(CONFIG_NOP_USB_XCEIV) && defined(MODULE))
>  /* sometimes transceivers are accessed only through e.g. ULPI */
>  extern void usb_nop_xceiv_register(void);
>  extern void usb_nop_xceiv_unregister(void);
> -- 
> 1.7.7.6
