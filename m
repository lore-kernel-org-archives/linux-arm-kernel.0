From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 11:40:27 +0000
Subject: [PATCH v3] ARM: SPEAr600: Add device-tree support to SPEAr600
 boards
In-Reply-To: <4F61CC81.1020902@st.com>
References: <1331808632-22585-1-git-send-email-sr@denx.de>
 <4F61CC81.1020902@st.com>
Message-ID: <201203151140.27453.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2012, Viresh Kumar wrote:
> On 3/15/2012 4:20 PM, Stefan Roese wrote:
> 
> > diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
> 
> > +/ {
> > +       compatible = "st,spear600";
> > +
> > +       cpus {
> > +               cpu at 0 {
> > +                       compatible = "arm,arm926ejs";
> > +               };
> > +       };
> > +
> > +       memory {
> > +               device_type = "memory";
> > +               reg = <0 0x40000000>; /* Real value updated by U-Boot */
> > +       };
> > +
> > +       ahb {
> 
> What is the significance of this name? As i see gpio/spi etc in this list,
> which are on apb bus.

That sounds like it should be corrected, the device tree should reflect
the physical hierarchy where possible, e.g.

	ahb0 {
		#address-cells = <1>;
		#size-cells = <1>;
		compatible = "simple-bus";
		ranges = <0xe0000000 0xe0000000 0x10000000>;

		ethernet at e0800000 {
			...
		};

		...
	};

	ahb1 {
		#address-cells = <1>;
		#size-cells = <1>;
		compatible = "simple-bus";
		ranges = <0xd0000000 0xd0000000 0x10000000>;
		ranges = <0xf0000000 0xf0000000 0x10000000>;

		apb {
			#address-cells = <1>;
			#size-cells = <1>;
			compatible = "simple-bus";
			ranges = <0x0 0xf0000000 0x10000000>;
	
			gpio at f0100000 {
				/* note: reg relative to local ranges property */
				reg = <0x100000 0x1000>;
				...
			};
			...
		};
		...


               i2c at d0200000 {
                        reg = <0xd0200000 0x1000>;
			...
               };

	};

I don't have the data sheet, so the bus hierarchy above is completely made up,
but I guess you get the idea. If each bus has its own local register range, it
may be helpful to use the ranges property to remap the reg properties in the
way that I did in the apb example above.

	Arnd
