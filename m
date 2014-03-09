From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 9 Mar 2014 07:39:18 +0100
Subject: [PATCH 4/7] of: configure the platform device dma_mask and
 dma_pfn_offset
In-Reply-To: <CAL_JsqLu_16p-8FLjBYt7xQA2eAyiprPML2q5R3fnivZPrvPug@mail.gmail.com>
References: <1394097598-17622-1-git-send-email-santosh.shilimkar@ti.com>
 <201403071702.41716.arnd@arndb.de>
 <CAL_JsqLu_16p-8FLjBYt7xQA2eAyiprPML2q5R3fnivZPrvPug@mail.gmail.com>
Message-ID: <201403090739.18351.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 08 March 2014, Rob Herring wrote:
> On Fri, Mar 7, 2014 at 10:02 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> > a) Follow what we do for PCI devices: assume that we can do DMA_MASK(32)
> > on any device, and have drivers call dma_set_mask(DMA_MASK(64)) on devices
> > that would like to do more than that, or call e.g. dma_set_mask(DMA_MASK(28))
> > for devices that can do less than 32 bit, as given in the argument. This
> > approach would be most consistent with the way PCI works, but it doesn't
> > really work well for the case where the mask is less than 32-bit and the
> > device driver doesn't know that.
> >
> > b) Never have to call dma_set_mask() for platform devices and assume that the
> > platform code sets it up correctly. This would probably be the simpler
> > solution, and I can't think of any downsides at the moment.
> 
> I don't think we want this. In the case of setting up 64-bit masters,
> it is typically the device that knows if it can do 64-bit DMA either
> thru a capabilities register or compatible value. That device specific
> knowledge should really stay within the device's driver.

So you think we should still set a 64-bit mask in the "ranges" property
for devices that can only do 32-bit and let the driver figure it out?

I think this approach is much less useful for platform devices than it is
for PCI devices, where we don't explicitly describe the "ranges" for each
device. Are you thinking of off-chip or on-chip DMA masters here? If
on-chip, I don't think it's likely that we would end up with different
versions of the chip that have the same device on there but not the
same DMA capabilities.

	Arnd
