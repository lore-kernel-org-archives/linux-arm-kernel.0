From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Nov 2010 17:33:11 +0000
Subject: [PATCH] ARM: V6 MPCore v6_dma_inv_range RWFO fix
In-Reply-To: <1290595333.3056.6.camel@e102109-lin.cambridge.arm.com>
References: <20101123222806.GA22936@mvista.com>
	<20101123224237.GF26510@n2100.arm.linux.org.uk>
	<1290595333.3056.6.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20101124173311.GA13934@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 10:42:13AM +0000, Catalin Marinas wrote:
> On Tue, 2010-11-23 at 22:42 +0000, Russell King - ARM Linux wrote:
> > On Wed, Nov 24, 2010 at 01:28:06AM +0300, Valentine Barshak wrote:
> > > Cache ownership must be acqired by reading/writing data from the
> > > cache line to make cache operation have the desired effect on the
> > > SMP MPCore CPU. However, the ownership is never aquired in the
> > > v6_dma_inv_range function when cleaning the first line and
> > > flushing the last one, in case the address is not aligned
> > > to D_CACHE_LINE_SIZE boundary.
> > > Fix this by reading/writing data if needed, before performing
> > > cache operations.
> > 
> > You should do this on the data _inside_ the requested buffer.  We don't
> > know if the overlapping cache line shares itself with some atomic
> > variable, and doing a read-write on it could undo other updates to it.
> 
> We could just use the boundary addresses to avoid writing beyond the
> buffer. Something like below (pretty much moving the BIC after the RFO,
> untested):

What if the pointer is not word aligned?

The safest thing to do is:

	tst	r0, #D_CACHE_LINE_SIZE - 1
	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
	ldrneb	r2, [r0, #D_CACHE_LINE_SIZE - 1]
	strneb	r2, [r0, #D_CACHE_LINE_SIZE - 1]
...
	tst	r1, #D_CACHE_LINE_SIZE - 1
	bic	r1, r1, #D_CACHE_LINE_SIZE - 1
	ldrneb	r2, [r0]
	strneb	r2, [r0]

so that we only touch the very last byte of the first cache line, and
the very first byte of the last cache line.  That provides for the
most safe behaviour that we can manage in all scenarios.
