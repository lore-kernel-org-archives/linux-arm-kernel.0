From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 19 Jan 2017 15:34:06 +0100
Subject: [PATCH] ARM: dts: imx6q-utilite-pro: enable 2nd display pipeline
In-Reply-To: <17a7f9cea35944288f97735e66859929@rwthex-s1-b.rwth-ad.de>
References: <ec9676f344eb4786a28a3c7b969f0e94@rwthex-s1-b.rwth-ad.de>
 <88bdfd5321484efc82af4132ac2f0d7e@rwthex-s1-b.rwth-ad.de>
 <6ed3f695104044f18e98fc9619aab16e@rwthex-s1-b.rwth-ad.de>
 <17a7f9cea35944288f97735e66859929@rwthex-s1-b.rwth-ad.de>
Message-ID: <1484836446.2989.18.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On Wed, 2017-01-18 at 23:20 +0100, Christopher Spinrath wrote:
> Hi Philipp,
> 
> turns out I have a question on your comment after all:
> 
> On 01/17/2017 07:35 PM, Christopher Spinrath wrote:
> > Hi Philipp,
> >
> > thanks for the review!
> >
> > On 01/17/2017 09:57 AM, Philipp Zabel wrote:
> >> [...]
> >>> +
> >>> +    parallel-display {
> >>> +        compatible = "fsl,imx-parallel-display";
> >>> +        #address-cells = <1>;
> >>> +        #size-cells = <0>;
> >>> +        pinctrl-names = "default";
> >>> +        pinctrl-0 = <&pinctrl_ipu1>;
> >>> +
> >>> +        interface-pix-fmt = "rgb24";
> >>
> >> This is not necessary if the connector created by the tpf410 has the
> >> correct media bus format set in its display_info structure. This can be
> >> done in tfp410_attach, before calling drm_mode_connector_attach_encoder:
> >>
> >>         u32 bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> >>
> >>     drm_display_info_set_bus_formats(&dvi->connector.display_info,
> >>                      &bus_format, 1);
> >>
> >> After this is done, the above line should be removed in a follow-up
> >> patch.
> 
> On closer inspection the tfp410 can handle rgb12, rgb24, and DVI 
> formats. Considering this it feels wrong to hardcode the bus format to 
> rgb24 (isn't it?).

That is a good point, I agree. I have some thoughts on this:

> So a solution might be to add a property specifying the bus format to 
> the tfp410 binding. But then we would effectively just move this 
> property from one node to another. I wonder if this is still desireable...?

If this is configurable on both ends, the necessary setting is neither a
hardware property of the bridge, nor of the display interface, but
rather one of the board specific wiring between the two (if at all).

Ideally all possible settings should be known to the drivers and the
best format should be negotiated. Note that display_info.bus_formats
already is an array of possible bus formats, even though the parallel
display driver currently only looks at the first element.

If there is no limitation imposed by the wiring, presenting best format
first in that array seems reasonable for now.

Otherwise I think the links should describe the parallel bus layout,
which is specified for the (input) media video interfaces:

Documentation/devicetree/bindings/media/video-interfaces.txt

Using the
	bus-width = <24>;
or
	bus-width = <12>;
property the tfp510 driver could choose which bus_formats to add to the
display_info.

regards
Philipp
