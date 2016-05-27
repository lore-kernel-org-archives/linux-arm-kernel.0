From: ddaney@caviumnetworks.com (David Daney)
Date: Fri, 27 May 2016 09:07:02 -0700
Subject: [PATCH 2/3] of/numa: fix a memory@ dt node can only contains
 one memory block
In-Reply-To: <5747C0BF.505@huawei.com>
References: <1464230639-9852-1-git-send-email-thunder.leizhen@huawei.com>
 <1464230639-9852-2-git-send-email-thunder.leizhen@huawei.com>
 <20160526131345.GA12024@rob-hp-laptop> <5747C0BF.505@huawei.com>
Message-ID: <574870A6.40003@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/2016 08:36 PM, Leizhen (ThunderTown) wrote:
[...]		continue;
> Hi, everybody:
>      If some "memory" node contains "numa-node-id", but some others missed. Can we simply ignored it?
> I think we should break out too, and faking to only have node0.


I think if some "memory" nodes contain "numa-node-id" and others do not, 
then you have a defective device tree.  In this case I think we must 
continue with the existing behavior, and indicate failure.  This will 
cause the architecture specific NUMA code to disable NUMA and force 
everything onto a singl pseudo-NUMA-node.

I doubt there is anything to be gained by guessing which NUMA node 
orphaned "memory" nodes belong to.

>
>> 		else if (r)
>> 			/* some other error */
>> 			break;
>>
>> 		r = of_address_to_resource(np, 0, &rsrc);
>> 		for (i = 0; !r; i++, r = of_address_to_resource(np, i,
>
> But r(non-zero) is just break this loop, the original is break the outer for (;;) loop
>
> How about as below?
>
> 	for_each_node_by_type(np, "memory") {
> 		... ...
>
> 		for (i = 0; !of_address_to_resource(np, i, &rsrc); i++) {
>                          r = numa_add_memblk(nid, rsrc.start,
>                                              rsrc.end - rsrc.start + 1);
>                          if (r)
>                                  goto finished;
>                  }
>
> 		if (!i)
> 			pr_err("NUMA: bad reg property in memory node\n");
> 	}
>
> finished:
> 	
>
>> &rsrc)) {
>> 			r = numa_add_memblk(nid, rsrc.start,
>> 				    rsrc.end - rsrc.start + 1);
>> 		}
>> 	}
>> 	of_node_put(np);
>>
>> 	return r;
>>
>>
>> Perhaps with a "if (!i && r) pr_err()" for an error message at the end.
>>
>> Rob
>>
>> .
>>
>
