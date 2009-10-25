From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 25 Oct 2009 14:48:05 +0000
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <1256038748.32578.14.camel@pc1117.cambridge.arm.com>
References: <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20091015145753.GC14817@n2100.arm.linux.org.uk>
	<1255620022.10164.74.camel@pc1117.cambridge.arm.com>
	<20091015152852.GD14817@n2100.arm.linux.org.uk>
	<1255622179.10164.92.camel@pc1117.cambridge.arm.com>
	<1256038748.32578.14.camel@pc1117.cambridge.arm.com>
Message-ID: <20091025144805.GA1774@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2009 at 12:39:08PM +0100, Catalin Marinas wrote:
> diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
> index d0d17b6..4e37ab6 100644
> --- a/arch/arm/mm/fault-armv.c
> +++ b/arch/arm/mm/fault-armv.c
> @@ -160,8 +160,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
>  	if (mapping) {
>  		if (cache_is_vivt())
>  			make_coherent(mapping, vma, addr, pfn);
> -		else if (vma->vm_flags & VM_EXEC)
> -			__flush_icache_all();
> +		__flush_icache_all();

BTW, why are you penalising VIVT cached systems as well with this
change?  Surely you meant to leave the 'else' still there.
