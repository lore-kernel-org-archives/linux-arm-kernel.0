From: grant.likely@linaro.org (Grant Likely)
Date: Sun, 02 Mar 2014 13:40:43 +0800
Subject: [PATCH v6 05/11] drivers: of: add automated assignment of
 reserved regions to client devices
In-Reply-To: <1393594976-16728-6-git-send-email-m.szyprowski@samsung.com>
References: <1393594976-16728-1-git-send-email-m.szyprowski@samsung.com> <
 1393594976-16728-6-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20140302054043.4F48AC414EF@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Feb 2014 14:42:50 +0100, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> This patch adds code for automated assignment of reserved memory regions
> to struct device. reserved_mem->ops->device_init()/device_cleanup()
> callbacks are called to perform reserved memory driver specific
> initialization and cleanup
> 
> Based on previous code provided by Josh Cartwright <joshc@codeaurora.org>
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Hi Marek,

I've not applied this one yet, only because there is still the open
issue of whether or not these functions should be called from drivers or
from core code. I don't actually have any problems with the content of
this patch. Once the user is sorted out I'll merge it.

g.

> ---
>  drivers/of/of_reserved_mem.c    |   70 +++++++++++++++++++++++++++++++++++++++
>  include/linux/of_reserved_mem.h |    7 ++++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index daaaf935911d..5c45016efd31 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -206,8 +206,16 @@ void __init fdt_init_reserved_mem(void)
>  	for (i = 0; i < reserved_mem_count; i++) {
>  		struct reserved_mem *rmem = &reserved_mem[i];
>  		unsigned long node = rmem->fdt_node;
> +		unsigned long len;
> +		__be32 *prop;
>  		int err = 0;
>  
> +		prop = of_get_flat_dt_prop(node, "phandle", &len);
> +		if (!prop)
> +			prop = of_get_flat_dt_prop(node, "linux,phandle", &len);
> +		if (prop)
> +			rmem->phandle = of_read_number(prop, len/4);
> +
>  		if (rmem->size == 0)
>  			err = __reserved_mem_alloc_size(node, rmem->name,
>  						 &rmem->base, &rmem->size);
> @@ -215,3 +223,65 @@ void __init fdt_init_reserved_mem(void)
>  			__reserved_mem_init_node(rmem);
>  	}
>  }
> +
> +static inline struct reserved_mem *__find_rmem(struct device_node *node)
> +{
> +	unsigned int i;
> +
> +	if (!node->phandle)
> +		return NULL;
> +
> +	for (i = 0; i < reserved_mem_count; i++)
> +		if (reserved_mem[i].phandle == node->phandle)
> +			return &reserved_mem[i];
> +	return NULL;
> +}
> +
> +/**
> + * of_reserved_mem_device_init() - assign reserved memory region to given device
> + *
> + * This function assign memory region pointed by "memory-region" device tree
> + * property to the given device.
> + */
> +void of_reserved_mem_device_init(struct device *dev)
> +{
> +	struct reserved_mem *rmem;
> +	struct device_node *np;
> +
> +	np = of_parse_phandle(dev->of_node, "memory-region", 0);
> +	if (!np)
> +		return;
> +
> +	rmem = __find_rmem(np);
> +	of_node_put(np);
> +
> +	if (!rmem || !rmem->ops || !rmem->ops->device_init)
> +		return;
> +
> +	rmem->ops->device_init(rmem, dev);
> +	dev_info(dev, "assigned reserved memory node %s\n", rmem->name);
> +}
> +
> +/**
> + * of_reserved_mem_device_release() - release reserved memory device structures
> + *
> + * This function releases structures allocated for memory region handling for
> + * the given device.
> + */
> +void of_reserved_mem_device_release(struct device *dev)
> +{
> +	struct reserved_mem *rmem;
> +	struct device_node *np;
> +
> +	np = of_parse_phandle(dev->of_node, "memory-region", 0);
> +	if (!np)
> +		return;
> +
> +	rmem = __find_rmem(np);
> +	of_node_put(np);
> +
> +	if (!rmem || !rmem->ops || !rmem->ops->device_release)
> +		return;
> +
> +	rmem->ops->device_release(rmem, dev);
> +}
> diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
> index 9b1fbb7f29fc..6a54e6565b89 100644
> --- a/include/linux/of_reserved_mem.h
> +++ b/include/linux/of_reserved_mem.h
> @@ -8,6 +8,7 @@ struct reserved_mem_ops;
>  struct reserved_mem {
>  	const char			*name;
>  	unsigned long			fdt_node;
> +	unsigned long			phandle;
>  	const struct reserved_mem_ops	*ops;
>  	phys_addr_t			base;
>  	phys_addr_t			size;
> @@ -25,6 +26,9 @@ typedef int (*reservedmem_of_init_fn)(struct reserved_mem *rmem,
>  				      unsigned long node, const char *uname);
>  
>  #ifdef CONFIG_OF_RESERVED_MEM
> +void of_reserved_mem_device_init(struct device *dev);
> +void of_reserved_mem_device_release(struct device *dev);
> +
>  void fdt_init_reserved_mem(void);
>  void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
>  			       phys_addr_t base, phys_addr_t size);
> @@ -37,6 +41,9 @@ void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
>  				init : init }
>  
>  #else
> +static inline void of_reserved_mem_device_init(struct device *dev) { }
> +static inline void of_reserved_mem_device_release(struct device *pdev) { }
> +
>  static inline void fdt_init_reserved_mem(void) { }
>  static inline void fdt_reserved_mem_save_node(unsigned long node,
>  		const char *uname, phys_addr_t base, phys_addr_t size) { }
> -- 
> 1.7.9.5
> 
