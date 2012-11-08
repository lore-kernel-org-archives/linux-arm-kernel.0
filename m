From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Nov 2012 16:26:13 +0000
Subject: [PATCH] ARM: setup_mm_for_reboot(): use flush_cache_louis()
In-Reply-To: <alpine.LFD.2.02.1211071505410.21033@xanadu.home>
References: <alpine.LFD.2.02.1211061610070.21033@xanadu.home>
 <20121106220458.GP28327@n2100.arm.linux.org.uk>
 <20121107095106.GA23305@mudshark.cambridge.arm.com>
 <20121107095635.GV28327@n2100.arm.linux.org.uk>
 <20121107100835.GB23305@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1211071035220.21033@xanadu.home>
 <20121107184129.GB18293@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1211071505410.21033@xanadu.home>
Message-ID: <20121108162613.GB16373@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 08:10:49PM +0000, Nicolas Pitre wrote:
> Here's my latest version.  I made the tlb flush conditional.  Please 
> review again before I add your ACK.

Ok.

> ---- >8
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> Subject: [PATCH] ARM: idmap: use flush_cache_louis() and flush TLBs only when necessary
> 
> Flushing the cache is needed for the hardware to see the idmap table
> and therefore can be done at init time.  On ARMv7 it is not necessary to 
> flush L2 so flush_cache_louis() is used here instead.
> 
> There is no point flushing the cache in setup_mm_for_reboot() as the
> caller should, and already is, taking care of this.  If switching the
> memory map requires a cache flush, then cpu_switch_mm() already includes
> that operation.
> 
> What is not done by cpu_switch_mm() on ASID capable CPUs is TLB flushing
> as the whole point of the ASID is to tag the TLBs and avoid flushing them
> on a context switch.  Since we don't have a clean ASID for the identity
> mapping, we need to flush the TLB explicitly in that case.  Otherwise
> this is already performed by cpu_switch_mm().
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> 
> diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
> index ab88ed4f8e..99db769307 100644
> --- a/arch/arm/mm/idmap.c
> +++ b/arch/arm/mm/idmap.c
> @@ -92,6 +92,9 @@ static int __init init_static_idmap(void)
>  		(long long)idmap_start, (long long)idmap_end);
>  	identity_mapping_add(idmap_pgd, idmap_start, idmap_end);
>  
> +	/* Flush L1 for the hardware to see this page table content */
> +	flush_cache_louis();
> +
>  	return 0;
>  }
>  early_initcall(init_static_idmap);
> @@ -103,12 +106,15 @@ early_initcall(init_static_idmap);
>   */
>  void setup_mm_for_reboot(void)
>  {
> -	/* Clean and invalidate L1. */
> -	flush_cache_all();
> -
>  	/* Switch to the identity mapping. */
>  	cpu_switch_mm(idmap_pgd, &init_mm);
>  
> -	/* Flush the TLB. */
> +#ifdef CONFIG_CPU_HAS_ASID
> +	/*
> +	 * We don't have a clean ASID for the identity mapping, which
> +	 * may clash with virtual addresses of the previous page tables
> +	 * and therefore potentially in the TLB.
> +	 */
>  	local_flush_tlb_all();
> +#endif

I checked all of the switch_mm implementations and it looks like
!CONFIG_CPU_HAS_ASID implies the TLB flush in all cases, so this looks fine
to me.

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
