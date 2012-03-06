From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 06 Mar 2012 12:18:53 -0500 (EST)
Subject: [PATCH v4 1/4] ARM: provide runtime hook for ioremap/iounmap
In-Reply-To: <1331006580-3579-1-git-send-email-robherring2@gmail.com>
References: <alpine.LFD.2.02.1203051545200.31242@xanadu.home>
 <1331006580-3579-1-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1203061210430.31242@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Mar 2012, Rob Herring wrote:

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
> ---
[...]
> index 80632e8..c37c67a 100644
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -306,9 +306,16 @@ __arm_ioremap_pfn(unsigned long pfn, unsigned long offset, size_t size,
>  }
>  EXPORT_SYMBOL(__arm_ioremap_pfn);
>  
> +void __iomem * (*arch_ioremap_caller)(unsigned long, size_t, unsigned int, void *);
> +EXPORT_SYMBOL(arch_ioremap_caller);

We don't want modules to mess with this, so the export can go.

>  void __iomem *
>  __arm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
>  {
> +	if (arch_ioremap_caller)
> +		return arch_ioremap_caller(phys_addr, size, mtype,
> +			__builtin_return_address(0));
> +
>  	return __arm_ioremap_caller(phys_addr, size, mtype,
>  			__builtin_return_address(0));

Why not initializing arch_ioremap_caller with __arm_ioremap_caller like 
the iounmap case?  That would remove the need for a runtime test.

> @@ -370,3 +377,12 @@ void __iounmap(volatile void __iomem *io_addr)
>  	vunmap(addr);
>  }
>  EXPORT_SYMBOL(__iounmap);
> +
> +void (*arch_iounmap)(volatile void __iomem *) = __iounmap;
> +EXPORT_SYMBOL(arch_iounmap);

Same comment as above about the export.

> +void __arm_iounmap(volatile void __iomem *io_addr)
> +{
> +	arch_iounmap(io_addr);
> +}
> +EXPORT_SYMBOL(__arm_iounmap);
> -- 
> 1.7.5.4
> 
