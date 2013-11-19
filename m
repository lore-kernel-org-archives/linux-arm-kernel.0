From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 19 Nov 2013 15:14:18 +0000
Subject: [PATCH 0/2] Revert support for reserved memory regions defined in
 device tree
In-Reply-To: <528B5949.20204@samsung.com>
References: <1381476448-14548-1-git-send-email-m.szyprowski@samsung.com> <
 20131030134702.19B57C402A0@trevor.secretlab.ca> <528B5949.20204@samsung.com >
Message-ID: <20131119151418.8BB2BC4079D@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Nov 2013 13:27:53 +0100, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Hi Grant!
> 
> On 2013-10-30 14:47, Grant Likely wrote:
> > On Fri, 11 Oct 2013 09:27:26 +0200, Marek Szyprowski<m.szyprowski@samsung.com>  wrote:
> > > Hi all!
> > >
> > > Benjamin Herrenschmidt pointed a few issues in the proposed design of
> > > device tree bindings for contiguous memory allocator and reserved memory
> > > regions:
> > >https://lkml.org/lkml/2013/9/15/151
> > >http://www.spinics.net/lists/arm-kernel/msg273548.html
> > >
> > > Some time has passed, but there is still no consensus on the bindings
> > > for the reserved memory and various drawback of this solution has been
> > > shown, so in my opinion the best I can do now is to revert them
> > > completely and start from scratch again later.
> >
> > Hi Marek,
> >
> > At the ARM summit last week in Edinburgh, several of us sat down and
> > hammered out a new proposal for handling reserved memory regions based
> > on the work that you started here. Below you will find a new binding
> > document. I started looking at implementing this, but haven't made much
> > progress.
> >
> > Please take a look and let me know what you think.
> >
> > Also, while I'm thinking about it, I took another look at the code and I
> > think the code supporting reserved regions should go directly into
> > drivers/of/fdt.c and drivers/of/memory.c.  Also, the reserved regions
> > parsing should be enabled unconditionally insted of filtered by (DMA_CMA
> > || (HAVE_GENERIC_DMA_COHERENT && HAVE_MEMBLOCK). If the hardware
> > description says to reserve a region, then the kernel must always do so,
> > even if it doesn't actually use it for anything.
> 
> Thanks for discussing this item. I'm really sorry for the late reply, but
> various 'more_imporant_things(tm)' have eaten me completely last weeks.
> 
> The proposal look good for me. I'm not convinced that we really need the
> support for 'reg' property, as the fixed memory region is a special case
> of generic dynamic allocation specified by the size and alloc-ranges, but
> I assume that there have been already a long discussion about this, so I
> accept the common consensus.

It is absolutely necessary for some use cases. For example, a
framebuffer enabled by firmware and passed onto the kernel for
flicker-free boot. Some platforms have fixed regions that cannot be
moved up.

> Grant: have you started working on the code, which implements such binding?
> If not, I will try to start do it and post the code soon for review.

No, please go ahead and start.

g.
