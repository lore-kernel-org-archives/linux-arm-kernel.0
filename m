From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Dec 2010 15:08:41 +0000
Subject: bug in PL011 console
In-Reply-To: <20101223150234.GW14221@pengutronix.de>
References: <20101223150234.GW14221@pengutronix.de>
Message-ID: <20101223150841.GP3636@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 23, 2010 at 04:02:34PM +0100, Uwe Kleine-K?nig wrote:
> Steven told me on irc that sleeping was not allowed in the console write
> callback.  Maybe this didn't show up earlier because not all clk
> implementations sleep as mxs' does.
> 
> I think the only possible fix is to do the clk_enable in the setup
> callback instead of per-write.
> 
> Will send a patch as follow up.

We really need to sort out what's expected from the CLK API.  The drivers
I write assume that it's absolutely fine to call clk_enable/clk_disable
from IRQ context, and for the platforms I implemented the CLK API for,
that's absolutely true.

I'd lobby for it because it allows for proper power saving management of
clocks for devices - PL011 only enables the clock when either the port is
open or it's actually sending data out the port.  So it's doing absolutely
the best power management that can be done with UARTs.
