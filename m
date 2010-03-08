From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Mon, 8 Mar 2010 17:46:58 +0900
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267933038.2812.12.camel@mulgrave.site>
References: <1267872443.8894.1443.camel@mulgrave.site>
	<1267909429.22204.127.camel@pasglop>
	<1267933038.2812.12.camel@mulgrave.site>
Message-ID: <20100308174621X.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 07 Mar 2010 09:07:17 +0530
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> So, assuming full congruence of user space, can't you use the VMA as an
> indicator?  i.e. if we have no user space mappings, we have to flush the
> icache ... if we have one or more, the icache has been flushed and
> placing the same page congruently in a different address space benefits
> from that prior flush, so consequently there's no need to flush again?

I'm not sure about this (sounds like the trick might work for some
though). As I said earlier, I think that IA64 could avoid flushing
I-cache even if the page has no user space mappings (if it did dma to
the page). ia64 needs to track pages for that.

As Ben said, I guess that we need two separate bits for D and I. I
think that it's a good idea to standardize how to use the bits for
optimization (some uses none, some uses only one, some needs both
though). And then we need to revisit I/O path (fs, the block layer,
drivers). Seems that we added flush_dcache_page() everywhere.


> I also think we've established the relevant facts for the I/O thread
> (that we only need to either flush the kernel D cache or mark it as to
> be flushed later on PIO reads).

We have the PIO issue about D-cache aliasing now? That's, don't mm/ or
fs/ already flush D-cache properly? I thought that Catalin has only
D/I cache consistency issue. If not, PIO doesn't also work powerpc
that handles properly D/I cache consistency.


> We're now into deep technicalities of
> how the mm system operates at the architecture level, so perhaps we
> should move this to linux-arch?

Yeah, probably we should.
