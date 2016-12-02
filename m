From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Fri, 02 Dec 2016 14:46:01 +0100
Subject: IMX6 - KMS/DRM video overlay question
Message-ID: <m3r35qtpeu.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm currently able to display flawless full HD video on IMX6
HDMI using:

gst-launch-1.0 udpsrc uri=udp://XXX reuse=true caps="application/x-rtp,media=(string)video,clock-rate=(int)90000,encoding-name=(string)H264" ! rtph264depay ! h264parse ! v4l2video1dec capture-io-mode=dmabuf ! kmssink name=imx-drm sync=0

The CPU utilization is very small.

Now, I'd like to display some OSD on top of the video. Is it possible
with the current driver code?

The idea would be to have a YUV420 video plane in the background, and
an ARGB frame buffer (with transparency) in the foreground.

What I'm trying to do is (test source available on request; 720p ATM
but 1080p performance doesn't seem to be an issue):

drmSetMaster()

# Testing plane buffer
kms_bo_create(1280x720)
drmModeAddFB2(1280x720, DRM_FORMAT_[AX]RGB8888) <<< YUV420 planned
drmModeSetCrtc(crtc_id 24, fb_id 37)
kms_bo_map()
drmModeSetPlane(plane_id 25, crtc_id 24, fb_id 37, 1280x720)

# Testing dumb buffer
DRM_IOCTL_MODE_CREATE_DUMB(1280x720)
drmModeAddFB2(1280x720, handle 2, pitch 5120, DRM_FORMAT_[AX]RGB8888)
drmModeSetCrtc(crtc_id 24, fb_id 36)
DRM_IOCTL_MODE_MAP_DUMB(handle 2)
mmap(size 3686400, offset 0x10546000)

drmDropMaster()

I get either the video plane only (if created with XRGB8888) or both
planes, with video plane on top (if created with ARGB8888 - I can
control video plane transparency). Base FB XRGB/ARGB mode seems to be
ignored (it's always completely opaque).

Would it be possible to swap the planes (so they work like the other
drivers)?
The IMX6DQRM book says both planes can be combined in any order, however
I'm not yet sure how is it done in the driver.

Also, I noticed that I have to drmModeSetCrtc(video plane) first.
Otherwise (if drmModeSetCrtc(base fb) is done first) I only get the
video plane.

Comments?

TIA,
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
