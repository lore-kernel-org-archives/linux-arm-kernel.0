From: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 10 Mar 2014 07:27:48 -0700
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <5345792.VhzckVI5HA@wuerfel>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
 <20110101151545.GC25924@n2100.arm.linux.org.uk>
 <1394459790.2270.39.camel@shinybook.infradead.org>
 <5345792.VhzckVI5HA@wuerfel>
Message-ID: <1394461668.2270.47.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-03-10 at 15:11 +0100, Arnd Bergmann wrote:
> On Monday 10 March 2014 06:56:30 David Woodhouse wrote:
> > It is not impossible for the DMA controller to "delegate" transactions
> > so that (to the IOMMU) they appear to come from the individual slave
> > device rather than from itself.
> > 
> > The Intel IOMMU has now gained support for DMA mapping for devices
> > enumerated by ACPI ? essentially the ACPI "DMAR" table just has a lookup
> > table of ACPI device paths, and tells us the PCI bus/devfn that their
> > DMA transactions will *appear* to be from.
> 
> This makes a lot of sense for standalone DMA masters enumerated by ACPI,
> but I fail to see what the purpose of that would be when the DMA
> is delegated to a separate DMA engine devices. Do you have an idea?
>
> It sounds to me that they are trying to isolate the DMA masters
> because the slave driver is not trusted for some reason, yet the
> DMA engine driver that does the DMA is trusted.

I don't really know; I'm just trying to make sense of what I'm seeing on
the hardware.

Perhaps it's just been done on the general principle that devices' DMA
should be separable. If you have different devices, you should be able
to distinguish between them and set up mappings for them separately.

> > Of course, it's also possible that all these BIOSes are broken and they
> > *should* just list the DMA controller itself, instead of all the slave
> > devices. But while I'm always quick to jump to the conclusion that it's
> > the BIOS at fault, that doesn't necessarily seem likely here...
> 
> It would be good to verify this anyway. 

Right. I'm working on that.

> There are multiple reasons why
> we have to pass the dmaengine device to the dma-mapping API at the moment
> rather than the slave device, but in essence it comes down to the engine
> being the one that is the master on its parent bus. A trivial example
> where it goes wrong would be the slave living on a 32-bit noncoherent bus
> and the master living on a 64-bit coherent bus.

That's true in the general case, certainly. But in this case we're
basically just talking about different functions of a multifunction
device. It may turn out that we need the *flexibility* to specify which
device shall be used for DMA mappings for a given channel, even if in
*most* cases it ends up being the DMA controller itself.

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140310/c2666558/attachment-0001.bin>
