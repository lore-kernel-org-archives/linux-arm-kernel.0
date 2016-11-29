From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 29 Nov 2016 09:25:19 -0600
Subject: [PATCH 1/2] ARM: mm: fix set_memory_*() bounds checks
In-Reply-To: <E1c8r91-0007wL-Fl@rmk-PC.armlinux.org.uk>
References: <E1c8r91-0007wL-Fl@rmk-PC.armlinux.org.uk>
Message-ID: <24932a5a-4cbf-dd84-2e87-de29b07da5b3@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On 11/21/2016 10:08 AM, Russell King wrote:
> The set_memory_*() bounds checks are buggy on several fronts:
>
> 1. They fail to round the region size up if the passed address is not
>    page aligned.
> 2. The region check was incomplete, and didn't correspond with what
>    was being asked of apply_to_page_range()
>
> So, rework change_memory_common() to fix these problems, adding an
> "in_region()" helper to determine whether the start & size fit within
> the provided region start and stop addresses.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm/mm/pageattr.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
> index d19b1ad29b07..db09f2e7efda 100644
> --- a/arch/arm/mm/pageattr.c
> +++ b/arch/arm/mm/pageattr.c
> @@ -34,28 +34,28 @@ static int change_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
>  	return 0;
>  }
>
> +static bool in_range(unsigned long start, unsigned long size,
> +	unsigned long range_start, unsigned long range_end)
> +{
> +	return start >= range_start && start < range_end &&
> +		size <= range_end - start;
> +}
> +
>  static int change_memory_common(unsigned long addr, int numpages,
>  				pgprot_t set_mask, pgprot_t clear_mask)
>  {
> -	unsigned long start = addr;
> -	unsigned long size = PAGE_SIZE*numpages;
> -	unsigned long end = start + size;
> +	unsigned long start = addr & PAGE_SIZE;

This doesn't work as is, I believe 'start' should be set to 
PAGE_ALIGN(addr), addr & PAGE_SIZE as it is doesn't make sense. If I 
make this change this code works ok.

Regards,
Dave

> +	unsigned long end = PAGE_ALIGN(addr) + numpages * PAGE_SIZE;
> +	unsigned long size = end - start;
>  	int ret;
>  	struct page_change_data data;
>
> -	if (!IS_ALIGNED(addr, PAGE_SIZE)) {
> -		start &= PAGE_MASK;
> -		end = start + size;
> -		WARN_ON_ONCE(1);
> -	}
> +	WARN_ON_ONCE(start != addr);
>
> -	if (!numpages)
> +	if (!size)
>  		return 0;
>
> -	if (start < MODULES_VADDR || start >= MODULES_END)
> -		return -EINVAL;
> -
> -	if (end < MODULES_VADDR || start >= MODULES_END)
> +	if (!in_range(start, size, MODULES_VADDR, MODULES_END))
>  		return -EINVAL;
>
>  	data.set_mask = set_mask;
>
