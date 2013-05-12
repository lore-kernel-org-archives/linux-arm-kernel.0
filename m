From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 12 May 2013 23:18:53 +0800
Subject: [PATCH 5/5] ARM: dts: add SPI/NOR for mx6q{dl}-sabreauto boards
In-Reply-To: <20130512144339.GD31135@pengutronix.de>
References: <1368070143-1655-1-git-send-email-b32955@freescale.com>
 <1368070143-1655-6-git-send-email-b32955@freescale.com>
 <20130512144339.GD31135@pengutronix.de>
Message-ID: <20130512151850.GA24494@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 12, 2013 at 04:43:39PM +0200, Sascha Hauer wrote:
> On Thu, May 09, 2013 at 11:29:03AM +0800, Huang Shijie wrote:
> > Since the SPI/NOR has pin conflict with the WEIM NOR,
> > we disable the spi/nor by default.
> > 
> > Signed-off-by: Huang Shijie <b32955@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi |   32 ++++++++++++++++++++++++++++++
> >  1 files changed, 32 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> > index 7b561fb..b6b9e56 100644
> > --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> > @@ -16,6 +16,38 @@
> >  	};
> >  };
> >  
> > +&ecspi1 {
> > +	fsl,spi-num-chipselects = <1>;
> > +	cs-gpios = <&gpio3 19 0>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_ecspi1_1>;
> > +	status = "disabled";
> > +
> > +	flash: m25p80 at 0 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		compatible = "st,m25p32";
> > +		spi-max-frequency = <20000000>;
> > +		reg = <0>;
> > +
> > +		partition at 0 {
> > +			label = "U-Boot";
> > +			reg = <0x0 0x40000>;
> > +		};
> > +
> > +		partition at 40000 {
> > +			label = "U-Boot-ENV";
> > +			reg = <0x40000 0x10000>;
> > +			read-only;
> > +		};
> > +
> > +		partition at 50000 {
> > +			label = "Kernel";
> > +			reg = <0x50000 0x3b0000>;
> > +		};
> 
> I really object to enforcing partition layouts in the devicetree. That's
> clearly usecase specific and should be filled by the bootloader. Having
> no partitions normally is not harmful, but having the wrong layout just
> because we start a mainline devicetree really can be harmful.

Ah, yes.  I recall the discussion you had with people a couple of weeks
ago.  I agreed with your opinion.  Just fixed it up with partition
layouts removed.

Shawn
