From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 21 Feb 2017 10:11:05 +0100
Subject: [PATCH v4 15/36] platform: add video-multiplexer subdevice driver
In-Reply-To: <20170219220237.GD32327@amd>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-16-git-send-email-steve_longerbeam@mentor.com>
 <20170219220237.GD32327@amd>
Message-ID: <1487668265.2331.23.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2017-02-19 at 23:02 +0100, Pavel Machek wrote:
> Hi!
> 
> > From: Philipp Zabel <p.zabel@pengutronix.de>
> > 
> > This driver can handle SoC internal and external video bus multiplexers,
> > controlled either by register bit fields or by a GPIO. The subdevice
> > passes through frame interval and mbus configuration of the active input
> > to the output side.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > --
> >
> 
> Again, this is slightly non-standard format. Normally changes from v1
> go below ---, but in your case it would cut off the signoff...
> 
> > diff --git a/Documentation/devicetree/bindings/media/video-multiplexer.txt b/Documentation/devicetree/bindings/media/video-multiplexer.txt
> > new file mode 100644
> > index 0000000..9d133d9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/video-multiplexer.txt
> > @@ -0,0 +1,59 @@
> > +Video Multiplexer
> > +=================
> > +
> > +Video multiplexers allow to select between multiple input ports. Video received
> > +on the active input port is passed through to the output port. Muxes described
> > +by this binding may be controlled by a syscon register bitfield or by a GPIO.
> > +
> > +Required properties:
> > +- compatible : should be "video-multiplexer"
> > +- reg: should be register base of the register containing the control bitfield
> > +- bit-mask: bitmask of the control bitfield in the control register
> > +- bit-shift: bit offset of the control bitfield in the control register
> > +- gpios: alternatively to reg, bit-mask, and bit-shift, a single GPIO phandle
> > +  may be given to switch between two inputs
> > +- #address-cells: should be <1>
> > +- #size-cells: should be <0>
> > +- port@*: at least three port nodes containing endpoints connecting to the
> > +  source and sink devices according to of_graph bindings. The last port is
> > +  the output port, all others are inputs.
> 
> At least three? I guess it is exactly three with the gpio?

Yes. With the mmio bitfield muxes there can be more.

> Plus you might want to describe which port correspond to which gpio
> state/bitfield values...
> 
> > +struct vidsw {
> 
> I knew it: it is secretely a switch! :-).

This driver started as a two-input gpio controlled bus switch.
I changed the name when adding support for bitfield controlled
multiplexers with more than two inputs.

> > +static void vidsw_set_active(struct vidsw *vidsw, int active)
> > +{
> > +	vidsw->active = active;
> > +	if (active < 0)
> > +		return;
> > +
> > +	dev_dbg(vidsw->subdev.dev, "setting %d active\n", active);
> > +
> > +	if (vidsw->field)
> > +		regmap_field_write(vidsw->field, active);
> > +	else if (vidsw->gpio)
> > +		gpiod_set_value(vidsw->gpio, active);
> 
>          else dev_err()...?

If neither field nor gpio are set, probe will have failed and this will
never be called.

> > +static int vidsw_async_init(struct vidsw *vidsw, struct device_node *node)
> > +{
> > +	struct device_node *ep;
> > +	u32 portno;
> > +	int numports;
> 
> numbports is int, so I guess portno should be, too?

We could change both to unsigned int, as both vidsw->num_pads and
endpoint.base.port are unsigned int, and they are only compared/assigned
to those and each other.

> > +		portno = endpoint.base.port;
> > +		if (portno >= numports - 1)
> > +			continue;
> 
     I. 
> > +	if (!pad) {
> > +		/* Mirror the input side on the output side */
> > +		cfg->type = vidsw->endpoint[vidsw->active].bus_type;
> > +		if (cfg->type == V4L2_MBUS_PARALLEL ||
> > +		    cfg->type == V4L2_MBUS_BT656)
> > +			cfg->flags = vidsw->endpoint[vidsw->active].bus.parallel.flags;
> > +	}
> 
> Will this need support for other V4L2_MBUS_ values?

To support CSI-2 multiplexers, yes.

> > +MODULE_AUTHOR("Sascha Hauer, Pengutronix");
> > +MODULE_AUTHOR("Philipp Zabel, Pengutronix");
> 
> Normally, MODULE_AUTHOR contains comma separated names of authors,
> perhaps with <email@addresses>. Not sure two MODULE_AUTHORs per file
> will work.
> 
> Thanks,
> 								Pavel

regards
Philipp
