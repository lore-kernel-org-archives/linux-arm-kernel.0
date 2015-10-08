From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Thu, 8 Oct 2015 19:27:39 +0800
Subject: [PATCH v9 1/5] dt-bindings: Add usb3.0 phy binding for MT65xx SoCs
In-Reply-To: <560AA37E.2090106@cogentembedded.com>
References: <1443495698-32233-1-git-send-email-chunfeng.yun@mediatek.com>
 <1443495698-32233-2-git-send-email-chunfeng.yun@mediatek.com>
 <560AA37E.2090106@cogentembedded.com>
Message-ID: <1444303659.26198.1.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Tue, 2015-09-29 at 17:43 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 09/29/2015 06:01 AM, Chunfeng Yun wrote:
> 
> > add a DT binding documentation of usb3.0 phy for MT65xx
> > SoCs from Mediatek.
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >   .../devicetree/bindings/phy/phy-mt65xx-usb.txt     | 68 ++++++++++++++++++++++
> >   1 file changed, 68 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> >
> > diff --git a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> > new file mode 100644
> > index 0000000..00100cf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> > @@ -0,0 +1,68 @@
> > +mt65xx USB3.0 PHY binding
> > +--------------------------
> > +
> > +This binding describes a usb3.0 phy for mt65xx platforms of Medaitek SoC.
> > +
> > +Required properties (controller (parent) node):
> > + - compatible	: should be "mediatek,mt8173-u3phy"
> > + - reg		: offset and length of register for phy, exclude port's
> > +		  register.
> > + - clocks	: a list of phandle + clock-specifier pairs, one for each
> > +		  entry in clock-names
> > + - clock-names	: must contain
> > +		  "u3phya_ref": for reference clock of usb3.0 analog phy.
> > +
> > +Required nodes	: a sub-node is required for each port the controller
> > +		  provides. Address range information including the usual
> > +		  'reg' property is used inside these nodes to describe
> > +		  the controller's topology.
> > +
> > +Required properties (port (child) node):
> > +- reg		: address and length of the register set for the port.
> > +- #phy-cells	: should be 1 (See second example)
> > +		  cell after port phandle is phy type from:
> > +			- PHY_TYPE_USB2
> > +			- PHY_TYPE_USB3
> > +
> > +Example:
> > +
> > +u3phy: usb-phy at 11290000 {
> > +	compatible = "mediatek,mt8173-u3phy";
> > +	reg = <0 0x11290000 0 0x800>;
> > +	clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
> > +	clock-names = "u3phya_ref";
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +	ranges;
> 
>     You don't describe the above 3 props neither as mandatory nor optional.
> 
I will describe them as mandatory properties later.

> [...]
> > +Specifying phy control of devices
> > +---------------------------------
> > +
> > +Device nodes should specify the configuration required in their "phys"
> > +property, containing a phandle to the phy port node and a device type;
> > +phy-names for each port are optional.
> > +
> > +Example:
> > +
> > +#include <dt-bindings/phy/phy.h>
> > +
> > +usb30: usb at 11270000 {
> > +	...
> > +	phys = <&phy_port0 PHY_TYPE_USB3>;
> > +	phy-names = "usb3-0";
> > +	...
> > +};
> 
>     Isn't the above already described in 
> Documentation/devicetree/bindings/phy/phy-bindings.txt?
> 
The usage is already described in phy-bindings.txt.
But many phy binding documents include a simple example, so I add it
too.

Thanks a lot

> MBR, Sergei
> 
