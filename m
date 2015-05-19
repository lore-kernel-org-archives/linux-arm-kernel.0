From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 19 May 2015 02:28:52 +0200
Subject: [V4 PATCH 1/6] ACPI / scan: Parse _CCA and setup device coherency
In-Reply-To: <555A69D9.7080508@amd.com>
References: <1431724994-21601-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1880793.yBqSWvxoqF@vostro.rjw.lan> <555A69D9.7080508@amd.com>
Message-ID: <1542643.dHW9Z8dPkv@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, May 18, 2015 05:38:17 PM Suravee Suthikulanit wrote:
> Hi Rafael,
> 
> On 5/15/2015 6:53 PM, Rafael J. Wysocki wrote:
> > On Friday, May 15, 2015 04:23:09 PM Suravee Suthikulpanit wrote:
> >> [...]
> >> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> >> index 4bf7559..f6bc438 100644
> >> --- a/drivers/acpi/acpi_platform.c
> >> +++ b/drivers/acpi/acpi_platform.c
> >> @@ -103,14 +103,18 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
> >>   	pdevinfo.res = resources;
> >>   	pdevinfo.num_res = count;
> >>   	pdevinfo.fwnode = acpi_fwnode_handle(adev);
> >> -	pdevinfo.dma_mask = DMA_BIT_MASK(32);
> >> +	pdevinfo.dma_mask = acpi_dma_is_supported(adev) ? DMA_BIT_MASK(32) : 0;
> >>   	pdev = platform_device_register_full(&pdevinfo);
> >> -	if (IS_ERR(pdev))
> >> +	if (IS_ERR(pdev)) {
> >>   		dev_err(&adev->dev, "platform device creation failed: %ld\n",
> >>   			PTR_ERR(pdev));
> >> -	else
> >> +	} else {
> >> +		if (acpi_dma_is_supported(adev))
> >> +			arch_setup_dma_ops(&pdev->dev, 0, 0, NULL,
> >> +					   acpi_dma_is_coherent(adev));
> >
> > Shouldn't we generally do that in acpi_bind_one() for all bus types
> > that don't have specific handling rather than here?
> 
> I think that would also work, and makes sense. However, I'm not sure if 
> this would help in the case when we are creating PCI end-point devices, 
> since the CCA is specified at the host bridge node, and there is no ACPI 
> companion for the end-point devices. It seems that patch 3/6 of this 
> series is still needed.

Yes, PCI needs its own handling, but there are multiple bus types that
don't (SPI, I2C etc) in addition to the platform bus type.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
