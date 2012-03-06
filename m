From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Mar 2012 16:53:10 +0000
Subject: [PATCH v4 1/4] ARM: provide runtime hook for ioremap/iounmap
In-Reply-To: <1331006580-3579-1-git-send-email-robherring2@gmail.com>
References: <alpine.LFD.2.02.1203051545200.31242@xanadu.home>
 <1331006580-3579-1-git-send-email-robherring2@gmail.com>
Message-ID: <201203061653.11049.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 March 2012, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> We have compile time over-ride of ioremap and iounmap, but an run-time
> override is needed for multi-platform builds. This adds an extra function
> pointer check, but ioremap is not peformance critical. The option for
> compile time selection remains.
> 
> The caller variant is used here to provide correct caller information as
> ARM can only support level 0 for __builtin_return_address.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>

Very nice!

Just one small comment:

> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -306,9 +306,16 @@ __arm_ioremap_pfn(unsigned long pfn, unsigned long offset, size_t size,
>  }
>  EXPORT_SYMBOL(__arm_ioremap_pfn);
>  
> +void __iomem * (*arch_ioremap_caller)(unsigned long, size_t, unsigned int, void *);
> +EXPORT_SYMBOL(arch_ioremap_caller);
> +
>  void __iomem *
>  __arm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
>  {
> +	if (arch_ioremap_caller)
> +		return arch_ioremap_caller(phys_addr, size, mtype,
> +			__builtin_return_address(0));
> +
>  	return __arm_ioremap_caller(phys_addr, size, mtype,
>  			__builtin_return_address(0));
>  }
> @@ -370,3 +377,12 @@ void __iounmap(volatile void __iomem *io_addr)
>  	vunmap(addr);
>  }
>  EXPORT_SYMBOL(__iounmap);
> +
> +void (*arch_iounmap)(volatile void __iomem *) = __iounmap;
> +EXPORT_SYMBOL(arch_iounmap);
> +
> +void __arm_iounmap(volatile void __iomem *io_addr)
> +{
> +	arch_iounmap(io_addr);
> +}
> +EXPORT_SYMBOL(__arm_iounmap);

The EXPORT_SYMBOL() statements for arch_ioremap_caller and arch_iounmap
seem to be leftover from a previous version of this patch and can be removed
now. Other than that:

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
