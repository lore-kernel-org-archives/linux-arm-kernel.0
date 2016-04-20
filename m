From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 20 Apr 2016 14:12:58 +0100
Subject: [PATCH v7 05/10] iommu/dma-reserved-iommu: reserved binding
 rb-tree and helpers
In-Reply-To: <1461084994-2355-6-git-send-email-eric.auger@linaro.org>
References: <1461084994-2355-1-git-send-email-eric.auger@linaro.org>
 <1461084994-2355-6-git-send-email-eric.auger@linaro.org>
Message-ID: <5717805A.3070602@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/16 17:56, Eric Auger wrote:
> we will need to track which host physical addresses are mapped to
> reserved IOVA. In that prospect we introduce a new RB tree indexed
> by physical address. This RB tree only is used for reserved IOVA
> bindings.
>
> It is expected this RB tree will contain very few bindings.

Sounds like a good reason in favour of using a list, and thus having 
rather less code here ;)

>  Those
> generally correspond to single page mapping one MSI frame (GICv2m
> frame or ITS GITS_TRANSLATER frame).
>
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>
> ---
> v5 -> v6:
> - add comment about @d->reserved_lock to be held
>
> v3 -> v4:
> - that code was formerly in "iommu/arm-smmu: add a reserved binding RB tree"
> ---
>   drivers/iommu/dma-reserved-iommu.c | 63 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
>
> diff --git a/drivers/iommu/dma-reserved-iommu.c b/drivers/iommu/dma-reserved-iommu.c
> index 2562af0..f6fa18e 100644
> --- a/drivers/iommu/dma-reserved-iommu.c
> +++ b/drivers/iommu/dma-reserved-iommu.c
> @@ -23,6 +23,69 @@ struct reserved_iova_domain {
>   	int prot; /* iommu protection attributes to be obeyed */
>   };
>
> +struct iommu_reserved_binding {
> +	struct kref		kref;
> +	struct rb_node		node;
> +	struct iommu_domain	*domain;

Hang on, the tree these are in is already embedded in a domain. Ergo we 
can't look them up without first knowing the domain they belong to, so 
what purpose does this guy serve?

Robin.

> +	phys_addr_t		addr;
> +	dma_addr_t		iova;
> +	size_t			size;
> +};
> +
> +/* Reserved binding RB-tree manipulation */
> +
> +/* @d->reserved_lock must be held */
> +static struct iommu_reserved_binding *find_reserved_binding(
> +				    struct iommu_domain *d,
> +				    phys_addr_t start, size_t size)
> +{
> +	struct rb_node *node = d->reserved_binding_list.rb_node;
> +
> +	while (node) {
> +		struct iommu_reserved_binding *binding =
> +			rb_entry(node, struct iommu_reserved_binding, node);
> +
> +		if (start + size <= binding->addr)
> +			node = node->rb_left;
> +		else if (start >= binding->addr + binding->size)
> +			node = node->rb_right;
> +		else
> +			return binding;
> +	}
> +
> +	return NULL;
> +}
> +
> +/* @d->reserved_lock must be held */
> +static void link_reserved_binding(struct iommu_domain *d,
> +				  struct iommu_reserved_binding *new)
> +{
> +	struct rb_node **link = &d->reserved_binding_list.rb_node;
> +	struct rb_node *parent = NULL;
> +	struct iommu_reserved_binding *binding;
> +
> +	while (*link) {
> +		parent = *link;
> +		binding = rb_entry(parent, struct iommu_reserved_binding,
> +				   node);
> +
> +		if (new->addr + new->size <= binding->addr)
> +			link = &(*link)->rb_left;
> +		else
> +			link = &(*link)->rb_right;
> +	}
> +
> +	rb_link_node(&new->node, parent, link);
> +	rb_insert_color(&new->node, &d->reserved_binding_list);
> +}
> +
> +/* @d->reserved_lock must be held */
> +static void unlink_reserved_binding(struct iommu_domain *d,
> +				    struct iommu_reserved_binding *old)
> +{
> +	rb_erase(&old->node, &d->reserved_binding_list);
> +}
> +
>   int iommu_alloc_reserved_iova_domain(struct iommu_domain *domain,
>   				     dma_addr_t iova, size_t size, int prot,
>   				     unsigned long order)
>
