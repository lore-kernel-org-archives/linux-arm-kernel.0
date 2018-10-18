From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 18 Oct 2018 18:00:05 +0800
Subject: [PATCH 4/9] dt-bindings: Add ANX6345 DP/eDP transmitter binding
In-Reply-To: <1886367.eljNk7jKYl@avalon>
References: <20181018073327.64942-1-icenowy@aosc.io>
 <20181018073327.64942-5-icenowy@aosc.io> <1886367.eljNk7jKYl@avalon>
Message-ID: <c68f0da9607805e1f6673a9a16a7dcfff4d8fe91.camel@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2018-10-18?? 11:53 +0300?Laurent Pinchart???
> Hi Icenowy,
> 
> Thank you for the patch.
> 
> On Thursday, 18 October 2018 10:33:22 EEST Icenowy Zheng wrote:
> > The ANX6345 is an ultra-low power DisplayPort/eDP transmitter
> > designed
> > for portable devices.
> > 
> > Add a binding document for it.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> >  .../bindings/display/bridge/anx6345.txt       | 39
> > +++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/display/bridge/anx6345.txt
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> > b/Documentation/devicetree/bindings/display/bridge/anx6345.txt new
> > file
> > mode 100644
> > index 000000000000..0689d4eb5f65
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> > @@ -0,0 +1,39 @@
> > +Analogix ANX6345 eDP Transmitter
> > +--------------------------------
> > +
> > +The ANX6345 is an ultra-low power Full-HD eDP transmitter designed
> > for
> > +portable devices.
> > +
> > +Required properties:
> > +
> > + - compatible		: "analogix,anx6345"
> > + - reg			: I2C address of the device
> > + - reset-gpios		: Which GPIO to use for reset
> > +
> > +Optional properties:
> > +
> > + - dvdd12-supply	: Regulator for 1.2V digital core power.
> > + - dvdd25-supply	: Regulator for 2.5V digital core power.
> 
> Shouldn't these to supplies be mandatory ?

Yes they should.

> 
> > + - panel-supply		: Regulator for the power of the panel.
> 
> Shouldn't the panel supply for specified in the DT node of the panel
> ?

However, eDP panel can be probed, may vary on the same device, and we
don't have a generic binding for it...

> 
> > + - edid			: verbatim EDID data block describing
> > attached
> > +			  panel, only used when the panel has no EDID
> > info.
> 
> This should also be specified in the panel DT node.
> 
> > + - Video port for RGB input, using the DT bindings defined in [1].
> 
> I think you should also add a port for the output.

What will it point to?

> 
> > +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> > +
> > +Example:
> > +
> > +anx6345: anx6345 at 38 {
> > +	compatible = "analogix,anx6345";
> > +	reg = <0x38>;
> > +	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
> > +	panel-supply = <&reg_dc1sw>;
> > +	dvdd25-supply = <&reg_dldo2>;
> > +	dvdd12-supply = <&reg_fldo1>;
> > +
> > +	port {
> > +		anx6345_in: endpoint {
> > +			remote-endpoint = <&tcon0_out_anx6345>;
> > +		};
> > +	};
> > +};
> 
> 
