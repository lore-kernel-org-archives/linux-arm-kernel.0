From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 16 Feb 2010 13:27:53 +0530
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1265628483.4020.63.camel@pc1117.cambridge.arm.com>
References: <20100208065519.GE1290@ucw.cz>
	<1265622676.4020.19.camel@pc1117.cambridge.arm.com>
	<20100208105209.GA31671@atrey.karlin.mff.cuni.cz>
	<1265628483.4020.63.camel@pc1117.cambridge.arm.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF7D50@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Catalin Marinas
> Sent: Monday, February 08, 2010 4:58 PM
> To: Pavel Machek
> Cc: Matthew Dharm; Sergei Shtylyov; Ming Lei; Sebastian Siewior; linux-usb at vger.kernel.org; linux-
> kernel; Greg KH; linux-arm-kernel
> Subject: Re: USB mass storage and ARM cache coherency
> 
> On Mon, 2010-02-08 at 10:52 +0000, Pavel Machek wrote:
> > > On Mon, 2010-02-08 at 06:55 +0000, Pavel Machek wrote:
> > > > > > So, let's put this in the HCD drivers and be done with it.
> > > > >
> > > > > The patch below is what fixes the I-D cache incoherency issues on ARM. I
> > > > > don't particularly like the solution but it seems to be the only one
> > > > > available.
> > > >
> > > > Really? It looks like arm should just flush the caches when mapping
> > > > executable page to the userspace.... you can't expect all the drivers
> > > > to be modified like that...
> > >
> > > We could of course flush the caches every time we get a page fault but
> > > that's far from optimal, especially since DMA-capable drivers to do
> > > not
> >
> > Maybe far for optimal, but it is something that should be done,
> > _first_. Correctness is more important than performance, and you can't
> > expect all drivers to behave like you want them.
> 
> I wouldn't call heavy cache flushing "correctness". We could as well
> disable the caches so that it is fully coherent.
> 
> The arch code follows an API defined in cachetlb.txt but the PIO drivers
> don't (some do, like mmci.c). It may be inconvenient to call
> flush_dcache_page() in the driver, hence I started a discussion on
> linux-arch on a PIO mapping API that x86 or other fully coherent
> architectures can leave it as no-ops.
> 
> > Then you can add optimalizations not to do the flushes on drivers you
> > audited and where you care...
> 
> Sorry but that's not really feasible (unless I don't fully understand
> what you mean) - if we do the cache flushing on the fault handling path
> in the arch code, there is no way for the arch code to know what driver
> is doing, unless we make this conditionally compiled with something like
> CONFIG_ARCH_NEEDS_HEAVY_FLUSHING.


Continuing on the USB issue w.r.t cache coherency, the usb host
code is violating the buffer ownership rules of streaming APIs from
dma and non-dma transfers point if view.

We have a below temporary patch to get around the issue and probably it
needs to be fixed in the right way in the stack because some controllers
may not have PIO option even for control transfers. (e.g. Synopsis EHCI
controller)

From: Maulik Mankad <x0082077@ti.com>

USB: Avoid DMA map/unmap of control transfer buffers.

This patch avoids the DMA mapping of buffers for control
transfers.

Signed-off-by: Maulik Mankad <x0082077@ti.com>
---
Index: omap4_integration/drivers/usb/core/hcd.c
===================================================================
--- omap4_integration.orig/drivers/usb/core/hcd.c
+++ omap4_integration/drivers/usb/core/hcd.c
@@ -1274,6 +1274,10 @@ static int map_urb_for_dma(struct usb_hc
 	if (is_root_hub(urb->dev))
 		return 0;
 
+	if (usb_endpoint_xfer_control(&urb->ep->desc))
+		urb->transfer_flags = URB_NO_SETUP_DMA_MAP |
+					URB_NO_TRANSFER_DMA_MAP;
+
 	if (usb_endpoint_xfer_control(&urb->ep->desc)
 	    && !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP)) {
 		if (hcd->self.uses_dma) {
