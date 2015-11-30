From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 30 Nov 2015 08:46:03 +0100
Subject: [PATCH v2 03/10] drm/hisilicon: Add hisilicon DRM master driver
In-Reply-To: <CACvgo51NJNRKObgExtv=vNJ10GSgDPz=nQs=4BHAcgqPpSB_ug@mail.gmail.com>
References: <CACvgo51NJNRKObgExtv=vNJ10GSgDPz=nQs=4BHAcgqPpSB_ug@mail.gmail.com>
Message-ID: <20151130074603.GE17050@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 28, 2015 at 03:25:35PM +0000, Emil Velikov wrote:
> Hi Xinliang,
> 
> On 28 November 2015 at 10:38, Xinliang Liu <xinliang.liu@linaro.org> wrote:
> > Add DRM master driver for hi6220 SoC which used in HiKey board.
> > Add dumb buffer feature.
> > Add prime dmabuf feature.
> >
> > Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
> > Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> > Signed-off-by: Andy Green <andy.green@linaro.org>
> Your s-o-b should be the bottom of the list. There was a presentation
> (ages ago) from Greg KH, who nicely described the order as a "chain of
> command" or "guilt path". Looks like the rest of the series could use
> this tweak.
> 
> > ---
> >  drivers/gpu/drm/Kconfig                  |   2 +
> >  drivers/gpu/drm/Makefile                 |   1 +
> >  drivers/gpu/drm/hisilicon/Kconfig        |   9 ++
> >  drivers/gpu/drm/hisilicon/Makefile       |   3 +
> >  drivers/gpu/drm/hisilicon/hisi_drm_drv.c | 214 +++++++++++++++++++++++++++++++
> >  5 files changed, 229 insertions(+)
> >  create mode 100644 drivers/gpu/drm/hisilicon/Kconfig
> >  create mode 100644 drivers/gpu/drm/hisilicon/Makefile
> >  create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_drv.c
> >
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index 8773fad..038aae8 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -274,3 +274,5 @@ source "drivers/gpu/drm/amd/amdkfd/Kconfig"
> >  source "drivers/gpu/drm/imx/Kconfig"
> >
> >  source "drivers/gpu/drm/vc4/Kconfig"
> > +
> > +source "drivers/gpu/drm/hisilicon/Kconfig"
> I could swear that we can a patch that sorts these alphabetically,
> although it doesn't seem to have made it upstream yet :-(
> 
> > --- /dev/null
> > +++ b/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
> 
> > +static int hisi_drm_load(struct drm_device *dev, unsigned long flags)
> > +{
> The use of .load (and .unload?) callbacks is not recommended. Take a
> look at Laurent Pinchart's patch [1] about the whys and hows on the
> topic
> 
> > +static struct dma_buf *hisi_gem_prime_export(struct drm_device *dev,
> > +                                            struct drm_gem_object *obj,
> > +                                            int flags)
> > +{
> > +       /* we want to be able to write in mmapped buffer */
> > +       flags |= O_RDWR;
> Erm... something feels fishy here. Out of the existing 15 drivers
> setting up the prime callbacks only one (sti) does a similar thing. So
> either everyone else is missing something obvious or hisilicon and sti
> can rework their inner working to remove this (dare I say it) hack.

Mmap on drm dma-bufs doesn't work, and fairly intentionally. There's been
some rfc patch series to address this:

http://lists.freedesktop.org/archives/dri-devel/2015-August/089263.html

Unfortunately it seems stuck with getting the userspace piece in shape.
Might be best to ping Tiago for an update.

Meanwhile please don't do this in drivers ;-)

> > +static int hisi_gem_cma_dumb_create(struct drm_file *file,
> > +                                   struct drm_device *dev,
> > +                                   struct drm_mode_create_dumb *args)
> > +{
> > +       int min_pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
> > +
> > +       /* mali gpu need pitch 8 bytes alignment for 32bpp */
> > +       args->pitch = roundup(min_pitch, 8);
> > +
> I'm not sure you want this kind of dependency of an out of tree driver
> upstream. If this is some limitation on the display engine so be it,
> but tailoring things for an external module seems like a very bad
> idea.

Yup, nacked. dumb_create is for dumb buffers, not rendering. Mali needs to
go upstream to fix this ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
