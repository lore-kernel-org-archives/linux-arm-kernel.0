From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 09 Jan 2010 06:45:54 +1100
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <20100108125934.GA27567@n2100.arm.linux.org.uk>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<BD79186B4FD85F4B8E60E381CAEE190902089611@mi8nycmail19.Mi8.com>
	<201001081220.14485.jeremy.kerr@canonical.com>
	<201001081426.09754.jk@ozlabs.org>
	<20100108094214.GA23420@n2100.arm.linux.org.uk>
	<1262944873.585.17.camel@pasglop>
	<20100108111831.GA25082@n2100.arm.linux.org.uk>
	<1262951103.585.40.camel@pasglop>
	<20100108125934.GA27567@n2100.arm.linux.org.uk>
Message-ID: <1262979954.585.52.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Taking the two machine types that are most likely to want to use this:
> 
> On PXA, there are 67 struct clk's, each of which has a single pointer
> to an operations structure.  Each operations structure is three pointers
> and there are 11 such structures.  That's 67 * 4 + 11 * 12 = 400 bytes.
> PXA is simple enough that these operations structures can be swallowed
> up into this struct clk.  So, switching PXA to this will mean 67 * 32 =
> 2144 bytes.  That's an increase in overhead of 5x.

Right. Half a page, big deal :-) Now, again, we aren't necessarily
talking about converting existing / old platforms. I believe the main
target here is things like netbooks etc... and the whole new batch of
ARM stuff coming up which has at least half a GB of RAM if not more.

Also a lot of that overhead can be alleviated by using a pointer to an
"ops" structure which can be static in most case. Jeremy, that might be
a better approach if the memory footprint is such a concern.

But again, maybe the PXA platform will not want to use that stuff... it
doesn't -have- to.

Among other things, the idea of having this more flexible infrastructure
and the device-tree is also to allow multiple platforms to be more
easily built as a single kernel, which is something I believe
distributions want to do as much as possible for the incoming batch of
ARM based netbooks, tablets, etc... 

> On OMAP, there are 16 clkops structures of 16 bytes each, and each
> struct clk has a pointer to this structure.  Due to the way OMAP works,
> these can't be directly called from the proposed generic version
> because of the additional clock domain/power domain code, so we can
> discount these.
> 
> There are two function pointers in the struct clk which would be
> identical to the versions proposed in this generic struct clk.
> There's a total of 219 clk structures in OMAP3.  So, 219 * (4 + 8)
> = 2628.  Switching OMAP means 219 * (4 + 32) = 7884, which is an
> increase in overhead of 3x.
> 
> This is the problem - you can have "generic" versions of stuff provided
> you're willing to put up with the additional overhead that comes with
> it.

Right. On the other hand, as you mentioned earlier, the above more
"efficient" way of doing it is also mostly unable to deal with non-SoC
clocks. You cannot for example have a set of generic drivers for a bunch
of existing PLL chips etc...

It may not be a huge deal but I know from some discussions I had in the
past that there -is- interest in that.

So yes, you may use up a bit more memory (and again, I'm curious to see
how much really with an ops pointer) and or a bit more overhead going
through said function pointers, but there are significant benefits in
term of code re-usability between platforms, in some cases
simplification, etc... in addition to the device-tree stuff you may want
to use on top of that which brings its own benefits.

Cheers,
Ben.
