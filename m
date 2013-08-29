From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 29 Aug 2013 22:12:59 +0100
Subject: [PATCH v6 3/4] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <98354044.bRIxVeGEeu@flatron>
References: <1376924669-28873-1-git-send-email-m.szyprowski@samsung.com>
 <1376924669-28873-4-git-send-email-m.szyprowski@samsung.com>
 <521292E0.105@wwwdotorg.org> <98354044.bRIxVeGEeu@flatron>
Message-ID: <20130829211259.D8DF33E1222@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Aug 2013 00:02:37 +0200, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Stephen,
> 
> On Monday 19 of August 2013 15:49:20 Stephen Warren wrote:
> > On 08/19/2013 09:04 AM, Marek Szyprowski wrote:
> > > This patch adds device tree support for contiguous and reserved memory
> > > regions defined in device tree.
> > > 
> > > diff --git a/Documentation/devicetree/bindings/memory.txt
> > > b/Documentation/devicetree/bindings/memory.txt
> > > 
> > > +*** Reserved memory regions ***
> > > +
> > > +In /memory/reserved-memory node one can create additional nodes
> > 
> > s/additional/child/ or s/additional/sub/ would make it clearer where the
> > "additional" nodes should be placed.
> > 
> > > +compatible:	"linux,contiguous-memory-region" - enables binding 
> of
> > > this
> > > +		region to Contiguous Memory Allocator (special region for
> > > +		contiguous memory allocations, shared with movable system
> > > +		memory, Linux kernel-specific), alternatively if
> > > +		"reserved-memory-region" - compatibility is defined, given
> > > +		region is assigned for exclusive usage for by the 
> respective
> > > +		devices
> > 
> > "alternatively" makes it sound like the two compatible values are
> > mutually-exclusive. Perhaps make this a list, like:
> > 
> > ----------
> > compatible: One or more of:
> > 
> > 	- "linux,contiguous-memory-region" - enables binding of this
> > 	  region to Contiguous Memory Allocator (special region for
> > 	  contiguous memory allocations, shared with movable system
> > 	  memory, Linux kernel-specific).
> > 	- "reserved-memory-region" - compatibility is defined, given
> > 	  region is assigned for exclusive usage for by the respective
> > 	  devices.
> > ----------
> > 
> > "linux,contiguous-memory-region" is already long enough, but I'd
> > slightly bikeshed towards "linux,contiguous-memory-allocator-region", or
> > perhaps "linux,cma-region" since it's not really describing whether the
> > memory is contiguous (at the level of /memory, each chunk of memory is
> > contiguous...)
> 
> I'm not really sure if we need the "linux" prefix for "contiguous-memory-
> region". The concept of contiguous memory region is rather OS independent 
> and tells us that memory allocated from this region will be contiguous. 
> IMHO any OS is free to implement its own contiguous memory allocation 
> method, without being limited to Linux CMA.
> 
> Keep in mind that rationale behind those contiguous regions was that there 
> are devices that require buffers contiguous in memory to operate 
> correctly.
> 
> But this is just nitpicking and I don't really have any strong opinion on 
> this.

Actually, I think this is important. It is something that describes the
expected usage of the hardware (flicker-free framebuffer is a really
good example) and isn't really linux-specific from that perspective.
I think you can drop the 'linux,' prefix string.

g.
