From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sun, 18 Sep 2016 13:04:17 +0300
Subject: [PATCH v3 1/4] drm/bridge: Add RGB to VGA bridge support
In-Reply-To: <2115773.yQojqqIjGI@avalon>
References: <20160908121751.16911-1-maxime.ripard@free-electrons.com>
 <20160908121751.16911-2-maxime.ripard@free-electrons.com>
 <2115773.yQojqqIjGI@avalon>
Message-ID: <1682784.hDdFQltm22@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 18 Sep 2016 13:01:16 Laurent Pinchart wrote:
> On Thursday 08 Sep 2016 14:17:48 Maxime Ripard wrote:
> > Some boards have an entirely passive RGB to VGA bridge, based on either
> > DACs or resistor ladders.
> > 
> > Those might or might not have an i2c bus routed to the VGA connector in
> > order to access the screen EDIDs.
> > 
> > Add a bridge that doesn't do anything but expose the modes available on
> > the screen, either based on the EDIDs if available, or based on the XGA
> > standards.
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> > 
> >  .../bindings/display/bridge/rgb-to-vga-bridge.txt  |  52 +++++
> >  drivers/gpu/drm/bridge/Kconfig                     |   6 +
> >  drivers/gpu/drm/bridge/Makefile                    |   1 +
> >  drivers/gpu/drm/bridge/rgb-to-vga.c                | 232 ++++++++++++++++
> >  4 files changed, 291 insertions(+)
> >  create mode 100644
> > 
> > Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
> > create mode 100644 drivers/gpu/drm/bridge/rgb-to-vga.c
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
> > b/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
> > new file mode 100644
> > index 000000000000..83a053fb51a0
> > --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
> > @@ -0,0 +1,52 @@
> > +Passive RGB to VGA bridge
> > +-------------------------
> > +
> > +This binding is aimed for entirely passive RGB to VGA bridges that do not
> > +require any configuration.
> 
> Couldn't it also support active RGB to VGA bridges that don't require any
> configuration ? It would seem a bit pointless to define a separate DT
> binding for them.

I'm thinking in particular about the ADV7123 
(http://www.analog.com/media/en/technical-documentation/data-sheets/ADV7123.pdf) that already has a DT binding. Would it be feasible to 
combine the two, and support both devices with a single driver ?

> > +Required properties:
> > +
> > +- compatible: Must be "rgb-to-vga-bridge"
> > +
> > +Required nodes:
> > +
> > +This device has two video ports. Their connections are modeled using the
> > OF +graph bindings specified in
> > Documentation/devicetree/bindings/graph.txt. +
> > +- Video port 0 for RGB input
> > +- Video port 1 for VGA output
> > +
> > +
> > +Example
> > +-------
> > +
> > +bridge {
> > +	compatible = "rgb-to-vga-bridge";
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +
> > +	ports {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		port at 0 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			reg = <0>;
> > +
> > +			vga_bridge_in: endpoint {
> > +				remote-endpoint = <&tcon0_out_vga>;
> > +			};
> > +		};
> > +
> > +		port at 1 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			reg = <1>;
> > +
> > +			vga_bridge_out: endpoint {
> > +				remote-endpoint = <&vga_con_in>;
> > +			};
> > +		};
> > +	};
> > +};

-- 
Regards,

Laurent Pinchart
