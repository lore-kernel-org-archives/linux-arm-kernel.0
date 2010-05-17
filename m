From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 17 May 2010 05:03:25 +0100
Subject: PIPT cache handling on s5pv210 chip
In-Reply-To: <00ca01caf359$643defa0$2cb9cee0$%kim@samsung.com>
References: <AANLkTilN-B_hvIPWFC8Q02wIcO7nJLmodSj0RyBYZKuk@mail.gmail.com>
	<00bc01caf351$5daf71c0$190e5540$%kim@samsung.com>
	<20100514104843.GG10339@n2100.arm.linux.org.uk>
	<00ca01caf359$643defa0$2cb9cee0$%kim@samsung.com>
Message-ID: <20100517040325.GX6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 08:34:14PM +0900, Kukjin Kim wrote:
> Russell King wrote:
> > 
> > On Fri, May 14, 2010 at 07:36:47PM +0900, Kukjin Kim wrote:
> > > In case of __vmalloc() with non-cacheable option, there may come some
> > > malfunctions related to cache.
> > 
> > Practically, you are not allowed on ARMv6 or ARMv7 to create mappings
> > which alias with differing memory types; that is 100% outlawed by the
> > architecture spec, and there is NO mitigation for this.

Unfortunately, just because something is outlawed doesn't mean that people
will try and do it.
 
> > It means that it is _illegal_ to use __vmalloc() with anything but a
> > memory-like mapping protection.
> > 
> > There is mitigation for having different cacheability, but this is just
> > a work-around while OSes like Linux work to remove the creation of
> > aliases with differing cacheability attributes.  There's no guarantee
> > that later ARMv7 or future CPUs will continue to operate predictably.
> > 
> > The same applies for ioremap() being used on SDRAM - and those who look
> > at what's in my tree will notice that ioremap() has recently been made
> > to fail when used on SDRAM for this very reason.
> 
> In case a driver starts the Memory_To_Peripheral DMA operation with the
> memory area allotted by __vmalloc(,,no-cacheable), the driver can face some
> problems caused by cache victims.

This would seem to indicate either the driver needs to allocate the
memory differently, or that it is not following the correct procedure
to hande the memory area to the hardware or that there it is a problem
with how the L2 cache has been integrated into the kernel.

I'm not sure what kernel this is based on, or what drivers are being
affected by this as I suspect this is from one of the for-vendor branches
that tends to pop-up because something needs to be shipped ASAP.
 
> > Therefore, the above hack isn't going near mainline.
> 
> Nevertheless, I think so too.

This is the kind of thing that makes me want to go and find the
perpitrators and uise the ogg-cavetech-super-pointy-stick on them.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
