From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 29 Apr 2015 16:53:10 -0500
Subject: [PATCH 2/2] ACPI / scan: Parse _CCA and setup device coherency
In-Reply-To: <2968069.n1L1S3Mp2q@wuerfel>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1430315049-4663-3-git-send-email-Suravee.Suthikulpanit@amd.com>
 <2968069.n1L1S3Mp2q@wuerfel>
Message-ID: <554152C6.7020600@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/29/15 11:25, Arnd Bergmann wrote:
> On Wednesday 29 April 2015 08:44:09 Suravee Suthikulpanit wrote:
>> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
>> index 4bf7559..a4db208 100644
>> --- a/drivers/acpi/acpi_platform.c
>> +++ b/drivers/acpi/acpi_platform.c
>> @@ -108,9 +108,12 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
>>          if (IS_ERR(pdev))
>>                  dev_err(&adev->dev, "platform device creation failed: %ld\n",
>>                          PTR_ERR(pdev));
>> -       else
>> +       else {
>> +               arch_setup_dma_ops(&pdev->dev, 0, 0, NULL,
>> +                                  adev->flags.is_coherent);
>>                  dev_dbg(&adev->dev, "created platform device %s\n",
>>                          dev_name(&pdev->dev));
>> +       }
>>
>>          kfree(resources);
>>
>
> Looking at this code in more detail, it seems that it unconditionally
> sets pdevinfo.dma_mask = DMA_BIT_MASK(32), before calling
> arch_setup_dma_ops().

I think that's just the default legacy value assigned when it first 
create the platform_device from acpi_device.

> This assignment should really done inside of arch_setup_dma_ops()
 > instead, which means we should implement that
> function on all architectures that support ACPI.


> For the case where _CCA is missing (or coherency disabled, if you ask
> me), we would not call that function.

Actually, I agree for the case of missing _CCA when needed, ACPI driver 
probably should not make assumption and leave the decision for the 
default underlying arch-specific default. Basically, it should not be 
calling arch_setup_dma_ops().

As for the case where _CCA=0, I think the ACPI driver should essentially 
communicate the information as HW is non-coherent as described in the 
spec, and should be calling arch_setup_dma_ops(dev, false). It is true 
that this in probably less-likely for the ARM64 server platforms. 
However, I would think that the ACPI driver should not be making such 
assumption.

> On a related note, I'm not sure how to handle different DMA masks here.
> arch_setup_dma_ops() gets passed a size (and offset) argument, which should
> match the DMA mask, but I don't know if there is a way to find out the
> size from ACPI. Should we assume it's always 64-bit DMA capable?

Looking at the ACPI spec, it does have the _DMA object. IIUC, this can 
be used to describe DMA properties of a particular bus.

Method(_DMA, ResourceTemplate()
{
	QWORDMemory(
	ResourceConsumer,
	PosDecode, // _DEC
	MinFixed, // _MIF
	MaxFixed, // _MAF
	Prefetchable, // _MEM
	ReadWrite, // _RW
	0, // _GRA
	0, // _MIN
	0x1fffffff, // _MAX
	0x200000000, // _TRA
	0x20000000, // _LEN
	, , ,	
	)
}

I am not sure if this is an appropriate use for this object, but this 
seems to be similar to the dma-ranges property for OF, and probably can 
be used to specify baseaddr and size information when calling 
arch_setup_dma_ops().

> For legacy reasons, the default mask is probably best left at 32-bit,
> but drivers are expected to call dma_set_mask() if they can do 64-bit DMA,
> and that should fail based on the information provided by the platform
> if the bus is not capable of doing that.
>
> 	Arnd
>

However, on ARM64 the dma_base and size parameter for 
arch_setup_dma_ops() is currently not used, and only coherent flag is 
used. We probably should look at this separately. For the moment, we can 
probably say that if _CCA object is missing when needed, the ACPI driver 
won't set up dma_mask when creating platform_device, which should be 
equivalent to saying DMA is not supported.

Please let me know if this is acceptable, and I'll make change in V2 
accordingly.

Thanks,

Suravee
