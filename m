From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 30 Nov 2016 11:44:15 +0100
Subject: [PATCH v7 4/8] drm/sunxi: Add DT bindings documentation of
 Allwinner HDMI
In-Reply-To: <3478036.d2UQM8n6lv@avalon>
References: <cover.1480414715.git.moinejf@free.fr> <4614815.L3DQhhBy6d@avalon>
 <20161130102757.9eec1f7f3377d0f4787e3829@free.fr>
 <3478036.d2UQM8n6lv@avalon>
Message-ID: <20161130114415.2280151e2965280733a629e5@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Nov 2016 11:52:25 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Jean-Fran?ois,
> 
> On Wednesday 30 Nov 2016 10:27:57 Jean-Francois Moine wrote:
> > On Wed, 30 Nov 2016 10:20:21 +0200 Laurent Pinchart wrote:
> > >> Well, I don't see what this connector can be.
> > >> May you give me a DT example?
> > > 
> > > Sure.
> > > 
> > > arch/arm/boot/dts/r8a7791-koelsch.dts
> > > 
> > >         /* HDMI encoder */
	[snip]
> > >         /* HDMI connector */
> > >         
> > >         hdmi-out {
> > >                 compatible = "hdmi-connector";
> > >                 type = "a";
> > >                 
> > >                 port {
> > >                         hdmi_con: endpoint {
> > >                                 remote-endpoint = <&adv7511_out>;
> > >                         };
> > >                 };
> > >         };
	[snip]
> > - what does the software do with the connector type?
> 
> That's up to the software to decide, the DT bindings should describe the 
> hardware in the most accurate and usable way for the OS as possible. One of my 
> longer term goals is to add connector drivers to handle DDC and HPD when 
> they're not handled by the encoder (they are in the above example).
> 
> If the DDC was connected to a general-purpose I2C bus of the SoC, and the HPD 
> to a GPIO, we would have
> 
> 	hdmi-out {
> 		compatible = "hdmi-connector";
> 		type = "a";
> 		/* I2C bus and GPIO references are made up for the example */
> 		ddc-i2c-bus = <&i2c4>;
> 		hpd-gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>
> 
> 		port {
> 			hdmi_con: endpoint {
> 				remote-endpoint = <&adv7511_out>;
> 			};
> 		};
> 	};
> 
> and both HPD and EDID reading should be handled by the connector driver.
	[snip]

Hi Laurent,

OK. I understand. This connector complexity should be added in all DTs,
and the same code would be used.

Actually, for component binding, I use drm_of_component_probe():

- from the DRM master, loop on the "ports" phandle array and bind the
  CRTCs,

- for each CRTC, loop on the first remote port level and bind the
  encoders/connectors

Now, this should be:

- from the DRM master, loop on the first remote ports level and bind
  the CRTCs,

- for each CRTC, loop on the second remote port level and bind the
  encoders (and bridges?),

- for each encoder, loop on the third remote port level and bind the
  connectors.

Then, it would be nice to have a generic function for doing this job.

Otherwise, from your description:

> 	hdmi-out {
> 		compatible = "hdmi-connector";
> 		type = "a";
> 		/* I2C bus and GPIO references are made up for the example */
> 		ddc-i2c-bus = <&i2c4>;
> 		hpd-gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>

the "hdmi-connector" is a big piece of software. It must handle a lot
of more and more exotic connectors.
So, I hope that you have written a "simple-hdmi-connector" which does
nothing but setting the connector type.
Where is it?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
