From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Mar 2016 08:28:26 +0100
Subject: [PATCH] usb: chipidea: Configure DMA properties and ops from DT
In-Reply-To: <20160318015414.GA30851@shlinux2.ap.freescale.net>
References: <1456119133-16114-1-git-send-email-bjorn.andersson@linaro.org>
 <3240370.XdEELlSA8f@wuerfel>
 <20160318015414.GA30851@shlinux2.ap.freescale.net>
Message-ID: <3761533.8BImebjOQF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 March 2016 09:54:14 Peter Chen wrote:
> > 
> > I don't think it's a very widespread problem, there are only very few
> > developers that intentionally use this method, and some use the
> > platform_device_register_full() call to create a device with a known
> > mask, which is generally ok for the limited case where the driver
> > is only ever going to run on a single platform, but not in the
> > more general case that of_dma_configure is designed to handle.
> 
> Even only for qualcomm platforms, it may be possible have different
> DMA masks at ARM64 platforms, so we may can't use a fixed value
> at glue layer driver. So, using of_dma_configure is suitable choice
> for DT platforms for this case, right?

Yes.

> > I think we should fix the drivers to consistently use the device
> > that was created by the platform (DT or ACPI or board file)
> > to pass that into the DMA API, anything else will just cause
> > more subtle bugs.
> > 
> 
> Although I don't know what kinds of bugs it may have, it may be
> met before, otherwise, why most of platform drivers need to call
> dma_set_coherent_mask or dma_coerce_mask_and_coherent explicitly

Any driver that wants to do 64-bit addressing on DMA should call
dma_set_mask()/dma_set_coherent_mask() on its device and check the
return code.

No driver should call dma_coerce_mask_and_coherent() on its own
device, it's basically always a bug and we named the function
to make that more obvious. The problem with dma_coerce_mask_and_coherent()
is that it just overrides whatever the platform knows about the
device when the driver thinks it knows better. 

The reason for having those calls in a lot of drivers is that
traditionally, ARM platforms booting with DT did not set up any DMA
mask and the drivers worked around it by manually setting up a mask
that happened to work for them (almost all 32-bit ARM devices need
a 32-bit mask without coherency or offset or iommu, so that's easy).
We now call of_dma_configure() for all devices that get probed from
DT, so we should be removing those calls.

	Arnd
