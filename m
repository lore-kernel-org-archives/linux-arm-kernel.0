From: joonwoop@codeaurora.org (Joonwoo Park)
Date: Mon, 13 Oct 2014 21:04:50 -0700
Subject: [PATCH] arm64: optimize memcpy_{from,to}io() and memset_io()
In-Reply-To: <20141009101613.GD17836@e104818-lin.cambridge.arm.com>
References: <1406701706-12808-1-git-send-email-joonwoop@codeaurora.org>
 <20140801063009.GA24602@codeaurora.org>
 <20141003163141.GC2384@e104818-lin.cambridge.arm.com>
 <20141009023933.GA21161@codeaurora.org>
 <20141009101613.GD17836@e104818-lin.cambridge.arm.com>
Message-ID: <20141014040450.GA19810@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 11:16:14AM +0100, Catalin Marinas wrote:
> On Thu, Oct 09, 2014 at 03:39:33AM +0100, Joonwoo Park wrote:
> > On Fri, Oct 03, 2014 at 05:31:42PM +0100, Catalin Marinas wrote:
> > > On Tue, Jul 29, 2014 at 11:28:26PM -0700, Joonwoo Park wrote:
> > > > diff --git a/arch/arm64/kernel/io.c b/arch/arm64/kernel/io.c
> > > > index 7d37ead..c0e3ab1 100644
> > > > --- a/arch/arm64/kernel/io.c
> > > > +++ b/arch/arm64/kernel/io.c
> > > > @@ -20,18 +20,34 @@
> > > >  #include <linux/types.h>
> > > >  #include <linux/io.h>
> > > >  
> > > > +#define IO_CHECK_ALIGN(v, a) ((((unsigned long)(v)) & ((a) - 1)) == 0)
> > > 
> > > Can you not use just IS_ALIGNED?
> > 
> > Will do.  I would need to cast from/to with unsigned long.
> 
> Or define IO_CHECK_ALIGN as IS_ALIGNED((unsigned long)v, a)
> 
> > > > +		from++;
> > > > +		to++;
> > > >  		count--;
> > > > -		*t = readb(from);
> > > > -		t++;
> > > > +	}
> > > > +
> > > > +	while (count >= 8) {
> > > > +		*(u64 *)to = readq_relaxed(from);
> > > > +		from += 8;
> > > > +		to += 8;
> > > > +		count -= 8;
> > > > +	}
> > > > +
> > > > +	while (count) {
> > > > +		*(u8 *)to = readb_relaxed(from);
> > > >  		from++;
> > > > +		to++;
> > > > +		count--;
> > > >  	}
> > > > +	__iormb();
> > > 
> > > We don't need this barrier here. In the readl() implementation, it's use
> > > is for ordering between I/O polling and DMA buffer access.
> > 
> > The barriers here and down below are for accessing different devices in a row.
> > I thought that's what your suggestion too.
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-September/123178.html
> 
> I think we should leave them out until we find a use case. I currently
> don't see any (writel/readl etc. still have the barriers).
> 
> > > > +	while (count && !IO_CHECK_ALIGN(p, 8)) {
> > > > +		writeb_relaxed(c, p);
> > > 
> > > Using dst here directly here should work (__raw_writeb takes the same
> > > type as the second argument).
> > 
> > Will update.
> > 
> > I'm quite not sure if barriers are not needed or not indeed.
> > The situation I'm worried about is like 'memcpy_io(device A);
> > memcpy_io(device B);' which I think memcpy_io() needs to guarantee the
> > order.
> 
> Without barriers, ordering between device A and B would not be
> guaranteed. But do you have a scenario where this ordering actually
> matters? Most case we have something like:
> 
> 	memcpy_io(device A);	// mapped as Device or Normal NonCacheable
> 	writel(device B);	// or an I/O register of device A
> 
> Here writel() has the correct barrier.

I don't have such use case that ordering matters either.  I agree that we should leave until it's needed.

Thanks,
Joonwoo

> 
> -- 
> Catalin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
