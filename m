From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 12 Aug 2012 14:07:59 +0200
Subject: [PATCH] Allow memblock steal operations to remove memory from
 anywhere
In-Reply-To: <20120812105708.GD18957@n2100.arm.linux.org.uk>
References: <20120812105708.GD18957@n2100.arm.linux.org.uk>
Message-ID: <20120812120759.GH1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 12, 2012 at 11:57:08AM +0100, Russell King - ARM Linux wrote:
> Found this with the cubox, which wants to obtain large blocks of
> RAM for the GPU and VPU devices at boot time.  I don't believe
> any other platforms care where the memory comes from, so I think
> this is safe.
> 
> However, OMAP and iMX folk should check this patch - thanks.
> 
> 8<===
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Subject: ARM: Allow arm_memblock_steal() to remove memory from any RAM region
> 
> Allow arm_memblock_steal() to remove memory from any RAM region,
> including highmem areas.  This allows memory to be stolen from the
> very top of declared memory, including highmem areas, rather than
> our precious lowmem.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

There shouldn't be any problems with this on i.MX.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>


> ---
>  arch/arm/mm/init.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index f54d592..04632f3 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -324,7 +324,7 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
>  
>  	BUG_ON(!arm_memblock_steal_permitted);
>  
> -	phys = memblock_alloc(size, align);
> +	phys = memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ANYWHERE);
>  	memblock_free(phys, size);
>  	memblock_remove(phys, size);
>  
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
