From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Apr 2015 10:23:59 +0200
Subject: [Linaro-acpi] [PATCH 2/2] ACPI / scan: Parse _CCA and setup
 device coherency
In-Reply-To: <554152C6.7020600@amd.com>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <2968069.n1L1S3Mp2q@wuerfel> <554152C6.7020600@amd.com>
Message-ID: <6513459.YvvHTY3yyJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 April 2015 16:53:10 Suravee Suthikulpanit wrote:
> On 4/29/15 11:25, Arnd Bergmann wrote:
> > On Wednesday 29 April 2015 08:44:09 Suravee Suthikulpanit wrote:
> >> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> >> index 4bf7559..a4db208 100644
> >> --- a/drivers/acpi/acpi_platform.c
> >> +++ b/drivers/acpi/acpi_platform.c
> >> @@ -108,9 +108,12 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
> >>          if (IS_ERR(pdev))
> >>                  dev_err(&adev->dev, "platform device creation failed: %ld\n",
> >>                          PTR_ERR(pdev));
> >> -       else
> >> +       else {
> >> +               arch_setup_dma_ops(&pdev->dev, 0, 0, NULL,
> >> +                                  adev->flags.is_coherent);
> >>                  dev_dbg(&adev->dev, "created platform device %s\n",
> >>                          dev_name(&pdev->dev));
> >> +       }
> >>
> >>          kfree(resources);
> >>
> >
> > Looking at this code in more detail, it seems that it unconditionally
> > sets pdevinfo.dma_mask = DMA_BIT_MASK(32), before calling
> > arch_setup_dma_ops().
> 
> I think that's just the default legacy value assigned when it first 
> create the platform_device from acpi_device.

Understood. And on x86 there is no way to find out if a device supports
DMA or not, so it has to do this I guess.

> > This assignment should really done inside of arch_setup_dma_ops()
>  > instead, which means we should implement that
> > function on all architectures that support ACPI.
> 
> 
> > For the case where _CCA is missing (or coherency disabled, if you ask
> > me), we would not call that function.
> 
> Actually, I agree for the case of missing _CCA when needed, ACPI driver 
> probably should not make assumption and leave the decision for the 
> default underlying arch-specific default. Basically, it should not be 
> calling arch_setup_dma_ops().

Ok.

> As for the case where _CCA=0, I think the ACPI driver should essentially 
> communicate the information as HW is non-coherent as described in the 
> spec, and should be calling arch_setup_dma_ops(dev, false). It is true 
> that this in probably less-likely for the ARM64 server platforms. 
> However, I would think that the ACPI driver should not be making such 
> assumption.

Can you add a description to the ACPI spec then to describe in detail what
"non-coherent" is supposed to mean, and which action the OS is supposed to
take when accessing data from device or CPU?

As I explained, the way we handle it by default on ARM64 is what embedded
systems typically do, but that might be completely different on the imagined
server chips that are not coherent for some reason. Just saying a device
is not coherent is like saying the CPU has known bugs but not saying how
to prevent it from crashing.

Is there some AML method that the OS can call to synchronize the cache
controller for all DMA to/from a particular device?

> > On a related note, I'm not sure how to handle different DMA masks here.
> > arch_setup_dma_ops() gets passed a size (and offset) argument, which should
> > match the DMA mask, but I don't know if there is a way to find out the
> > size from ACPI. Should we assume it's always 64-bit DMA capable?
> 
> Looking at the ACPI spec, it does have the _DMA object. IIUC, this can 
> be used to describe DMA properties of a particular bus.
> 
> Method(_DMA, ResourceTemplate()
> {
> 	QWORDMemory(
> 	ResourceConsumer,
> 	PosDecode, // _DEC
> 	MinFixed, // _MIF
> 	MaxFixed, // _MAF
> 	Prefetchable, // _MEM
> 	ReadWrite, // _RW
> 	0, // _GRA
> 	0, // _MIN
> 	0x1fffffff, // _MAX
> 	0x200000000, // _TRA
> 	0x20000000, // _LEN
> 	, , ,	
> 	)
> }
> 
> I am not sure if this is an appropriate use for this object, but this 
> seems to be similar to the dma-ranges property for OF, and probably can 
> be used to specify baseaddr and size information when calling 
> arch_setup_dma_ops().

Yes, that seems like a good idea. What is the expected behavior when that
object is absent? Do we assume that the parent device is not DMA capable?

Is this sufficient to describe the case where a device can only do DMA
to a specific address range that is not at bus address zero but that maps
to the beginning of physical RAM?

> > For legacy reasons, the default mask is probably best left at 32-bit,
> > but drivers are expected to call dma_set_mask() if they can do 64-bit DMA,
> > and that should fail based on the information provided by the platform
> > if the bus is not capable of doing that.
> >
> 
> However, on ARM64 the dma_base and size parameter for 
> arch_setup_dma_ops() is currently not used, and only coherent flag is 
> used. 

We can hope that we won't need the dma_base setting here, but it's
good to have the option to pass it down if we need it.

Not passing the size is a bug that needs to be fixed ASAP, I believe
a number of folks have run into this, most recently the APM X-Gene
MMC controller

> We probably should look at this separately. For the moment, we can 
> probably say that if _CCA object is missing when needed, the ACPI driver 
> won't set up dma_mask when creating platform_device, which should be 
> equivalent to saying DMA is not supported.
> 
> Please let me know if this is acceptable, and I'll make change in V2 
> accordingly.

I would still ask that you treat non-coherent to mean "no DMA" until
we have come up with a way to sufficiently describe the kind of
non-coherency in ACPI.

	Arnd
