From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Nov 2010 18:01:21 +0000
Subject: [PATCH] ARM: V6 MPCore v6_dma_inv_range RWFO fix
In-Reply-To: <1290620763.3056.40.camel@e102109-lin.cambridge.arm.com>
References: <20101123222806.GA22936@mvista.com>
	<20101123224237.GF26510@n2100.arm.linux.org.uk>
	<1290595333.3056.6.camel@e102109-lin.cambridge.arm.com>
	<20101124173311.GA13934@n2100.arm.linux.org.uk>
	<1290620763.3056.40.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20101124180121.GB13934@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 05:46:03PM +0000, Catalin Marinas wrote:
> On Wed, 2010-11-24 at 17:33 +0000, Russell King - ARM Linux wrote:
> > What if the pointer is not word aligned?
> 
> I followed up in my reply to George.
> 
> > The safest thing to do is:
> > 
> >         tst     r0, #D_CACHE_LINE_SIZE - 1
> >         bic     r0, r0, #D_CACHE_LINE_SIZE - 1
> >         ldrneb  r2, [r0, #D_CACHE_LINE_SIZE - 1]
> >         strneb  r2, [r0, #D_CACHE_LINE_SIZE - 1]
> 
> Should we always assume that the buffer size is at least a cache line? I
> think the current code assumes this already.

Hmm, true.  In that case:

	tst     r0, #D_CACHE_LINE_SIZE - 1
	ldrneb  r2, [r0]
	strneb  r2, [r0]
	bic     r0, r0, #D_CACHE_LINE_SIZE - 1


> >         tst     r1, #D_CACHE_LINE_SIZE - 1
> >         bic     r1, r1, #D_CACHE_LINE_SIZE - 1
> >         ldrneb  r2, [r0]
> >         strneb  r2, [r0]
> 
> Did you mean "ldrneb r2, [r1]"?

Yes.  However, for the same reason above:

	tst	r1, #D_CACHE_LINE_SIZE - 1
	ldrneb	r2, [r1, #-1]
	strneb	r2, [r1, #-1]
	bic	r1, r1, #D_CACHE_LINE_SIZE - 1

> Since the interval is exclusive, what if r1 is already cache-line
> aligned?

If r1 is cache line aligned, then we won't be touching that cache line
except for the main loop, which should already do what is necessary.
