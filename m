From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 28 Jul 2017 16:55:36 +0100
Subject: [PATCH 0/4] ACPI: DMA ranges management
In-Reply-To: <20170728140956.GA21569@red-moon>
References: <20170720144517.32529-1-lorenzo.pieralisi@arm.com>
 <7df11172-5a40-685f-5202-9a0bceb6e19b@codeaurora.org>
 <c09352cc-e1a2-a494-c457-dc3ea275f504@arm.com>
 <20170726153519.GA4696@red-moon>
 <eb81a7c6-b62b-8e02-8f22-a7fda7e403ce@arm.com>
 <20170728140956.GA21569@red-moon>
Message-ID: <c6edb652-d13c-e21f-1cef-01ced2b08c05@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/07/17 15:09, Lorenzo Pieralisi wrote:
> On Fri, Jul 28, 2017 at 02:08:01PM +0100, Robin Murphy wrote:
> 
> [...]
> 
>>>>> To ensure that dma_set_mask() and friends actually respect _DMA, would
>>>>> you consider introducing a dma_supported() callback to check the input
>>>>> dma_mask against the FW defined limits? This would end up aggressively
>>>>> clipping the dma_mask to 32-bits for devices like the above if the _DMA
>>>>> limit was less than 64-bits, but that is probably preferable to the
>>>>> controller accessing unintended addresses.
>>>>>
>>>>> Also, how would you feel about adding support for the IORT named_node
>>>>> memory_address_limit field?
>>>>
>>>> We will certainly need that for some platform devices, so if you fancy
>>>> giving it a go before Lorenzo or I get there, feel free!
>>>
>>> I can do it for v2 but I would like to understand why using _DMA is
>>> not good enough for named components - having two bindings describing
>>> the same thing is not ideal and I'd rather avoid it - if there is
>>> a reason I am happy to add the necessary code.
>>
>> My interpretation of "_DMA is only defined under devices that represent
>> buses." (ACPI 6.0, section 6.2.4) is that "devices that represent buses"
>> are those that have other device objects as children.
> 
> Well if that was the case we would not be able to use _DMA for
> eg PNP0A03 PCI host bridges that have no child ACPI devices, which
> defeats the whole purpose of what I am doing.
> 
> The question here is what the _DMA object binding exactly means when
> it refers to a "bus" and that's something I will figure out (and possibly
> change) ASAP.
> 
>> In other words (excuse my novice pseudo-ASL), this would be valid:
>>
>> Scope(_SB)
>> {
>> 	Device (Bus)
>> 	{
>> 		...
>> 		Method (_DMA ... )
>> 		Device (Dev1)
>> 		{
>> 			...
>> 		}
>> 	}
>> }
>>
>> but this should be invalid:
>>
>> Scope(_SB)
>> {
>> 	Device (Dev2)
>> 	{
>> 		...
>> 		Method (_DMA ... )
>> 	}
>> }
> 
> Not sure about that (see above) and I agree that's what needs
> clarification.
> 
>> Thus in the case where Dev2 is wired directly to an SMMU input, but
>> fewer address bits are wired up between the two than both the device and
>> SMMU interfaces are capable of, memory address limit is enough to
>> describe that without having to insert a fake "bus" object above it just
>> to hold the _DMA method.
> 
> BTW, how would you describe that in DT ? A "dma-ranges" property in the
> device DT node right ? Arguably "dma-ranges" was not meant to be used
> like that either ;-)

I believe that in real Open Firmware, the full PCI hierarchy is
described in the device tree - I had assumed that ACPI expected the
equivalent (i.e. the firmware probes PCI and assigns resources, so
bridges/endpoints/etc. would be represented in the namespace with
appropriate _CRS), thus the "bus with invisible children" case would
only need to apply to DT. In terms of DTspec, it does not say that
"dma-ranges" cannot be present on nodes without children, but that *is*
implied of #address-cells and #size cells, so there does exist a similar
ambiguity about what exactly counts as "a memory-mapped bus whose
devicetree parent can be accessed from DMA operations originating from
the bus". Certainly in the current Linux code, of_dma_configure()
*doesn't* parse "dma-ranges" on leaf nodes (which is an open problem for
some PCI host bridges in extant FDTs).

As for the case of straightforward interconnect widths/offsets (rather
than potentially arbitrary windows), the 'fake bus' notion is already
alive and well:

$ git grep 'soc {' arch/arm*/boot/dts

and the current "dma-ranges" users thankfully have consistent-enough
topologies that they don't need to get much crazier than that.

(side note: up at the other end, I'm not entirely convinced that what I
did for Juno is actually legal either)

> Long and short of it is: I do not like having two ways of describing
> the same thing. I agree that the _DMA object usage requires
> clarifications from a spec point of view but I want to do that before
> plugging in code that may use bindings inconsistently.

I'd still argue that they are describing different things, just that one
(the number of address bits wired up between a device and an SMMU)
happens to be possible to describe as a subset of the other (an
arbitrary mapping between two address spaces). The use-cases don't
entirely overlap either - the information in _DMA is also likely to be
wanted by non-ECAM PCI host controller drivers to configure their
inbound windows, irrespective of anything to do with IOMMUs, whereas
IORT code in hypervisors or other situations without a full ACPI
namespace available may need to make decisions that the device memory
address size limit is necessary for (well, that's the argument I've
heard anyway).
> I will flag this up at ACPI spec level as soon as possible and get this
> sorted.

Agreed.

Robin.
