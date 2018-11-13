From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Nov 2018 09:20:13 +0000
Subject: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
In-Reply-To: <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
Message-ID: <20181113092012.GI30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 02:39:00PM +1100, Finn Thain wrote:
> On Mon, 12 Nov 2018, Christoph Hellwig wrote:
> 
> > On Mon, Nov 12, 2018 at 03:12:39PM +1100, Finn Thain wrote:
> > > Implementations of arch_gettimeoffset are generally not re-entrant and 
> > > assume that interrupts have been disabled. Unfortunately this 
> > > pre-condition got broken in v2.6.32.
> > > 
> > > Fixes: 5cfc8ee0bb51 ("ARM: convert arm to arch_gettimeoffset()")
> > > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > 
> > This looks like a sensible fix for -stable backporting.  But with m68k
> > converted over it might be time for these two arm platforms to either
> > be converted to the clocksource API or to be dropped..
> > 
> 
> You could remove the old arch_gettimeoffset API without dropping any 
> platforms.
> 
> If no-one converts a given platform to the clocksource API it would mean 
> that the default 'jiffies' clocksource will get used on that platform.
> 
> Clock resolution and timer precision would be degraded, but that might not 
> matter.
> 
> Anyway, if someone who has this hardware is willing to test a clocksource 
> API conversion, they can let me know and I'll attempt that patch.

There's reasons why that's not appropriate - such as not having two
separate timers in order to supply a clocksource and separate clock
event.

Not all hardware is suited to the clocksource + clockevent idea.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
