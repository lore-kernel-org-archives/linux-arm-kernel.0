From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 12 Feb 2014 09:54:50 +0000
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Do not place regulator
 nodes under simple-bus
In-Reply-To: <20140212092227.GA24834@S2101-09.ap.freescale.net>
References: <1392165078-25794-1-git-send-email-festevam@gmail.com>
 <20140212092227.GA24834@S2101-09.ap.freescale.net>
Message-ID: <20140212095450.GB21992@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 09:22:30AM +0000, Shawn Guo wrote:
> On Tue, Feb 11, 2014 at 10:31:18PM -0200, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > According to Documentation/devicetree/bindings/regulator/regulator.txt 
> > regulator nodes should not be placed under 'simple-bus'.
> 
> I failed to read that statement from the binding doc.  Can you quote the
> doc specifically on that statement?

The statement is slightly wrong. Rather, regulators are not required to
be on a simple bus.

In this particular case the simple-bus is being used incorrectly. I
describe some of this in the link Fabio provided immediately below, and
I have further comments specific to this case.

> 
> > 
> > Mark Rutland also explains about it at:
> > http://www.spinics.net/lists/linux-usb/msg101497.html 
> >  
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> > Shawn,
> > 
> > I can convert other dts files if you are fine with this approach.
> 
> I take it as an unnecessary churn, unless I see the consensus from most
> of DT maintainers and arm-soc folks that we should make this change.
> And see comment below ...

My concern is that the simple-bus is being used in a nonsensical way,
with a meaningless address space and reg values on children. While this
currently works it is not correct, and it's not even necessary. I would
like to limit the misuse of these constructs so as to prevent others
from making the same mistakes.

> 
> > 
> >  arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 51 ++++++++++++++--------------------
> >  1 file changed, 21 insertions(+), 30 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > index 0d816d3..d7df5b2 100644
> > --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > @@ -18,38 +18,29 @@
> >  		reg = <0x10000000 0x40000000>;
> >  	};
> >  
> > -	regulators {
> > -		compatible = "simple-bus";
> > -		#address-cells = <1>;
> > -		#size-cells = <0>;
> > -
> > -		reg_usb_otg_vbus: regulator at 0 {
> > -			compatible = "regulator-fixed";
> > -			reg = <0>;
> > -			regulator-name = "usb_otg_vbus";
> > -			regulator-min-microvolt = <5000000>;
> > -			regulator-max-microvolt = <5000000>;
> > -			gpio = <&gpio3 22 0>;
> > -			enable-active-high;
> > -		};
> > +	reg_usb_otg_vbus: regulator at 0 {
> 
> nodename at num should only be used for nodes that have 'reg' property.
> Why are you dropping 'reg' property here?  Right, it does not compile if
> you do not drop it.  You can take it as a reason of why I endorse
> simple-bus regulators container.

I don't think the logical jump from "it does not compile" to "I endorse
simple-bus regulators container" makes any sense. They're two separate
issues.

The unit-addresses and reg values can be dropped. They are not in the
regulator-fixed binding, and were never necessary. All that's necessary
is a unique name, and unit-addresses (which required a reg) were misused
to provide uniqueness. With that fixed, this will compile.

The question to ask is what address space does the simple-bus represent?
The regulators never defined one in their binding, and the simple-bus is
missing a _required_ ranges property, so it's not in the MMIO space of
the parent. Yet somehow it has a single address cell and no size cells.

This is _clearly_ not a simple-bus. Either it needs to map to the parent
address space in some way (which would mean dropping the reg values and
unit addresses as they would be clearly wrong), or it needs to be
replaced by something that isn't a simple-bus. For the latter case that
would mean you couldn't have MMIO regulators in the same container as
fixed regulators, which would be a bit useless.

As far as I can see, a regulator container node is pointless. It
describes no topological information yet pretends to.

Mark.

> 
> Shawn
> 
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "usb_otg_vbus";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		gpio = <&gpio3 22 0>;
> > +		enable-active-high;
> > +	};
> >  
> > -		reg_usb_h1_vbus: regulator at 1 {
> > -			compatible = "regulator-fixed";
> > -			reg = <1>;
> > -			regulator-name = "usb_h1_vbus";
> > -			regulator-min-microvolt = <5000000>;
> > -			regulator-max-microvolt = <5000000>;
> > -			gpio = <&gpio1 29 0>;
> > -			enable-active-high;
> > -		};
> > +	reg_usb_h1_vbus: regulator at 1 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "usb_h1_vbus";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		gpio = <&gpio1 29 0>;
> > +		enable-active-high;
> > +	};
> >  
> > -		reg_audio: regulator at 2 {
> > -			compatible = "regulator-fixed";
> > -			reg = <2>;
> > -			regulator-name = "wm8962-supply";
> > -			gpio = <&gpio4 10 0>;
> > -			enable-active-high;
> > -		};
> > +	reg_audio: regulator at 2 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "wm8962-supply";
> > +		gpio = <&gpio4 10 0>;
> > +		enable-active-high;
> >  	};
> >  
> >  	gpio-keys {
> > -- 
> > 1.8.1.2
> > 
> 
> 
