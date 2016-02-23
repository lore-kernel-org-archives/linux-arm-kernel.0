From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Tue, 23 Feb 2016 11:30:51 -0600
Subject: [PATCH] irqchip/gicv3-its: Don't allow devices whose ID is
 outside range
In-Reply-To: <1456199868-9054-1-git-send-email-shankerd@codeaurora.org>
References: <1456199868-9054-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <56CC974B.8080907@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,


On 02/22/2016 09:57 PM, Shanker Donthineni wrote:
> We are not checking whether the requested device identifier fits into
> table or not. The ITS MAPD command fails if 'Device ID' is outside of
> device table range.
>
> Add a simple validation check to avoid MAPD failures since we are
> not handling ITS command errors. This change also helps to return an
> error -ENOMEM instead of success to caller.
>
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
> This patch depends on https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/gic-4.5-fixes&id=2eca0d6ceea1f108b2d3ac81fb34698c4fd41006
>
>   drivers/irqchip/irq-gic-v3-its.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index c0f227a..9bdcdf5 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -70,6 +70,7 @@ struct its_node {
>   	struct {
>   		void		*base;
>   		u32		order;
> +		u32		entry_size;
>   	} tables[GITS_BASER_NR_REGS];
>   	struct its_collection	*collections;
>   	struct list_head	its_device_list;
> @@ -880,6 +881,7 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
>   					node_name, order);
>   			}
>   		}
> +		its->tables[type].entry_size = entry_size;
>   
>   retry_alloc_baser:
>   		alloc_pages = (PAGE_ORDER_TO_SIZE(order) / psz);
> @@ -896,8 +898,8 @@ retry_alloc_baser:
>   			goto out_free;
>   		}
>   
> -		its->tables[i].base = base;
> -		its->tables[i].order = order;
> +		its->tables[type].base = base;
> +		its->tables[type].order = order;
>   
>   retry_baser:
>   		val = (virt_to_phys(base) 				 |
> @@ -947,7 +949,7 @@ retry_baser:
>   			 * something is horribly wrong...
>   			 */
>   			free_pages((unsigned long)base, order);
> -			its->tables[i].base = NULL;
> +			its->tables[type].base = NULL;
>   
>   			switch (psz) {
>   			case SZ_16K:
> @@ -1152,12 +1154,22 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>   	unsigned long *lpi_map;
>   	unsigned long flags;
>   	u16 *col_map = NULL;
> +	u8 type = GITS_BASER_TYPE_DEVICE;
> +	u32 entry_size;
> +	u32 order;
>   	void *itt;
>   	int lpi_base;
>   	int nr_lpis;
>   	int nr_ites;
>   	int sz;
>   
> +	entry_size = its->tables[type].entry_size;
> +	order = its->tables[type].order;
> +
> +	/* Don't allow 'dev_id' that exceeds single, flat table limit */
> +	if (dev_id >= (PAGE_ORDER_TO_SIZE(order) / entry_size))
> +		return NULL;
> +
>   	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>   	/*
>   	 * At least one bit of EventID is being used, hence a minimum
ITS probe function tries to allocate maximum memory as much as possible 
to cover whole DevID.
sparse which is reported (ITS_TYPER.Devbits) by HW. We might not be able 
to allocate enough
memory for device table.  We reduce memory allocation size for two 
reasons either because of
crossing MAX_ORDER limit or max ITS_BASERn size.

1) According to ARM-GIC spec, we can assign maximum memory size 256 
(ITS-Size) *
    64K (ITS-PageSzie) Bytes to level-one (flat) device table.

     DevID = flat_table_size / device_table_entry_size = 16 MBytes / 8  
= 21bits (max)

2) Maximum 4Mbytes memory is possible on kernel using PAGE_SIZE=4K with 
default
     arch/arm64/defconfig (MAX_ORDER = 12).

     DevID = flat_table_size / device_table_entry_size = 4 MBytes / 8  = 
19bits (max)

Assuming: minimum device table entry size 8 Bytes.

I think it is a generic problem and this fail scenario happens if DevID 
range is more than 21bits or
failed to allocate required memory size for device table.

Our ITS hardware is capable of supporting 32bit DevID space, so it 
advertises ITS_TYPER.Devbits
field with value 31 causing this problem. I think we need some 
protection in its_create_device() to
avoid this scenario.

I am planning to post an another patch to add support for 
ITS-Indirection (two-level) table walk feature.

-- 
Shanker Donthineni
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
