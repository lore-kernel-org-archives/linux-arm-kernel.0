From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 18 Oct 2016 10:45:46 -0700
Subject: [PATCH v2 1/2] remoteproc: core: Add rproc OF look-up functions
In-Reply-To: <20160816143824.4120-1-lee.jones@linaro.org>
References: <20160816143824.4120-1-lee.jones@linaro.org>
Message-ID: <20161018174546.GY7509@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 16 Aug 07:38 PDT 2016, Lee Jones wrote:

> - of_rproc_by_index(): look-up and obtain a reference to a rproc
>                        using the DT phandle "rprocs" and a index.
> 
> - of_rproc_by_name():  lookup and obtain a reference to a rproc
>                        using the DT phandle "rprocs" and "rproc-names".
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

For the record; I have not picked these patches because I have not yet
seen an acceptable proposal for a client - there are concerns about DT
bindings of such client and questions on how to notify the client about
life cycle changes in the remoteproc (i.e. crash recovery events).

I think the patches looks good, so once these open questions gets
answered (or some new use case appear) I will pick these up again.

Regards,
Bjorn

> ---
> 
> v1 => v2:
>  - s/ti,rprocs/ti,rproc
> 
> drivers/remoteproc/remoteproc_core.c | 78 +++++++++++++++++++++++++++++++++++-
>  include/linux/remoteproc.h           | 25 +++++++++++-
>  2 files changed, 101 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index fe0539e..fe362fb 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -41,6 +41,8 @@
>  #include <linux/virtio_ids.h>
>  #include <linux/virtio_ring.h>
>  #include <asm/byteorder.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
>  
>  #include "remoteproc_internal.h"
>  
> @@ -1191,6 +1193,81 @@ out:
>  }
>  EXPORT_SYMBOL(rproc_shutdown);
>  
> +#ifdef CONFIG_OF
> +/**
> + * of_get_rproc_by_index() - lookup and obtain a reference to an rproc
> + * @np: node to search for rproc phandle
> + * @index: index into the phandle list
> + *
> + * This function increments the remote processor's refcount, so always
> + * use rproc_put() to decrement it back once rproc isn't needed anymore.
> + *
> + * Returns a pointer to the rproc struct on success or an appropriate error
> + * code otherwise.
> + */
> +struct rproc *of_get_rproc_by_index(struct device_node *np, int index)
> +{
> +	struct rproc *rproc = NULL, *r;
> +	struct device_node *rproc_np;
> +
> +	if (index < 0) {
> +		pr_err("Invalid index: %d\n", index);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	rproc_np = of_parse_phandle(np, "rprocs", index);
> +	if (!rproc_np) {
> +		/* Unfortunately we have to support this, at least for now */
> +		rproc_np = of_parse_phandle(np, "ti,rproc", index);
> +		if (!rproc_np) {
> +			pr_err("Failed to obtain phandle\n");
> +			return ERR_PTR(-ENODEV);
> +		}
> +	}
> +
> +	mutex_lock(&rproc_list_mutex);
> +	list_for_each_entry(r, &rproc_list, node) {
> +		if (r->dev.parent && r->dev.parent->of_node == rproc_np) {
> +			get_device(&r->dev);
> +			rproc = r;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&rproc_list_mutex);
> +
> +	of_node_put(rproc_np);
> +
> +	if (!rproc)
> +		pr_err("Could not find rproc, deferring\n");
> +
> +	return rproc ?: ERR_PTR(-EPROBE_DEFER);
> +}
> +EXPORT_SYMBOL(of_get_rproc_by_index);
> +
> +/**
> + * of_get_rproc_by_name() - lookup and obtain a reference to an rproc
> + * @np: node to search for rproc
> + * @name: name of the remoteproc from device's point of view
> + *
> + * This function increments the remote processor's refcount, so always
> + * use rproc_put() to decrement it back once rproc isn't needed anymore.
> + *
> + * Returns a pointer to the rproc struct on success or an appropriate error
> + * code otherwise.
> + */
> +struct rproc *of_get_rproc_by_name(struct device_node *np, const char *name)
> +{
> +	int index;
> +
> +	if (unlikely(!name))
> +		return ERR_PTR(-EINVAL);
> +
> +	index = of_property_match_string(np, "rproc-names", name);
> +
> +	return of_get_rproc_by_index(np, index);
> +}
> +EXPORT_SYMBOL(of_get_rproc_by_name);
> +
>  /**
>   * rproc_get_by_phandle() - find a remote processor by phandle
>   * @phandle: phandle to the rproc
> @@ -1203,7 +1280,6 @@ EXPORT_SYMBOL(rproc_shutdown);
>   *
>   * Returns the rproc handle on success, and NULL on failure.
>   */
> -#ifdef CONFIG_OF
>  struct rproc *rproc_get_by_phandle(phandle phandle)
>  {
>  	struct rproc *rproc = NULL, *r;
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 1c457a8..f130938 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -487,7 +487,6 @@ struct rproc_vdev {
>  	u32 rsc_offset;
>  };
>  
> -struct rproc *rproc_get_by_phandle(phandle phandle);
>  struct rproc *rproc_alloc(struct device *dev, const char *name,
>  				const struct rproc_ops *ops,
>  				const char *firmware, int len);
> @@ -511,4 +510,28 @@ static inline struct rproc *vdev_to_rproc(struct virtio_device *vdev)
>  	return rvdev->rproc;
>  }
>  
> +#ifdef CONFIG_OF
> +extern struct rproc *of_get_rproc_by_index(struct device_node *np,
> +					   int index);
> +extern struct rproc *of_get_rproc_by_name(struct device_node *np,
> +					  const char *name);
> +extern struct rproc *rproc_get_by_phandle(phandle phandle);
> +#else
> +static inline
> +struct rproc *of_get_rproc_by_index(struct device_node *np, int index)
> +{
> +	return NULL;
> +}
> +static inline
> +struct rproc *of_get_rproc_by_name(struct device_node *np, const char *name)
> +{
> +	return NULL;
> +}
> +static inline
> +struct rproc *rproc_get_by_phandle(phandle phandle)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_OF */
> +
>  #endif /* REMOTEPROC_H */
> -- 
> 2.9.0
> 
