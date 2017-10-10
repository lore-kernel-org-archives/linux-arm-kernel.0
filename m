From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 9 Oct 2017 19:52:15 -0500
Subject: [PATCH v3 2/5] of: reserved_mem: Accessor for acquiring
 reserved_mem
In-Reply-To: <20171005033258.12825-3-bjorn.andersson@linaro.org>
References: <20171005033258.12825-1-bjorn.andersson@linaro.org>
 <20171005033258.12825-3-bjorn.andersson@linaro.org>
Message-ID: <CAL_JsqKRt-ZyKWr6YP-jNOSHEx_nwiweSU9TE0mXZMjsy+2ySA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 10:32 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> In some cases drivers referencing a reserved-memory region might want to
> remap the entire region, but when defining the reserved-memory by "size"
> the client driver has no means to know the associated base address of
> the reserved memory region.
>
> This patch adds an accessor for such drivers to acquire a handle to
> their associated reserved-memory for this purpose.
>
> A complicating factor for the implementation is that the reserved_mem
> objects are created from the flattened DeviceTree, as such we can't
> use the device_node address for comparison. Fortunately the name of the
> node will be used as "name" of the reserved_mem and will be used when
> building the full_name, so we can compare the "name" with the basename
> of the full_name to find the match.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v2:
> - None
>
> Changes since v1:
> - Previous patch provided interface to resolve memory-region reference, instead
>   of direct lookup by device_node
>
>  drivers/of/of_reserved_mem.c    | 26 ++++++++++++++++++++++++++
>  include/linux/of_reserved_mem.h |  5 +++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index d507c3569a88..b40cfce68fd4 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -397,3 +397,29 @@ void of_reserved_mem_device_release(struct device *dev)
>         rmem->ops->device_release(rmem, dev);
>  }
>  EXPORT_SYMBOL_GPL(of_reserved_mem_device_release);
> +
> +/**
> + * of_reserved_mem_get() - acquire reserved_mem from a device node

*_get() generally implies reference counting. Maybe "lookup" instead. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> + * @np:                node pointer of the desired reserved-memory region
> + *
> + * This function allows drivers to acquire a reference to the reserved_mem
> + * struct based on a device node handle.
> + *
> + * Returns a reserved_mem reference, or NULL on error.
> + */
> +struct reserved_mem *of_reserved_mem_get(struct device_node *np)
> +{
> +       const char *name;
> +       int i;
> +
> +       if (!np->full_name)
> +               return NULL;
> +
> +       name = kbasename(np->full_name);
> +       for (i = 0; i < reserved_mem_count; i++)
> +               if (!strcmp(reserved_mem[i].name, name))
> +                       return &reserved_mem[i];
> +
> +       return NULL;
> +}
> +EXPORT_SYMBOL_GPL(of_reserved_mem_get);
> diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
> index f8e1992d6423..91b1eb5076e4 100644
> --- a/include/linux/of_reserved_mem.h
> +++ b/include/linux/of_reserved_mem.h
> @@ -44,6 +44,7 @@ int early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
>  void fdt_init_reserved_mem(void);
>  void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
>                                phys_addr_t base, phys_addr_t size);
> +struct reserved_mem *of_reserved_mem_get(struct device_node *np);
>  #else
>  static inline int of_reserved_mem_device_init_by_idx(struct device *dev,
>                                         struct device_node *np, int idx)
> @@ -55,6 +56,10 @@ static inline void of_reserved_mem_device_release(struct device *pdev) { }
>  static inline void fdt_init_reserved_mem(void) { }
>  static inline void fdt_reserved_mem_save_node(unsigned long node,
>                 const char *uname, phys_addr_t base, phys_addr_t size) { }
> +static inline struct reserved_mem *of_reserved_mem_get(struct device_node *np)
> +{
> +       return NULL;
> +}
>  #endif
>
>  /**
> --
> 2.12.0
>
