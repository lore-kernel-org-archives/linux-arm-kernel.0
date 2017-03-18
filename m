From: steve_longerbeam@mentor.com (Steve Longerbeam)
Date: Sat, 18 Mar 2017 12:58:27 -0700
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <20170318192258.GL21222@n2100.armlinux.org.uk>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170318192258.GL21222@n2100.armlinux.org.uk>
Message-ID: <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/18/2017 12:22 PM, Russell King - ARM Linux wrote:
> Hi Steve,
>
> I've just been trying to get gstreamer to capture and h264 encode
> video from my camera at various frame rates, and what I've discovered
> does not look good.
>
> 1) when setting frame rates, media-ctl _always_ calls
>     VIDIOC_SUBDEV_S_FRAME_INTERVAL with pad=0.
>
> 2) media-ctl never retrieves the frame interval information, so there's
>     no way to read it back with standard tools, and no indication that
>     this is going on...

I think Philipp Zabel submitted a patch which addresses these
in media-ctl. Check with him.

>
> 3) gstreamer v4l2src is getting upset, because it can't enumerate the
>     frame sizes (VIDIOC_ENUM_FRAMESIZES fails),

Right, imx-media-capture.c (the "standard" v4l2 user interface module)
is not implementing VIDIOC_ENUM_FRAMESIZES. It should, but it can only
return the single frame size that the pipeline has configured (the mbus
format of the attached source pad).

>   which causes it to
>     fallback to using the "tvnorms" to decide about frame rates.  This
>     makes it impossible to use frame rates higher than 30000/1001, and
>     causes the pipeline validation to fail.

In v5 I added validation of frame intervals between pads,
but due to negative feedback I've pulled that. So next
version will not attempt to validate frame intervals between
source->sink pads.

Can you share your gstreamer pipeline? For now, until
VIDIOC_ENUM_FRAMESIZES is implemented, try a pipeline that
does not attempt to specify a frame rate. I use the attached
script for testing, which works for me.



>
> 0:00:01.937465845 20954  0x15ffe90 DEBUG                   v4l2 gstv4l2object.c:2474:gst_v4l2_object_probe_caps_for_format:<v4l2src0> Enumerating frame sizes for RGGB
> 0:00:01.937588518 20954  0x15ffe90 DEBUG                   v4l2 gstv4l2object.c:2601:gst_v4l2_object_probe_caps_for_format:<v4l2src0> Failed to enumerate frame sizes for pixelformat RGGB (Inappropriate ioctl for device)
> 0:00:01.937879535 20954  0x15ffe90 LOG                     v4l2 gstv4l2object.c:2708:gst_v4l2_object_get_nearest_size:<v4l2src0> getting nearest size to 1x1 with format RGGB
> 0:00:01.937990874 20954  0x15ffe90 LOG                     v4l2 gstv4l2object.c:2724:gst_v4l2_object_get_nearest_size:<v4l2src0> got nearest size 816x616
> 0:00:01.938250889 20954  0x15ffe90 ERROR                   v4l2 gstv4l2object.c:1873:gst_v4l2_object_get_interlace_mode: Driver bug detected - check driver with v4l2-compliance from http://git.linuxtv.org/v4l-utils.git
> 0:00:01.938326893 20954  0x15ffe90 LOG                     v4l2 gstv4l2object.c:2708:gst_v4l2_object_get_nearest_size:<v4l2src0> getting nearest size to 32768x32768 with format RGGB
> 0:00:01.938431566 20954  0x15ffe90 LOG                     v4l2 gstv4l2object.c:2724:gst_v4l2_object_get_nearest_size:<v4l2src0> got nearest size 816x616
> 0:00:01.939776641 20954  0x15ffe90 ERROR                   v4l2 gstv4l2object.c:1873:gst_v4l2_object_get_interlace_mode: Driver bug detected - check driver with v4l2-compliance from http://git.linuxtv.org/v4l-utils.git
> 0:00:01.940110660 20954  0x15ffe90 DEBUG                   v4l2 gstv4l2object.c:1955:gst_v4l2_object_get_colorspace: Unknown enum v4l2_colorspace 0
>
>     This triggers the "/* Since we can't get framerate directly, try to
>     use the current norm */" code in v4l2object.c, which causes it to
>     select one of the 30000/1001 norms:
>
> 0:00:01.955927879 20954  0x15ffe90 INFO                    v4l2 gstv4l2object.c:3811:gst_v4l2_object_get_caps:<v4l2src0> probed caps: video/x-bayer, format=(string)rggb, framerate=(fraction)30000/1001, width=(int)816, height=(int)616, pixel-aspect-ratio=(fraction)1/1; video/x-raw, format=(string)I420, framerate=(fraction)30000/1001, width=(int)816, height=(int)616, interlace-mode=(string)progressive, pixel-aspect-ratio=(fraction)1/1; video/x-raw, format=(string)YV12, framerate=(fraction)30000/1001, width=(int)816, height=(int)616, interlace-mode=(string)progressive, pixel-aspect-ratio=(fraction)1/1; video/x-raw, format=(string)BGR, framerate=(fraction)30000/1001, width=(int)816, height=(int)616, interlace-mode=(string)progressive, pixel-aspect-ratio=(fraction)1/1; video/x-raw, format=(string)RGB, framerate=(fraction)30000/1001, width=(int)816, height=(int)616, interlace-mode=(string)progressive, pixel-aspect-ratio=(fraction)1/1
>
>     despite the media pipeline actually being configured for 60fps.
>
>     Forcing it by adjusting the pipeline only results in gstreamer
>     failing, because it believes that v4l2 is unable to operate at
>     60fps.
>
>     Also note the complaints from v4l2src about the non-compliance...

Thanks, I've fixed most of v4l2-compliance issues, but this is not
done yet. Is that something you can help with?

Steve

-------------- next part --------------
A non-text attachment was scrubbed...
Name: udpstream.sh
Type: application/x-shellscript
Size: 381 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170318/35942579/attachment.bin>
