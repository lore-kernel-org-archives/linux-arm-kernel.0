From: msalter@redhat.com (Mark Salter)
Date: Wed, 23 Mar 2016 15:47:18 -0400
Subject: [PATCH] arm64: handle unmapped pages in initrd relocation
In-Reply-To: <1454373031-24218-1-git-send-email-msalter@redhat.com>
References: <1454373031-24218-1-git-send-email-msalter@redhat.com>
Message-ID: <1458762438.23434.120.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-02-01 at 19:30 -0500, Mark Salter wrote:
> Commit 4dffbfc48d65 ("arm64/efi: mark UEFI reserved regions as
> MEMBLOCK_NOMAP") causes a potential problem in arm64 initrd relocation
> code. If the kernel uses a pagesize greater than the 4k pagesize used
> by UEFI, pagesize rounding may lead to one or both ends of the initrd
> image to be marked unmapped. This leads to a panic when the kernel goes
> to unpack it. This patch looks for unmapped pages at beginning and end
> of the initrd image and if seen, relocated the initrd to a new area
> completely covered by the kernel linear map.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---

The Fedora folks have run into this problem with a certain kernel build. What ever
happened to Ard's suggested fix. The MEMBLOCK_NOMAP patch caused a regression which
should be fixed. Whether this patch, Ard's patch, or something else.

https://bugzilla.redhat.com/show_bug.cgi?id=1309147


> ?arch/arm64/kernel/setup.c | 46 +++++++++++++++++++++++++++++++++++++---------
> ?1 file changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index d22c5fc..849566e 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -235,24 +235,29 @@ static void __init relocate_initrd(void)
> ?	phys_addr_t ram_end = memblock_end_of_DRAM();
> ?	phys_addr_t new_start;
> ?	unsigned long size, to_free = 0;
> +	unsigned long unmapped_start = 0, unmapped_end = 0;
> ?	void *dest;
> ?
> -	if (orig_end <= ram_end)
> +	size = orig_end - orig_start;
> +	if (!size)
> ?		return;
> ?
> ?	/*
> -	?* Any of the original initrd which overlaps the linear map should
> -	?* be freed after relocating.
> +	?* If kernel pagesize > 4K, pagesize rounding may have placed
> +	?* part of either end of initrd in an unmapped page.
> +	?*
> +	?* Find any unmapped bytes at start or end of initrd.
> ?	?*/
> -	if (orig_start < ram_end)
> -		to_free = ram_end - orig_start;
> +	if (!memblock_is_map_memory(orig_start))
> +		unmapped_start = PAGE_SIZE - (orig_start & (PAGE_SIZE - 1));
> +	if (!memblock_is_map_memory(orig_end - 1))
> +		unmapped_end = ((orig_end - 1) & (PAGE_SIZE - 1)) + 1;
> ?
> -	size = orig_end - orig_start;
> -	if (!size)
> +	if (unmapped_start == 0 && unmapped_end == 0 && orig_end <= ram_end)
> ?		return;
> ?
> ?	/* initrd needs to be relocated completely inside linear mapping */
> -	new_start = memblock_find_in_range(0, PFN_PHYS(max_pfn),
> +	new_start = memblock_find_in_range(0, ram_end,
> ?					???size, PAGE_SIZE);
> ?	if (!new_start)
> ?		panic("Cannot relocate initrd of size %ld\n", size);
> @@ -267,7 +272,30 @@ static void __init relocate_initrd(void)
> ?
> ?	dest = (void *)initrd_start;
> ?
> -	if (to_free) {
> +	if (unmapped_end) {
> +		copy_from_early_mem(dest + size - unmapped_end,
> +				????orig_start + size - unmapped_end,
> +				????unmapped_end);
> +		size -= unmapped_end;
> +		if (size == 0)
> +			return;
> +	}
> +
> +	if (unmapped_start) {
> +		copy_from_early_mem(dest, orig_start, unmapped_start);
> +		dest += unmapped_start;
> +		orig_start += unmapped_start;
> +		size -= unmapped_start;
> +		if (size == 0)
> +			return;
> +	}
> +
> +	/*
> +	?* Any of the remaining original initrd which overlaps the linear map
> +	?* should be freed after relocating.
> +	?*/
> +	if (orig_start < ram_end) {
> +		to_free = min(size, (unsigned long)(ram_end - orig_start));
> ?		memcpy(dest, (void *)__phys_to_virt(orig_start), to_free);
> ?		dest += to_free;
> ?	}
