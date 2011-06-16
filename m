From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Jun 2011 17:21:27 +0200
Subject: Dynamic patching in discarded sections
In-Reply-To: <alpine.LFD.2.00.1106080946000.2142@xanadu.home>
References: <201106081123.59414.arnd@arndb.de>
	<alpine.LFD.2.00.1106080946000.2142@xanadu.home>
Message-ID: <201106161721.27330.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 June 2011, Nicolas Pitre wrote:
> Dave Martin proposed an extension to gas here (also sent to 
> binutils at sourceware.org):
> 
> http://article.gmane.org/gmane.linux.linaro.toolchain/701
> 
> But as far as I know, nothing further happened. And this is not an ARM 
> specific issue either as the X86 alternates have the same problem.

Ah, yes. That would be really nice to have. Dave, do you still have hopes
that this patch gets merged?

> > I don't know if the same problem exists in other places in the code, but it's
> > entirely possible. I also couldn't think of a good solution for this, short of
> > moving the definition of dma_unmap_single() to out of line code.
> 
> Probably the best interim solution would be:
> 
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index dfbb377..f231c92 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -21,7 +21,8 @@
>  #define ARM_CPU_KEEP(x)
>  #endif
>  
> -#if defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)
> +#if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || \
> +    defined(CONFIG_ARM_PATCH_PHYS_VIRT)
>  #define ARM_EXIT_KEEP(x)       x
>  #else
>  #define ARM_EXIT_KEEP(x)
> 
> But clearly the toolchain should be more accommodating instead.
> 

10000 randconfig kernel build later without that patch, I'm rather sure
that there is only a single driver that is suffering from this. While your
patch absolutely makes sense, a less invasive workaround would be to just
not mark mmc_spi_remove as __devexit until Dave's patch gets in.

	Arnd
