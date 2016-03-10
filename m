From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Wed, 9 Mar 2016 18:49:31 -0600
Subject: [PATCH v2] irqchip/gicv3-its: Don't allow devices whose ID is
 outside range
In-Reply-To: <20160309023116.7172f095@arm.com>
References: <1456687323-8446-1-git-send-email-shankerd@codeaurora.org>
 <20160309023116.7172f095@arm.com>
Message-ID: <56E0C49B.8010300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 03/08/2016 08:31 PM, Marc Zyngier wrote:
> On Sun, 28 Feb 2016 13:22:03 -0600
> Shanker Donthineni <shankerd@codeaurora.org> wrote:
>
> Hi Shanker,
>
>> We are not checking whether the requested device identifier fits into
>> the device table memory or not. The function its_create_device()
>> assumes that enough memory has been allocated for whole DevID sparse
>> (reported by ITS_TYPER.Devbits) during the ITS probe() and continues
>> to initialize ITS hardware.
>>
>> This assumption is not perfect, sometimes we reduce memory size either
>> because of its size crossing MAX_ORDER-1 or BASERn max size limit. The
>> MAPD command fails if 'Device ID' is outside of device table range.
>>
>> Add a simple validation check to avoid MAPD failures since we are
>> not handling ITS command errors. This change also helps to return an
>> error -ENOMEM instead of success to caller.
>>
>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>> ---
>> [v1]->[v2]
>>   Rebase to v4.5-rc6, edit commit text and simplify code changes
>>
>>  drivers/irqchip/irq-gic-v3-its.c | 24 ++++++++++++++++++++----
>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 43dfd15..6d986ac 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -55,6 +55,16 @@ struct its_collection {
>>  };
>>  
>>  /*
>> + * The ITS_BASER structure - contains memeory information and table
>> + * entry size in bytes.
>> + */
>> +struct its_baser {
>> +	void		*base;
>> +	u32		order;
>> +	u32		entry_size;
>> +};
>> +
>> +/*
>>   * The ITS structure - contains most of the infrastructure, with the
>>   * top-level MSI domain, the command queue, the collections, and the
>>   * list of devices writing to it.
>> @@ -66,14 +76,12 @@ struct its_node {
>>  	unsigned long		phys_base;
>>  	struct its_cmd_block	*cmd_base;
>>  	struct its_cmd_block	*cmd_write;
>> -	struct {
>> -		void		*base;
>> -		u32		order;
>> -	} tables[GITS_BASER_NR_REGS];
>> +	struct its_baser	tables[GITS_BASER_NR_REGS];
>>  	struct its_collection	*collections;
>>  	struct list_head	its_device_list;
>>  	u64			flags;
>>  	u32			ite_size;
>> +	struct its_baser	*device_table;
> nit: grouping this field with the tables array would make it slightly
> nicer.

Sure, I will get rid of this variable and add a simple accessory
function to retrieve device table pointer.

static struct its_baser *its_get_baser(struct its_node *its, u8 type)
{
        int i;

        for (i = 0; i < GITS_BASER_NR_REGS; i++) {
                if (its->tables[i].type == type)
                        return &its->tables[i];
        }

        return NULL;
}

>>  };
>>  
>>  #define ITS_ITT_ALIGN		SZ_256
>> @@ -860,6 +868,7 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
>>  		 * For other tables, only allocate a single page.
>>  		 */
>>  		if (type == GITS_BASER_TYPE_DEVICE) {
>> +			its->device_table = &its->tables[i];
>>  			/*
>>  			 * 'order' was initialized earlier to the default page
>>  			 * granule of the the ITS.  We can't have an allocation
>> @@ -874,6 +883,7 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
>>  					node_name, order);
>>  			}
>>  		}
>> +		its->tables[i].entry_size = entry_size;
>>  
>>  retry_alloc_baser:
>>  		alloc_pages = (PAGE_ORDER_TO_SIZE(order) / psz);
>> @@ -1152,6 +1162,12 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>>  	int nr_ites;
>>  	int sz;
>>  
>> +	/* Don't allow 'dev_id' that exceeds single, flat table limit */
>> +	if (its->device_table &&
>> +	    (dev_id >= (PAGE_ORDER_TO_SIZE(its->device_table->order) /
>> +	    its->device_table->entry_size)))
> Assume for a minute we do not have a device table (which would be
> perfectly possible - just think of an ITS with its own private memory,
> like we have with KVM). Shouldn't we also check devid with the number of
> bits that this ITS implements for Device IDs?

Thanks, I thought of same thing. I am planning to handle second
validation check with code changes something like shown below.

        /* Don't allow 'dev_id' that exceeds single, flat table limit */
        if (baser) {
            if (dev_id >= (PAGE_ORDER_TO_SIZE(baser->order) /
                baser->entry_size))
                return NULL;
        } else if (ilog2(dev_id) >= its->device_ids)
                return NULL;
 
>> +		return NULL;
>> +
>>  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>>  	/*
>>  	 * At least one bit of EventID is being used, hence a minimum
> Thanks,
>
> 	M.

-- 
Shanker Donthineni
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
