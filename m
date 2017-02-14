From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Tue, 14 Feb 2017 06:55:18 +0100
Subject: [PATCH v6 5/5] ARM: dts: sun9i: Initial support for the Sunchip
 CX-A99 board
In-Reply-To: <CAGb2v64AfBW+CHHkFvvNzCGBG09UK-sPcAZi2QgCR9wM=jguxw@mail.gmail.com>
References: <cover.1486592470.git.rask@formelder.dk>
 <d4211c5d57f80b0281d7d332edc7d69e66202d3d.1486592471.git.rask@formelder.dk>
 <20170210085920.7l7gswm6yjuqgdfx@lukather>
 <CAGb2v64AfBW+CHHkFvvNzCGBG09UK-sPcAZi2QgCR9wM=jguxw@mail.gmail.com>
Message-ID: <20170214055517.ahfz5fxajn3pv7fd@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let me just answer the questions about the regulator names and get back to
you about your other points.

On Fri, Feb 10, 2017 at 05:22:21PM +0800, Chen-Yu Tsai wrote:
> On Fri, Feb 10, 2017 at 4:59 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Thu, Feb 09, 2017 at 12:34:06AM +0100, Rask Ingemann Lambertsen wrote:
[...]
> >> +                     /* 1.8 V (enabled). */
> >> +                     reg_aldo2: aldo2 {
> >> +                             regulator-boot-on;
> >> +                             regulator-min-microvolt = <1800000>;
> >> +                             regulator-max-microvolt = <3600000>;
> >> +                             regulator-name = "vcc-pg-pm-wifi+btio-audio";
> >
> > Usually, there is simpler names available on the schematics, or at
> > least simpler names we can come up with.
> >
> > Something like vcc-wifi would be enough her.
> 
> It should be vddio-wifi. Looking at the pin groups it names, it likely
> just drives the I/O pins on both ends.

Sys_config.fex lists is as supplying the audio codec as well, so
"vddio-wifi-codec" perhaps?

> >> +                     /* 2.5 V (enabled). */
> >> +                     reg_aldo3: aldo3 {
> >> +                             regulator-boot-on;
> >> +                             regulator-min-microvolt = <2500000>;
> >> +                             regulator-max-microvolt = <2500000>;
> >> +                             regulator-name = "vcc-pa-gmac2v5";
> >
> > vcc-gmac
> 
> vcc-pa or vddio-gmac. 2.5V is for RGMII I/O. vcc-gmac is the "sw"
> regulator @ 3.3V.

I think nothing else is connected to pin group A, so I'll call it
"vddio-gmac".

> >> +                     /* 1.8 V (enabled). */
> >> +                     reg_bldo1: bldo1 {
> >> +                             regulator-always-on;    /* Hang if disabled */
> >> +                             regulator-min-microvolt = <1700000>;
> >> +                             regulator-max-microvolt = <1900000>;
> >> +                             regulator-name = "vdd18-dll-vcc18-pll";
> >
> > vdd-dll
> 
> PLLs and DLLs are different though. Maybe vcc-pll-dll?

The SoC data sheet uses the names "VDD18-DLL" and "VCC18-PLL". However, it's
quite likely that more of the SoC's 1.8 V consumers are connected to bldo1,
as I see no other likely 1.8 V supply for them. I'll call it "vdd18".

> >> +                     /* 3.3 V (enabled). PLx pins control some regulators. */
> >> +                     reg_cldo1: cldo1 {
> >> +                             regulator-always-on;
> >> +                             regulator-min-microvolt = <3300000>;
> >> +                             regulator-max-microvolt = <3300000>;
> >> +                             regulator-name = "vcc-pl-led";
> >
> > vcc-led, etc...
> 
> vcc-pl is probably better... One can figure out the LEDs are connected to the
> PL group and maybe realize they are powered this way. Not that easy the other
> way around.

The LEDs are controlled by PG10 and PG11 but get their power from cldo1,
which is connected to the (common) anode of the red and blue LED. Cldo1 also
supplies the SoCs "VCC-PL", which powers pin group L that controls the USB
2.0 Vbus and vdd-cpub regulators. Pin group L has nothing to do with the
LEDs. Thus I think the regulator name is appropriate in this case.

-- 
Rask Ingemann Lambertsen
