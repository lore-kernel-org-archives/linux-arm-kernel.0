From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 14 Jul 2015 09:45:55 +0200
Subject: [PATCH v2 1/5] dt-bindings: Add usb3.0 phy binding for MT65xx SoCs
In-Reply-To: <1436854791.11289.11.camel@mhfsdcap03>
References: <1436348468-4126-1-git-send-email-chunfeng.yun@mediatek.com>
 <1436348468-4126-2-git-send-email-chunfeng.yun@mediatek.com>
 <20150710051018.GU18700@pengutronix.de>
 <1436854791.11289.11.camel@mhfsdcap03>
Message-ID: <20150714074555.GR18700@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 02:19:51PM +0800, chunfeng yun wrote:
> hi,
> On Fri, 2015-07-10 at 07:10 +0200, Sascha Hauer wrote:
> > On Wed, Jul 08, 2015 at 05:41:03PM +0800, Chunfeng Yun wrote:
> > > add a DT binding documentation of usb3.0 phy for MT65xx
> > > SoCs from Mediatek.
> > > 
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/usb/mt65xx-u3phy.txt       | 34 ++++++++++++++++++++++
> > >  1 file changed, 34 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/usb/mt65xx-u3phy.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/usb/mt65xx-u3phy.txt b/Documentation/devicetree/bindings/usb/mt65xx-u3phy.txt
> > > new file mode 100644
> > > index 0000000..056b2aa
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/usb/mt65xx-u3phy.txt
> > > @@ -0,0 +1,34 @@
> > > +MT65xx U3PHY
> > > +
> > > +The device node for Mediatek SOC usb3.0 phy
> > > +
> > > +Required properties:
> > > + - compatible : Should be "mediatek,mt8173-u3phy"
> > > + - reg        : Offset and length of registers, the first is for mac domain,
> > > +	another for phy domain
> > > + - power-domains: to enable usb's mtcmos
> > > + - usb-wakeup-ctrl : to access usb wakeup control register
> > > + - wakeup-src : 1: ip sleep wakeup mode; 2: line state wakeup mode; others
> > > +	means don't enable wakeup source of usb
> > > + - u2port-num : number of usb2.0 ports to support which should be 1 or 2
> > > + - clocks     : must support all clocks that phy need
> > > + - clock-names: should be "wakeup_deb_p0", "wakeup_deb_p1" for wakeup
> > > +	debounce control clocks, and "u3phya_ref" for u3phya reference clock.
> > > +
> > > +Example:
> > > +
> > > +u3phy: usb-phy at 11271000 {
> > > +	compatible = "mediatek,mt8173-u3phy";
> > > +	reg = <0 0x11271000 0 0x3000>,
> > > +	      <0 0x11280000 0 0x20000>;
> > 
> > 0x11271000 is the register space the xhci controller takes. You should
> > not expose the same register space to two different drivers.
> > 
> 
> usb: usb30 at 11270000 {
>    compatible = "mediatek,mt8173-xhci";
>    reg = <0 0x11270000 0 0x1000>;
> 
> the size of xhci register space is 0x1000, and the range is
> [0x11270000, 0x11271000 - 1], so the address of 0x11271000 is not
> included.

Indeed, you are right. Nevertheless my datasheet lists these resources:

0x11270000 - 0x1127ffff: SSUSB CSR
0x11280000 - 0x1128ffff: SSUSB SIF
0x11290000 - 0x1129ffff: SSUSB

It seems that with the current binding you are not modelling the
hardware but something that reflects your current implementation. This
is not a good sign. Normally I would expect device nodes that match the
above resources, but your USB phy spans most of the SSUSB CSR register
space and both the SSUSB SIF and SSUSB regster space. I think it would
be good if you could give an overview over the USB hardware and explain
why you have to violate the above resources.

Also something to consider: Is your binding suitable for adding OTG
support later? You don't have to add OTG support to the Kernel now,
but your binding should be suitable to add it later.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
