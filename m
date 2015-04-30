From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Thu, 30 Apr 2015 18:39:34 -0500
Subject: [Linaro-acpi] [PATCH 2/2] ACPI / scan: Parse _CCA and setup device
 coherency
In-Reply-To: <6513459.YvvHTY3yyJ@wuerfel>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <2968069.n1L1S3Mp2q@wuerfel> <554152C6.7020600@amd.com>
 <6513459.YvvHTY3yyJ@wuerfel>
Message-ID: <5542BD36.3030602@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/30/2015 3:23 AM, Arnd Bergmann wrote:
> On Wednesday 29 April 2015 16:53:10 Suravee Suthikulpanit wrote:
>> On 4/29/15 11:25, Arnd Bergmann wrote:
>>> On Wednesday 29 April 2015 08:44:09 Suravee Suthikulpanit wrote:
>> [...]
>> As for the case where _CCA=0, I think the ACPI driver should essentially
>> communicate the information as HW is non-coherent as described in the
>> spec, and should be calling arch_setup_dma_ops(dev, false). It is true
>> that this in probably less-likely for the ARM64 server platforms.
>> However, I would think that the ACPI driver should not be making such
>> assumption.
>
> Can you add a description to the ACPI spec then to describe in detail what
> "non-coherent" is supposed to mean, and which action the OS is supposed to
> take when accessing data from device or CPU?

I believe Will has already provided this, and we have already discussed 
this on separate emails in this thread.

>>>[...]
>>> On a related note, I'm not sure how to handle different DMA masks here.
>>> arch_setup_dma_ops() gets passed a size (and offset) argument, which should
>>> match the DMA mask, but I don't know if there is a way to find out the
>>> size from ACPI. Should we assume it's always 64-bit DMA capable?
>>
>> Looking at the ACPI spec, it does have the _DMA object. IIUC, this can
>> be used to describe DMA properties of a particular bus.
>>
>> Method(_DMA, ResourceTemplate()
>> {
>> 	QWORDMemory(
>> 	ResourceConsumer,
>> 	PosDecode, // _DEC
>> 	MinFixed, // _MIF
>> 	MaxFixed, // _MAF
>> 	Prefetchable, // _MEM
>> 	ReadWrite, // _RW
>> 	0, // _GRA
>> 	0, // _MIN
>> 	0x1fffffff, // _MAX
>> 	0x200000000, // _TRA
>> 	0x20000000, // _LEN
>> 	, , ,	
>> 	)
>> }
>>
>> I am not sure if this is an appropriate use for this object, but this
>> seems to be similar to the dma-ranges property for OF, and probably can
>> be used to specify baseaddr and size information when calling
>> arch_setup_dma_ops().
>
> Yes, that seems like a good idea. What is the expected behavior when that
> object is absent? Do we assume that the parent device is not DMA capable?

 From the spec:
If the _DMA object is not present for a bus device, the OS assumes that 
any address placed on a bus by a child device will be decoded either by 
a device on the bus or by the bus itself, (in other words, all address 
ranges can be used for DMA).

The issue is, since this is optional, I don't know which FW often 
providing this info.

> Is this sufficient to describe the case where a device can only do DMA
> to a specific address range that is not at bus address zero but that maps
> to the beginning of physical RAM?

I believe that's the _MIN (Minimum Base Address) is for.

>>> For legacy reasons, the default mask is probably best left at 32-bit,
>>> but drivers are expected to call dma_set_mask() if they can do 64-bit DMA,
>>> and that should fail based on the information provided by the platform
>>> if the bus is not capable of doing that.
>>>
>> However, on ARM64 the dma_base and size parameter for
>> arch_setup_dma_ops() is currently not used, and only coherent flag is
>> used.
>
> We can hope that we won't need the dma_base setting here, but it's
> good to have the option to pass it down if we need it.
>
> Not passing the size is a bug that needs to be fixed ASAP, I believe
> a number of folks have run into this, most recently the APM X-Gene
> MMC controller
>

Ok. I'll look at this separately.

>> We probably should look at this separately. For the moment, we can
>> probably say that if _CCA object is missing when needed, the ACPI driver
>> won't set up dma_mask when creating platform_device, which should be
>> equivalent to saying DMA is not supported.
>>
>> Please let me know if this is acceptable, and I'll make change in V2
>> accordingly.
>
> I would still ask that you treat non-coherent to mean "no DMA" until
> we have come up with a way to sufficiently describe the kind of
> non-coherency in ACPI.
>
> 	Arnd

Ok. In V2, when _CCA=0, since we are not aware of ARM64 systems that is 
working with such assumption with ACPI. I will also default to not 
calling arch_setup_dma_ops() and fallback to arch-specific default. We 
can revisit this later once we need to support such case.

Thanks,

Suravee
