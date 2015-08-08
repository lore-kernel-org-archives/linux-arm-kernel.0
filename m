From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Aug 2015 14:47:09 +0100
Subject: [BUG, RFC] MTD Execute in Place on ARM breaks build
In-Reply-To: <1564596.BEQS8u7XSM@wuerfel>
References: <55C51319.2010901@tul.cz>
 <1564596.BEQS8u7XSM@wuerfel>
Message-ID: <20150808134708.GK7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 08, 2015 at 01:42:50PM +0200, Arnd Bergmann wrote:
> A cleaner approach might be to replace xip_currtime() with
> ktime_get_ns(), and find some other generic interface to replace
> xip_irqpending.

Definitely not.

The issue here is that the kernel sits in flash.  When we want to write
to flash, we need to switch the flash into a mode where the data
contained in the flash becomes unreadable - reading from it results in
status bytes being returned.  Status bytes are not executable.

To get around that problem, we have a small amount of code in RAM which
does the flash erasing and/or programming.  This code, however, needs
to have access to the interrupt controller and timer.

Calling generic functions that would be part of the paged-out kernel
image is just not possible; doing so will immediately crash the kernel
and break what's being achieved here.  You'd need to mark these functions
and any functions that they then call (including spinlocks, probably
the entire lockdep infrastructure, etc) with __xipram.  I don't think
that's feasible.

In any case, I don't think XIP multiplatform makes any sense what so
ever.  Needless to say, it _could_ be made to work, but you're likely
need some complexity, and given that it has very few users, I don't
think there's much to be gained from putting that work in.  We've even
talked a few times about removing XIP support altogether.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
