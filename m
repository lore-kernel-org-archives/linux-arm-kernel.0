From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 26 Feb 2014 13:36:33 -0700
Subject: [PATCH 0/2] Watchdog on Armada 375 SoC
In-Reply-To: <1393419047-10071-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1393419047-10071-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140226203633.GA24656@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 09:50:45AM -0300, Ezequiel Garcia wrote:
 
> Here we found both the above RSTOUT:
> 
> 1. It has the same dedicated register as A370/XP (0x20704)
> 2. Also has a bit in the shared RSTOUT register (0x18254)

Unless you know otherwise I think the same risk exists, RSTOUT could
be (or become) internally asserted when you unmask the bit in the
control register that drives the pin, which says the watchdog driver
should control to it.

> A possible solution is to extend the reg property in the watchdog
> devicetree and allow for a new optional pair of cells to complete
> the specification of the RSTOUT.
> 
> 	watchdog-timer at 20300 {
> 		compatible = "marvell,orion-wdt";
> 		reg = <0x20300 0x28
> 		       {shared RSOUT} 0x4
> 		       0x0 0x0>;
> 	};

I wouldn't have the 0x0, if you want to go this way, just make the
375 compatible string require a 3 entry reg.

Jason
