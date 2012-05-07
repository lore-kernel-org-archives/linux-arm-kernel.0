From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 May 2012 19:57:35 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <20120507103724.GF4415@opensource.wolfsonmicro.com>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <20120507090858.GN26481@n2100.arm.linux.org.uk>
 <20120507094718.GD4415@opensource.wolfsonmicro.com>
 <201205071014.03632.arnd@arndb.de>
 <20120507103724.GF4415@opensource.wolfsonmicro.com>
Message-ID: <20120507185735.GO26481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 11:37:29AM +0100, Mark Brown wrote:
> On Mon, May 07, 2012 at 10:14:03AM +0000, Arnd Bergmann wrote:
> > On Monday 07 May 2012, Mark Brown wrote:
> 
> > > Don't think I've got any examples with regions beginning at 0 but other
> > > regions seem to not run into any problems with overlap.  Note that all
> > > these drivers do with the regions is use them to look up the base
> > > register.
> 
> > ISA devices start at 0. Using a definition for IORESOURCE_IO of "PCI
> > port number for relatively large values, but either ISA or PCMCIA or
> > an arbitrary MFD for relatively small values" is absolutely crazy.
> 
> So what you're saying is that it's nothing to do with zero and just
> about plain conflicts - there's nothing magic about zero (which is what
> Russell seemed to be suggesting)?

You've totally missed my point if that's what you think I was saying.

The resource system as it stands handles two types of resources:

1. MMIO resources, of type IORESOURCE_MEM, registered against the
   iomem_resource root resource
2. PCI/ISA IO resources, of type IORESOURCE_IO, registered against the
   ioport_resource root resource

The two root resources are hard coded into the BUSY-marking request/release
APIs.

If you don't have PCMCIA/ISA/PCI (and their derivatives) then the ioport
resource ends up being zero sized, and therefore child resources fail to
register against it (we want this behaviour to prevent ISA drivers working
on platforms without ISA.)

The problem comes if you start abusing IORESOURCE_IO - which has _always_
meant "this is a PCI/ISA IO resource", and then you have someone adding
calls to request_region() etc.  That will make stuff look at the
ioport_resource root, and it won't work.

If you _do_ have PCMCIA/ISA/PCI, then request_region() may well succeed.
However, if you have two drivers playing this game, with overlapping
start/end, _even_ if they're totally unrelated devices which would never
clash, the APIs will fail just because of the _numeric_ overlap.  The
resource management subsystem really doesn't have any real knowledge of
anything beyond "MMIO" and "PCI/ISA IO" resources.

So, using IORESOURCE_IO for device-internal register spaces is an abuse
of what this resource type was meant for, and leads to people getting
confused about how to deal with this resource type (that's proven by
Haojian's patch.)

We really don't have a resource handling subsystem that sanely deals with
device private register spaces.

You can bodge around it by using request_resource() with specific parents,
which themselves are disconnected from the above two root resources, but
at the end of the day you're bodging around to try and get the resource
stuff to do something it was never designed to.

In any case, if the resource tree is disconnected from the main two parent
resources, then the resource probably shouldn't have either IORESOURCE_IO
nor IORESOURCE_MEM set in it.  It's neither of those two resource types.
