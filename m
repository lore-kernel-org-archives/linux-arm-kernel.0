From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 Jan 2016 13:14:29 +0000
Subject: [PATCHv2] arm64: Allow vmalloc regions to be set with set_memory_*
In-Reply-To: <1452640955-25491-1-git-send-email-labbott@fedoraproject.org>
References: <1452640955-25491-1-git-send-email-labbott@fedoraproject.org>
Message-ID: <20160113131428.GH23370@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 03:22:35PM -0800, Laura Abbott wrote:
> 
> The range of set_memory_* is currently restricted to the module address
> range because of difficulties in breaking down larger block sizes.
> vmalloc maps PAGE_SIZE pages so it is safe to use as well. Update the
> function ranges and add a comment explaining why the range is restricted
> the way it is.
> 
> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
> ---
> v2: Old version was sent out with vmalloc warnings. Sorry for the noise.
> ---
>  arch/arm64/mm/pageattr.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)

Conceptually this looks fine.

Implementation comments below.

> 
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 3571c73..88c8e54 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -36,6 +36,26 @@ static int change_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
>  	return 0;
>  }
>  
> +static bool validate_addr(unsigned long start, unsigned long end)
> +{
> +	/*
> +	 * This check explicitly excludes most kernel memory. Most kernel
> +	 * memory is mapped with a larger page size and breaking down the
> +	 * larger page size without causing TLB conflicts is very difficult.
> +	 *
> +	 * If you need to call set_memory_* on a range, the recommendation is
> +	 * to use vmalloc since that range is mapped with pages.
> +	 */
> +	if (start >= MODULES_VADDR && start < MODULES_END &&
> +	    end >= MODULES_VADDR && end < MODULES_END)
> +		return true;

I think we had an existing fencepost error that we carried across.

Say my module gets the very last page of the modules area. If I try to
change the permissions of that page, I'd call:

change_memory_common(MODULES_END - PAGE_SIZE, 1, foo, far);

We then calculate end as MODULES_END, sice we simply add one page.

Then we fail the check above, because end >= MODULES_END.

> +
> +	if (is_vmalloc_addr((void *)start) && is_vmalloc_addr((void *)end))
> +		return true;

Similarly here we would fail the check if this were the last page of the
vmalloc area, as addr == VMALLOC_END.

Other that that this looks good!

Thanks,
Mark.

> +
> +	return false;
> +}
> +
>  static int change_memory_common(unsigned long addr, int numpages,
>  				pgprot_t set_mask, pgprot_t clear_mask)
>  {
> @@ -51,10 +71,7 @@ static int change_memory_common(unsigned long addr, int numpages,
>  		WARN_ON_ONCE(1);
>  	}
>  
> -	if (start < MODULES_VADDR || start >= MODULES_END)
> -		return -EINVAL;
> -
> -	if (end < MODULES_VADDR || end >= MODULES_END)
> +	if (!validate_addr(start, end))
>  		return -EINVAL;
>  
>  	data.set_mask = set_mask;
> -- 
> 2.5.0
> 
