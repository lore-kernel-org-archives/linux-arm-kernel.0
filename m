From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 7 Dec 2014 12:11:03 +0100
Subject: Do I need to invalidate caches before enabling (on ARMv7)?
In-Reply-To: <20141207105823.GA21341@lunn.ch>
References: <20141204100357.GO2129@pengutronix.de>
 <20141206210031.GA1758@afzal-ThinkPad-R50e>
 <20141207100124.GT2129@pengutronix.de>
 <20141207105823.GA21341@lunn.ch>
Message-ID: <20141207111103.GV2129@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 07, 2014 at 11:58:23AM +0100, Andrew Lunn wrote:
> > That would match http://www.arm.linux.org.uk/developer/booting.php which
> > is good. I'd prefer if Linux handled stale data in the cache though for
> > two reasons:
> >  - Usually bootloaders are not perfect in adhering to requirements that
> >    are not obvious from testing.
> >  - Stale caches introduce problems that are hard to debug.
> 
> Can it handle stale data?
Yes, it can provided the cache is off adn the kernel image is correctly
flushed to RAM.

BTW that is the state that at least some Tegra machines come out of
reset with. That's why barebox invalidates the data cache before
enabling it.

> We had an issue with kirkwood boards with u-boot leaving the cache on
> when jumping into Linux. This causes corruption in the decompressed
> image as it was being decompressed. So by the time the kernel was
> running, it was too late, bad things had already happened and death
> was coming soon.
> 
> There is clearly a difference between leaving caches on, and turning
> them off but not cleaning them. So maybe it is possible for the kernel
> to handle this?
Even handling the cache being on would be possible, that would result in
something like:

	if cache_is_on():
		# assume everything is fine, no stale entries
	else:
		invalidate_cache()
		enable_cache()

not sure we want that complexity though. Still I think going from

	enable_cache()

as it is now to

	invalidate_cache()
	enable_cache()

would be nice. This would for example handle the case that the
bootloader on Tegra and machines with similar requirements doesn't make
use of the cache at all.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
