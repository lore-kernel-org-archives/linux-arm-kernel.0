From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 28 Feb 2014 12:09:26 -0300
Subject: [PATCH 0/2] Watchdog on Armada 375 SoC
In-Reply-To: <20140226203633.GA24656@obsidianresearch.com>
References: <1393419047-10071-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140226203633.GA24656@obsidianresearch.com>
Message-ID: <20140228150925.GC24805@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 01:36:33PM -0700, Jason Gunthorpe wrote:
> On Wed, Feb 26, 2014 at 09:50:45AM -0300, Ezequiel Garcia wrote:
>  
> > Here we found both the above RSTOUT:
> > 
> > 1. It has the same dedicated register as A370/XP (0x20704)
> > 2. Also has a bit in the shared RSTOUT register (0x18254)
> 
> Unless you know otherwise I think the same risk exists, RSTOUT could
> be (or become) internally asserted when you unmask the bit in the
> control register that drives the pin, which says the watchdog driver
> should control to it.
> 

I guess it's also possible to have the system-controller ensure the
watchdog is fully stopped, before unmasking the shared RSTOUT.

However, it seems it would be too ugly and hackish.

> > 
> > 	watchdog-timer at 20300 {
> > 		compatible = "marvell,orion-wdt";
> > 		reg = <0x20300 0x28
> > 		       {shared RSOUT} 0x4
> > 		       0x0 0x0>;
> > 	};
> 
> I wouldn't have the 0x0, if you want to go this way, just make the
> 375 compatible string require a 3 entry reg.
> 

Yes, this sounds like the right thing to do. It means we need to also
have per-SoC hooks for stop() and is_enabled(), but it's the price to
pay for changing the register semantic: the shared RSTOUT has unmask/mask
semantics on A375, while it's enable/disable on Kirkwood and friends.

Let me cook a new patch.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
