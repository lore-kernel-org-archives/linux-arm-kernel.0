From: eric.auger@redhat.com (Auger Eric)
Date: Thu, 16 Mar 2017 09:57:47 +0100
Subject: [RFC PATCH 13/33] irqchip/gic-v3-its: Generalize device table
 allocation
In-Reply-To: <1484648454-21216-14-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-14-git-send-email-marc.zyngier@arm.com>
Message-ID: <ca0a71ee-dedf-785d-30c7-1cb03091b529@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 17/01/2017 11:20, Marc Zyngier wrote:
> As we want to use 2-level tables for VCPUs, let's hack the device
s/VCPUS/vPE table
> table allocator in order to make it slightly more generic. It
> will get reused in subsequent patches.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 5d96b37..dcd4771 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1371,26 +1371,19 @@ static struct its_baser *its_get_baser(struct its_node *its, u32 type)
>  	return NULL;
>  }
>  
> -static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
> +static bool its_alloc_table_entry(struct its_baser *baser, u32 id)
>  {
> -	struct its_baser *baser;
>  	struct page *page;
>  	u32 esz, idx;
>  	__le64 *table;
>  
> -	baser = its_get_baser(its, GITS_BASER_TYPE_DEVICE);
> -
> -	/* Don't allow device id that exceeds ITS hardware limit */
> -	if (!baser)
> -		return (ilog2(dev_id) < its->device_ids);
> -
>  	/* Don't allow device id that exceeds single, flat table limit */
>  	esz = GITS_BASER_ENTRY_SIZE(baser->val);
>  	if (!(baser->val & GITS_BASER_INDIRECT))
> -		return (dev_id < (PAGE_ORDER_TO_SIZE(baser->order) / esz));
> +		return (id < (PAGE_ORDER_TO_SIZE(baser->order) / esz));
>  
>  	/* Compute 1st level table index & check if that exceeds table limit */
> -	idx = dev_id >> ilog2(baser->psz / esz);
> +	idx = id >> ilog2(baser->psz / esz);
>  	if (idx >= (PAGE_ORDER_TO_SIZE(baser->order) / GITS_LVL1_ENTRY_SIZE))
>  		return false;
>  
> @@ -1419,6 +1412,19 @@ static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
>  	return true;
>  }
>  
> +static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
I would rename this into its_alloc_device_table_entry().
> +{
> +	struct its_baser *baser;
> +
> +	baser = its_get_baser(its, GITS_BASER_TYPE_DEVICE);
> +
> +	/* Don't allow device id that exceeds ITS hardware limit */
> +	if (!baser)
> +		return (ilog2(dev_id) < its->device_ids);
I don't get above check and comment. Shouldn't you first check the baser
is not void and second check the dev_id does not overflow the HW capacity?

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> +
> +	return its_alloc_table_entry(baser, dev_id);
> +}
> +
>  static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>  					    int nvecs)
>  {
> 
