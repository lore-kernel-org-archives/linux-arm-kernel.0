From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Aug 2014 11:16:13 +0200
Subject: [PATCH] pstore/ram_core: Fix hang on ARMs because of
 pgprot_noncached
In-Reply-To: <20140825231449.GS17254@atomide.com>
References: <20140825231449.GS17254@atomide.com>
Message-ID: <4959575.hJIGzK9yj7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 August 2014 16:14:50 Tony Lindgren wrote:
> -static void *persistent_ram_vmap(phys_addr_t start, size_t size)
> +static void *persistent_ram_vmap(phys_addr_t start, size_t size,
> +               unsigned int cached)
>  {
>         struct page **pages;
>         phys_addr_t page_start;
> @@ -392,7 +393,10 @@ static void *persistent_ram_vmap(phys_addr_t start, size_t size)
>         page_start = start - offset_in_page(start);
>         page_count = DIV_ROUND_UP(size + offset_in_page(start), PAGE_SIZE);
>  
> -       prot = pgprot_noncached(PAGE_KERNEL);
> +       if (cached)
> +               prot = pgprot_writecombine(PAGE_KERNEL);
> +       else
> +               prot = pgprot_noncached(PAGE_KERNEL);
>  
>         pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
>         if (!pages) {

If you have a 'struct page', you also have a cacheable mapping in the kernel already,
so you are not really supposed to add another uncached mapping. On some architectures
(e.g. powerpc) that will cause the CPU to checkstop, on others it is undefined
behavior. What is the reason for using an uncached mapping here in the first place?

> @@ -411,8 +415,11 @@ static void *persistent_ram_vmap(phys_addr_t start, size_t size)
>         return vaddr;
>  }
>  
> -static void *persistent_ram_iomap(phys_addr_t start, size_t size)
> +static void *persistent_ram_iomap(phys_addr_t start, size_t size,
> +               unsigned int cached)
>  {
> +       void *va;
> +
>         if (!request_mem_region(start, size, "persistent_ram")) {
>                 pr_err("request mem region (0x%llx at 0x%llx) failed\n",
>                         (unsigned long long)size, (unsigned long long)start);
> @@ -422,19 +429,24 @@ static void *persistent_ram_iomap(phys_addr_t start, size_t size)
>         buffer_start_add = buffer_start_add_locked;
>         buffer_size_add = buffer_size_add_locked;
>  
> -       return ioremap(start, size);
> +       if (cached)
> +               va = ioremap(start, size);
> +       else
> +               va = ioremap_wc(start, size);
> +
> +       return va;
>  }

This seems confusing at best, but is probably just wrong: so you use
an uncached mapping if someone asks for cached, but use a (more relaxed)
write-combining mapping if someone asked for a stricter mapping?
It's also the other way round for persistent_ram_vmap above.

According to your description, the intention is to make atomic operations
work, however most architectures don't allow atomics on either type of
uncached mapping, since atomicity is a feature of the cache coherency
fabric.

The only way I see to actually make atomics work here is to use a cached
mapping and explicit dcache flushes to actually force the data into
persistent storage.

	Arnd
