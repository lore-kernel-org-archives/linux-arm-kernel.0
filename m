From: nicolas.dufresne@collabora.com (Nicolas Dufresne)
Date: Tue, 21 Aug 2018 13:07:43 -0400
Subject: [PATCH 1/9] CHROMIUM: v4l: Add H264 low-level decoder API
 compound controls.
In-Reply-To: <80e1d9cb49c6df06843e49332685f2b401023292.camel@collabora.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-2-maxime.ripard@bootlin.com>
 <80e1d9cb49c6df06843e49332685f2b401023292.camel@collabora.com>
Message-ID: <d8a30e78e6a33db10360995d800f2c0d19acc500.camel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mardi 21 ao?t 2018 ? 13:58 -0300, Ezequiel Garcia a ?crit :
> On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> > From: Pawel Osciak <posciak@chromium.org>
> > 
> > Signed-off-by: Pawel Osciak <posciak@chromium.org>
> > Reviewed-by: Wu-cheng Li <wuchengli@chromium.org>
> > Tested-by: Tomasz Figa <tfiga@chromium.org>
> > [rebase44(groeck): include linux/types.h in v4l2-controls.h]
> > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> > 
> 
> [..]
> > diff --git a/include/uapi/linux/videodev2.h
> > b/include/uapi/linux/videodev2.h
> > index 242a6bfa1440..4b4a1b25a0db 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -626,6 +626,7 @@ struct v4l2_pix_format {
> >  #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /*
> > H264 with start codes */
> >  #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /*
> > H264 without start codes */
> >  #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /*
> > H264 MVC */
> > +#define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /*
> > H264 parsed slices */
> 
> As pointed out by Tomasz, the Rockchip VPU driver expects start codes
> [1], so the userspace
> should be aware of it. Perhaps we could document this pixel format
> better as:
> 
> #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /*
> H264 parsed slices with start codes */
> 
> And introduce another pixel format:
> 
> #define V4L2_PIX_FMT_H264_SLICE_NO_SC v4l2_fourcc(TODO) /* H264
> parsed slices without start codes */
> 
> For cedrus to use, as it seems it doesn't need start codes.

I must admit that this RK requirement is a bit weird for slice data.
Though, userspace wise, always adding start-code would be compatible,
as the driver can just offset to remove it.

Another option, because I'm not fan of adding dedicated formats for
this, the RK driver could use data_offset (in mplane v4l2 buffers),
just write a start code there. I like this solution because I would not
be surprise if some drivers requires in fact an HW specific header,
that the driver can generate as needed.

> 
> How does it sound? 
> 
> [1] 
> https://cs.chromium.org/chromium/src/media/gpu/v4l2/v4l2_slice_video_decode_accelerator.cc?rcl=63129434aeacf0f54bbae96814f10cf64e3e6c35&l=2438
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180821/de2e3094/attachment.sig>
