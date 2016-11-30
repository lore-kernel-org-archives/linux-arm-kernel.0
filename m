From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 30 Nov 2016 10:20:21 +0200
Subject: [PATCH v7 4/8] drm/sunxi: Add DT bindings documentation of
 Allwinner HDMI
In-Reply-To: <20161130091208.f38cd79f1cc5d27b27f3b130@free.fr>
References: <cover.1480414715.git.moinejf@free.fr> <4502748.8rUF7ESxa4@avalon>
 <20161130091208.f38cd79f1cc5d27b27f3b130@free.fr>
Message-ID: <4614815.L3DQhhBy6d@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Fran?ois,

On Wednesday 30 Nov 2016 09:12:08 Jean-Francois Moine wrote:
> On Tue, 29 Nov 2016 22:10:01 +0200 Laurent Pinchart wrote:
> > On Tuesday 29 Nov 2016 21:04:55 Jean-Francois Moine wrote:
> >> On Tue, 29 Nov 2016 21:33 +0200 Laurent Pinchart wrote:
> >>>>> You need a third port for the HDMI encoder output, connected to an
> >>>>> HDMI connector DT node.
> >>>> 
> >>>> I don't see what you mean. The HDMI device is both the encoder
> >>> 
> >>>> and connector (as the TDA998x):
> >>> The driver might create both an encoder and a connector, but I very
> >>> much doubt that the "allwinner,sun8i-a83t-hdmi" hardware contains a
> >>> connector, unless the SoC package has an HDMI connector coming out of
> >>> it :-)
> >>> 
> >>>> plane -> DE2 mixer ---> TCON -----> HDMI -----> display device
> >>>> ----- plane ------    - CRTC -   - encoder  \
> >>>>                                    connector -- (HDMI cable)
> >>>>          audio-controller -   - audio-codec /
> >> 
> >> The schema is the same as the Dove Cubox: the TDA998x is just a chip
> >> with some wires going out and the physical connector is supposed to be
> >> at the end of the wires.
> > 
> > I've missed the Dove Cubox DT bindings when they were submitted.
> > Fortunately (or unfortunately for you, depending on how you look at it
> > ;-)) I've paid more attention this time.
> > 
> >> Here, the HDMI pins of the SoC go to a pure hardware chip and then to
> >> the physical connector. Which software entity do you want to add?
> > 
> > I don't want to add a software entity, I just want to model the connector
> > in DT as it's present in the system. Even though that's more common for
> > other bus types than HDMI (LVDS for instance) it wouldn't be
> > inconceivable to connect the HDMI signals to an on-board chim instead of
> > an HDMI connector, so the HDMI encoder output should be modelled by a
> > port and connected to a connector DT node in this case.
> 
> Well, I don't see what this connector can be.
> May you give me a DT example?

Sure.

arch/arm/boot/dts/r8a7791-koelsch.dts

        /* HDMI encoder */

        hdmi at 39 {
                compatible = "adi,adv7511w";
                reg = <0x39>;
                interrupt-parent = <&gpio3>;
                interrupts = <29 IRQ_TYPE_LEVEL_LOW>;

                adi,input-depth = <8>;
                adi,input-colorspace = "rgb";
                adi,input-clock = "1x";
                adi,input-style = <1>;
                adi,input-justification = "evenly";

                ports {
                        #address-cells = <1>;
                        #size-cells = <0>;

                        port at 0 {
                                reg = <0>;
                                adv7511_in: endpoint {
                                        remote-endpoint = <&du_out_rgb>;
                                };
                        };

                        port at 1 {
                                reg = <1>;
                                adv7511_out: endpoint {
                                        remote-endpoint = <&hdmi_con>;
                                };
                        };
                };
        };

        /* HDMI connector */

        hdmi-out {
                compatible = "hdmi-connector";
                type = "a";

                port {
                        hdmi_con: endpoint {
                                remote-endpoint = <&adv7511_out>;
                        };
                };
        };

-- 
Regards,

Laurent Pinchart
