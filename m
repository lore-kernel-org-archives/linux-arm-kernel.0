From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Dec 2015 15:30:13 +0000
Subject: [PATCH v3 7/7] arm64: allow kernel Image to be loaded anywhere
 in physical memory
In-Reply-To: <1447672998-20981-8-git-send-email-ard.biesheuvel@linaro.org>
References: <1447672998-20981-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447672998-20981-8-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151207153012.GB7083@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 12:23:18PM +0100, Ard Biesheuvel wrote:
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 3148691bc80a..d6a237bda1f9 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -120,13 +120,10 @@ extern phys_addr_t		memstart_addr;
>  extern u64 kernel_va_offset;
>  
>  /*
> - * The maximum physical address that the linear direct mapping
> - * of system RAM can cover. (PAGE_OFFSET can be interpreted as
> - * a 2's complement signed quantity and negated to derive the
> - * maximum size of the linear mapping.)
> + * Allow all memory at the discovery stage. We will clip it later.
>   */
> -#define MAX_MEMBLOCK_ADDR	({ memstart_addr - PAGE_OFFSET - 1; })
> -#define MIN_MEMBLOCK_ADDR	__pa(KIMAGE_VADDR)
> +#define MIN_MEMBLOCK_ADDR	0
> +#define MAX_MEMBLOCK_ADDR	U64_MAX

Just in case we get some random memblock information, shall we cap the
maximum to PHYS_MASK?

> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index b3b0175d7135..29a7dc5327b6 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -158,9 +159,55 @@ static int __init early_mem(char *p)
>  }
>  early_param("mem", early_mem);
>  
> +static void __init enforce_memory_limit(void)
> +{
> +	const phys_addr_t kbase = round_down(__pa(_text), MIN_KIMG_ALIGN);
> +	u64 to_remove = memblock_phys_mem_size() - memory_limit;
> +	phys_addr_t max_addr = 0;
> +	struct memblock_region *r;
> +
> +	if (memory_limit == (phys_addr_t)ULLONG_MAX)
> +		return;
> +
> +	/*
> +	 * The kernel may be high up in physical memory, so try to apply the
> +	 * limit below the kernel first, and only let the generic handling
> +	 * take over if it turns out we haven't clipped enough memory yet.
> +	 */
> +	for_each_memblock(memory, r) {
> +		if (r->base + r->size > kbase) {
> +			u64 rem = min(to_remove, kbase - r->base);
> +
> +			max_addr = r->base + rem;
> +			to_remove -= rem;
> +			break;
> +		}
> +		if (to_remove <= r->size) {
> +			max_addr = r->base + to_remove;
> +			to_remove = 0;
> +			break;
> +		}
> +		to_remove -= r->size;
> +	}
> +
> +	memblock_remove(0, max_addr);

I don't fully get the reason for this function. Do you want to keep the
kernel around in memblock? How do we guarantee that the call below
wouldn't remove it anyway?

> +
> +	if (to_remove)
> +		memblock_enforce_memory_limit(memory_limit);

Shouldn't this be memblock_enforce_memory_limit(to_remove)?

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 526eeb7e1e97..1b9d7e48ba1e 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c

> @@ -481,11 +482,33 @@ static void __init bootstrap_linear_mapping(unsigned long va_offset)
>  static void __init map_mem(void)
>  {
>  	struct memblock_region *reg;
> +	u64 new_memstart_addr;
> +	u64 new_va_offset;
>  
> -	bootstrap_linear_mapping(KIMAGE_OFFSET);
> +	/*
> +	 * Select a suitable value for the base of physical memory.
> +	 * This should be equal to or below the lowest usable physical
> +	 * memory address, and aligned to PUD/PMD size so that we can map
> +	 * it efficiently.
> +	 */
> +	new_memstart_addr = round_down(memblock_start_of_DRAM(), SZ_1G);

With this trick, we can no longer assume we have a mapping at
PAGE_OFFSET. I don't think we break any expectations but we probably
don't free the unused memmap at the beginning. We can probably set
prev_end to this rounded down address in free_unused_memmap().

-- 
Catalin
