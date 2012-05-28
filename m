From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 28 May 2012 12:32:44 +0800
Subject: [RFC/PATCH 1/1] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <1338160318-20712-2-git-send-email-gmbnomis@gmail.com>
References: <1338160318-20712-1-git-send-email-gmbnomis@gmail.com>
 <1338160318-20712-2-git-send-email-gmbnomis@gmail.com>
Message-ID: <20120528043241.GA2803@mbp.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, May 28, 2012 at 12:11:58AM +0100, Simon Baatz wrote:
> Commit f8b63c1 made flush_kernel_dcache_page a no-op assuming that the pages
> it needs to handle are kernel mapped only.  However, for example when doing
> direct I/O, pages with user space mappings may occur.
> 
> Thus, continue to do lazy flushing if there are no user space mappings.
> Otherwise, flush the kernel cache lines directly.
...
> +void __flush_kernel_dcache_page(struct page *page)
> +{
> +	struct address_space *mapping;
> +
> +	mapping = page_mapping(page);
> +
> +	if (!mapping || mapping_mapped(mapping))
> +		__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
> +}
> +EXPORT_SYMBOL(__flush_kernel_dcache_page);

I wonder whether the above condition isn't always true after
get_user_pages().

-- 
Catalin
