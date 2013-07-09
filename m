From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 09 Jul 2013 10:03:15 -0600
Subject: [PATCH] ARM: mm: restrict early_alloc_aligned to legal area
In-Reply-To: <1373323495-10087-1-git-send-email-swarren@wwwdotorg.org>
References: <1373323495-10087-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51DC3443.3060408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2013 04:44 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> When early_alloc_aligned() is called, it appears that only memory in the
> first memory bank is mapped for CPU access. However, memblock_alloc() is
> called to allocate the RAM, and that can return RAM that is part of any
> valid memory bank, which hence could be inaccessible to the CPU. If this
> happens, the subsequent memset() will hang or crash.
> 
> Solve this by calling memblock_alloc_base() instead of memblock_alloc().
> This function takes an explicit max address. Use the end of the first
> memory bank as the address.

Scratch this; it causes problems on systems with highmem.

> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c

>  static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
>  {
> -	void *ptr = __va(memblock_alloc(sz, align));
> +	phys_addr_t max_pa = memblock.memory.regions[0].base +
> +				memblock.memory.regions[0].size;

Perhaps that needs to be min(memblock 0 end, end of lowmem). I'll try
that...
