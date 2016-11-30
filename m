From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 30 Nov 2016 11:52:25 +0200
Subject: [PATCH v7 4/8] drm/sunxi: Add DT bindings documentation of
 Allwinner HDMI
In-Reply-To: <20161130102757.9eec1f7f3377d0f4787e3829@free.fr>
References: <cover.1480414715.git.moinejf@free.fr> <4614815.L3DQhhBy6d@avalon>
 <20161130102757.9eec1f7f3377d0f4787e3829@free.fr>
Message-ID: <3478036.d2UQM8n6lv@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Fran?ois,

On Wednesday 30 Nov 2016 10:27:57 Jean-Francois Moine wrote:
> On Wed, 30 Nov 2016 10:20:21 +0200 Laurent Pinchart wrote:
> >> Well, I don't see what this connector can be.
> >> May you give me a DT example?
> > 
> > Sure.
> > 
> > arch/arm/boot/dts/r8a7791-koelsch.dts
> > 
> >         /* HDMI encoder */
> >         
> >         hdmi at 39 {
> >                 compatible = "adi,adv7511w";
> >                 reg = <0x39>;
> >                 interrupt-parent = <&gpio3>;
> >                 interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
> >                 
> >                 adi,input-depth = <8>;
> >                 adi,input-colorspace = "rgb";
> >                 adi,input-clock = "1x";
> >                 adi,input-style = <1>;
> >                 adi,input-justification = "evenly";
> >                 
> >                 ports {
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;
> >                         
> >                         port at 0 {
> >                                 reg = <0>;
> >                                 adv7511_in: endpoint {
> >                                         remote-endpoint = <&du_out_rgb>;
> >                                 };
> >                         };
> >                         
> >                         port at 1 {
> >                                 reg = <1>;
> >                                 adv7511_out: endpoint {
> >                                         remote-endpoint = <&hdmi_con>;
> >                                 };
> >                         };
> >                 };
> >         
> >         };
> >         
> >         /* HDMI connector */
> >         
> >         hdmi-out {
> >                 compatible = "hdmi-connector";
> >                 type = "a";
> >                 
> >                 port {
> >                         hdmi_con: endpoint {
> >                                 remote-endpoint = <&adv7511_out>;
> >                         };
> >                 };
> >         };
> 
> Hi Laurent,
> 
> Sorry for I don't see the interest:
> - it is obvious that the HDMI connector is a 'hdmi-connector'!

It still has to be told to the drivers, they don't know how to identify a 
connector by looking at it :-)

> - the physical connector type may be changed on any board by a soldering
>   iron or a connector to connector cable.

Which is also true for any other component on the board. DT (and for that 
matter any firmware description of the platform) isn't soldering-proof.

> - what does the software do with the connector type?

That's up to the software to decide, the DT bindings should describe the 
hardware in the most accurate and usable way for the OS as possible. One of my 
longer term goals is to add connector drivers to handle DDC and HPD when 
they're not handled by the encoder (they are in the above example).

If the DDC was connected to a general-purpose I2C bus of the SoC, and the HPD 
to a GPIO, we would have

	hdmi-out {
		compatible = "hdmi-connector";
		type = "a";
		/* I2C bus and GPIO references are made up for the example */
		ddc-i2c-bus = <&i2c4>;
		hpd-gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>

		port {
			hdmi_con: endpoint {
				remote-endpoint = <&adv7511_out>;
			};
		};
	};

and both HPD and EDID reading should be handled by the connector driver.

> - why not to put the connector information in the HDMI device?

Because the connector is separate from the encoder. It's not uncommon 
(depending on the encoder type) to have the encoder output connected to a non-
connector entity such as another chained encoder.

For example most LVDS encoders are connected to a panel, but I have a board 
with the following encoders chain.

CRTC -- parallel RGB --> on-SoC LVDS encoder -- LVDS --> on-board LVDS decoder 
-- parallel RGB --> HDMI encoder -- HDMI --> HDMI connector

I can't support that if the LVDS encoder driver hardcodes the assumption that 
the encoder output is connected to a panel. This kind of usage might be less 
common for HDMI but is certainly not inconceivable.

> And, if I follow you, the graph of ports could also be used to describe
> the way the various parts of the SoCs are powered, to describe the pin
> connections, to describe the USB connectors, to describe the board
> internal hubs and bridges...

It should be used where applicable, it's not meant as the only possible 
hardware description for all pieces of the system.

-- 
Regards,

Laurent Pinchart
