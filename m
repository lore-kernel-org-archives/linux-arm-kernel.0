From: nicolas@ndufresne.ca (Nicolas Dufresne)
Date: Mon, 17 Jul 2017 10:45:10 -0400
Subject: [PATCH v2 2/6] [media] rockchip/rga: v4l2 m2m support
In-Reply-To: <11368407.z8bSoa2YAE@avalon>
References: <1500101920-24039-1-git-send-email-jacob-chen@iotwrt.com>
 <2363665.x6z9MR1vqI@avalon> <1500137353.2353.1.camel@ndufresne.ca>
 <11368407.z8bSoa2YAE@avalon>
Message-ID: <1500302710.21957.1.camel@ndufresne.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le lundi 17 juillet 2017 ? 05:37 +0300, Laurent Pinchart a ?crit :
> Hi Nicolas,
> 
> On Saturday 15 Jul 2017 12:49:13 Personnel wrote:
> 
> You might want to fix your mailer to use your name :-)
> 
> > Le samedi 15 juillet 2017 ? 12:42 +0300, Laurent Pinchart a ?crit :
> > > On Saturday 15 Jul 2017 14:58:36 Jacob Chen wrote:
> > > > Rockchip RGA is a separate 2D raster graphic acceleration unit. It
> > > > accelerates 2D graphics operations, such as point/line drawing, image
> > > > scaling, rotation, BitBLT, alpha blending and image blur/sharpness.
> > > > 
> > > > The drvier is mostly based on s5p-g2d v4l2 m2m driver.
> > > > And supports various operations from the rendering pipeline.
> > > > 
> > > >  - copy
> > > >  - fast solid color fill
> > > >  - rotation
> > > >  - flip
> > > >  - alpha blending
> > > 
> > > I notice that you don't support the drawing operations. How do you plan to
> > > support them later through the V4L2 M2M API ? I hate stating the obvious,
> > > but wouldn't the DRM API be better fit for a graphic accelerator ?
> > 
> > It could fit, maybe, but it really lacks some framework. Also, DRM is
> > not really meant for M2M operation, and it's also not great for multi-
> > process.
> 
> GPUs on embedded devices are mem-to-mem, and they're definitely shared between 
> multiple processes :-)
> 
> > Until recently, there was competing drivers for Exynos, both
> > implemented in V4L2 and DRM, for similar rational, all DRM ones are
> > being deprecated/removed.
> > 
> > I think 2D blitters in V4L2 are fine, but they terribly lack something
> > to differentiate them from converters/scalers when looking up the HW
> > list. Could be as simple as a capability flag, if I can suggest. For
> > the reference, the 2D blitter on IMX6 has been used to implement a live
> > video mixer in GStreamer.
> > 
> > https://bugzilla.gnome.org/show_bug.cgi?id=772766
> 
> If we decide that 2D blitters should be supported by V4L2 (and I'm open to get 
> convinced about that), we really need to define a proper API before merging a 
> bunch of drivers that will implement things in slightly different ways, 
> otherwise the future will be very painful.

Arguably, Jacob is not proposing anything new, as at least one other
driver has been merged.

> 
> Among the issues that need to be solved are
> 
> - stateful vs. stateless operation (as mentioned by Jacob in this mail 
> thread), a.k.a. the request API

Would it be possible to extend your thought. To me, Request API could
enable more use cases but is not strictly required.

> 
> - exposing capabilities to userspace (a single capability flag would be enough 
> only if all blitters expose the same API, which I'm not sure we can assume)

I am just rethinking this. With this patch series, Jacob is trying to
generalize the Blit Operation controls (still need a name, blend mode
does not work). We can easily make a recommendation to set the default
operation to a copy operation (drivers always support that). This way,
the node will behave like a converter (scaler, colorspace converter,
rotator and/or etc.) Checking the presence of that control, we can
clearly and quickly figure-out what this node is about. The capability
remains a nice idea, but probably optional.

I totally agree we should document the behaviours and rationals for
picking a certain default. The control should maybe become a "menu"
too, so each driver can cherry-pick the blit operations they support
(using int with min/max requires userspace trial and error, we already
did that mistake for encoders profiles and level).

> 
> - single input (a.k.a. in-place blitters as you mentioned below) vs. multiple 
> inputs

I do think the second is something you can build on top of the first by
cascading (what we do in the refereed GStreamer element). So far this
is applicable to Exynos, IMX6 and now Rockchip (probably more). The
"optimal" form for the second case seems like something that will be
implemented using much lower level kernel interface, like a GPU
programming interface (aka proprietary Adreno C2D API), or through
multiple nodes (multiple inputs and outputs). It's seems like the cut
between high-end and low-end.

> 
> - API for 2D-accelerated operations other than blitting (filling, point and 
> line drawing, ...)

I doubt such hardware exist in a form that is not bound to the GPU. I'm
not ignoring your point, there is a clear overlap between how we
integrated GPUs and having this into V4L2.

> 
> > > Additionally, V4L2 M2M has one source and one destination. How do you
> > > implement alpha blending in that case, which by definition requires at
> > > least two sources ?
> > 
> > This type of HW only do in-place blits. When using such a node, the
> > buffer queued on the V4L2_CAPTURE contains the destination image, and
> > the buffer queued on the V4L2_OUTPUT is the source image.
> > 
> > > > The code in rga-hw.c is used to configure regs accroding to operations.
> > > > 
> > > > The code in rga-buf.c is used to create private mmu table for RGA.
> > > > The tables is stored in a list, and be removed when buffer is cleanup.
> > > 
> > > Looking at the implementation it seems to be a scatter-gather list, not an
> > > MMU. Is that right ? Does the hardware documentation refer to it as an MMU
> > > ?
> > > 
> > > > Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
> > > > ---
> > > > 
> > > >  drivers/media/platform/Kconfig                |  11 +
> > > >  drivers/media/platform/Makefile               |   2 +
> > > >  drivers/media/platform/rockchip-rga/Makefile  |   3 +
> > > >  drivers/media/platform/rockchip-rga/rga-buf.c | 122 ++++
> > > >  drivers/media/platform/rockchip-rga/rga-hw.c  | 652 ++++++++++++++++++
> > > >  drivers/media/platform/rockchip-rga/rga-hw.h  | 437 ++++++++++++
> > > >  drivers/media/platform/rockchip-rga/rga.c     | 958 +++++++++++++++++++
> > > >  drivers/media/platform/rockchip-rga/rga.h     | 111 +++
> > > >  8 files changed, 2296 insertions(+)
> > > >  create mode 100644 drivers/media/platform/rockchip-rga/Makefile
> > > >  create mode 100644 drivers/media/platform/rockchip-rga/rga-buf.c
> > > >  create mode 100644 drivers/media/platform/rockchip-rga/rga-hw.c
> > > >  create mode 100644 drivers/media/platform/rockchip-rga/rga-hw.h
> > > >  create mode 100644 drivers/media/platform/rockchip-rga/rga.c
> > > >  create mode 100644 drivers/media/platform/rockchip-rga/rga.h
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170717/fe4b25c4/attachment.sig>
