From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Jun 2014 17:20:14 +0100
Subject: [PATCH 0/5] Handle non-secure L2C initialization on Exynos4
In-Reply-To: <CAD8Lp46MbKZrCAMp+9T9LbWTB4uHRDdivhtjoQbkTyBbK48EgQ@mail.gmail.com>
References: <CAD8Lp46MbKZrCAMp+9T9LbWTB4uHRDdivhtjoQbkTyBbK48EgQ@mail.gmail.com>
Message-ID: <20140612162014.GA3705@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 02:38:49PM +0100, Daniel Drake wrote:
> From 2e67231f10ed0b05c2bacfdd05774fe21315d6da Mon Sep 17 00:00:00 2001
> From: Gu1 <gu1@aeroxteam.fr>
> Date: Mon, 21 Jan 2013 04:13:56 +0100
> Subject: [PATCH] ARM: EXYNOS: Add secure firmware support for l2x0 init
> 
> Conflicts:
> 	arch/arm/mm/cache-l2x0.c

For this patch... it's a big NAK because it's taking us right back down
the route of a totally fucked up cache-l2x0.c driver.

Why can't you people write stuff properly?  There's already another set
of patches on this mailing list which want to pass the virtual base
address of the l2x0 controller to l2c_write_sec() so that various
registers can be read back, because the platform's secure API can
only update several registers at the same time.

This is the same pattern that is revealed in this patch.  So, what
this means is that the l2c_write_sec API is wrong.  We need to come
up with a *replacement* API which allows the platforms to do this
kind of setup in a *clean* way, and stop creating rotten hacks like
this which just makes long term maintanence a nightmare.

So... please start doing stuff properly.  If you don't, you're going
to be getting more flames from me, especially if you start doing this
kind of hackery on code that I've been cleaning up to get rid of such
crap.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
