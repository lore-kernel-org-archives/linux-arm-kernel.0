From: fthain@telegraphics.com.au (Finn Thain)
Date: Wed, 14 Nov 2018 08:55:37 +1100 (AEDT)
Subject: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
In-Reply-To: <20181113092012.GI30658@n2100.armlinux.org.uk>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
Message-ID: <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Nov 2018, Russell King - ARM Linux wrote:

> On Tue, Nov 13, 2018 at 02:39:00PM +1100, Finn Thain wrote:
> > 
> > You could remove the old arch_gettimeoffset API without dropping any 
> > platforms.
> > 
> > If no-one converts a given platform to the clocksource API it would mean 
> > that the default 'jiffies' clocksource will get used on that platform.
> > 
> > Clock resolution and timer precision would be degraded, but that might not 
> > matter.
> > 
> > Anyway, if someone who has this hardware is willing to test a clocksource 
> > API conversion, they can let me know and I'll attempt that patch.
> 
> There's reasons why that's not appropriate - such as not having two
> separate timers in order to supply a clocksource and separate clock
> event.
> 
> Not all hardware is suited to the clocksource + clockevent idea.
> 

Sorry, I don't follow.

AFAIK, clocksources and clock event devices are orthogonal concepts. There 
are platforms with !ARCH_USES_GETTIMEOFFSET && !GENERIC_CLOCKEVENTS (and 
every other combination).

A clocksource read method just provides a cycle count, and in this sense 
arch_gettimeoffset() is equivalent to a clocksource.

If these two arm platforms have an existing clock event device which 
somehow precludes any new clocksources, why doesn't that also render 
arch_gettimeoffset() impossible?

-- 
