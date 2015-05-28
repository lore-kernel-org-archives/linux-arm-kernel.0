From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 May 2015 19:16:52 +0200
Subject: [GIT PULL] Allwinner drivers changes for 4.2
In-Reply-To: <20150521122019.GC7461@lukather>
References: <20150511193527.GA29690@lukather> <7268386.7h5UbnZJi7@phil>
 <20150521122019.GC7461@lukather>
Message-ID: <3656359.T7MWGL2sPr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 May 2015 14:20:19 Maxime Ripard wrote:
> > Preface: I only did the reserved sections so I could claim parts of my 
> > Rockchip sram for the smp code that needed to reside at a specific place in it, 
> > so I guess I don't necessarily feel qualified to judge one against the other 
> > :-), but anyway
> > 
> > 
> > The commit message for the driver contains
> > 
> > "We could also imagine changing this at runtime for example to change the
> > mapping of these SRAMs to use them for suspend/resume or runtime memory rate
> > change, if that ever happens."
> > 
> > which sounds to me a lot like the generic use case for the current sram driver 
> > - for example in conjuction with the PIE stuff if it ever resurfaces.
> > 
> > 
> > But from my short glance I also don't see how this quite custom mapping thing 
> > (device vs. cpu) would be able to fit into the generic description.
> 
> So, what's the conclusion on this?
> 
> This driver has been properly sent, without any kind of review from
> you. I then sent a pull request with it for 4.1, which has only been
> silently ignored.
> 
> And now, it seems like this is going to be the same for 4.2. I'd
> *really* like to have some kind of a discussion here, and not let it
> fall into oblivion. It fixes some real issues we have.

I've looked at the driver some more now, and tried to come up with
a binding that I think would fit better with the existing mmio-sram
one. Do you think you could get it to work like this?

sram at 00000000 {
	// we bind to the first one here
	compatible = "allwinner,sun4i-a10-sram-controller", "mmio-sram";
	// first the SRAM, second the controller regs
	reg = <0x10000000 0x11000>, <0x01c00000 0x30>;
	ranges = <0 0x10000000 0x11000>;
	#address-cells = <1>;
	#size-cells = <1>;

	otg-sram: otg-sram at 10000 {
		compatible = "allwinner,sun4i-a10-sram";
		reg = <0x10000 0x1000>;
	};
};

&usb-otg {
	// allow otg driver to find the sram by phandle and
	// not need a table in the driver
	sram = <&sram-D>;
};

One important advantage here would be that we later have the option
of turning it into a subsystem with multiple sram controller drivers
and have sram clients just ask for a node by referencing a phandle.

The part I'm unsure about is whether the connections between
a particular client, the physical address of the SRAM as seen
from the CPU, and the register to control it are all fixed, or
if you can have clients that work with one or another SRAM chunk
depending on configuration.

	Arnd
