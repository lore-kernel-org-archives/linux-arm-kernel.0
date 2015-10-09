From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Oct 2015 17:10:34 +0100
Subject: [RFC] arm: add relocate initrd support
In-Reply-To: <1444406109-28354-1-git-send-email-yalin.wang2010@gmail.com>
References: <1444406109-28354-1-git-send-email-yalin.wang2010@gmail.com>
Message-ID: <20151009161033.GA32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 11:55:09PM +0800, yalin wang wrote:
> Add support for initrd on ARM arch, in case
> mem= boot option change the memory size or the initrd are
> not placed in low memory region, we need copy the initrd
> to low memory region.
> 
> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
> ---
>  arch/arm/include/asm/fixmap.h |  1 +
>  arch/arm/kernel/setup.c       | 72 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
> 
> diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
> index 58cfe9f..18ad90f 100644
> --- a/arch/arm/include/asm/fixmap.h
> +++ b/arch/arm/include/asm/fixmap.h
> @@ -10,6 +10,7 @@
>  
>  enum fixed_addresses {
>  	FIX_EARLYCON_MEM_BASE,
> +	FIX_RELOCATE_INITRD,
>  	__end_of_permanent_fixed_addresses,
>  
>  	FIX_KMAP_BEGIN = __end_of_permanent_fixed_addresses,
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 20edd34..4260d59 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -811,6 +811,77 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
>  		request_resource(&ioport_resource, &lp2);
>  }
>  
> +#if defined(CONFIG_BLK_DEV_INITRD) && defined(CONFIG_MMU)
> +/*
> + * Relocate initrd if it is not completely within the linear mapping.
> + * This would be the case if mem= cuts out all or part of it
> + * or the initrd are not in low mem region place.
> + */
> +static void __init relocate_initrd(void)
> +{
> +	phys_addr_t orig_start = __virt_to_phys(initrd_start);
> +	phys_addr_t orig_end = __virt_to_phys(initrd_end);

If initrd_start or initrd_end are outside of the lowmem region, it's
quite possible for these to return incorrect physical addresses.
The generic kernel's idea of using virtual addresses for the initrd
stuff is painfully wrong IMHO.

The unfortunate thing is that the DT code propagates this stuff:

        initrd_start = (unsigned long)__va(start);
        initrd_end = (unsigned long)__va(end);

and even this can give wrong results for the virtual address when the
physical is outside of lowmem.  For addresses outside of lowmem,
__virt_to_phys(__va(start)) is not guaranteed to return 'start'.

This is why I've said that if we want to support ramdisks outside of
the lowmem mapping, we need to get rid of the initrd_start/initrd_end
virtual addresses.

I'm sorry, but we need much wider code changes before we can cope with
this.

> +	phys_addr_t ram_end = memblock_end_of_DRAM();
> +	phys_addr_t new_start;
> +	phys_addr_t src;
> +	unsigned long size, to_free = 0;
> +	unsigned long slop, clen, p;
> +	void *dest;
> +
> +	if (orig_end <= memblock_get_current_limit())
> +		return;
> +
> +	/*
> +	 * Any of the original initrd which overlaps the linear map should
> +	 * be freed after relocating.

How does this work?  The code in arm_memblock_init() will have already
reserved the physical addresses for the ramdisk:

	memblock_reserve(phys_initrd_start, phys_initrd_size);

So any new allocation shouldn't overlap the existing ramdisk - unless
this is wrong.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
