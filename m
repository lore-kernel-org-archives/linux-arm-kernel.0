From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 18 Oct 2011 21:37:28 +0800
Subject: [patch 1/1] iMX: Fix module build
In-Reply-To: <20111018131353.663173305@rtp-net.org>
References: <20111018131353.663173305@rtp-net.org>
Message-ID: <20111018133727.GF30703@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

http://patchwork.ozlabs.org/patch/118547/

Regards,
Shawn

On Tue, Oct 18, 2011 at 03:13:34PM +0200, Arnaud Patard wrote:
> When trying to build some modules with the "hint" branch of imx tree,
> they're now failing to build at modpost with an error like this :
> 
>   OBJCOPY arch/arm/boot/zImage
>   Kernel: arch/arm/boot/zImage is ready
>   Building modules, stage 2.
>   MODPOST 69 modules
> ERROR: "imx_ioremap" [sound/soc/imx/snd-soc-imx.ko] undefined!
> ERROR: "imx_ioremap" [drivers/usb/gadget/fsl_usb2_udc.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> It seems to be caused by commit f548897ffc0510885af27e22a11f449fe5e0cbbd,
> which introduced imx_ioremap without EXPORT_SYMBOL.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Index: linux-2.6-submit/arch/arm/plat-mxc/system.c
> ===================================================================
> --- linux-2.6-submit.orig/arch/arm/plat-mxc/system.c	2011-10-18 01:35:32.000000000 +0200
> +++ linux-2.6-submit/arch/arm/plat-mxc/system.c	2011-10-18 11:56:45.000000000 +0200
> @@ -21,6 +21,7 @@
>  #include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/delay.h>
> +#include <linux/module.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/common.h>
> @@ -30,6 +31,7 @@
>  
>  void (*imx_idle)(void) = NULL;
>  void __iomem *(*imx_ioremap)(unsigned long, size_t, unsigned int) = NULL;
> +EXPORT_SYMBOL(imx_ioremap);
>  
>  static void __iomem *wdog_base;
>  
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
