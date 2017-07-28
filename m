From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 28 Jul 2017 14:08:01 +0100
Subject: [PATCH 0/4] ACPI: DMA ranges management
In-Reply-To: <20170726153519.GA4696@red-moon>
References: <20170720144517.32529-1-lorenzo.pieralisi@arm.com>
 <7df11172-5a40-685f-5202-9a0bceb6e19b@codeaurora.org>
 <c09352cc-e1a2-a494-c457-dc3ea275f504@arm.com>
 <20170726153519.GA4696@red-moon>
Message-ID: <eb81a7c6-b62b-8e02-8f22-a7fda7e403ce@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/07/17 16:35, Lorenzo Pieralisi wrote:
> On Wed, Jul 26, 2017 at 04:05:55PM +0100, Robin Murphy wrote:
>> Hi Nate,
>>
>> On 26/07/17 15:46, Nate Watterson wrote:
>>> Hi Lorenzo,
>>>
>>> On 7/20/2017 10:45 AM, Lorenzo Pieralisi wrote:
>>>> As reported in:
>>>>
>>>> http://lkml.kernel.org/r/CAL85gmA_SSCwM80TKdkZqEe+S1beWzDEvdki1kpkmUTDRmSP7g at mail.gmail.com
>>>>
>>>>
>>>> the bus connecting devices to an IOMMU bus can be smaller in size than
>>>> the IOMMU input address bits which results in devices DMA HW bugs in
>>>> particular related to IOVA allocation (ie chopping of higher address
>>>> bits owing to system bus HW capabilities mismatch with the IOMMU).
>>>>
>>>> Fortunately this problem can be solved through an already present but
>>>> never
>>>> used ACPI 6.2 firmware bindings (ie _DMA object) allowing to define
>>>> the DMA
>>>> window for a specific bus in ACPI and therefore all upstream devices
>>>> connected to it.
>>>>
>>>> This small patch series enables _DMA parsing in ACPI core code and
>>>> use it in ACPI IORT code in order to detect DMA ranges for devices and
>>>> update their data structures to make them work with their related DMA
>>>> addressing restrictions.
>>>
>>> I tested the patches and unfortunately it seems like the DMA addressing
>>> restrictions are not really enforced for devices that attempt to set
>>> their own dma_mask based on controller capabilities. For instance,
>>> consider the following from the ahci_platform driver:
>>>
>>>     if (hpriv->cap & HOST_CAP_64) {
>>>         rc = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
>>>         [...]
>>>     }
>>>
>>> Prior to the check, I can see that the device dma_mask respects the
>>> limits enumerated in the _DMA object, however it is then clobbered by
>>> the call to dma_coerce_mask_and_coherent(). Interestingly, if
>>> HOST_CAP_64 was not set and the _DMA object for the device (or its
>>> parent) indicated support for > 32-bit addrs, the host controller
>>> could end up getting programmed with addresses beyond what it actually
>>> supports. That is more a bug with the ahci_platform driver assuming a
>>> default 32-bit dma_mask, but I would not be surprised to find other
>>> drivers that rely on the same assumption.
>>
>> Yup, you've hit upon the more general problem, which applies equally to
>> DT "dma-ranges" too. I'm working on arm64 DMA stuff at the moment, and
>> have the patch to actually enforce the firmware-described limit when
>> drivers update their masks, but that depends on everyone passing the
>> correct information to arch_setup_dma_ops() in the first place (I think
>> DT needs more fixing than ACPI does).
>>
>>> To ensure that dma_set_mask() and friends actually respect _DMA, would
>>> you consider introducing a dma_supported() callback to check the input
>>> dma_mask against the FW defined limits? This would end up aggressively
>>> clipping the dma_mask to 32-bits for devices like the above if the _DMA
>>> limit was less than 64-bits, but that is probably preferable to the
>>> controller accessing unintended addresses.
>>>
>>> Also, how would you feel about adding support for the IORT named_node
>>> memory_address_limit field?
>>
>> We will certainly need that for some platform devices, so if you fancy
>> giving it a go before Lorenzo or I get there, feel free!
> 
> I can do it for v2 but I would like to understand why using _DMA is
> not good enough for named components - having two bindings describing
> the same thing is not ideal and I'd rather avoid it - if there is
> a reason I am happy to add the necessary code.

My interpretation of "_DMA is only defined under devices that represent
buses." (ACPI 6.0, section 6.2.4) is that "devices that represent buses"
are those that have other device objects as children. In other words
(excuse my novice pseudo-ASL), this would be valid:

Scope(_SB)
{
	Device (Bus)
	{
		...
		Method (_DMA ... )
		Device (Dev1)
		{
			...
		}
	}
}

but this should be invalid:

Scope(_SB)
{
	Device (Dev2)
	{
		...
		Method (_DMA ... )
	}
}

Thus in the case where Dev2 is wired directly to an SMMU input, but
fewer address bits are wired up between the two than both the device and
SMMU interfaces are capable of, memory address limit is enough to
describe that without having to insert a fake "bus" object above it just
to hold the _DMA method.

Robin.
