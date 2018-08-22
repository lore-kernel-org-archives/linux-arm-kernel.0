From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Wed, 22 Aug 2018 16:45:29 +0200
Subject: [PATCH 1/9] CHROMIUM: v4l: Add H264 low-level decoder API
 compound controls.
In-Reply-To: <CAAFQd5B68ArBgSj-Oso8=MzSrvVGB=h+MVO12qqgACmBrZtRkw@mail.gmail.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-2-maxime.ripard@bootlin.com>
 <80e1d9cb49c6df06843e49332685f2b401023292.camel@collabora.com>
 <d8a30e78e6a33db10360995d800f2c0d19acc500.camel@collabora.com>
 <53987ca7a536a21b2eb49626d777a9bf894d6910.camel@bootlin.com>
 <CAAFQd5B68ArBgSj-Oso8=MzSrvVGB=h+MVO12qqgACmBrZtRkw@mail.gmail.com>
Message-ID: <faca77cc213e4737c689f80ac5e830833bbe87ae.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2018-08-22 at 22:38 +0900, Tomasz Figa wrote:
> On Wed, Aug 22, 2018 at 10:07 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > 
> > Hi,
> > 
> > On Tue, 2018-08-21 at 13:07 -0400, Nicolas Dufresne wrote:
> > > Le mardi 21 ao?t 2018 ? 13:58 -0300, Ezequiel Garcia a ?crit :
> > > > On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> > > > > From: Pawel Osciak <posciak@chromium.org>
> > > > > 
> > > > > Signed-off-by: Pawel Osciak <posciak@chromium.org>
> > > > > Reviewed-by: Wu-cheng Li <wuchengli@chromium.org>
> > > > > Tested-by: Tomasz Figa <tfiga@chromium.org>
> > > > > [rebase44(groeck): include linux/types.h in v4l2-controls.h]
> > > > > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > > > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > > > ---
> > > > > 
> > > > 
> > > > [..]
> > > > > diff --git a/include/uapi/linux/videodev2.h
> > > > > b/include/uapi/linux/videodev2.h
> > > > > index 242a6bfa1440..4b4a1b25a0db 100644
> > > > > --- a/include/uapi/linux/videodev2.h
> > > > > +++ b/include/uapi/linux/videodev2.h
> > > > > @@ -626,6 +626,7 @@ struct v4l2_pix_format {
> > > > >  #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /*
> > > > > H264 with start codes */
> > > > >  #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /*
> > > > > H264 without start codes */
> > > > >  #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /*
> > > > > H264 MVC */
> > > > > +#define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /*
> > > > > H264 parsed slices */
> > > > 
> > > > As pointed out by Tomasz, the Rockchip VPU driver expects start codes
> > > > [1], so the userspace
> > > > should be aware of it. Perhaps we could document this pixel format
> > > > better as:
> > > > 
> > > > #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /*
> > > > H264 parsed slices with start codes */
> > > > 
> > > > And introduce another pixel format:
> > > > 
> > > > #define V4L2_PIX_FMT_H264_SLICE_NO_SC v4l2_fourcc(TODO) /* H264
> > > > parsed slices without start codes */
> > > > 
> > > > For cedrus to use, as it seems it doesn't need start codes.
> > > 
> > > I must admit that this RK requirement is a bit weird for slice data.
> > > Though, userspace wise, always adding start-code would be compatible,
> > > as the driver can just offset to remove it.
> > 
> > This would mean that the stateless API no longer takes parsed bitstream
> > data but effectively the full bitstream, which defeats the purpose of
> > the _SLICE pixel formats.
> > 
> 
> Not entirely. One of the purposes of the _SLICE pixel format was to
> specify it in a way that adds a requirement of providing the required
> controls by the client.

I think we need to define what we want the stateless APIs (and these
formats) to precisely reflect conceptually. I've started discussing this
in the Request API and V4L2 capabilities thread.

> > > Another option, because I'm not fan of adding dedicated formats for
> > > this, the RK driver could use data_offset (in mplane v4l2 buffers),
> > > just write a start code there. I like this solution because I would not
> > > be surprise if some drivers requires in fact an HW specific header,
> > > that the driver can generate as needed.
> > 
> > I like this idea, because it implies that the driver should deal with
> > the specificities of the hardware, instead of making the blurrying the
> > lines of stateless API for covering these cases.
> 
> The spec says
> 
> "Offset in bytes to video data in the plane. Drivers must set this
> field when type refers to a capture stream, applications when it
> refers to an output stream."
> 
> which would mean that user space would have to know to reserve some
> bytes at the beginning for the driver to add the start code there. (Or
> the driver memmove()ing the data forward when the buffer is queued,
> assuming that there is enough space in the buffer, but it should
> normally be the case.)
> 
> Sounds like a pixel format with full bitstream data and some offsets
> to particular parts inside given inside a control might be the most
> flexible and cleanest solution.

I can't help but think that bringing the whole bitstream over to the
kernel with a dedicated pix fmt just for the sake of having 3 start code
bytes is rather overkill anyway.

I believe moving the data around to be the best call for this situation.
Or maybe there's a way to alloc more data *before* the bufer that is
exposed to userspace, so userspace can fill it normally and the driver
can bring-in the necessary heading start code bytes before the buffer?

Cheers,

Paul

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180822/c635d458/attachment.sig>
