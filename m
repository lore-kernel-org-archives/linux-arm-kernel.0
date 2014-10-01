From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 01 Oct 2014 10:41:53 +0200
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <abb0c775ec2549e3abb0a2218b4eef98@BN1PR0301MB0772.namprd03.prod.outlook.com>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <10249326.XCThPmSrfL@wuerfel>
 <abb0c775ec2549e3abb0a2218b4eef98@BN1PR0301MB0772.namprd03.prod.outlook.com>
Message-ID: <1845601.0ISfgfFO3Y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 October 2014 06:35:58 Peter Chen wrote:
> > Subject: Re: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
> > 
> > On Tuesday 30 September 2014 20:39:34 Peter Chen wrote:
> > > Thanks, Arnd. I had not thought setting dma mask is so complicated,
> > > yes, it should check the return value, two things to confirm:
> > >
> > > - dma_coerce_mask_and_coherent or dma_set_mask_and_coherent, the
> > only
> > > difference of these two API is the first one do "dev->dma_mask = &dev-
> > >coherent_dma_mask;"
> > > The reason you suggest choosing dma_set_mask_and_coherent is you do
> > > not want assign dev->dma_mask?
> > 
> > No, that is just the current definition on ARM32 with
> > CONFIG_ARCH_MULTIPLATFORM, and that is going to change soon to be DT
> > aware.
> > dma_set_mask_and_coherent() is supposed to check whether the platform
> > can support the respective mask and return an error if it cannot.
> > 
> > > - The second parameter for dma_set_mask_and_coherent is
> > > DMA_BIT_MASK(32), is it ok?
> > >
> > > I just a little confused of what's the operation is "hardcoding the dma mask"?
> > 
> > dma_coerce_mask_and_coherent() will hardcode the dma mask and override
> > whatever the platform says is necessary.
> > 
> 
> So, we should use dma_set_mask_and_coherent() in most of cases in device driver,
> and use dma_coerce_mask_and_coherent() only  when the device's dma_mask is wrong?
> 
> 

dma_coerce_mask_and_coherent() should really not be used at all. Russell
introduced it to convert drivers that were incorrectly setting the dma_mask
pointer themselves to something slightly more palatable.

The initial dma_mask is supposed to be set by the platform for each DMA
capable device, according to the address width of its upstream bus.
For DT based probing, we now set it to 32-bit mask but should really set
it to something smaller if the bus is more limited than that.

For devices created by platform code (board files), the platform should
call platform_device_register_full() and specify the dma mask in the
platform_device_info. Older platforms sometimes define a static platform
device structure that has the dma mask set. This works as well but is
discouraged for other reasons.

Drivers that require a dma mask that is either smaller than 32-bit (because
of device specific quirks) or that know that the device is capable of
larger DMA space and want to use that need to call dma_set_mask or
dma_set_mask_and_coherent and check the return value.

Ideally all device drivers that want to do DMA should call set_dma_mask
or set_dma_mask_and_coherent, even if the device has exactly a 32-bit
connection to the upstream bus.	

One more complication: if the device is not a DMA master itself but
uses a dma engine, you should not use set_dma_mask_and_coherent()
but instead use dma_get_mask() on the dmaengine device to query its
mask, and also use that same pointer to pass into dma_alloc_coherent
and dma_map_*.

	Arnd
