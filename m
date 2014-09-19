From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 19 Sep 2014 21:30:36 +0300
Subject: [PATCH] arm64/pci: fix dma coherency inheritance for PCI devices
In-Reply-To: <1411144934.25340.34.camel@deneb.redhat.com>
References: <1411141886-11310-1-git-send-email-msalter@redhat.com>
 <20140919162859.GG20773@arm.com> <1411144934.25340.34.camel@deneb.redhat.com>
Message-ID: <541C764C.9030301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 09/19/2014 07:42 PM, Mark Salter wrote:
> On Fri, 2014-09-19 at 17:28 +0100, Will Deacon wrote:
>> On Fri, Sep 19, 2014 at 04:51:26PM +0100, Mark Salter wrote:
>>> The default dma_ops for devices on arm64 systems are noncoherent in
>>> nature and rely upon special operations and bounce buffers to
>>> perform a device DMA operation to/from memory. Some drivers rely
>>> upon coherent operations involving suitably capable hardware. In
>>> this case, a "dma-coherent" property will exist on the corresponding
>>> Device Tree node for the bridge device, or one of its ancestors.
>>> This patch adds support for applying a DMA coherent dma_ops for
>>> PCI devices in the case of such a property.
>>>
>>> Signed-off-by: Jon Masters <jcm@redhat.com>
>>> [added search for device with of_node]
>>> Signed-off-by: Mark Salter <msalter@redhat.com>
>>> ---
>>>   arch/arm64/mm/dma-mapping.c | 21 +++++++++++++++++++--
>>>   1 file changed, 19 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>>> index 4164c5a..0e26bd7 100644
>>> --- a/arch/arm64/mm/dma-mapping.c
>>> +++ b/arch/arm64/mm/dma-mapping.c
>>> @@ -23,10 +23,12 @@
>>>   #include <linux/dma-mapping.h>
>>>   #include <linux/dma-contiguous.h>
>>>   #include <linux/of.h>
>>> +#include <linux/of_address.h>
>>>   #include <linux/platform_device.h>
>>>   #include <linux/vmalloc.h>
>>>   #include <linux/swiotlb.h>
>>>   #include <linux/amba/bus.h>
>>> +#include <linux/pci.h>
>>>   
>>>   #include <asm/cacheflush.h>
>>>   
>>> @@ -316,8 +318,18 @@ static int dma_bus_notifier(struct notifier_block *nb,
>>>   	if (event != BUS_NOTIFY_ADD_DEVICE)
>>>   		return NOTIFY_DONE;
>>>   
>>> -	if (of_property_read_bool(dev->of_node, "dma-coherent"))
>>> -		set_dma_ops(dev, &coherent_swiotlb_dma_ops);
>>> +	/*
>>> +	 * Some devices won't have an of_node but a bus controller/bridge will.
>>> +	 * Search up the device chain until we find an of_node to check.
>>> +	 */
>>> +	while (dev) {
>>> +		if (dev->of_node) {
>>> +			if (of_dma_is_coherent(dev->of_node))
>>> +				set_dma_ops(_dev, &coherent_swiotlb_dma_ops);
>>> +			break;
>>> +		}
>>> +		dev = dev->parent;
>>> +	}
>>
>> Hmm, how does this interact with of_dma_configure? I don't think the
>> dma-coherent property is inherited there, so I'm uneasy about doing this for
>> buses other than PCI (i.e. the platform bus).
> 
> of_dma_configure() only gets called for platform bus and it

It's going to be used for AMBA bus too -
"[PATCH] of: amba: use of_dma_configure for AMBA devices"
http://www.spinics.net/lists/arm-kernel/msg363169.html

> uses of_dma_is_coherent() which searches device ancestors for
> dma-coherent property. But it uses set_arch_dma_coherent_ops()

of_dma_is_coherent() will search from current Device node and all its
ancestors.

> which is a no-op on arm64 now. Catalin mentions this in another
> thread: https://lkml.org/lkml/2014/9/15/363
> 
> So maybe we should fix set_arch_dma_coherent_ops() and drop
> platform bus from the notifier handler.

Yes. That will allow you to drop platform bus notifier handler.
Actually, if patch "[PATCH] of: amba: use of_dma_configure for AMBA devices"
will be merged then notifier for AMBA bus can be dropped too.

> 
>>
>> In other words, we should move to using of_dma_configure for the platform
>> and amba buses, and have a separate notifier for the PCI bus. Is it likely
>> that people will have a mixture of coherent and non-coherent devices behind
>> the same host controller?
>>

Also, there is a patch which updates DT documentation for DMA properties,
but it's not been merged accidentally :(
"Re: [PATCH] dt/documentation: add specification of dma bus information"
https://lkml.org/lkml/2014/6/22/144

Regards,
-grygorii
