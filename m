From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 27 Jun 2013 15:23:35 -0700
Subject: [PATCH v2] mm: module_alloc: check if size is 0
In-Reply-To: <20130627093917.GQ7171@linux-mips.org>
References: <1330631119-10059-1-git-send-email-veli-pekka.peltola@bluegiga.com>
 <1331125768-25454-1-git-send-email-veli-pekka.peltola@bluegiga.com>
 <20130627093917.GQ7171@linux-mips.org>
Message-ID: <20130627152335.c3a4c9f4c647cf4a2b263479@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Jun 2013 11:39:17 +0200 Ralf Baechle <ralf@linux-mips.org> wrote:

> Imho de7d2b567d040e3b67fe7121945982f14343213d [mm/vmalloc.c: report more
> vmalloc failures] is overly strict in that it also reports zero-sized
> allocations.  I consider such allocations stupid but legitimiate and often
> better preferrable over having to scatter checks for zero size all over
> place.  So maybe something like below patch?
> 
> ...
>
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1679,7 +1679,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  	unsigned long real_size = size;
>  
>  	size = PAGE_ALIGN(size);
> -	if (!size || (size >> PAGE_SHIFT) > totalram_pages)
> +	if (unlikely(!size))
> +		return NULL;
> +
> +	if ((size >> PAGE_SHIFT) > totalram_pages)
>  		goto fail;
>  
>  	area = __get_vm_area_node(size, align, VM_ALLOC | VM_UNLIST,
> @@ -1711,6 +1714,7 @@ fail:
>  	warn_alloc_failed(gfp_mask, 0,
>  			  "vmalloc: allocation failure: %lu bytes\n",
>  			  real_size);
> +
>  	return NULL;
>  }

If the caller actually dereferences the returned pointer the kernel
will go oops, which should provide adequate notification of a
programming error ;) But all callers should be checking the return
value.  So I worry about the by-far-most-common case where code does

	size = some_screwed_up_calculation();
	p = vmalloc(size);
	if (!p)
		return -ENOMEM;

So the mistake gets propagated back to who-knows-where as memory
exhaustion and thereby becomes a lot harder to diagnose.


How many callsites really truly need to be edited to avoid the warning?


Veli-Pekka's original patch would be neater if we were to add a new

void *__vmalloc_node_range_zero_size_ok(<args>)
{
	if (size == 0)
		return NULL;
	return __vmalloc_node_range(<args>);
}

(with a better name than __vmalloc_node_range_zero_size_ok!)
