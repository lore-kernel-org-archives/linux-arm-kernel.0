From: robh@kernel.org (Rob Herring)
Date: Mon, 30 Nov 2015 11:25:28 -0600
Subject: [PATCH v2 03/10] drm/hisilicon: Add hisilicon DRM master driver
In-Reply-To: <20151130074603.GE17050@phenom.ffwll.local>
References: <CACvgo51NJNRKObgExtv=vNJ10GSgDPz=nQs=4BHAcgqPpSB_ug@mail.gmail.com>
 <20151130074603.GE17050@phenom.ffwll.local>
Message-ID: <20151130172528.GA10974@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 08:46:03AM +0100, Daniel Vetter wrote:
> On Sat, Nov 28, 2015 at 03:25:35PM +0000, Emil Velikov wrote:
> > Hi Xinliang,
> > 
> > On 28 November 2015 at 10:38, Xinliang Liu <xinliang.liu@linaro.org> wrote:
> > > Add DRM master driver for hi6220 SoC which used in HiKey board.
> > > Add dumb buffer feature.
> > > Add prime dmabuf feature.
> > >

> > > +static int hisi_gem_cma_dumb_create(struct drm_file *file,
> > > +                                   struct drm_device *dev,
> > > +                                   struct drm_mode_create_dumb *args)
> > > +{
> > > +       int min_pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
> > > +
> > > +       /* mali gpu need pitch 8 bytes alignment for 32bpp */
> > > +       args->pitch = roundup(min_pitch, 8);
> > > +
> > I'm not sure you want this kind of dependency of an out of tree driver
> > upstream. If this is some limitation on the display engine so be it,
> > but tailoring things for an external module seems like a very bad
> > idea.
> 
> Yup, nacked. dumb_create is for dumb buffers, not rendering. Mali needs to
> go upstream to fix this ...

I believe this is copy-n-paste from Rockchip driver.

I'm curious why there is not a common interface for rendering buffers at 
least for systems without graphics memory like most ARM systems. Are the 
requirements of GPU so diverse that things like pitch alignment can't be 
parameterized?

Rob
