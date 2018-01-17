From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Jan 2018 10:58:15 +0000
Subject: [PATCH] ARM: make memzero optimization smarter
In-Reply-To: <nycvar.YSQ.7.76.1801162150190.13881@knanqh.ubzr>
References: <20180116162905.1404585-1-arnd@arndb.de>
 <nycvar.YSQ.7.76.1801161205560.13881@knanqh.ubzr>
 <CAK8P3a2bfErHxu2i-3JJpUdG64RSoYgmpip2xLAutiSSM9UEkw@mail.gmail.com>
 <nycvar.YSQ.7.76.1801162150190.13881@knanqh.ubzr>
Message-ID: <20180117105815.GL17719@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 11:07:34PM -0500, Nicolas Pitre wrote:
> On Tue, 16 Jan 2018, Arnd Bergmann wrote:
> 
> > On Tue, Jan 16, 2018 at 6:10 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > > On Tue, 16 Jan 2018, Arnd Bergmann wrote:
> > >
> > >> However, we can avoid this class of bogus warnings for the memset() macro
> > >> by only doing the micro-optimization for zero-length arguments when the
> > >> length is a compile-time constant. This should also reduce code size by
> > >> a few bytes, and avoid an extra branch for the cases that a variable-length
> > >> argument is always nonzero, which is probably the common case anyway.
> > >>
> > >> I have made sure that the __memzero implementation can safely handle
> > >> a zero length argument.
> > >
> > > Why not simply drop the test on (__n) != 0 then? I fail to see what the
> > > advantage is in that case.
> > 
> > Good point. We might actually get even better results by dropping the
> > __memzero path entirely, since gcc has can optimize trivial memset()
> > operations and inline them.
> > 
> > If I read arch/arm/lib/memzero.S correctly, it saves exactly two 'orr'
> > instructions compared to the memset.S implementation, but calling
> > memset() rather than __memzero() from C code ends up saving a
> > function call at least some of the time.
> > 
> > Building a defconfig kernel with gcc-7.2.1, I see 1919 calls to __memzero()
> > and 636 calls to memset() in vmlinux. If I remove the macro entirely,
> > I get 1775 calls to memset() instead, so 780 memzero instances got
> > inlined, and kernel shrinks by 5488 bytes (0.03%), not counting the
> > __memzero implementation that we could possibly also drop.
> 
> I get 3668 fewer bytes just by removing the test against 0 in the macro.
> 
> And an additional 5092 fewer bytes by removing the call-to-__memzero 
> optimization.

However, __memzero is not safe against being called with a zero length
so it's not something we can simply remove.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
