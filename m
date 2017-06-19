From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 19 Jun 2017 16:42:15 +0100
Subject: [RFC PATCH 09/33] irqchip/gic-v3-its: Split out property table
 allocation
In-Reply-To: <c98bf0f6-884a-3851-aefc-571b0cbce703@redhat.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-10-git-send-email-marc.zyngier@arm.com>
 <c98bf0f6-884a-3851-aefc-571b0cbce703@redhat.com>
Message-ID: <a0fe6356-72fc-edb9-6751-0494d2d53321@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/02/17 06:15, Auger Eric wrote:
> Hi Marc,
> On 17/01/2017 11:20, Marc Zyngier wrote:
>> Move the LPI property table allocation into its own function, as
>> this is going to be required for those associated with VMs in
>> the future.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 28 ++++++++++++++++++----------
>>  1 file changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index b28fb19..c92ff4d 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -889,15 +889,31 @@ static void its_lpi_free(struct event_lpi_map *map)
>>  	kfree(map->col_map);
>>  }
>>  
>> +static struct page *its_allocate_prop_table(gfp_t gfp_flags)
>> +{
>> +	struct page *prop_page;
>> +
>> +	prop_page = alloc_pages(gfp_flags, get_order(LPI_PROPBASE_SZ));
>> +	if (!prop_page)
>> +		return NULL;
>> +
>> +	/* Priority 0xa0, Group-1, disabled */
>> +	memset(page_address(prop_page),
>> +	       LPI_PROP_DEFAULT_PRIO | LPI_PROP_GROUP1,
>> +	       LPI_PROPBASE_SZ);
>> +
>> +	/* Make sure the GIC will observe the written configuration */
>> +	gic_flush_dcache_to_poc(page_address(gic_rdists->prop_page), LPI_PROPBASE_SZ);
> s/gic_rdists->prop_page/prop_page.

Yeah, this doesn't hit on the model, bizarrely. Oh well... Thanks for
spotting this.

	M.
-- 
Jazz is not dead. It just smells funny...
