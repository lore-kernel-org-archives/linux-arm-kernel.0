From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Dec 2009 16:59:04 +0000
Subject: DMA/cache problems on SA1110/SA1111 (Was: Re: USB Host on a
	SA1111)
In-Reply-To: <de2dcbb80912220833mdc1788cq6f60dd5522e7ab0@mail.gmail.com>
References: <de2dcbb80912220833mdc1788cq6f60dd5522e7ab0@mail.gmail.com>
Message-ID: <20091222165904.GE17191@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2009 at 05:33:30PM +0100, Filip Zyzniewski wrote:
> On Thu, Dec 17, 2009 at 10:13 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> >> Russell you got any clues on this? From my point of view it really should
> >> just work. But Ive never done this myself.
> >
> > I've never really been that much involved with USB stuff, so can't really
> > comment.
> >
> 
> There was some discussion about this at linux-usb mailing list.
> The interesting part is here:
> http://thread.gmane.org/gmane.linux.usb.general/25732
> 
> Especially the last post by Alan Stern:
> 
> > I looked at one of these logs. ?Apparently there's a problem with the
> > memory caching and DMA. ?With some of the commands, the debugging
> > message shows incorrect data in the buffer. ?But later on, when the
> > data gets used, it obviously is correct.
> > This implies that something is wrong with the implementation of
> > dma_map_single() or dma_unmap_unsingle(). ?And it might explain why
> > changing the system's cache settings affects the behavior.
> 
> I don't know architecture handling details, could somebody more
> knowledgeable give me
> some clues about where to begin fixing this? What could be broken?

Make sure that the DMA mask is correctly set - SA1111's have a bug in them
which means that certain address bits must have a certain value for all
DMA activities.

We set the DMA masks up properly for the devices in the SA1111 core code,
and rely on the DMA bounce hack to bounce any unsatisfactory buffers into
regions of memory which should avoid the hardware bug.

This also relies upon having the system memory described properly to the
kernel - which basically means ensuring that GFP_DMA returns memory which
can be DMA'd by _any_ device in the system.

Assabet with Neponset should be a good place to look at - I thought at
least the memory layout was all done automatically by the kernel if
SA1111 support was enabled.
