From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 24 Nov 2010 18:07:39 +0000
Subject: [PATCH] ARM: V6 MPCore v6_dma_inv_range RWFO fix
In-Reply-To: <20101124180121.GB13934@n2100.arm.linux.org.uk>
References: <20101123222806.GA22936@mvista.com>
	<20101123224237.GF26510@n2100.arm.linux.org.uk>
	<1290595333.3056.6.camel@e102109-lin.cambridge.arm.com>
	<20101124173311.GA13934@n2100.arm.linux.org.uk>
	<1290620763.3056.40.camel@e102109-lin.cambridge.arm.com>
	<20101124180121.GB13934@n2100.arm.linux.org.uk>
Message-ID: <1290622059.3056.41.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-11-24 at 18:01 +0000, Russell King - ARM Linux wrote:
> On Wed, Nov 24, 2010 at 05:46:03PM +0000, Catalin Marinas wrote:
> > On Wed, 2010-11-24 at 17:33 +0000, Russell King - ARM Linux wrote:
> > > What if the pointer is not word aligned?
> >
> > I followed up in my reply to George.
> >
> > > The safest thing to do is:
> > >
> > >         tst     r0, #D_CACHE_LINE_SIZE - 1
> > >         bic     r0, r0, #D_CACHE_LINE_SIZE - 1
> > >         ldrneb  r2, [r0, #D_CACHE_LINE_SIZE - 1]
> > >         strneb  r2, [r0, #D_CACHE_LINE_SIZE - 1]
> >
> > Should we always assume that the buffer size is at least a cache line? I
> > think the current code assumes this already.
> 
> Hmm, true.  In that case:
> 
>         tst     r0, #D_CACHE_LINE_SIZE - 1
>         ldrneb  r2, [r0]
>         strneb  r2, [r0]
>         bic     r0, r0, #D_CACHE_LINE_SIZE - 1
> 
> 
> > >         tst     r1, #D_CACHE_LINE_SIZE - 1
> > >         bic     r1, r1, #D_CACHE_LINE_SIZE - 1
> > >         ldrneb  r2, [r0]
> > >         strneb  r2, [r0]
> >
> > Did you mean "ldrneb r2, [r1]"?
> 
> Yes.  However, for the same reason above:
> 
>         tst     r1, #D_CACHE_LINE_SIZE - 1
>         ldrneb  r2, [r1, #-1]
>         strneb  r2, [r1, #-1]
>         bic     r1, r1, #D_CACHE_LINE_SIZE - 1

This looks OK to me (though not sure about Thumb-2, I haven't checked).

-- 
Catalin
