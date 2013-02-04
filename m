From: balbi@ti.com (Felipe Balbi)
Date: Mon, 4 Feb 2013 17:41:53 +0200
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <20130201213003.GW2637@n2100.arm.linux.org.uk>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <1359742975-10421-2-git-send-email-mporter@ti.com>
 <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
 <20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com>
 <20130201185820.GE29898@arwen.pp.htv.fi>
 <510C2A47.1090607@mvista.com>
 <20130201205600.GA31762@arwen.pp.htv.fi>
 <20130201213003.GW2637@n2100.arm.linux.org.uk>
Message-ID: <20130204154153.GA18237@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 01, 2013 at 09:30:03PM +0000, Russell King - ARM Linux wrote:
> > > > I guess to make the MUSB side simpler we would need musb-dma-engine glue
> > > > to map dmaengine to the private MUSB API. Then we would have some
> > > > starting point to also move inventra (and anybody else) to dmaengine
> > > > API.
> > > 
> > >    Why? Inventra is a dedicated device's private DMA controller, why make
> > > universal DMA driver for it?
> > 
> > because it doesn't make sense to support multiple DMA APIs. We can check
> > from MUSB's registers if it was configured with Inventra DMA support and
> > based on that we can register MUSB's own DMA Engine to dmaengine API.
> 
> Hang on.  This is one of the DMA implementations which is closely
> coupled with the USB and only the USB?  If it is...
> 
> I thought this had been discussed _extensively_ before.  I thought the
> resolution on it was:
> 1. It would not use the DMA engine API.
> 2. It would not live in arch/arm.
> 3. It would be placed nearby the USB driver it's associated with.
> 
> (1) because we don't use APIs just for the hell of it - think.  Do we
> use the DMA engine API for PCI bus mastering ethernet controllers?  No.
> Do we use it for PCI bus mastering SCSI controllers?  No.  Because the
> DMA is integral to the rest of the device.

that's not really a fair comparison, however. MUSB is used with several
DMA engines.

The only DMA engine which is really coupled with MUSB is the Inventra
DMA engine which comes as an optional feature to the IP. Many users have
opted out of it. From the top of my head we have CPPI 3.x, CPPI 4.1,
Inventra DMA, OMAP sDMA and ux500 DMA engines supported by the driver.

Granted, CPPI 4.1 makes some assumptions about the fact that it's
handling USB tranfers, but nevertheless, the IP can be, and in fact is,
used with many different DMA engines and driver needs to cope with it.

Current DMA abstraction is quite poor, for example there's no way to
compile support for multiple DMA engines. Code also makes certain, IMO
unnecessary, assumptions about the underlying DMA engine (abstraction is
poor, as said above but it we could follow MUSB's programming guide when
it comes to programming DMA transfers).

Considering all of the above, it's far better to use DMA engine and get
rid of all the mess.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130204/054ca073/attachment.sig>
