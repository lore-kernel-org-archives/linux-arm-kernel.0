From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 10 Jul 2015 10:41:58 +0100
Subject: [PATCH v2 6/9] irqchip / gic: Add stacked irqdomain support for
 ACPI based GICv2 init
In-Reply-To: <559C9BB4.90103@linaro.org>
References: <1434703572-26221-1-git-send-email-hanjun.guo@linaro.org>
 <1434703572-26221-7-git-send-email-hanjun.guo@linaro.org>
 <20150622172014.GB26129@red-moon> <5589772A.8070708@linaro.org>
 <20150623173845.GC31466@red-moon> <558E1DEE.3090900@linaro.org>
 <55910440.8070702@arm.com> <559282A0.8090601@linaro.org>
 <559288CA.40605@arm.com> <559C9BB4.90103@linaro.org>
Message-ID: <559F9366.2070900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/15 04:40, Hanjun Guo wrote:
> Hi Marc,
> 
> On 06/30/2015 08:17 PM, Marc Zyngier wrote:
>> On 30/06/15 12:50, Hanjun Guo wrote:
>>> Hi Marc,
>>>
>>> On 06/29/2015 04:39 PM, Marc Zyngier wrote:
>>>> On 27/06/15 04:52, Hanjun Guo wrote:
>>>>> On 06/24/2015 01:38 AM, Lorenzo Pieralisi wrote:
>>>>>> On Tue, Jun 23, 2015 at 04:11:38PM +0100, Hanjun Guo wrote:
>>> [...]
>>>>>>
>>>>>>>>>        for (i = 0; i < nr_irqs; i++)
>>>>>>>>>                gic_irq_domain_map(domain, virq + i, hwirq + i);
>>>>>>>>> @@ -945,11 +952,11 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>>>>>>>>>                gic_irqs = 1020;
>>>>>>>>>        gic->gic_irqs = gic_irqs;
>>>>>>>>>
>>>>>>>>> -      if (node) {             /* DT case */
>>>>>>>>> +      if (node || !acpi_disabled) {           /* DT or ACPI case */
>>>>>>>>>                gic->domain = irq_domain_add_linear(node, gic_irqs,
>>>>>>>>>                                                    &gic_irq_domain_hierarchy_ops,
>>>>>>>>>                                                    gic);
>>>>>>
>>>>>> I think this is a bit more worrying, I mean passing a NULL node pointer to
>>>>>> the irqdomain layer which basically means you are booting out of ACPI
>>>>>
>>>>> I'm little confused here, would you mind explaining more for your
>>>>> worrying? To me, node pointer is optional and it's ok for ACPI
>>>>> case.
>>>>>
>>>>>> (for you, if that's true for the irq_domain_add_linear implementation
>>>>>> that's another story), the node pointer should be optional but you
>>>>>> need feedback from IRQ layer maintainers here.
>>>>>
>>>>> Sure.
>>>>
>>>> Frankly, I'd really like to see ACPI using the "node" parameter for
>>>> something useful. This would save having to cache pointers all over the
>>>> place, will make find_irq_host() work as expected... etc.
>>>>
>>>> See the comment at the top of linux/irqdomain.h :
>>>>
>>>> "... This code could thus be used on other architectures by replacing
>>>> those two by some sort of arch-specific void * "token" used to identify
>>>> interrupt controllers."
> 
> I'm stuck here, I think the token for now is tied to device tree as
> the device node pointer for now in the code if the pointer is not NULL,
> just see the of_node_get(of_node) in __irq_domain_add(), if dynamic
> dt is enabled:
> 
> struct device_node *of_node_get(struct device_node *node)
> {
>          if (node)
>                  kobject_get(&node->kobj);
>          return node;
> }
> EXPORT_SYMBOL(of_node_get);
> 
> so if the node is not NULL, it will be used to get the node's
> kobject, that will be a problem for acpi case if we pass a token
> as a parameter.

Well, I'm sure this could be worked around, and we could have different
handling for different type of objects.

> 
> I rethink for quite a while and have a discussion with Graeme,
> I come out another idea and we don't need the token at all
> for ACPI case.

>>>
>>> To init GIC in ACPI, we can only use the table entry pointer as
>>> the token, but the ACPI static tables are early mem/io remapped
>>> memory at boot stage, and it will be not available after boot,
>>> also we need muti types of MADT enties to init GIC (GICC and GICD
>>> for GICv2, GICC or GICR and GICD for GICv3), not as DT, just
>>> one single node to include all the information needed to init
>>> the GIC.
>>
>> A single pointer would be enough, you don't need all of them.
>>
>>> We use ACPI handle for devices as node for DT when the namespace
>>> is available, but that's pretty late in the boot stage which GIC,
>>> SMP and timers were already initialized, so ACPI handle can not
>>> use as the token too.
>>>
>>> I see multi places just pass NULL as the pointer directly for
>>> irq_domain_add_linear() which works fine, and for ACPI, we tested
>>> this patch and also it works.
>>
>> Yes it works. But you're reinventing the wheel by keeping references
>> outside of the normal framework, which is simply going to make the code
> 
> That's the framework for DT not suitable for ACPI, just see the comments
> below.
> 
>> more difficult to maintain in the long run.
>>
>> Putting NULL as the device_node parameter really means "this is a domain
>> I don't need to look up later". In your case, you will have to lookup
> 
> I agree that we need to look up the domain not just using the
> global acpi_irq_domain pointer everywhere, which make the code not
> scalable, but I don't think it's not OK to put NULL as the device_node
> parameter in ACPI case.
> 
> The reason is that we use different model of mapping interrupt with
> device in ACPI, for ACPI device in DSDT, it's using another mapping of
> device and hwirq number than DT, in DT, we using the interrupt parent
> property to get the device node of irqchip, that's why we need the
> matching function that match the device node with the one associated
> with the irqdomain. But for ACPI, we only can get the gsi which the
> device is using, no interrupt parent will be used, that because gsi is
> a flat hwirq number which is unique in the system, then we can get its
> associated irq domain by matching the gsi supported by this irqchip
> (see drawings below),  then we can be without the token pointer
> matching the interrupt controller.

But that's for only GSI. GSI are not the *real* problem. The real issue
is when you have a system that composes domains. We're moving away from
a model where you can store the various domains yourself. For example,
have a look at this:

https://lwn.net/Articles/650418/

and specially patch 13. See how the PCI/MSI domain looks up the core ITS
domain? This is where we're going. Various *independent* entities
building a hierarchy based on a common repository.

So please stop saying that ACPI is different, because it really isn't.
You create domains based on some global identifier, you look them up
using this identifier. There is nothing more to it. The core code has
some issues with that? Let's fix it.

Look at Suravee's patches introducing ACPI support for GICv2m. He seems
to be doing a rather good job reusing the existing framework, and
adapting it to fit the ACPI model. It doesn't mean I agree with
everything in his series (I need to review it in more details), but this
is the direction I'd like to see things taken.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
