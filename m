From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jan 2010 12:59:34 +0000
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <1262951103.585.40.camel@pasglop>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<BD79186B4FD85F4B8E60E381CAEE190902089611@mi8nycmail19.Mi8.com>
	<201001081220.14485.jeremy.kerr@canonical.com>
	<201001081426.09754.jk@ozlabs.org>
	<20100108094214.GA23420@n2100.arm.linux.org.uk>
	<1262944873.585.17.camel@pasglop>
	<20100108111831.GA25082@n2100.arm.linux.org.uk>
	<1262951103.585.40.camel@pasglop>
Message-ID: <20100108125934.GA27567@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2010 at 10:45:03PM +1100, Benjamin Herrenschmidt wrote:
> I don't think Jeremy (again he will have to confirm) is aiming toward a
> common implementation of the entire clock subsystem. The idea is that
> the struct clk is a clock object. You can have many struct clk, they can
> have many different capabilities and features.

Taking the two machine types that are most likely to want to use this:

On PXA, there are 67 struct clk's, each of which has a single pointer
to an operations structure.  Each operations structure is three pointers
and there are 11 such structures.  That's 67 * 4 + 11 * 12 = 400 bytes.
PXA is simple enough that these operations structures can be swallowed
up into this struct clk.  So, switching PXA to this will mean 67 * 32 =
2144 bytes.  That's an increase in overhead of 5x.

On OMAP, there are 16 clkops structures of 16 bytes each, and each
struct clk has a pointer to this structure.  Due to the way OMAP works,
these can't be directly called from the proposed generic version
because of the additional clock domain/power domain code, so we can
discount these.

There are two function pointers in the struct clk which would be
identical to the versions proposed in this generic struct clk.
There's a total of 219 clk structures in OMAP3.  So, 219 * (4 + 8)
= 2628.  Switching OMAP means 219 * (4 + 32) = 7884, which is an
increase in overhead of 3x.

This is the problem - you can have "generic" versions of stuff provided
you're willing to put up with the additional overhead that comes with
it.
