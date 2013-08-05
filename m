From: mina86@mina86.com (Michal Nazarewicz)
Date: Mon, 05 Aug 2013 16:06:17 +0200
Subject: [PATCH v4 1/4] drivers: dma-contiguous: clean source code and
 prepare for device tree
In-Reply-To: <1375275119-12787-2-git-send-email-m.szyprowski@samsung.com>
References: <1375275119-12787-1-git-send-email-m.szyprowski@samsung.com>
 <1375275119-12787-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <xa1twqo0ut9i.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31 2013, Marek Szyprowski wrote:
> This patch cleans the initialization of dma contiguous framework. The
> all-in-one dma_declare_contiguous() function is now separated into
> dma_contiguous_reserve_area() which only steals the the memory from
> memblock allocator and dma_contiguous_add_device() function, which
> assigns given device to the specified reserved memory area. This improves
> the flexibility in defining contiguous memory areas and assigning device
> to them, because now it is possible to assign more than one device to
> the given contiguous memory area. Such split in initialization procedure
> is also required for upcoming device tree support.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

Even though I have some comments.

> @@ -124,22 +124,29 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>  #endif
>  	}
>  
> -	if (selected_size) {
> +	if (selected_size && !dma_contiguous_default_area) {

Perhaps check this earlier in the function?  Also, maybe WARN would be
in order when dma_contiguous_reserve is called with
dma_contiguous_default_area already reserved.

>  		pr_debug("%s: reserving %ld MiB for global area\n", __func__,
>  			 (unsigned long)selected_size / SZ_1M);
>  
> -		dma_declare_contiguous(NULL, selected_size, 0, limit);
> +		dma_contiguous_reserve_area(selected_size, 0, limit,
> +					    &dma_contiguous_default_area);
>  	}
>  };
>  
>  static DEFINE_MUTEX(cma_mutex);


> -int __init dma_declare_contiguous(struct device *dev, phys_addr_t size,
> -				  phys_addr_t base, phys_addr_t limit)
> +int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
> +				       phys_addr_t limit, struct cma **res_cma)

> @@ -277,10 +245,11 @@ int __init dma_declare_contiguous(struct device *dev, phys_addr_t size,
>  	 * Each reserved area must be initialised later, when more kernel
>  	 * subsystems (like slab allocator) are available.
>  	 */
> -	r->start = base;
> -	r->size = size;
> -	r->dev = dev;
> -	cma_reserved_count++;
> +	cma->base_pfn = PFN_DOWN(base);
> +	cma->count = size >> PAGE_SHIFT;
> +	*res_cma = cma;

Alternatively it could return a pointer, but either way?

> +	cma_area_count++;
> +
>  	pr_info("CMA: reserved %ld MiB at %08lx\n", (unsigned long)size / SZ_1M,
>  		(unsigned long)base);
>  

> +int __init dma_contiguous_add_device(struct device *dev, struct cma *cma)
> +{
> +	dev_set_cma_area(dev, cma);
> +	return 0;
> +}

This never fails and it is used in dma_declare_contiguous w/o checking
for errors so perhaps it should return void?  Applies to some other
functions as well.

Moreover, this function is so tiny, it makes me wonder why does it exist
in the first place (why would anyone call it rather then
dev_set_cma_area?  is it just matter of name?), and since it exists, why
not put it to a header file as a static inline.

> +int __init dma_contiguous_set_default_area(struct cma *cma)
> +{
> +	dma_contiguous_default_area = cma;
> +	return 0;
>  }

Ditto.

> +static inline int dma_declare_contiguous(struct device *dev, phys_addr_t size,
> +					 phys_addr_t base, phys_addr_t limit)
> +{
> +	struct cma *cma;
> +	int ret;

+	if (WARN_ON(!dev))
+		return -EINVAL;

> +	ret = dma_contiguous_reserve_area(size, base, limit, &cma);
> +	if (ret == 0)
> +		dma_contiguous_add_device(dev, cma);
> +
> +	return ret;
> +}

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 835 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130805/76f09c24/attachment.sig>
