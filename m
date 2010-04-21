From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 22 Apr 2010 07:26:56 +1000
Subject: [RFC/PATCH] dns323: Support for HW rev C1
In-Reply-To: <20100421201516.GG26616@n2100.arm.linux.org.uk>
References: <1271838486.2330.139.camel@pasglop>
	<20100421180737.GE4586@mail.wantstofly.org>
	<20100421201516.GG26616@n2100.arm.linux.org.uk>
Message-ID: <1271885216.2330.175.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-04-21 at 21:15 +0100, Russell King - ARM Linux wrote:
> > Just register a different machine ID for the rev C1 board and pass
> > that in from the boot loader, that'll solve all these problems.
> 
> Or use the system_rev for what it's meant for; it was invented to deal
> with the differences between rev 3,4,5 netwinders - or more specifically
> revision 4 netwinders where the fan control hardware is different from
> rev 3 and 5.

Right, that is a good way to pass the board revision around drivers
etc...

However, in this specific case, we have a different problem, this is not
related really to identifying rev A vs B vs C of the board.

The issue at hand is that the PHY driver for that 1118 PHY hard wires a
value into the PHY LED control register that doesn't work for this
board. (Rev A and B are using a different PHY altogether). So my patch
just adds to the PHY driver a test of machine_is_dns323() (with
appropriate ifdef's) to set the right value in there when initializing
it.

This is a bit of a wart, but is simple and works fine. I was just
pointing out that we don't seem to have an overall good way to pass
board/platform info such as these to individual PHY drivers using the
generic mdio bus.

Cheers,
Ben.
