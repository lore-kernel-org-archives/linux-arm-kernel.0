From: jason@lakedaemon.net (Jason)
Date: Fri, 2 Mar 2012 09:15:41 -0500
Subject: [PATCH 4/4] ARM: kirkwood: convert orion-wdt to fdt.
In-Reply-To: <20120302091510.GC29461@kw.sim.vm.gnt>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <2f29e88b98b2bcff0c241996e6d7216a60995d2d.1330625878.git.jason@lakedaemon.net>
 <20120302091510.GC29461@kw.sim.vm.gnt>
Message-ID: <20120302141541.GE11986@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2012 at 10:15:11AM +0100, Simon Guinot wrote:
> Hi Jason,
> 
> On Thu, Mar 01, 2012 at 06:20:55PM +0000, Jason Cooper wrote:
> > Converted register address to a variable so that it could be set from
> > fdt.  Also, pull clock frequency from fdt and clean up failure logic a
> > bit.
> > 
> > Same as rtc-mv, this device is used in all kirkwood boards.  So, it is
> > placed in kirkwood.dtsi.
> > 
> > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> > ---
> >  arch/arm/boot/dts/kirkwood.dtsi   |    6 +++++
> >  arch/arm/mach-kirkwood/board-dt.c |    1 -
> >  arch/arm/mach-kirkwood/common.c   |    2 +-
> >  arch/arm/mach-kirkwood/common.h   |    1 -
> >  drivers/watchdog/orion_wdt.c      |   44 ++++++++++++++++++++++++++----------
> >  5 files changed, 39 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> > index 5fb185c..bf28424 100644
> > --- a/arch/arm/boot/dts/kirkwood.dtsi
> > +++ b/arch/arm/boot/dts/kirkwood.dtsi
> > @@ -8,5 +8,11 @@
> >  		reg = <0xf1010300 0x1f>;
> >  		interrupts = <53>;
> >  	};
> > +
> > +	wdt at fed20300 {
> > +		compatible = "marvell,orion-wdt";
> > +		reg = <0xfed20300 0x28>;
> > +		clock-frequency = <200000000>;
> > +	};
> 
> How this will work for boards using a different clock frequency (TCLK) ?
> Here, we could have 166MHz for example.
> 
> Can this node be updated during the board initialization with a detected
> TCLK value ?
> 
> Or maybe this clock-frequency can reference a TCLK frequency defined in
> a board specific dts (I don't know if the DT format allow such things) ?

Grr... good catch.  I originally had this in kirkwood-dreamplug.dts,
which is always 200000000.  That's not the case in kirkwood.dtsi.  What
I would like to do, and I haven't had time to look into it (I thought I
would tackle it later as a refinement :-( ), is a reference of some
sort, eg:

in kirkwood.dtsi:

/ {
	compatible = "marvell,kirkwood";
	tclk:clock-frequency = <200000000>;

	wdt at fed20300 {
		compatible = "marvell,orion-wdt";
		reg = <0xfed20300 0x28>;
		clock-frequency = &tclk;
	};
};

then, in kirkwood-foobar.dts

/include/ "kirkwood.dtsi"

/ {
	model = "foobar";
	compatible = "...";
	tclk:clock-frequency = <166000000>;
};

but I'm not sure if that would work.

In any case, the simplest answer is to set clock-frequency in
kirkwood-dreamplug.dts as a root node property, and then each driver
that needs tclk, requests the clock-frequency from the root node.
Hopefully, Grant can chime in on this one.

Thanks for the review,

Jason.
