From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 08 Feb 2017 10:47:15 +0100
Subject: [PATCH v3 13/24] platform: add video-multiplexer subdevice driver
In-Reply-To: <20170207204617.GD13854@valkosipuli.retiisi.org.uk>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-14-git-send-email-steve_longerbeam@mentor.com>
 <20170207204617.GD13854@valkosipuli.retiisi.org.uk>
Message-ID: <1486547235.2309.15.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sakari,

On Tue, 2017-02-07 at 22:46 +0200, Sakari Ailus wrote:
> Hi Steve,
> 
> On Fri, Jan 06, 2017 at 06:11:31PM -0800, Steve Longerbeam wrote:
> > From: Philipp Zabel <p.zabel@pengutronix.de>
> > 
> > This driver can handle SoC internal and external video bus multiplexers,
> > controlled either by register bit fields or by a GPIO. The subdevice
> > passes through frame interval and mbus configuration of the active input
> > to the output side.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > 
> > --
> > 
> > - fixed a cut&paste error in vidsw_remove(): v4l2_async_register_subdev()
> >   should be unregister.
> > 
> > - added media_entity_cleanup() and v4l2_device_unregister_subdev()
> >   to vidsw_remove().
> > 
> > - there was a line left over from a previous iteration that negated
> >   the new way of determining the pad count just before it which
> >   has been removed (num_pads = of_get_child_count(np)).
> > 
> > - Philipp Zabel has developed a set of patches that allow adding
> >   to the subdev async notifier waiting list using a chaining method
> >   from the async registered callbacks (v4l2_of_subdev_registered()
> >   and the prep patches for that). For now, I've removed the use of
> >   v4l2_of_subdev_registered() for the vidmux driver's registered
> >   callback. This doesn't affect the functionality of this driver,
> >   but allows for it to be merged now, before adding the chaining
> >   support.
> > 
> > Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> > ---
> >  .../bindings/media/video-multiplexer.txt           |  59 +++
> >  drivers/media/platform/Kconfig                     |   8 +
> >  drivers/media/platform/Makefile                    |   2 +
> >  drivers/media/platform/video-multiplexer.c         | 472 +++++++++++++++++++++
> >  4 files changed, 541 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/video-multiplexer.txt
> >  create mode 100644 drivers/media/platform/video-multiplexer.c
> > 
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
> > +
> > +Example:
> > +
> > +syscon {
> > +	compatible = "syscon", "simple-mfd";
> > +
> > +	mux {
> 
> Could you use standardised properties for this, i.e. ones defined in
> Documentation/devicetree/bindings/media/video-interfaces.txt ?

What do you mean? Should we add the optional bus-width property to
describe the bit width of the parallel bus even though the driver
doesn't care about any of the properties?

> This is very similar to another patch "[PATCH] devicetree: Add video bus
> switch" posted by Pavel Machek recently. The problem with that is also
> similar than with this one: how to pass the CSI-2 bus configuration to the
> receiver.
>
> There's some discussion here:
> 
> <URL:http://www.spinics.net/lists/linux-media/msg109493.html>

[Added Sebastian do Cc:]

Yes, this is essentially the same driver, except that this driver also
handles MMIO-bitfield controlled muxes, and that the actual physical bus
(which the drivers currently don't care about) is MIPI CSI-2 in the
other case, and parallel this one.
They should probably be combined, or maybe split into two separate
drivers (MMIO controlled mux, GPIO controlled switch), possibly using
the same v4l2_subdev boilerplate.

> As Laurent already suggested, I think we should have a common solution for
> the problem that, besides conveying the bus parameters to the receiver, also
> encompasses CSI-2 virtual channels and data types.

Yes, that seems to be necessary, as certainly we can't configure the mux
output bus parameters in DT to a fixed setting.

> That would mean finishing the series of patches in the branch I believe
> Laurent already quoted here.

regards
Philipp
