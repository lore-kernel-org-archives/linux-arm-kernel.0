From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 May 2012 10:15:51 +0100
Subject: common clock framework
In-Reply-To: <AAD1C6EB06EE3649B35B7E026785068D1A74A942DB@SC-VEXCH2.marvell.com>
References: <AAD1C6EB06EE3649B35B7E026785068D1A74A94270@SC-VEXCH2.marvell.com>
 <20120504082110.GB16535@pengutronix.de>
 <AAD1C6EB06EE3649B35B7E026785068D1A74A942DB@SC-VEXCH2.marvell.com>
Message-ID: <20120504091551.GC26481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 01:45:15AM -0700, Chao Xie wrote:
> For the clock dependency, what about bus clock. What do you mean about
> bus level.
>
> As I understand the device driver only need care about enabling a clock
> to make it work. For example a USB driver. To make a USB work, it may
> need turn on bus clock, function clock, and phy clock. For some SOCs,
> phy and function may share same clock. There is a problem, we leave this
> dependency to device driver or keep it in our clock framework.

If the hardware block takes three clocks, then the driver should be asking
for three clocks and turning them on as if they were three separate clocks.
Note I'm talking here about the USB module itself _before_ it is integrated
onto the SoC.

Where SoCs don't provide explicit control of three clocks, but instead
combine it as one clock, then you need to provide all three clock lookups
from the _very_ _same_ struct clk for the device driver.  That means when
any one of the clocks is requested to be enabled, they all will be.

This eliminates this kind of horrible dependency at the clock layer as well
as the driver layer.  This is also how the clk API is intended to be used
by drivers.

We don't ifdef clocks in drivers.  We provide what the driver (and
ultimately hardware) requires.
