From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 5 Jun 2011 21:18:57 +0300
Subject: [PATCH v4] ARM: ep93xx: use more reliable CPLD watchdog for
	reset on ts72xx
In-Reply-To: <20110605160734.GV16318@ibawizard.net>
References: <ADE657CA350FB648AAC2C43247A983F001F381FC4A7E@AUSP01VMBX24.collaborationhost.net>
	<1307125685-5110-1-git-send-email-ynezz@true.cz>
	<20110605095450.GC16018@acer>
	<20110605160734.GV16318@ibawizard.net>
Message-ID: <20110605181857.GA5108@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 05, 2011 at 06:07:34PM +0200, Petr ?tetiar wrote:
> Mika Westerberg <mika.westerberg@iki.fi> [2011-06-05 12:54:50]:
> 
> > > +	if (board_is_ts7200() || board_is_ts7250() || board_is_ts7260() ||
> > > +	    board_is_ts7300() || board_is_ts7400()) {
> > > +		/* We use more reliable CPLD watchdog to perform the reset */
> > > +		__raw_writeb(0x5, TS72XX_WDT_FEED_PHYS_BASE);
> > > +		__raw_writeb(0x1, TS72XX_WDT_CONTROL_PHYS_BASE);
> > 
> > I just noticed that you are accessing the registers via *physical* address. It
> > currently works because arm_machine_restart() sets up 1:1 mappings in place of
> > userspace before arch_reset() gets called.
> 
> Setups the 1:1 mappings, clean+invalidate cache, turns off caching and flush
> the cache.
> 
> > This might cause some problems as the register accesses are cached, or does it
> > make a difference in ARM920?
> 
> Caching is disabled by the caller, isn't it?

Yes.

I'm just wondering whether this should be done via valid mapping? Note also
that __raw_writeb() takes void __iomem * which is different that the value you
are passing.

Anyway, I tried the patch on my TS-7260 and I'm still able to reset the board
so you can add my

Tested-by: Mika Westerberg <mika.westerberg@iki.fi>

if you like.
