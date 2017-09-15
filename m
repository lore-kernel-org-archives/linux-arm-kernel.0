From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Fri, 15 Sep 2017 15:12:04 +0000
Subject: [PATCH 6/8] ARM: dts: iwg20m: Add SPI NOR support
In-Reply-To: <20170915083517.GJ3924@verge.net.au>
References: <1505322341-9480-1-git-send-email-chris.paterson2@renesas.com>
 <1505322341-9480-7-git-send-email-chris.paterson2@renesas.com>
 <20170915083517.GJ3924@verge.net.au>
Message-ID: <TY1PR06MB070286FFE608AAB042B6E7DCB76C0@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Simon,

> From: devicetree-owner at vger.kernel.org [mailto:devicetree-
> owner at vger.kernel.org] On Behalf Of Simon Horman
> Sent: 15 September 2017 09:35
> 
> On Wed, Sep 13, 2017 at 06:05:39PM +0100, Chris Paterson wrote:
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >
> > Add support for the SPI NOR device used to boot up the system to the
> > System on Module DT.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> > ---
> > This patch is based on renesas-devel-20170913-v4.13.
> >
> > This patch is dependant on:
> > - "of: add vendor prefix for Silicon Storage Technology Inc."
> > - "doc: dt: mtd: Add sst25vf016b to the list of supported chip names"
> >
> >
> >  arch/arm/boot/dts/r8a7743-iwg20m.dtsi | 26
> ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
> > b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
> > index 4119737..75a8ca5 100644
> > --- a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
> > +++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
> > @@ -44,6 +44,11 @@
> >  		function = "mmc";
> >  	};
> >
> > +	qspi_pins: qspi {
> > +		groups = "qspi_ctrl", "qspi_data2";
> > +		function = "qspi";
> > +	};
> > +
> >  	sdhi0_pins: sd0 {
> >  		groups = "sdhi0_data4", "sdhi0_ctrl";
> >  		function = "sdhi0";
> > @@ -61,6 +66,27 @@
> >  	status = "okay";
> >  };
> >
> > +&qspi {
> > +	pinctrl-0 = <&qspi_pins>;
> > +	pinctrl-names = "default";
> > +
> > +	status = "okay";
> > +
> > +	/* WARNING - This device contains the bootloader. Handle with care.
> */
> > +	flash: flash at 0 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		compatible = "sst,sst25vf016b", "jedec,spi-nor";
> > +		reg = <0>;
> > +		spi-max-frequency = <50000000>;
> > +		spi-tx-bus-width = <1>;
> > +		spi-rx-bus-width = <1>;
> > +		m25p,fast-read;
> > +		spi-cpol;
> > +		spi-cpha;
> > +	};
> 
> Does the device have partitions?
> If so, should they be described here?

We aren't confident that all devices will come with the same partitions, so decided not to add any here.

Kind regards, Chris

> 
> > +};
> > +
> >  &sdhi0 {
> >  	pinctrl-0 = <&sdhi0_pins>;
> >  	pinctrl-names = "default";
> > --
> > 1.9.1
> >
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in the
> body of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
