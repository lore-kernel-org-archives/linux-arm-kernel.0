From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 13 Feb 2017 16:14:17 -0600
Subject: [RFC PATCH 10/33] irqchip/gic-v4-its: Allow use of indirect VCPU
 tables
In-Reply-To: <1484648454-21216-11-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-11-git-send-email-marc.zyngier@arm.com>
Message-ID: <90c5e45f-3eea-9e84-08b2-919edc15e2c8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,


On 01/17/2017 04:20 AM, Marc Zyngier wrote:
> The VCPU tables can be quite sparse as well, and it makes sense
> to use indirect tables as well if possible.
The VCPU table has maximum of 2^16 entries as compared to 2^32 entries 
in device table. ITS hardware implementations may not support indirect 
table because of low memory requirement.
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/irqchip/irq-gic-v3-its.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c
> b/drivers/irqchip/irq-gic-v3-its.c
> index c92ff4d..14305db1 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1060,10 +1060,13 @@ static int its_setup_baser(struct its_node *its,
> struct its_baser *baser,
>   	return 0;
>   }
>   
> -static bool its_parse_baser_device(struct its_node *its, struct its_baser
> *baser,
> -				   u32 psz, u32 *order)
> +static bool its_parse_indirect_baser(struct its_node *its,
> +				     struct its_baser *baser,
> +				     u32 psz, u32 *order)
>   {
> -	u64 esz = GITS_BASER_ENTRY_SIZE(its_read_baser(its, baser));
> +	u64 tmp = its_read_baser(its, baser);
> +	u64 type = GITS_BASER_TYPE(tmp);
> +	u64 esz = GITS_BASER_ENTRY_SIZE(tmp);
>   	u64 val = GITS_BASER_InnerShareable | GITS_BASER_WaWb;
>   	u32 ids = its->device_ids;
>   	u32 new_order = *order;
> @@ -1102,8 +1105,9 @@ static bool its_parse_baser_device(struct its_node
> *its, struct its_baser *baser
>   	if (new_order >= MAX_ORDER) {
>   		new_order = MAX_ORDER - 1;
>   		ids = ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
> -		pr_warn("ITS@%pa: Device Table too large, reduce ids
> %u->%u\n",
> -			&its->phys_base, its->device_ids, ids);
> +		pr_warn("ITS@%pa: %s Table too large, reduce ids
> %u->%u\n",
> +			&its->phys_base, its_base_type_string[type],
> +			its->device_ids, ids);
>   	}
>   
>   	*order = new_order;
> @@ -1154,8 +1158,10 @@ static int its_alloc_tables(struct its_node *its)
>   		if (type == GITS_BASER_TYPE_NONE)
>   			continue;
>   
> -		if (type == GITS_BASER_TYPE_DEVICE)
> -			indirect = its_parse_baser_device(its, baser, psz,
> &order);
Try to allocate maximum memory as possible then attempt enabling 
indirection table.

#define ITS_VPES_MAX            (65536)

if (type == GITS_BASER_TYPE_VCPU)
          order = get_order(esz * ITS_VPES_MAX);

On Qualcomm implementation, 1MBytes, 64536  * 16Byte (vPE entry size) 
memory is enough to sparse 16bit vPE.
> +		if (type == GITS_BASER_TYPE_DEVICE ||
> +		    type == GITS_BASER_TYPE_VCPU)
> +			indirect = its_parse_indirect_baser(its, baser,
> +							    psz, &order);
>   
>   		err = its_setup_baser(its, baser, cache, shr, psz, order,
> indirect);
>   		if (err < 0) {

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
