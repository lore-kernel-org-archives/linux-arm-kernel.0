From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 May 2012 20:27:03 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <20120507185735.GO26481@n2100.arm.linux.org.uk>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <20120507090858.GN26481@n2100.arm.linux.org.uk>
 <20120507094718.GD4415@opensource.wolfsonmicro.com>
 <201205071014.03632.arnd@arndb.de>
 <20120507103724.GF4415@opensource.wolfsonmicro.com>
 <20120507185735.GO26481@n2100.arm.linux.org.uk>
Message-ID: <20120507192702.GA15893@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 07:57:35PM +0100, Russell King - ARM Linux wrote:
> On Mon, May 07, 2012 at 11:37:29AM +0100, Mark Brown wrote:

> > So what you're saying is that it's nothing to do with zero and just
> > about plain conflicts - there's nothing magic about zero (which is what
> > Russell seemed to be suggesting)?

> You've totally missed my point if that's what you think I was saying.

I don't think I missed anything.  I understood you were saying you think
this is a terrible idea; I had thought you were saying that it was an
even worse idea for a value of zero for some reason (ie, that that broke
things further).

> The resource system as it stands handles two types of resources:

> 1. MMIO resources, of type IORESOURCE_MEM, registered against the
>    iomem_resource root resource
> 2. PCI/ISA IO resources, of type IORESOURCE_IO, registered against the
>    ioport_resource root resource

> The two root resources are hard coded into the BUSY-marking request/release
> APIs.

There's also IRQ, DMA and BUS resource types defined, though not handled
by kernel/resource.c.

> The problem comes if you start abusing IORESOURCE_IO - which has _always_
> meant "this is a PCI/ISA IO resource", and then you have someone adding
> calls to request_region() etc.  That will make stuff look at the
> ioport_resource root, and it won't work.

Yes, the request_region() usage is totally broken - I hadn't realised
that the original patch was doing that.  I had thought it was just
peering at the start of the address range and using that as the base
address for register I/O which is not wonderful but not actively broken
on the client side.

> In any case, if the resource tree is disconnected from the main two parent
> resources, then the resource probably shouldn't have either IORESOURCE_IO
> nor IORESOURCE_MEM set in it.  It's neither of those two resource types.

There is something of a shortage of other options as things stand...  I
guess using _BUS or something would at least eliminate the possibility
of confusion with the management code would be a quick, short term
improvement.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120507/bb26f1ae/attachment-0001.sig>
