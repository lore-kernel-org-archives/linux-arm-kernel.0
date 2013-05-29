From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 29 May 2013 12:05:09 +0100
Subject: [PATCH V4] ARM: handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
References: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <20130529110508.GH17767@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 12, 2013 at 06:35:56AM +0100, Simon Baatz wrote:
> Commit f8b63c1 made flush_kernel_dcache_page a no-op assuming that the pages
> it needs to handle are kernel mapped only.  However, for example when doing
> direct I/O, pages with user space mappings may occur.

After Nico's clarification, I think the original commit introducing this
function was also incomplete (commit 73be1591 - [ARM] 5545/2: add
flush_kernel_dcache_page() for ARM) since it ignores highmem pages and
their flushing could be deferred for a long time.

For my understanding (if I re-read this tread) - basically code like
this should not leave the user mapping inconsistent:

kmap()
...
flush_kernel_dcache_page()
kunmap()

If we use the atomic variants, we get the cache flushing automatically
but the kunmap_high() does not flush the cache immediately, so we need
to handle it in flush_kernel_dcache_page().

> Thus, continue to do lazy flushing if there are no user space mappings.
> Otherwise, flush the kernel cache lines directly.
...
>  /*
> + * Ensure cache coherency for kernel mapping of this page.
> + *
> + * If the page only exists in the page cache and there are no user
> + * space mappings, this is a no-op since the page was already marked
> + * dirty at creation.  Otherwise, we need to flush the dirty kernel
> + * cache lines directly.
> + */
> +void flush_kernel_dcache_page(struct page *page)
> +{
> +	if (cache_is_vivt() || cache_is_vipt_aliasing()) {
> +		struct address_space *mapping;
> +
> +		mapping = page_mapping(page);
> +
> +		if (!mapping || mapping_mapped(mapping))
> +			__flush_kernel_dcache_page(page);
> +	}
> +}

BTW, does the mapping check optimise anything for the
flush_kernel_dcache_page() uses? Would we have a mapping anyway (or
anonymous page) in most cases?

Otherwise the patch looks good.

-- 
Catalin
