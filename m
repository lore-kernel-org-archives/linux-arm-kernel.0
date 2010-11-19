From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Nov 2010 19:56:35 +0000
Subject: [PATCH] ARM: l2x0: Check the correct address range
In-Reply-To: <AANLkTikpAPLSTAzm2iPSV1_LL=B+zPbWzTPdhne3XFVc@mail.gmail.com>
References: <20101119014029.GA26429@july>
	<AANLkTikpAPLSTAzm2iPSV1_LL=B+zPbWzTPdhne3XFVc@mail.gmail.com>
Message-ID: <20101119195635.GB10722@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 19, 2010 at 05:30:14AM -0600, Kanigeri, Hari wrote:
> > diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> > index 170c9bb..50599d9 100644
> > --- a/arch/arm/mm/cache-l2x0.c
> > +++ b/arch/arm/mm/cache-l2x0.c
> > @@ -195,7 +195,7 @@ static void l2x0_clean_range(unsigned long start, unsigned long end)
> > ? ? ? ?void __iomem *base = l2x0_base;
> > ? ? ? ?unsigned long flags;
> >
> > - ? ? ? if ((end - start) >= l2x0_size) {
> > + ? ? ? if ((end - start + 1) >= l2x0_size) {
> 
> nitpick: probably will look more obvious if it is coded as  if ((end +
> 1) - start) >= l2x0_size)

Start defines the first byte of the object to perform the cache
maintainence on.  End defines the first subsequent byte not in the
object.  So, (end - start) is the number of bytes in the object,
and therefore the original code _is_ correct.

If you have an object which is 1MB in size, then (end - start) will
be 1048576 bytes.  If your cache is 1MB, then we'll use the xxx_all()
version of the function.

However, things get more murky when you consider that we have the
granularity of cache lines to deal with.

If start is mid-way in a cache line, then that cache line has to be
operated on.  If end is mid-way or at the end of a cache line, that
cache line also has to be operated on.  However, if end is at the
very first byte of the cache line, it must not be operated on.

So, it is possible for start = mid-cache line, end = start + 1048575,
that you will end up not doing the xxx_all() optimization, despite
operating on over 1MB of cached data - but this is only true for the
corner case up to 1MB + cache line size - 1.
