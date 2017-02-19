From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 19 Feb 2017 23:02:37 +0100
Subject: [PATCH v4 15/36] platform: add video-multiplexer subdevice driver
In-Reply-To: <1487211578-11360-16-git-send-email-steve_longerbeam@mentor.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-16-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170219220237.GD32327@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> This driver can handle SoC internal and external video bus multiplexers,
> controlled either by register bit fields or by a GPIO. The subdevice
> passes through frame interval and mbus configuration of the active input
> to the output side.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> --
>

Again, this is slightly non-standard format. Normally changes from v1
go below ---, but in your case it would cut off the signoff...

> diff --git a/Documentation/devicetree/bindings/media/video-multiplexer.txt b/Documentation/devicetree/bindings/media/video-multiplexer.txt
> new file mode 100644
> index 0000000..9d133d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/video-multiplexer.txt
> @@ -0,0 +1,59 @@
> +Video Multiplexer
> +=================
> +
> +Video multiplexers allow to select between multiple input ports. Video received
> +on the active input port is passed through to the output port. Muxes described
> +by this binding may be controlled by a syscon register bitfield or by a GPIO.
> +
> +Required properties:
> +- compatible : should be "video-multiplexer"
> +- reg: should be register base of the register containing the control bitfield
> +- bit-mask: bitmask of the control bitfield in the control register
> +- bit-shift: bit offset of the control bitfield in the control register
> +- gpios: alternatively to reg, bit-mask, and bit-shift, a single GPIO phandle
> +  may be given to switch between two inputs
> +- #address-cells: should be <1>
> +- #size-cells: should be <0>
> +- port@*: at least three port nodes containing endpoints connecting to the
> +  source and sink devices according to of_graph bindings. The last port is
> +  the output port, all others are inputs.

At least three? I guess it is exactly three with the gpio?

Plus you might want to describe which port correspond to which gpio
state/bitfield values...

> +struct vidsw {

I knew it: it is secretely a switch! :-).

> +static void vidsw_set_active(struct vidsw *vidsw, int active)
> +{
> +	vidsw->active = active;
> +	if (active < 0)
> +		return;
> +
> +	dev_dbg(vidsw->subdev.dev, "setting %d active\n", active);
> +
> +	if (vidsw->field)
> +		regmap_field_write(vidsw->field, active);
> +	else if (vidsw->gpio)
> +		gpiod_set_value(vidsw->gpio, active);

         else dev_err()...?
	 
> +static int vidsw_async_init(struct vidsw *vidsw, struct device_node *node)
> +{
> +	struct device_node *ep;
> +	u32 portno;
> +	int numports;

numbports is int, so I guess portno should be, too?

> +		portno = endpoint.base.port;
> +		if (portno >= numports - 1)
> +			continue;


> +	if (!pad) {
> +		/* Mirror the input side on the output side */
> +		cfg->type = vidsw->endpoint[vidsw->active].bus_type;
> +		if (cfg->type == V4L2_MBUS_PARALLEL ||
> +		    cfg->type == V4L2_MBUS_BT656)
> +			cfg->flags = vidsw->endpoint[vidsw->active].bus.parallel.flags;
> +	}

Will this need support for other V4L2_MBUS_ values?

> +MODULE_AUTHOR("Sascha Hauer, Pengutronix");
> +MODULE_AUTHOR("Philipp Zabel, Pengutronix");

Normally, MODULE_AUTHOR contains comma separated names of authors,
perhaps with <email@addresses>. Not sure two MODULE_AUTHORs per file
will work.

Thanks,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170219/3eb79876/attachment.sig>
