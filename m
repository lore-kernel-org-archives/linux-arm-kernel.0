From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Mar 2017 19:22:58 +0000
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170318192258.GL21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

I've just been trying to get gstreamer to capture and h264 encode
video from my camera at various frame rates, and what I've discovered
does not look good.

1) when setting frame rates, media-ctl _always_ calls
   VIDIOC_SUBDEV_S_FRAME_INTERVAL with pad=0.

2) media-ctl never retrieves the frame interval information, so there's
   no way to read it back with standard tools, and no indication that
   this is going on...

3) gstreamer v4l2src is getting upset, because it can't enumerate the
   frame sizes (VIDIOC_ENUM_FRAMESIZES fails), which causes it to
   fallback to using the "tvnorms" to decide about frame rates.  This
   makes it impossible to use frame rates higher than 30000/1001, and
   causes the pipeline validation to fail.

0:00:01.937465845 20954  0x15ffe90 DEBUG                   v4l2 gstv4l2object.c:2474:gst_v4l2_object_probe_caps_for_format:<v4l2src0> Enumerating frame sizes for RGGB
0:00:01.937588518 20954  0x15ffe90 DEBUG                   v4l2 gstv4l2object.c:2601:gst_v4l2_object_probe_caps_for_format:<v4l2src0> Failed to enumerate frame sizes for pixelformat RGGB (Inappropriate ioctl for device)
0:00:01.937879535 20954  0x15ffe90 LOG                     v4l2 gstv4l2object.c:2708:gst_v4l2_object_get_nearest_size:<v4l2src0> getting nearest size to 1x1 with format RGGB
0:00:01.937990874 20954  0x15ffe90 LOG                     v4l2 gstv4l2object.c:2724:gst_v4l2_object_get_nearest_size:<v4l2src0> got nearest size 816x616
0:00:01.938250889 20954  0x15ffe90 ERROR                   v4l2 gstv4l2object.c:1873:gst_v4l2_object_get_interlace_mode: Driver bug detected - check driver with v4l2-compliance from http://git.linuxtv.org/v4l-utils.git
0:00:01.938326893 20954  0x15ffe90 LOG                     v4l2 gstv4l2object.c:2708:gst_v4l2_object_get_nearest_size:<v4l2src0> getting nearest size to 32768x32768 with format RGGB
0:00:01.938431566 20954  0x15ffe90 LOG                     v4l2 gstv4l2object.c:2724:gst_v4l2_object_get_nearest_size:<v4l2src0> got nearest size 816x616
0:00:01.939776641 20954  0x15ffe90 ERROR                   v4l2 gstv4l2object.c:1873:gst_v4l2_object_get_interlace_mode: Driver bug detected - check driver with v4l2-compliance from http://git.linuxtv.org/v4l-utils.git
0:00:01.940110660 20954  0x15ffe90 DEBUG                   v4l2 gstv4l2object.c:1955:gst_v4l2_object_get_colorspace: Unknown enum v4l2_colorspace 0

   This triggers the "/* Since we can't get framerate directly, try to
   use the current norm */" code in v4l2object.c, which causes it to
   select one of the 30000/1001 norms:

0:00:01.955927879 20954  0x15ffe90 INFO                    v4l2 gstv4l2object.c:3811:gst_v4l2_object_get_caps:<v4l2src0> probed caps: video/x-bayer, format=(string)rggb, framerate=(fraction)30000/1001, width=(int)816, height=(int)616, pixel-aspect-ratio=(fraction)1/1; video/x-raw, format=(string)I420, framerate=(fraction)30000/1001, width=(int)816, height=(int)616, interlace-mode=(string)progressive, pixel-aspect-ratio=(fraction)1/1; video/x-raw, format=(string)YV12, framerate=(fraction)30000/1001, width=(int)816, height=(int)616, interlace-mode=(string)progressive, pixel-aspect-ratio=(fraction)1/1; video/x-raw, format=(string)BGR, framerate=(fraction)30000/1001, width=(int)816, height=(int)616, interlace-mode=(string)progressive, pixel-aspect-ratio=(fraction)1/1; video/x-raw, format=(string)RGB, framerate=(fraction)30000/1001, width=(int)816, height=(int)616, interlace-mode=(string)progressive, pixel-aspect-ratio=(fraction)1/1

   despite the media pipeline actually being configured for 60fps.

   Forcing it by adjusting the pipeline only results in gstreamer
   failing, because it believes that v4l2 is unable to operate at
   60fps.

   Also note the complaints from v4l2src about the non-compliance...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
