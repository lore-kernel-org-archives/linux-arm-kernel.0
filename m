From: jacopo@jmondi.org (jacopo mondi)
Date: Fri, 20 Apr 2018 13:22:04 +0200
Subject: [PATCH v3 0/7] Add tda998x (HDMI) support to atmel-hlcdc
In-Reply-To: <6354350.l8DgUyNhLT@avalon>
References: <20180419162751.25223-1-peda@axentia.se>
 <20180420085235.GI4235@w540> <6354350.l8DgUyNhLT@avalon>
Message-ID: <20180420112204.GK4235@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Fri, Apr 20, 2018 at 01:18:13PM +0300, Laurent Pinchart wrote:
> Hello,
>
> On Friday, 20 April 2018 11:52:35 EEST jacopo mondi wrote:
> > Hi Peter,
> >     I've been a bit a pain in the arse for you recently, but please
> > bear with me a bit more, and sorry for jumping late on the band wagon.
> >
> > On Thu, Apr 19, 2018 at 06:27:44PM +0200, Peter Rosin wrote:
> > > Hi!
> > >
> > > I naively thought that since there was support for both nxp,tda19988 (in
> > > the tda998x driver) and the atmel-hlcdc, things would be a smooth ride.
> > > But it wasn't, so I started looking around and realized I had to fix
> > > things.
> > >
> > > In v1 and v2 I fixed things by making the atmel-hlcdc driver a master
> > > component, but now in v3 I fix things by making the tda998x driver
> > > a bridge instead. This was after a suggestion from Boris Brezillion
> > > (the atmel-hlcdc maintainer), so there was some risk of bias ... but
> > > after comparing what was needed, I too find the bridge approach better.
> > >
> > > In addition to the above, our PCB interface between the SAMA5D3 and the
> > > HDMI encoder is only using 16 bits, and this has to be described
> > > somewhere, or the atmel-hlcdc driver have no chance of selecting the
> > > correct output mode. Since I have similar problems with a ds90c185 lvds
> > > encoder I added patches to override the atmel-hlcdc output format via
> > > DT properties compatible with the media video-interface binding and
> > > things start to play together.
> > >
> > > Since this series superseeds the bridge series [1], I have included the
> > > leftover bindings patch for the ti,ds90c185 here.
> >
> > I feel like this series would look better if it would make use of the
> > proposed bridge media bus format support I have recently sent out [1]
> > (and which was not there when you first sent v1).
> >
> > I understand your fundamental problem here is that the bus format
> > that should be reported by your bridge is different from the ones
> > actually supported by the TDA19988 chip, as the wirings ground some
> > of the input pins.
> >
> > Although this is defintely something that could be described in the
> > bridge's own OF node with the 'bus_width' property, and what I would do,
> > now that you have made a bridge out from the tda19988 driver, is:
> >
> > 1) Set the bridge accepted input bus_format parsing its pin
> > configuration, or default it if that's not implemented yet.
> > This will likely be rgb888. You can do that using the trivial
> > support for bridge input image formats implemented by my series.
> > 2) Specify in the bridge endpoint a 'bus_width' of <16>
> > 3) In your atmel-hlcd get both the image format of the bridge (rgb888)
> > and parse the remote endpoint property 'bus_width' and get the <16>
> > value back.
>
> Parsing properties of remote nodes should be avoided as much as possible, as
> they need to be interpreted in the context of the DT bindings related to the
> compatible string applicable to that node. I'd rather have the bus_width
> property in the local endpoint node.

Right, I see...
Well, in Peter's case, the bus width, being a consequence of
wirings, can be described safely in both endpoints, right?

>
> > 4) Set the correct format in the atmel hlcd driver to accommodate a
> > bridge that wants rgb888 on a 16 bit wide bus (that would be rgb565,
> > or are there other possible combinations I am missing?)
> >
> > I would consider this better mostly because in this series you are
> > creating a semantic for the whole DRM subsystem on the 'bus_width'
> > property, where numerical values as '12', '16' etc are arbitrary tied
> > to the selection of a media bus format. At least you should use a
> > common set of defines [1] between the device tree and the driver,
> > but this looks anyway fragile imho.
>
> This I agree with though. Combining the remote bus format with the local bus
> width should fix the problem without having to parse remote properties.
>
> > Have I maybe missed some parts of the problem you are trying to solve
> > here?
> >
> > Thank you
> >    j
> >
> > [1] drm: bridge: Add support for static image formats
> >     https://lwn.net/Articles/752296/
> > [2] include/uapi/linux/media-bus-format.h
> >
> > > Anyway, this series solves some real issues for my HW.
> > >
> > > Cheers,
> > > Peter
> > >
> > > Changes since v2   https://lkml.org/lkml/2018/4/17/385
> > > - patch 2/7 fixed spelling and added an example
> > > - patch 4/7 parse the DT up front and store the result indexed by encoder
> > > - old patch 5/6 and 6/6 dropped
> > > - patch 5-7/7 are new and makes the tda998x driver a drm_bridge
> > >
> > > Changes since v1   https://lkml.org/lkml/2018/4/9/294
> > > - added reviewed-by from Rob to patch 1/6
> > > - patch 2/6 changed so that the bus format override is in the endpoint
> > >   DT node, and follows the binding of media video-interfaces.
> > > - patch 3/6 is new, it adds drm_of_media_bus_fmt which parses above
> > >   media video-interface binding (partially).
> > > - patch 4/6 now makes use of the above helper (and also fixes problems
> > >   with the 3/5 patch from v1 when no override was specified).
> > > - do not mention unrelated connector display_info details in the cover
> > >   letter and commit messages.
> > >
> > > [1]
> > > "Bridge" series v2   https://lkml.org/lkml/2018/3/26/610
> > > "Bridge" series v1   https://lkml.org/lkml/2018/3/17/221
> > >
> > > Peter Rosin (7):
> > >   dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
> > >   dt-bindings: display: atmel: optional video-interface of endpoints
> > >   drm: of: introduce drm_of_media_bus_fmt
> > >   drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
> > >   drm/i2c: tda998x: find the drm_device via the drm_connector
> > >   drm/i2c: tda998x: split encoder and component functions from the work
> > >   drm/i2c: tda998x: register as a drm bridge
> > >
> > >  .../devicetree/bindings/display/atmel/hlcdc-dc.txt |  26 +++
> > >  .../bindings/display/bridge/lvds-transmitter.txt   |   8 +-
> > >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |  71 ++++++--
> > >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |   2 +
> > >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   |  40 +++-
> > >  drivers/gpu/drm/drm_of.c                           |  38 ++++
> > >  drivers/gpu/drm/i2c/tda998x_drv.c                  | 201 ++++++++++++++--
> > >  include/drm/drm_of.h                               |   7 +
> > >  8 files changed, 342 insertions(+), 51 deletions(-)
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180420/d7a1c20c/attachment-0001.sig>
