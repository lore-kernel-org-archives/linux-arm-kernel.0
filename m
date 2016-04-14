From: pantelis.antoniou@konsulko.com (Pantelis Antoniou)
Date: Thu, 14 Apr 2016 13:40:30 +0300
Subject: [Question] refcount of DT node
In-Reply-To: <20160414101053.GC10273@leverpostej>
References: <CAK7LNATFUW2KXUpFas6C_SJ0C7Qb1DWU0njLg-FCYciK2U6Oag@mail.gmail.com>
 <20160414101053.GC10273@leverpostej>
Message-ID: <EF5FABC1-E74B-4154-8F20-A21DC6E01AB5@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> On Apr 14, 2016, at 13:10 , Mark Rutland <mark.rutland@arm.com> wrote:
> 
> On Thu, Apr 14, 2016 at 04:47:57PM +0900, Masahiro Yamada wrote:
>> Hi experts.
>> 
>> My understanding of refcount of DT node is poor.
>> Please help me understand it correctly.
>> 
>> Sorry if I am asking stupid questions.
>> 
>> 
>> [1] Does this reference count exist for Overlay?
>>    Is a node freed when its refcount becomes zero?
> 
> I'm not familiar with the way that overlays are intended to work, but
> generally this is true, and I believe the same applies.
> 
> Pantelis, please correct me if I am wrong on that front.
> 

Yes, if the refcount goes to zero everything is released.
No that doesn?t always imply freeing memory.

>> [2] When of_node_put() should be called,
>>     or should not be called?
>> 
>> 
>> Shouldn't of_node_put() be called
>> when we are still referencing to any of its properties?
>> 
>> For example,  cpu_read_enable_method()
>> in arch/arm64/kernel/cpu_ops.c
>> returns a pointer to the property value
>> instead of creating a copy of it.
>> 
>> In this case, of_node_put() should not be called
>> because we are still referencing the DT property
>> (in other words, referencing to the DT node indirectly).
>> 
>> Am I right?
> 
> Yes, the node should not be freed while its data is referred to.
> 
> We are leaking a ref there, though, as we no longer refer to that data
> after cpu_read_ops().
> 
> Fixing that will require some restructuring. We don't expect a CPU node
> to need to disappear, so while it's currently not strictly correct the
> code shouldn't lead to any adverse behaviour.
> 

So let me explain a bit.

Due to historical reasons by default nodes and property contents are not dynamically
allocated, they are merely being pointed at in the binary blob that was passed on
during boot.

This all takes place in __unflatten_device_tree and there is an allocator argument for
allocating the device_node & properties structures. The content pointers of those structures
are directly pointing in the binary blob.

Early in the boot process the allocator used is not the standard kmalloc allocator; this does
not support freeing the structures at all.

Dynamic DT instead kmalloc?s everything; this is marked by using the node flag OF_DYNAMIC.

So when a node is released a check is performed whether OF_DYNAMIC is set.

There is an additional complication with properties. Since DT property methods (like of_get_property)
return a pointer to property value it is generally not safe to free a property. So when a property
is removed (but the node still exists) it is placed on the node?s deadprops list which may reside
until the node is released.

Hope this makes things clearer.

>> [3] Is the following code correct?
>> 
>>   np = of_find_compatible_node(NULL, NULL,"foo-node");
>>   of_node_put(np);
>>   ret = of_address_to_resource(np, 0, &res);
>>   if (ret) {
>>            pr_err("failed to get resource\n");
>>            return ret;
>>   }
>> 
>> Actually I wrote the code above, and it was applied.
>> 
>> But, the node is still referenced while of_address_to_resource() is being run.
>> 
>> So the correct code should be as follows?
>> 
>>   np = of_find_compatible_node(NULL, NULL,"foo-node");
>>   ret = of_address_to_resource(np, 0, &res);
>>   of_node_put(np);
>>   if (ret) {
>>            pr_err("failed to get resource\n");
>>            return ret;
>>   }
> 
> It is correctly balanced, yes.
> 
> If you don't need to keep the node for future use, this is fine.
> 

The second code fragment is the correct one.

> Mark.

Regards

? Pantelis
