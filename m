From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 3 Nov 2016 15:57:54 +0000
Subject: [PATCHv2 6/6] arm64: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <a77c2162-6eb9-09c8-e84f-03a207b59c6b@redhat.com>
References: <20161102210054.16621-1-labbott@redhat.com>
 <20161102210054.16621-7-labbott@redhat.com>
 <20161102230642.GB19591@remoulade>
 <a77c2162-6eb9-09c8-e84f-03a207b59c6b@redhat.com>
Message-ID: <20161103155753.GG25852@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2016 at 06:05:38PM -0600, Laura Abbott wrote:
> On 11/02/2016 05:06 PM, Mark Rutland wrote:
> >On Wed, Nov 02, 2016 at 03:00:54PM -0600, Laura Abbott wrote:
> >>+CFLAGS_physaddr.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
> >>+obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o

> >>+	/*
> >>+	 * This is intentionally different than above to be a tighter check
> >>+	 * for symbols.
> >>+	 */
> >>+	VIRTUAL_BUG_ON(x < kimage_vaddr + TEXT_OFFSET || x > (unsigned long) _end);
> >
> >Can't we use _text instead of kimage_vaddr + TEXT_OFFSET? That way we don't
> >need CFLAGS_physaddr.o.
> >
> >Or KERNEL_START / KERNEL_END from <asm/memory.h>?
> >
> >Otherwise, this looks good to me (though I haven't grokked the need for
> >__pa_symbol() yet).
> 
> I guess it's a question of what's clearer. I like kimage_vaddr +
> TEXT_OFFSET because it clearly states we are checking from the
> start of the kernel image vs. _text only shows the start of the
> text region. Yes, it's technically the same but a little less
> obvious. I suppose that could be solved with some more elaboration
> in the comment.

Sure, it's arguable either way.

I do think that KERNEL_START/KERNEL_END are a better choice, with the comment
you suggest, and/or renamed to KERNEL_IMAGE_*. They already describe the bounds
of the image (though the naming doesn't make that entirely clear).

Thanks,
Mark.
