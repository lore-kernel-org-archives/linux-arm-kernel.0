From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Jun 2011 22:43:22 +0100
Subject: [RFC 1/2] ARM:Tegra: Device Tree Support: Initialize the audio
	card from the device tree.
In-Reply-To: <BANLkTikGp_O-Wd3nMhbV+-RLeXZoWeB6eQ@mail.gmail.com>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205706.21000.34832.stgit@riker>
	<BANLkTi=NMjBjWVv_o3PocejhgGr8TdG+1Q@mail.gmail.com>
	<BANLkTi=PtEhxxmZo2DqvmySCmnEd3LbezQ@mail.gmail.com>
	<BANLkTikWpiY_o27OF-Jxvq7iPeWzrAYOsQ@mail.gmail.com>
	<20110602160445.GA8373@ponder.secretlab.ca>
	<BANLkTikGp_O-Wd3nMhbV+-RLeXZoWeB6eQ@mail.gmail.com>
Message-ID: <20110602214322.GC10532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2011 at 12:21:50AM +0800, Barry Song wrote:
> Arnd has required me to use device tree in our new SoC for the coming
> upstream. so i am trying to define a property like clock = "uart" in
> dts. then in drivers,
> i get this  string by:
> clk = of_get_property(np, "clock", NULL);
> then request this clock by clk_get().

This is entirely wrong.  clk_get() takes two things.  It takes a struct
device.  We should know what the struct device is (provided they're named
in a stable manner.)

The other parameter, the string, is up to the driver.  It's not a device
property.  It's not a SoC-wide clock name.  It's a connection name for
the clock on the device.  This won't change from one instance of the
device to another instance of the device - it's effectively a constant.

So there's no point in having the DT describe that name - that's out of
its realm.

One of the problems is that clk_get() hides the mapping of device+connection
internally, which it has had to as we haven't had a device tree to look
things up.

In essence, clk_get() is looking up a property (the clock connection name)
for the struct device.  When clks get converted to the device tree, the
DT stuff should hook inside clk_get() to do a property lookup to discover
which clock the driver wants.

Drivers should definitely not be looking up a property in the device tree
and using that as a connection name into clk_get().
