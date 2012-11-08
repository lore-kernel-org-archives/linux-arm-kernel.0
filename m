From: ian.campbell@citrix.com (Ian Campbell)
Date: Thu, 8 Nov 2012 16:40:45 +0100
Subject: [Xen-devel] BUG: ARM build failures due to Xen
In-Reply-To: <201211081528.31968.arnd@arndb.de>
References: <20121106175749.GO28327@n2100.arm.linux.org.uk>
 <201211081528.31968.arnd@arndb.de>
Message-ID: <1352389245.12977.106.camel@hastur.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-11-08 at 15:28 +0000, Arnd Bergmann wrote:
> On Tuesday 06 November 2012, Russell King - ARM Linux wrote:
> > My build system is giving me the following errors against an OMAP4
> > randconfig build against the latest Linus' kernel plus arm-soc:
> > 
> > ERROR: "privcmd_call" [drivers/xen/xen-privcmd.ko] undefined!
> > make[2]: *** [__modpost] Error 1
> > make[2]: Target `_modpost' not remade because of errors.
> > make[1]: *** [modules] Error 2
> > make: *** [sub-make] Error 2
> > make: Target `uImage' not remade because of errors.
> > make: Target `modules' not remade because of errors.
> > 
> > Full build results and configuration are here:
> > 
> > http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=2627
> > http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=2627
> > 
> 
> I can reproduce the same thing with mainline v3.7-rc4.
> 8<------
> xen/arm: export privcmd_call

Thanks, Konrad posted a fix for this on Tuesday which covers a few other
cases too: http://marc.info/?l=linux-kernel&m=135224075902642&w=2 I
added Russell to my response but forgot to add l-a-k@ too, sorry.

Is one of you going to pick it up and send to mainline?

Ian.

> privcmd_call may get called from a module, so it has to be exported.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 59bcb96..ff5e300 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -17,6 +17,9 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_address.h>
>  
> +/* from hypercall.S */
> +EXPORT_SYMBOL_GPL(privcmd_call);
> +
>  struct start_info _xen_start_info;
>  struct start_info *xen_start_info = &_xen_start_info;
>  EXPORT_SYMBOL_GPL(xen_start_info);
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
