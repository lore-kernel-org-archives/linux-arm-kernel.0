From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 8 Aug 2018 00:10:59 +0900
Subject: [linux-sunxi] [PATCH v6 4/8] media: platform: Add Cedrus VPU
 decoder driver
In-Reply-To: <2378753.ggmX2zm38T@jernej-laptop>
References: <20180725100256.22833-1-paul.kocialkowski@bootlin.com>
 <2251357.uoA9bQP17p@jernej-laptop>
 <5b8f8406620166903db35832489e0f2d314b4191.camel@bootlin.com>
 <2378753.ggmX2zm38T@jernej-laptop>
Message-ID: <CAAFQd5AtRz3aP2DpFk46_5MuDcFxx594MBMeu73UaZvBuZOp+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2018 at 12:05 AM Jernej ?krabec <jernej.skrabec@gmail.com> wrote:
>
> Dne torek, 07. avgust 2018 ob 14:31:03 CEST je Paul Kocialkowski napisal(a):
> > Hi,
> >
> > On Fri, 2018-07-27 at 16:58 +0200, Jernej ?krabec wrote:
> > > Dne petek, 27. julij 2018 ob 16:03:41 CEST je Jernej ?krabec napisal(a):
> > > > Hi!
> > > >
> > > > Dne sreda, 25. julij 2018 ob 12:02:52 CEST je Paul Kocialkowski
> napisal(a):
> > > > > This introduces the Cedrus VPU driver that supports the VPU found in
> > > > > Allwinner SoCs, also known as Video Engine. It is implemented through
> > > > > a v4l2 m2m decoder device and a media device (used for media
> > > > > requests).
> > > > > So far, it only supports MPEG2 decoding.
> > > > >
> > > > > Since this VPU is stateless, synchronization with media requests is
> > > > > required in order to ensure consistency between frame headers that
> > > > > contain metadata about the frame to process and the raw slice data
> > > > > that
> > > > > is used to generate the frame.
> > > > >
> > > > > This driver was made possible thanks to the long-standing effort
> > > > > carried out by the linux-sunxi community in the interest of reverse
> > > > > engineering, documenting and implementing support for Allwinner VPU.
> > > > >
> > > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > ---
> > > >
> > > > <snip>
> > > >
> > > > > +void cedrus_dst_format_set(struct cedrus_dev *dev,
> > > > > +                          struct v4l2_pix_format_mplane *fmt)
> > > > > +{
> > > > > +       unsigned int width = fmt->width;
> > > > > +       unsigned int height = fmt->height;
> > > > > +       u32 chroma_size;
> > > > > +       u32 reg;
> > > > > +
> > > > > +       switch (fmt->pixelformat) {
> > > > > +       case V4L2_PIX_FMT_NV12:
> > > > > +               chroma_size = ALIGN(width, 32) * ALIGN(height / 2, 32);
> > > >
> > > > After some testing, it turns out that right aligment for untiled format
> > > > is
> > > > 16.
> > > >
> > > > > +
> > > > > +               reg = VE_PRIMARY_OUT_FMT_NV12 |
> > > > > +                     VE_SECONDARY_SPECIAL_OUT_FMT_NV12;
> > > > > +               cedrus_write(dev, VE_PRIMARY_OUT_FMT, reg);
> > > > > +
> > > > > +               reg = VE_CHROMA_BUF_LEN_SDRT(chroma_size / 2) |
> > > > > +                     VE_SECONDARY_OUT_FMT_SPECIAL;
> > > > > +               cedrus_write(dev, VE_CHROMA_BUF_LEN, reg);
> > > > > +
> > > > > +               reg = chroma_size / 2;
> > > > > +               cedrus_write(dev, VE_PRIMARY_CHROMA_BUF_LEN, reg);
> > > > > +
> > > > > +               reg = VE_PRIMARY_FB_LINE_STRIDE_LUMA(ALIGN(width, 32)) |
> > > >
> > > > ^ that one should be aligned to 16
> > > >
> > > > > +                     VE_PRIMARY_FB_LINE_STRIDE_CHROMA(ALIGN(width / 2, 16));
> > >
> > > It seems that CHROMA has to be aligned to 8 ^
> >
> > I think the issue here is that the divider should be applied after the
> > alignment, not before, such as: ALIGN(width, 16) / 2, which also
> > provides a 8-aligned value.
> >
> > Feel free to let me know if that causes any particular issue!
>
> I think this is only semantics, it doesn't really matter if it is aligned to
> 16 first and then divided by 2 or divided by 2 and then aligned to 8.

It depends if |width| is always expected to be aligned to 2. For
example, given |width| = 17,

ALIGN(17, 16) = 32, 32 / 2 = 16
17 / 2 = 8, ALIGN(8, 8) = 8

Best regards,
Tomasz
