From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Wed, 22 Aug 2018 16:30:28 +0200
Subject: [PATCH 1/9] CHROMIUM: v4l: Add H264 low-level decoder API
 compound controls.
In-Reply-To: <CAAFQd5AybueM-rhy8bMbRHHZmwBP08-cWB11NadcUQAb6XJ1SA@mail.gmail.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-2-maxime.ripard@bootlin.com>
 <80e1d9cb49c6df06843e49332685f2b401023292.camel@collabora.com>
 <20180822091557.gtnlgoebyv6yttzf@flea>
 <CAAFQd5ANvKF2+GEXQTnRsdYVzJTtBOhv7nFahV=2W-9_QXwY4g@mail.gmail.com>
 <e6324ea983d34403199044ae30e932cd728c8ad4.camel@bootlin.com>
 <CAAFQd5AybueM-rhy8bMbRHHZmwBP08-cWB11NadcUQAb6XJ1SA@mail.gmail.com>
Message-ID: <e32484e1a2efce3e319e025ba7232500bd5aa2a8.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2018-08-22 at 22:24 +0900, Tomasz Figa wrote:
> On Wed, Aug 22, 2018 at 10:03 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > 
> > Hi,
> > 
> > On Wed, 2018-08-22 at 18:54 +0900, Tomasz Figa wrote:
> > > On Wed, Aug 22, 2018 at 6:16 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > On Tue, Aug 21, 2018 at 01:58:38PM -0300, Ezequiel Garcia wrote:
> > > > > On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> > > > > > From: Pawel Osciak <posciak@chromium.org>
> > > > > > 
> > > > > > Signed-off-by: Pawel Osciak <posciak@chromium.org>
> > > > > > Reviewed-by: Wu-cheng Li <wuchengli@chromium.org>
> > > > > > Tested-by: Tomasz Figa <tfiga@chromium.org>
> > > > > > [rebase44(groeck): include linux/types.h in v4l2-controls.h]
> > > > > > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > > > > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > > > > ---
> > > > > > 
> > > > > 
> > > > > [..]
> > > > > > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > > > > > index 242a6bfa1440..4b4a1b25a0db 100644
> > > > > > --- a/include/uapi/linux/videodev2.h
> > > > > > +++ b/include/uapi/linux/videodev2.h
> > > > > > @@ -626,6 +626,7 @@ struct v4l2_pix_format {
> > > > > >  #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /* H264 with start codes */
> > > > > >  #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /* H264 without start codes */
> > > > > >  #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /* H264 MVC */
> > > > > > +#define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
> > > > > 
> > > > > As pointed out by Tomasz, the Rockchip VPU driver expects start codes [1], so the userspace
> > > > > should be aware of it. Perhaps we could document this pixel format better as:
> > > > > 
> > > > > #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices with start codes */
> > > > 
> > > > I'm not sure this is something we want to do at that point. libva
> > > > doesn't give the start code, so this is only going to make the life of
> > > > the sane controllers more difficult. And if you need to have the start
> > > > code and parse it, then you're not so stateless anymore.
> > > 
> > > I might not remember correctly, but Rockchip decoder does some slice
> > > parsing on its own (despite not doing any higher level parsing).
> > > Probably that's why it needs those start codes.
> > 
> > The VPU found on Allwinner platforms also provides a mechanism to parse
> > the bitstream data via a dedicated interface through the VPU registers.
> > It is used in libvdpau-sunxi but not in our driver, because we don't
> > want to be doing bitstream parsing in the kernel.
> > 
> > It would be good to know if this is just a feature of the Rockchip VPU
> > hardware that can be skipped (like on Allwinner) or if it's a hard
> > requirement in its decoding pipeline.
> 
> It's a hard requirement for its decoding pipeline, but...
> 
> > Also, maybe it only concerns the
> > slice header? It is already part of the slice data (provided by VAAPI)
> > for H.264/H.265 and an offset is provided to the beginning of the coded
> > video data.
> 
> Yes, it seems to be only the slice header.

Sounds good, then I don't have any problem with that.

> > 
> > > I wonder if libva is the best reference here. It's been designed
> > > almost entirely by Intel for Intel video hardware. We want something
> > > that could work with a wide range of devices and avoid something like
> > > a need to create a semi-stateless API few months later. In fact,
> > > hardware from another vendor, we're working with, also does parsing of
> > > slice headers internally. Moreover, we have some weird
> > > kind-of-stateful decoders, which cannot fully deal with bitstream on
> > > its own, e.g. cannot parse formats, cannot handle resolution changes,
> > > need H264 bitstream NALUs split into separate buffers, etc.
> > > 
> > > As I suggested some time ago, having the full bitstream in the buffer,
> > > with offsets of particular units included in respective controls,
> > > would be the most scalable thing. If really needed, we could add flags
> > > telling the driver that particular units are present, so one's
> > > implementation of libva could put only raw slice data in the buffers.
> > > But perhaps it's libva which needs some amendment?
> > 
> > If the raw bitstream is needed, I think it would make more sense to use
> > the already-existing formats for stateful VPUs along with the controls
> > for stateless ones instead of having the full bitstream in the
> > V4L2_PIX_FMT_*_SLICE formats.
> 
> It may indeed make sense to separate this based on pixel format.
> However, how do we tell the client that it needs to provide those
> controls? Current concept was based entirely on pixel format, so I
> guess that would mean creating something like
> V4L2_PIX_FMT_*_NOT_REALLY_SLICE (_PARSED, _STATELESS?). Might be okay,
> though...

How about declaring support for the request API (through the associated
CAPs) and only having the non-_SLICE formats listed in ENUM_FMT?

> > I would also be tempted to say that reconstructing the needed parts of
> > the bitstream in-driver for these half-way VPUs would be a better
> > approach than blurrying the line between how (and what) data should be
> > passed for stateful and stateless VPUs at the API level. Stateless
> > should only cover what's in the slice NAL unit RBSP, which excludes the
> > start code detection bytes. It is no longer parsed data otherwise.
> 
> I'm not sure where such decision comes from. In particular, Chromium,
> from which this code originates, includes start codes in
> V4L2_PIX_FMT_H264_SLICE. As I mentioned earlier, we can't design this
> API based only on 1 type of hardware semantics. The stateless API
> should cover any kind of codec that needs user space assistance in
> processing the stream, which in practice would be almost everything
> for which stateful API doesn't work.

Maybe we need to formalize what the stateless API aims to support and
what the formats really entail. I was under the impression that it was
synonymouse with providing parsed bitstream to the kernel. The way I
understand "parsed bitstream" means the slice NALU RBSP as raw data and
the metadata from other NALUs as controls (with the overlap of the slice
header in recent formats, that is in both).

I don't see any other sane boundary that could be conceptually attached
to something like "providing parsed bitstream". Covering all that might
be required for != stateful seems hard to formalize conceptually and to
delimit in general.

> That said, since pixel format essentially specifies the buffer
> contents, having such cases differentiated based on the pixel format
> doesn't sound insane.

Great!

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180822/2dc3f39f/attachment.sig>
