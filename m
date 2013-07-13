From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 13 Jul 2013 10:35:16 +0200
Subject: DT binding review for Armada display subsystem
In-Reply-To: <CAMLZHHT1oAvOLe3JgQqMqLNXEr0NGrdtgELtF_djbqLFceHtiQ@mail.gmail.com>
References: <20130712164428.AC3D2FAAE9@dev.laptop.org>
 <20130712203952.6b7aa927@armhf>
 <CAMLZHHT1oAvOLe3JgQqMqLNXEr0NGrdtgELtF_djbqLFceHtiQ@mail.gmail.com>
Message-ID: <20130713103516.38a55b0b@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Jul 2013 13:00:23 -0600
Daniel Drake <dsd@laptop.org> wrote:

> On Fri, Jul 12, 2013 at 12:39 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> > - the phandles to the clocks does not tell how the clock may be set by
> >   the driver (it is an array index in the 510).  
> 
> In the other threads on clock selection, we decided that that exact
> information on how to select a clock (i.e. register bits/values) must
> be in the driver, not in the DT. What was suggested there is a
> well-documented scheme for clock naming, so the driver knows which
> clock is which. That is defined in the proposed DT binding though the
> "valid clock names" part. For an example driver implementation of this
> you can see my patch "armada_drm clock selection - try 2".

OK.

Sorry to go back to this thread.

I use my Cubox for daily jobs as a desktop computer. My kernel is a DT
driven 3.10.0. The dove-drm, tda998x and si5351 (clock) are kernel
modules. I set 3 clocks in the DT for the LCD0: lcdclk, axi and extclk0
(si5351). Normally, the external clock is used, but, sometimes, the
si5351 module is not yet initialized when the drm driver starts. So,
for 1920x1080p, it uses the lcdclk which sets the LCD clock to 133333
(400000/3) instead of 148500. As a result, display and sound still work
correctly on my TV set thru HDMI.

So, it would be nice to have 2 usable clocks per LCD, until we find a
good way to initialize the modules in the right order at startup time.

> > - I don't see the use of the phandles in the leaves (dcon and tda998x).  
> 
> That is defined by the video interfaces common binding. I'm not
> immediately aware of the use, but the ability to easily traverse the
> graph in both directions seems like a requirement that could easily
> emerge from somewhere.

OK, but I am not convinced...

> > Well, here is how I feel the DTs:
> >
> > - for the Cubox (one LCD, the DCON is not used, TDA998x for HDMI/DVI
> >   output):  
> 
> That is the same as my proposal except you have decided to use direct
> phandle properties instead of using the common video interfaces
> binding (which is just a slightly more detailed way of describing such
> links). In the "best practices" thread, the suggestion was raised
> multiple times of doing what v4l2 does, so thats why I decided to
> explore this here.
> 
> > - for some tablet based on the Armada 510 with a LCD and a VGA connector:
> >
> >         video {
> >                 compatible = "marvell,armada-video";
> >                 marvell,video-devices = <&lcd0>, <&lcd1>, <&dcon>
> >         };  
> 
> This proposal is slightly different because it does not describe the
> relationship between the LCD controllers and the DCON. Focusing
> specifically on LCD1, which would be connected to a DAC via a phandle
> property in your proposal. The interconnectivity between the
> components represented as a graph (and in the v4l2 way, which includes
> my proposal) would be:
> 
> LCD1 --- DCON --- DAC
> 
> However your phandle properties would "suggest" that LCD1 is directly
> connected to the DAC. The driver would have to have special knowledge
> that the DCON sits right in the middle. Maybe that is not an issue, as
> it is obviously OK for the driver to have *some* knowledge about how
> the hardware works :)
> 
> I don't think we have a full consensus on whether we want to go the
> "v4l2 way" here. But I figured that would be a good thing to propose
> in a first iteration to have a clearer idea of what the result would
> look like. It sounds like you are not overly keen on it, I would be
> interested to hear exactly why.

I think this is because I was focused on the software and not on the
hardware.

Back to the specific case of the Cubox with new ideas.

The Cubox is based on the Armada 510 (Dove), so, all the hardware must
be described in dove.dtsi. This includes the LCDs and DCON/IRE, the
possible clocks and the (static) v4l2 links:

	lcd0: lcd-controller at 820000 {
		compatible = "marvell,dove-lcd0";
		reg = <0x820000 0x1c8>;
		interrupts = <47>;
		clocks = <&core_clk 3>, <&lcdclk>;
		clock-names = "axi", "lcdclk";
		marvell-output = <&dcon 0>;
		status = "disabled";
	};

	lcd1: lcd-controller at 810000 {
		compatible = "marvell,dove-lcd1";
		reg = <0x810000 0x1c8>;
		interrupts = <46>;
		clocks = <&core_clk 3>, <&lcdclk>;
		clock-names = "axi", "lcdclk";
		marvell-output = <&dcon 1>;
		status = "disabled";
	};

	/* display controller and image rotation engine */
	dcon: display-controller at 830000 {
		compatible = "marvell,dove-dcon";
		reg = <0x830000 0xc4>,			/* DCON */
		      <0x831000 0x8c>;			/* IRE */
		interrupts = <45>;
		marvell-input = <&lcd0>, <&lcd1>;
		status = "disabled";
	};

The specific Cubox hardware (tda998x and si5351) is described in
dove-cubox.dts, with the new clocks and the v4l2 link dcon0 <--> tda998x.

	&i2c0 {
		si5351: clock-generator {
			...
		};
		tda998x: hdmi-encoder {
			compatible = "nxp,tda998x";
			reg = <0x70>;
			interrupt-parent = <&gpio0>;
			interrupts = <27 2>;		/* falling edge */
			marvell-input = <&dcon 0>;
		};
	};
	&lcd0 {
		status = "okay";
		clocks = <&si5351 0>;
		clock-names = "extclk0";
	};
	&dcon {
		status = "okay";
		marvell-output = <&tda998x>, 0;		/* no connector on port B */
	};

Then, about the software, the drm driver may not need to know anything
more (it scans the DT for the LCDs and gets all the subdevices thanks
to the v4l2 links):

	video {
		compatible = "marvell,armada-video";
	};

For some boards / other SoCs, there may be independant drm devices. In
this case, there would be descriptions as:

	video0 {
		compatible = "marvell,armada-video0";
		marvell,video-devices = <&lcd0>;
	};
	video1 {
		compatible = "marvell,armada-video1";
		marvell,video-devices = <&lcd1>;
	};

About the LCD clocks, the drm driver may choose itself one of the
clocks declared in the DT. If a clock should not be used, if should be
zeroed in the board specific DT:

	&lcd0 {
		status = "okay";
		clocks = 0, 0, <&si5351 0>;
		clock-names = "axi", "lcdclk", "extclk0";
	};

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
