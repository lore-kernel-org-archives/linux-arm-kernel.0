From: gdavis@mvista.com (George G. Davis)
Date: Wed, 24 Nov 2010 10:14:18 -0500
Subject: [PATCH] ARM: V6 MPCore v6_dma_inv_range RWFO fix
In-Reply-To: <AANLkTikcpK0X3JT0Whx-F1GohddAUpATQS7MfrwKRMGW@mail.gmail.com>
References: <20101123222806.GA22936@mvista.com>
	<20101123224237.GF26510@n2100.arm.linux.org.uk>
	<20101124002458.GJ2418@mvista.com>
	<AANLkTikcpK0X3JT0Whx-F1GohddAUpATQS7MfrwKRMGW@mail.gmail.com>
Message-ID: <20101124151418.GF31572@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 10:32:08AM +0000, Catalin Marinas wrote:
> On 24 November 2010 00:24, George G. Davis <gdavis@mvista.com> wrote:
> > On Tue, Nov 23, 2010 at 10:42:37PM +0000, Russell King - ARM Linux wrote:
> >> On Wed, Nov 24, 2010 at 01:28:06AM +0300, Valentine Barshak wrote:
> >> > Cache ownership must be acqired by reading/writing data from the
> >> > cache line to make cache operation have the desired effect on the
> >> > SMP MPCore CPU. However, the ownership is never aquired in the
> >> > v6_dma_inv_range function when cleaning the first line and
> >> > flushing the last one, in case the address is not aligned
> >> > to D_CACHE_LINE_SIZE boundary.
> >> > Fix this by reading/writing data if needed, before performing
> >> > cache operations.
> >>
> >> You should do this on the data _inside_ the requested buffer. ?We don't
> >> know if the overlapping cache line shares itself with some atomic
> >> variable, and doing a read-write on it could undo other updates to it.
> >
> > OK, how about this (untested interdiff):
> >
> > diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
> > index e0e5c6b..e778f2a 100644
> > --- a/arch/arm/mm/cache-v6.S
> > +++ b/arch/arm/mm/cache-v6.S
> > @@ -206,8 +206,8 @@ v6_dma_inv_range:
> > ? ? ? ?tst ? ? r0, #D_CACHE_LINE_SIZE - 1
> > ? ? ? ?bic ? ? r0, r0, #D_CACHE_LINE_SIZE - 1
> > ?#ifdef CONFIG_DMA_CACHE_RWFO
> > - ? ? ? ldr ? ? r2, [r0] ? ? ? ? ? ? ? ? ? ? ? ?@ read for ownership
> > - ? ? ? str ? ? r2, [r0] ? ? ? ? ? ? ? ? ? ? ? ?@ write for ownership
> > + ? ? ? ldr ? ? r2, [r0, #D_CACHE_LINE_SIZE - 4] ? ? ? ?@ read for ownership
> > + ? ? ? str ? ? r2, [r0, #D_CACHE_LINE_SIZE - 4] ? ? ? ?@ write for ownership
> > ?#endif
> 
> r0 here is already aligned to a cache line, so you still read from the
> same cache line, I don't see any difference.

Assuming "start" was not cache line aligned to begin with but let's say
it was initially at cache offset 24, then the above meets the contraint
that it is inside the buffer and doesn't touch any data which was
outside the DMA buffer.  I also had a paranoia that start and end may
not even be word aligned which is why these RWFOs are placed after those
BICs.

Thanks!

--
Regards,
George

> 
> -- 
> Catalin
