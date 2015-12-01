From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 1 Dec 2015 13:54:09 +0100
Subject: [PATCH v2 03/10] drm/hisilicon: Add hisilicon DRM master driver
In-Reply-To: <CAGd==07=HgFjRRW6b8xEKHOTwc+Fs+=Zy2LbNL1NoS+M2DyfLQ@mail.gmail.com>
References: <CACvgo51NJNRKObgExtv=vNJ10GSgDPz=nQs=4BHAcgqPpSB_ug@mail.gmail.com>
 <20151130074603.GE17050@phenom.ffwll.local>
 <CAGd==07=HgFjRRW6b8xEKHOTwc+Fs+=Zy2LbNL1NoS+M2DyfLQ@mail.gmail.com>
Message-ID: <20151201125409.GS17050@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 06:52:20PM +0800, Xinliang Liu wrote:
> On 30 November 2015 at 15:46, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Sat, Nov 28, 2015 at 03:25:35PM +0000, Emil Velikov wrote:
> >> Hi Xinliang,
> >>
> >> On 28 November 2015 at 10:38, Xinliang Liu <xinliang.liu@linaro.org> wrote:
> >> > Add DRM master driver for hi6220 SoC which used in HiKey board.
> >> > Add dumb buffer feature.
> >> > Add prime dmabuf feature.
> >> >
> >> > Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
> >> > Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> >> > Signed-off-by: Andy Green <andy.green@linaro.org>
> >> Your s-o-b should be the bottom of the list. There was a presentation
> >> (ages ago) from Greg KH, who nicely described the order as a "chain of
> >> command" or "guilt path". Looks like the rest of the series could use
> >> this tweak.
> >>
> >> > ---
> >> >  drivers/gpu/drm/Kconfig                  |   2 +
> >> >  drivers/gpu/drm/Makefile                 |   1 +
> >> >  drivers/gpu/drm/hisilicon/Kconfig        |   9 ++
> >> >  drivers/gpu/drm/hisilicon/Makefile       |   3 +
> >> >  drivers/gpu/drm/hisilicon/hisi_drm_drv.c | 214 +++++++++++++++++++++++++++++++
> >> >  5 files changed, 229 insertions(+)
> >> >  create mode 100644 drivers/gpu/drm/hisilicon/Kconfig
> >> >  create mode 100644 drivers/gpu/drm/hisilicon/Makefile
> >> >  create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_drv.c
> >> >
> >> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> >> > index 8773fad..038aae8 100644
> >> > --- a/drivers/gpu/drm/Kconfig
> >> > +++ b/drivers/gpu/drm/Kconfig
> >> > @@ -274,3 +274,5 @@ source "drivers/gpu/drm/amd/amdkfd/Kconfig"
> >> >  source "drivers/gpu/drm/imx/Kconfig"
> >> >
> >> >  source "drivers/gpu/drm/vc4/Kconfig"
> >> > +
> >> > +source "drivers/gpu/drm/hisilicon/Kconfig"
> >> I could swear that we can a patch that sorts these alphabetically,
> >> although it doesn't seem to have made it upstream yet :-(
> >>
> >> > --- /dev/null
> >> > +++ b/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
> >>
> >> > +static int hisi_drm_load(struct drm_device *dev, unsigned long flags)
> >> > +{
> >> The use of .load (and .unload?) callbacks is not recommended. Take a
> >> look at Laurent Pinchart's patch [1] about the whys and hows on the
> >> topic
> >>
> >> > +static struct dma_buf *hisi_gem_prime_export(struct drm_device *dev,
> >> > +                                            struct drm_gem_object *obj,
> >> > +                                            int flags)
> >> > +{
> >> > +       /* we want to be able to write in mmapped buffer */
> >> > +       flags |= O_RDWR;
> >> Erm... something feels fishy here. Out of the existing 15 drivers
> >> setting up the prime callbacks only one (sti) does a similar thing. So
> >> either everyone else is missing something obvious or hisilicon and sti
> >> can rework their inner working to remove this (dare I say it) hack.
> >
> > Mmap on drm dma-bufs doesn't work, and fairly intentionally. There's been
> > some rfc patch series to address this:
> >
> > http://lists.freedesktop.org/archives/dri-devel/2015-August/089263.html
> >
> > Unfortunately it seems stuck with getting the userspace piece in shape.
> > Might be best to ping Tiago for an update.
> >
> > Meanwhile please don't do this in drivers ;-)
> 
> It seems Tiago's patch is the best way to fix mmap issue.
> I'll ping him, hope he will repsonse.
> 
> >
> >> > +static int hisi_gem_cma_dumb_create(struct drm_file *file,
> >> > +                                   struct drm_device *dev,
> >> > +                                   struct drm_mode_create_dumb *args)
> >> > +{
> >> > +       int min_pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
> >> > +
> >> > +       /* mali gpu need pitch 8 bytes alignment for 32bpp */
> >> > +       args->pitch = roundup(min_pitch, 8);
> >> > +
> >> I'm not sure you want this kind of dependency of an out of tree driver
> >> upstream. If this is some limitation on the display engine so be it,
> >> but tailoring things for an external module seems like a very bad
> >> idea.
> >
> > Yup, nacked. dumb_create is for dumb buffers, not rendering. Mali needs to
> > go upstream to fix this ...
> 
> Oh! I have use dumb buffers for rendering now. What does dumb buffer
> mean and what's dumb buffers  for?
> For rendering buffer requirements how should I do then?

Dumb buffers are really just a very thin in-kernel abstraction for boot
splash screens. As soon as you have real userspace (surfaceflinger, gl es,
whatever) the idea is that an allocator in userspace (like gralloc, gbm or
similar) figures out the allocation constraints and where to allocate
things exactly. Maybe that includes allocating from dumb buffers with
special knowledge (by increasing x/y perhaps), but most likely that means
you either allocate from your proprietary/out-of-tree gpu render driver or
some other central allocator like ion.

Anyway, adding hacks to the dumb buffer which are meant to facilite
sharing with other devices, or using it for anything else than a boot
splash is a no-go. DRM has made the design decision that gpu rendering is
too vendor-specific at the kernel level to make such generic interfaces
possible, and that allocation problems can only be solved properly in
userspace.

For your case specifically first step is to get an open-source mali driver
released, since that the basic requirement for upstream drm to design new
solutions in any area. Hence why I mentioned that ;-)

Kernel modesetting drivers don't need that since for those we have a
well-defined ABI and already existing userspace like X or Wayland which
can use it.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
