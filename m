From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 26 Sep 2011 19:29:35 +0100
Subject: [PATCHv3 2/4] picoxcell: add the DTS for pc3x2 and pc3x3 devices
In-Reply-To: <4E80BEA3.1030803@gmail.com>
References: <1317050689-16417-1-git-send-email-jamie@jamieiles.com>
	<1317050689-16417-3-git-send-email-jamie@jamieiles.com>
	<4E80BEA3.1030803@gmail.com>
Message-ID: <20110926182934.GA9194@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks for taking a look at this!  A few comments inline.

Jamie

On Mon, Sep 26, 2011 at 01:04:19PM -0500, Rob Herring wrote:
> Jamie,
> 
> On 09/26/2011 10:24 AM, Jamie Iles wrote:
> > This describes the basic hierarchy of picoxcell pc3x3 devices including
> > clocks and bus interconnect.  Some onchip devices are currently omitted
> > as there haven't been bindings created for them.
> > 
> > v2:	- change timer compatible strings to be more soc specific
> > 	- split vic node into 2 devices
> > 
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> > ---
> >  arch/arm/boot/dts/picoxcell-pc3x2.dtsi |  249 ++++++++++++++++++++++
> >  arch/arm/boot/dts/picoxcell-pc3x3.dtsi |  365 ++++++++++++++++++++++++++++++++
> >  2 files changed, 614 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/picoxcell-pc3x2.dtsi
> >  create mode 100644 arch/arm/boot/dts/picoxcell-pc3x3.dtsi
> > 
> > diff --git a/arch/arm/boot/dts/picoxcell-pc3x2.dtsi b/arch/arm/boot/dts/picoxcell-pc3x2.dtsi
> > new file mode 100644
> > index 0000000..f0a8c20
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/picoxcell-pc3x2.dtsi
> > @@ -0,0 +1,249 @@
> > +/*
> > + *  Copyright (C) 2011 Picochip, Jamie Iles
> > + *
> > + * This software is licensed under the terms of the GNU General Public
> > + * License version 2, as published by the Free Software Foundation, and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +/include/ "skeleton.dtsi"
> > +/ {
> > +	model = "Picochip picoXcell PC3X2";
> > +	compatible = "picochip,pc3x2";
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu at 0 {
> > +			compatible = "arm,1176jz-s";
> > +			clock-frequency = <400000000>;
> > +			reg = <0>;
> > +			d-cache-line-size = <32>;
> > +			d-cache-size = <32768>;
> > +			i-cache-line-size = <32>;
> > +			i-cache-size = <32768>;
> > +		};
> > +	};
> > +
> > +	clocks {
> 
> I would hold off on clock bindings. Grant expressed at LPC the desire to
> re-work the binding.

OK, that's fine with me.

> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges;
> > +
> > +		pclk: clock at 0 {
> > +			compatible = "fixed-clock";
> > +			clock-outputs = "bus", "pclk";
> > +			clock-frequency = <200000000>;
> > +			ref-clock = <&ref_clk>, "ref";
> > +		};
> > +	};
> > +
> > +	paxi {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0 0x80000000 0x400000>;
> > +
> > +		emac: gem at 30000 {
> 
> ethernet is the preferred generic name here. See section 2.2.2 of ePAPR.
> 
> So it would be "emac: ethernet at 30000"

I'll take a closer look at that document, I don't think I've spent much 
time with it.

> > +			compatible = "cadence,gem";
> > +			reg = <0x30000 0x10000>;
> > +			interrupts = <31>;
> > +		};
> > +
> > +		dmac1: dmac at 40000 {
> > +			compatible = "snps,dw-dmac";
> > +			reg = <0x40000 0x10000>;
> > +			interrupts = <25>;
> > +		};
> > +
> > +		dmac2: dmac at 50000 {
> > +			compatible = "snps,dw-dmac";
> > +			reg = <0x50000 0x10000>;
> > +			interrupts = <26>;
> > +		};
> > +
> > +		vic0: interrupt-controller at 60000 {
> > +			compatible = "arm,pl192-vic";
> > +			interrupt-controller;
> > +			reg = <0x60000 0x1000>;
> > +			#interrupt-cells = <1>;
> 
> No edge/level control/settings for the vic? Needs binding documentation.

No, there's no configuration for the interrupts.  The binding is 
documented in the picoxcell bindings, but as there isn't a generic 
driver yet I thought I'd hold off from doing a separate binding.

> > +		};
> > +
> > +		vic1: interrupt-controller at 64000 {
> > +			compatible = "arm,pl192-vic";
> > +			interrupt-controller;
> > +			reg = <0x64000 0x1000>;
> > +			#interrupt-cells = <1>;
> > +		};
> > +
> > +		fuse: picoxcell-fuse at 80000 {
> > +			compatible = "picoxcell,fuse-pc3x2";
> > +			reg = <0x80000 0x10000>;
> > +		};
> > +
> > +		ssi: picoxcell-spi at 90000 {
> > +			compatible = "picoxcell,spi";
> > +			reg = <0x90000 0x10000>;
> > +			interrupt-parent = <&vic0>;
> > +			interrupts = <10>;
> > +		};
> > +
> > +		ipsec: spacc at 100000 {
> > +			compatible = "picochip,spacc-ipsec";
> > +			reg = <0x100000 0x10000>;
> > +			interrupt-parent = <&vic0>;
> > +			interrupts = <24>;
> > +			ref-clock = <&pclk>, "ref";
> > +		};
> > +
> > +		srtp: spacc at 140000 {
> > +			compatible = "picochip,spacc-srtp";
> > +			reg = <0x140000 0x10000>;
> > +			interrupt-parent = <&vic0>;
> > +			interrupts = <23>;
> > +		};
> > +
> > +		l2_engine: spacc at 180000 {
> > +			compatible = "picochip,spacc-l2";
> > +			reg = <0x180000 0x10000>;
> > +			interrupt-parent = <&vic0>;
> > +			interrupts = <22>;
> > +			ref-clock = <&pclk>, "ref";
> > +		};
> > +
> > +		apb {
> > +			compatible = "simple-bus";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges = <0 0x200000 0x80000>;
> > +
> > +			rtc0: rtc at 00000 {
> > +				compatible = "picochip,pc3x2-rtc";
> > +				clock-freq = <200000000>;
> > +				reg = <0x00000 0xf>;
> > +				interrupt-parent = <&vic1>;
> > +				interrupts = <8>;
> > +			};
> > +
> > +			timer0: timer at 10000 {
> > +				compatible = "picochip,pc3x2-timer";
> > +				interrupt-parent = <&vic0>;
> > +				interrupts = <4>;
> > +				clock-freq = <200000000>;
> > +				reg = <0x10000 0x14>;
> > +			};
> > +
> > +			timer1: timer at 10014 {
> > +				compatible = "picochip,pc3x2-timer";
> > +				interrupt-parent = <&vic0>;
> > +				interrupts = <5>;
> > +				clock-freq = <200000000>;
> > +				reg = <0x10014 0x14>;
> > +			};
> > +
> > +			timer2: timer at 10028 {
> > +				compatible = "picochip,pc3x2-timer";
> > +				interrupt-parent = <&vic0>;
> > +				interrupts = <6>;
> > +				clock-freq = <200000000>;
> > +				reg = <0x10028 0x14>;
> > +			};
> > +
> > +			timer3: timer at 1003c {
> > +				compatible = "picochip,pc3x2-timer";
> > +				interrupt-parent = <&vic0>;
> > +				interrupts = <7>;
> > +				clock-freq = <200000000>;
> > +				reg = <0x1003c 0x14>;
> > +			};
> > +
> > +			gpio: gpio at 20000 {
> > +				compatible = "snps,dw-apb-gpio";
> > +				reg = <0x20000 0x1000>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				reg-io-width = <4>;
> > +
> > +				banka: gpio-controller at 0 {
> > +					compatible = "snps,dw-apb-gpio-bank";
> > +					gpio-controller;
> > +					#gpio-cells = <2>;
> > +					gpio-generic,nr-gpio = <8>;
> 
> This seems like Linux creeping into device tree.

Yes, I was trying to come up with a fairly generic binding for the 
generic-gpio driver.  I can remove this for now if you think appropriate 
though.

> > +
> > +					regoffset-dat = <0x50>;
> > +					regoffset-set = <0x00>;
> > +					regoffset-dirout = <0x04>;
> > +				};
> > +
> > +				bankb: gpio-controller at 1 {
> > +					compatible = "snps,dw-apb-gpio-bank";
> > +					gpio-controller;
> > +					#gpio-cells = <2>;
> > +					gpio-generic,nr-gpio = <8>;
> > +
> > +					regoffset-dat = <0x54>;
> > +					regoffset-set = <0x0c>;
> > +					regoffset-dirout = <0x10>;
> > +				};
> > +			};
> > +
> > +			uart0: uart at 30000 {
> 
> Preferred name is serial at 30000

OK.

> > +				compatible = "snps,dw-apb-uart";
> > +				reg = <0x30000 0x1000>;
> > +				interrupt-parent = <&vic1>;
> > +				interrupts = <10>;
> > +				clock-frequency = <3686400>;
> > +				reg-shift = <2>;
> > +				reg-io-width = <4>;
> > +			};
> > +
> > +			uart1: uart at 40000 {
> > +				compatible = "snps,dw-apb-uart";
> > +				reg = <0x40000 0x1000>;
> > +				interrupt-parent = <&vic1>;
> > +				interrupts = <9>;
> > +				clock-frequency = <3686400>;
> > +				reg-shift = <2>;
> > +				reg-io-width = <4>;
> > +			};
> > +
> > +			wdog: watchdog at 50000 {
> > +				compatible = "snps,dw-apb-wdg";
> > +				reg = <0x50000 0x10000>;
> > +				interrupt-parent = <&vic0>;
> > +				interrupts = <11>;
> > +				bus-clock = <&pclk>, "bus";
> > +			};
> > +		};
> > +	};
> > +
> > +	rwid-axi {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		compatible = "simple-bus";
> > +		ranges;
> > +
> > +		ebi at 50000000 {
> > +			compatible = "simple-bus";
> > +			#address-cells = <2>;
> > +			#size-cells = <1>;
> > +			ranges = <0 0 0x40000000 0x08000000
> > +				  1 0 0x48000000 0x08000000
> > +				  2 0 0x50000000 0x08000000
> > +				  3 0 0x58000000 0x08000000>;
> > +		};
> > +
> > +		axi2pico at c0000000 {
> > +			compatible = "picochip,axi2pico-pc3x2";
> > +			reg = <0xc0000000 0x10000>;
> > +			interrupts = <13 14 15 16 17 18 19 20 21>;
> > +		};
> > +	};
> > +};
> > diff --git a/arch/arm/boot/dts/picoxcell-pc3x3.dtsi b/arch/arm/boot/dts/picoxcell-pc3x3.dtsi
> 
> Mostly same comments apply here. All these bindings need documentation.

I followed prima2 as an example here where the device tree lists all of 
the devices but only the register and interrupt resources even if there 
aren't full drivers/bindings for them yet.  I could remove the unused 
peripherals for now if you think appropriate though.
