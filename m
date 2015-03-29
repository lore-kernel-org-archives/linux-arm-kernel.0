From: juergen@kreuzholzen.de (Juergen Borleis)
Date: Sun, 29 Mar 2015 16:40:53 +0200
Subject: [PATCH 7/7] ARM: dts: add OPPs for i.MX23/i.MX28
In-Reply-To: <1470793430.944631.1427565192794.JavaMail.open-xchange@oxbaltgw00.schlund.de>
References: <1470793430.944631.1427565192794.JavaMail.open-xchange@oxbaltgw00.schlund.de>
Message-ID: <201503291640.56538.juergen@kreuzholzen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

Stefan Wahren wrote:
> > Juergen Borleis <juergen@kreuzholzen.de> hat am 24. M?rz 2015 um 21:45
> > geschrieben:
> >
> > Stefan Wahren wrote:
> > > [...]
> > > diff --git a/arch/arm/boot/dts/imx28.dtsi
> > > b/arch/arm/boot/dts/imx28.dtsi index 98c1be6..21c1921 100644
> > > --- a/arch/arm/boot/dts/imx28.dtsi
> > > +++ b/arch/arm/boot/dts/imx28.dtsi
> > > @@ -38,12 +38,23 @@
> > > };
> > >
> > > cpus {
> > > - #address-cells = <0>;
> > > + #address-cells = <1>;
> > > #size-cells = <0>;
> > >
> > > - cpu {
> > > + cpu at 0 {
> > > compatible = "arm,arm926ej-s";
> > > device_type = "cpu";
> > > + reg = <0x0>;
> > > + operating-points = <
> > > + /* kHz uV */
> > > + 261819 1350000
> > > + 360000 1350000
> > > + 392728 1450000
> > > + 454737 1550000
> > > + >;
> > > + clocks = <&clks 4>;
> > > + clock-latency = <61036>; /* two CLK32 periods */
> > > + cpu-supply = <&reg_vddd>;
> > > };
> > > };
> >
> > Maybe you should take into account not to reduce VDD below 1.55 V if the
> > SDRAM controller runs above 196 MHz. The i.MX28 datasheet[1] lists these
> > restrictions. VDD powers the SDRAM controller as well. From the datasheet
> > the table "Frequency versus Voltage for EMICLK" shows:
> >
> > EMICLK Fmax (MHz)
> > VDDD (V) DDR2 mDDR
> > --------------------------------
> > 1.550 205.71 205.71
> > 1.450 196.36 196.36
> > 1.350 196.36 196.36
> >
> > jbe
> >
> > [1]
> > i.MX28 Applications
> > Processors for Consumer
> > Products
> > Silicon Version 1.2
> >
> > Document Number: IMX28CEC
> > Rev. 3, 07/2012
>
> the only chance that i see to meet this constraint without introducing a
> new cpufreq driver is to change clock ref_cpu
> and ref_emi.
>
> Do you think this solution of a virtual clock [1] can be applied here, too?

This would imply we can change the SDRAM timing at run-time on the fly. IMHO 
that is not possible (at least not easy). I think when the driver detects the 
SDRAM controller runs above 196 MHz the clock for the CPU core can still be 
changed, but VDD must be kept at 1.55 V.

Juergen
