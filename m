From: dongas86@gmail.com (Dong Aisheng)
Date: Sat, 15 Apr 2017 00:00:17 +0800
Subject: [PATCH 6/8] ARM: dts: imx7d-sdb: Add GPIO expander node
In-Reply-To: <20170414034659.GH14915@dragon>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
 <20170413133242.5068-7-andrew.smirnov@gmail.com>
 <20170414034659.GH14915@dragon>
Message-ID: <20170414160017.GD1792@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 11:47:00AM +0800, Shawn Guo wrote:
> On Thu, Apr 13, 2017 at 06:32:40AM -0700, Andrey Smirnov wrote:
> > Add node for U38, a 74LV595PW serial-in shift register that acts as a
> > GPIO expander on the board.
> > 
> > Cc: yurovsky at gmail.com
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: devicetree at vger.kernel.org
> > Cc: linux-kernel at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  arch/arm/boot/dts/imx7d-sdb.dts | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
> > index 5be01a1..e0ff276 100644
> > --- a/arch/arm/boot/dts/imx7d-sdb.dts
> > +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> > @@ -52,6 +52,30 @@
> >  		reg = <0x80000000 0x80000000>;
> >  	};
> >  
> > +	spi4 {
> > +		compatible = "spi-gpio";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_spi1>;
> > +		status = "okay";
> 
> The 'status' is not needed in this case.
> 
> > +		gpio-sck = <&gpio1 13 0>;
> > +		gpio-mosi = <&gpio1 9 0>;
> > +		cs-gpios = <&gpio1 12 0>;
> > +		num-chipselects = <1>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		gpio_spi: gpio_spi at 0 {
> 
> gpio-expander might be a better node name?
> 
> > +			compatible = "fairchild,74hc595";
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			reg = <0>;
> > +			registers-number = <1>;
> > +			 /* Enable PERI_3V3, SENSOR_RST_B and HDMI_RST*/
> > +			registers-default = /bits/ 8 <0x74>;
> 
> I do not see this property is documented or supported by kernel.

It's FSL internal invented property to do some trick on register
intialization and should be dropped.

Regards
Dong Aisheng
