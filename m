From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 8 Jan 2013 17:13:10 +0100
Subject: [PATCH] ARM: Kirkwood: convert ns2 boards to pinctrl
In-Reply-To: <20130108150907.GM1357@kw.sim.vm.gnt>
References: <1357655778-32066-1-git-send-email-simon.guinot@sequanux.org>
 <20130108144954.GC3392@lunn.ch>
 <20130108150907.GM1357@kw.sim.vm.gnt>
Message-ID: <20130108161310.GD3392@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 04:09:07PM +0100, Simon Guinot wrote:
> On Tue, Jan 08, 2013 at 03:49:54PM +0100, Andrew Lunn wrote:
> > On Tue, Jan 08, 2013 at 03:36:18PM +0100, Simon Guinot wrote:
> > > Note that the pinctrl conversion also fixes GPIO support for ns2 boards.
> > > Since commit f9e75922: "ARM: Kirkwood: Make use of mvebu pincltl and
> > > gpio", the mvbu_gpio driver is used for DT boards. As mvbu_gpio relies
> > > on the pinctrl driver, then a pinctrl definition must be given to allow
> > > the GPIO configuration.
> > > 
> > > Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> > > ---
> > >  arch/arm/boot/dts/kirkwood-ns2-common.dtsi |   16 ++++++++++++
> > >  arch/arm/mach-kirkwood/board-ns2.c         |   38 ----------------------------
> > >  2 files changed, 16 insertions(+), 38 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
> > > index 9bc6785..77d21ab 100644
> > > --- a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
> > > +++ b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
> > > @@ -1,4 +1,5 @@
> > >  /include/ "kirkwood.dtsi"
> > > +/include/ "kirkwood-6281.dtsi"
> > >  
> > >  / {
> > >  	chosen {
> > > @@ -6,6 +7,21 @@
> > >  	};
> > >  
> > >  	ocp at f1000000 {
> > > +		pinctrl: pinctrl at 10000 {
> > > +			pinctrl-0 = < &pmx_spi &pmx_twsi0 &pmx_uart0
> > > +					&pmx_ns2_sata0 &pmx_ns2_sata1>;
> > > +			pinctrl-names = "default";
> > > +
> > > +			pmx_ns2_sata0: pmx-ns2-sata0 {
> > > +				marvell,pins = "mpp21";
> > > +				marvell,function = "sata0";
> > > +			};
> > > +			pmx_ns2_sata1: pmx-ns2-sata1 {
> > > +				marvell,pins = "mpp20";
> > > +				marvell,function = "sata1";
> > > +			};
> > > +		};
> > 
> > Hi Simon
> > 
> > Its normal to also list all the gpio pins here as well. 
> 
> I was not sure about that. As gpio_request triggers the mpp
> configuration at run time, IMHO there is no point for an initial and
> statical configuration, except for a documentation purpose.

[Goes away and reads Docunmentation/gpio.txt]

Yes, you appear to be correct. Its not necessary. Don't know that.

     Andrew
