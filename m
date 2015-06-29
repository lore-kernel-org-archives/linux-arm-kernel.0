From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 29 Jun 2015 12:05:33 +0100
Subject: [RFC PATCH v3] arm DMA: Fix allocation from CMA for coherent DMA
In-Reply-To: <20150629104604.GB7557@n2100.arm.linux.org.uk>
References: <1434663862-17858-1-git-send-email-lorenx4@gmail.com>
 <20150626162549.GK3078@e104818-lin.cambridge.arm.com>
 <CAE=W-e3YUjT=KbYTizBwg+3huvFLDqHvhzZN-oPqEnOKUXAtoQ@mail.gmail.com>
 <20150629103737.GC29907@e104818-lin.cambridge.arm.com>
 <20150629104604.GB7557@n2100.arm.linux.org.uk>
Message-ID: <20150629110532.GD29907@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 11:46:04AM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 29, 2015 at 11:37:37AM +0100, Catalin Marinas wrote:
> > I forgot about the arm_dma_mmap fix here:
> > 
> > https://lkml.org/lkml/2015/5/7/512
> > 
> > So we either fix both cases by changing __get_dma_pgprot() or just go
> > for Mike's and your patches as above. It's up to Russell.
> 
> I'd prefer the "least code" option. :)
> 
> > At some point, we could do with some more clean-up in the dma-mapping.c.
> > For example, both __alloc_simple_buffer() and __alloc_from_contiguous()
> > end up calling __dma_clear_buffer() even when not necessary (cacheable
> > mapping). Not too bad though as this is only done when setting up the
> > buffer.
> 
> The reason we always clear the buffer is that we can't be sure that a
> driver will not map a buffer allocated by dma_alloc_coherent() into
> userspace without it first being initialised.  There have been drivers
> which do this (ALSA in particular.)  I haven't checked whether this
> instance still does this, but it used to - and the problem is once
> one instance exists, it gets copied...

You are right, the memset'ing is probably still necessary to patch
potential security holes. The cache flushing is not for coherent buffers
(sometimes this may be more expensive than the memset itself, though
lost in the noise if only done once).

-- 
Catalin
