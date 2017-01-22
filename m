From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Sun, 22 Jan 2017 10:50:19 +0800
Subject: [RESEND PATCH 6/6] dt-bindings: phy-mt65xx-usb: add support for
 mt2712 platform
In-Reply-To: <20170121200844.k5ivauhws43ac2s2@rob-hp-laptop>
References: <1484719214-11989-1-git-send-email-chunfeng.yun@mediatek.com>
 <1484719214-11989-6-git-send-email-chunfeng.yun@mediatek.com>
 <20170121200844.k5ivauhws43ac2s2@rob-hp-laptop>
Message-ID: <1485053419.10292.88.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-01-21 at 14:08 -0600, Rob Herring wrote:
> On Wed, Jan 18, 2017 at 02:00:14PM +0800, Chunfeng Yun wrote:
> > add a new compatible string for "mt2712", and a new reference clock
> > for SuperSpeed analog phy;
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  .../devicetree/bindings/phy/phy-mt65xx-usb.txt     |   81 +++++++++++++++++---
> >  1 file changed, 70 insertions(+), 11 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> > index 33a2b1e..8f91136 100644
> > --- a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> > +++ b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> > @@ -6,19 +6,25 @@ This binding describes a usb3.0 phy for mt65xx platforms of Medaitek SoC.
> >  Required properties (controller (parent) node):
> >   - compatible	: should be one of
> >  		  "mediatek,mt2701-u3phy"
> > +		  "mediatek,mt2712-u3phy"
> >  		  "mediatek,mt8173-u3phy"
> > - - reg		: offset and length of register for phy, exclude port's
> > -		  register.
> >   - clocks	: a list of phandle + clock-specifier pairs, one for each
> >  		  entry in clock-names
> >   - clock-names	: must contain
> > -		  "u3phya_ref": for reference clock of usb3.0 analog phy.
> > +		  "u2ref_clk": 48M reference clock of HighSpeed analog phy.
> > +		  "u3ref_clk": 26M reference clock of SuperSpeed analog phy,
> > +			sometimes is 24M, 25M or 27M, depended on platform.
> 
> _clk is redundant.
remove it
> 
> >  
> >  Required nodes	: a sub-node is required for each port the controller
> >  		  provides. Address range information including the usual
> >  		  'reg' property is used inside these nodes to describe
> >  		  the controller's topology.
> >  
> > +Optional properties (controller (parent) node):
> > + - reg		: offset and length of register shared by multiple ports,
> > +		  exclude port's private register. It is needed on mt2701
> > +		  and mt8173, but not on mt2712.
> > +
> >  Required properties (port (child) node):
> >  - reg		: address and length of the register set for the port.
> >  - #phy-cells	: should be 1 (See second example)
> > @@ -31,21 +37,27 @@ Example:
> >  u3phy: usb-phy at 11290000 {
> >  	compatible = "mediatek,mt8173-u3phy";
> >  	reg = <0 0x11290000 0 0x800>;
> > -	clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
> > -	clock-names = "u3phya_ref";
> > +	clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>, <&clk26m>;
> > +	clock-names = "u2ref_clk", "u3ref_clk";
> >  	#address-cells = <2>;
> >  	#size-cells = <2>;
> >  	ranges;
> >  	status = "okay";
> >  
> > -	phy_port0: port at 11290800 {
> > -		reg = <0 0x11290800 0 0x800>;
> > +	u2port0: port at 11290800 {
> 
> port is for OF graph. This should be usb-phy at ... instead.
Is there any problems if u2port0's name at addr is the same as its parent's
(u3phy)?  as following:
	u3phy: usb-phy at 11290000 {
		compatible = ...;
		// no reg property
		clocks = ...;
		u2port0: usb-phy at 11290000 {
			reg = ...;
	}

> 
> > +		reg = <0 0x11290800 0 0x100>;
> > +		#phy-cells = <1>;
> > +		status = "okay";
> > +	};
> > +
> > +	u3port0: port at 11290900 {
> > +		reg = <0 0x11290800 0 0x700>;
> >  		#phy-cells = <1>;
> >  		status = "okay";
> >  	};
> >  

> > +            ...

Thank you!
