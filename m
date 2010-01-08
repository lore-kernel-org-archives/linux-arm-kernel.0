From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 08 Jan 2010 21:01:13 +1100
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <20100108094214.GA23420@n2100.arm.linux.org.uk>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<BD79186B4FD85F4B8E60E381CAEE190902089611@mi8nycmail19.Mi8.com>
	<201001081220.14485.jeremy.kerr@canonical.com>
	<201001081426.09754.jk@ozlabs.org>
	<20100108094214.GA23420@n2100.arm.linux.org.uk>
Message-ID: <1262944873.585.17.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-01-08 at 09:42 +0000, Russell King - ARM Linux wrote:
> What is clear from the clk API as implemented today is that what's
> right
> for one platform isn't right for another platform.  That's why we have
> each platform implementing struct clk in their own way. 

Such platforms would just not set CONFIG_HAVE_COMMON_STRUCT_CLK then.

I think what Jeremy is trying to achieve is a way for platforms that
which to use the device-tree to retrieve the clock binding to be able to
chose to do so, using as much common code as possible.

The problem with the more "static" variants of struct clk is that while
they are probably fine for a single SoC with a reasonably unified clock
mechanism, having more than one clock source programmed differently and
wanting to deal with potentially out-of-SoC clock links between devices
becomes quickly prohibitive without function pointers.

The moment you start having function pointers, you may as well have a
common infrastructure for "indirect" clk ops since that eases code
re-use. Which you do already in some of the ARM platforms afaik.

For example, while discussing the porting of struct clk to powerpc a
while back with some ARM folks, some people told me one issue they had
was to use it to represent clocks between an external i2c PLL chip and
an external device.

Such a scenario becomes trivial to deal with using the device-tree, as
the i2c clock provider "registers" with the device-tree aware clock
infrastructure, which will then transparently, bind the device to the
clock provider and provide the right struct clk to the device.

But again, if a platform choice to use or not to use that facility. If a
platform prefers not to use the facility, for example for performances
reasons, or because of a lot of existing code which would be hard to
update or not worth changing, that platform then just needs to not set
CONFIG_HAVE_COMMON_STRUCT_CLK.

Cheers,
Ben.
