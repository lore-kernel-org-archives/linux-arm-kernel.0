From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Fri, 27 May 2016 11:36:31 +0800
Subject: [PATCH 2/3] of/numa: fix a memory@ dt node can only contains one
 memory block
In-Reply-To: <20160526131345.GA12024@rob-hp-laptop>
References: <1464230639-9852-1-git-send-email-thunder.leizhen@huawei.com>
 <1464230639-9852-2-git-send-email-thunder.leizhen@huawei.com>
 <20160526131345.GA12024@rob-hp-laptop>
Message-ID: <5747C0BF.505@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/5/26 21:13, Rob Herring wrote:
> On Thu, May 26, 2016 at 10:43:58AM +0800, Zhen Lei wrote:
>> For a normal memory@ devicetree node, its reg property can contains more
>> memory blocks.
>>
>> Because we don't known how many memory blocks maybe contained, so we try
>> from index=0, increase 1 until error returned(the end).
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/of/of_numa.c | 30 ++++++++++++++++++++----------
>>  1 file changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
>> index 21d831f..2c5f249 100644
>> --- a/drivers/of/of_numa.c
>> +++ b/drivers/of/of_numa.c
>> @@ -63,7 +63,7 @@ static int __init of_numa_parse_memory_nodes(void)
>>  	struct device_node *np = NULL;
>>  	struct resource rsrc;
>>  	u32 nid;
>> -	int r = 0;
>> +	int i, r = 0;
>>
>>  	for (;;) {
>>  		np = of_find_node_by_type(np, "memory");
>> @@ -82,17 +82,27 @@ static int __init of_numa_parse_memory_nodes(void)
>>  			/* some other error */
>>  			break;
>>
>> -		r = of_address_to_resource(np, 0, &rsrc);
>> -		if (r) {
>> -			pr_err("NUMA: bad reg property in memory node\n");
>> -			break;
>> +		for (i = 0; ; i++) {
>> +			r = of_address_to_resource(np, i, &rsrc);
>> +			if (r) {
>> +				/* reached the end of of_address */
>> +				if (i > 0) {
>> +					r = 0;
>> +					break;
>> +				}
>> +
>> +				pr_err("NUMA: bad reg property in memory node\n");
>> +				goto finished;
>> +			}
>> +
>> +			r = numa_add_memblk(nid, rsrc.start,
>> +					    rsrc.end - rsrc.start + 1);
>> +			if (r)
>> +				goto finished;
>>  		}
>> -
>> -		r = numa_add_memblk(nid, rsrc.start,
>> -				    rsrc.end - rsrc.start + 1);
>> -		if (r)
>> -			break;
>>  	}
>> +
>> +finished:
>>  	of_node_put(np);
> 
> This function can be simplified down to:
> 
> 	for_each_node_by_type(np, "memory") {
OK, That's good.

> 		r = of_property_read_u32(np, "numa-node-id", &nid);
> 		if (r == -EINVAL)
> 			/*
> 			 * property doesn't exist if -EINVAL, continue
> 			 * looking for more memory nodes with
> 			 * "numa-node-id" property
> 			 */
> 			continue;
Hi, everybody:
    If some "memory" node contains "numa-node-id", but some others missed. Can we simply ignored it?
I think we should break out too, and faking to only have node0.

> 		else if (r)
> 			/* some other error */
> 			break;
> 
> 		r = of_address_to_resource(np, 0, &rsrc);
> 		for (i = 0; !r; i++, r = of_address_to_resource(np, i, 

But r(non-zero) is just break this loop, the original is break the outer for (;;) loop

How about as below?

	for_each_node_by_type(np, "memory") {
		... ...

		for (i = 0; !of_address_to_resource(np, i, &rsrc); i++) {
                        r = numa_add_memblk(nid, rsrc.start,
                                            rsrc.end - rsrc.start + 1);
                        if (r)
                                goto finished;
                }

		if (!i)
			pr_err("NUMA: bad reg property in memory node\n");
	}

finished:
	

> &rsrc)) {
> 			r = numa_add_memblk(nid, rsrc.start,
> 				    rsrc.end - rsrc.start + 1);
> 		}
> 	}
> 	of_node_put(np);
> 
> 	return r;
> 
> 
> Perhaps with a "if (!i && r) pr_err()" for an error message at the end.
> 
> Rob
> 
> .
> 
