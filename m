From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 28 Aug 2018 10:02:38 +0200
Subject: [PATCH 0/2] HEVC/H.265 stateless support for V4L2 and Cedrus
Message-ID: <20180828080240.10982-1-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces the required bits for supporting HEVC/H.265 both in the
V4L2 framework and the Cedrus VPU driver that concerns Allwinner
devices.

A specific pixel format is introduced for the HEVC slice format and
controls are provided to pass the bitstream metadata to the decoder.
Some bitstream extensions are knowingly not supported at this point.

Since this is the first proposal for stateless HEVC/H.265 support in
V4L2, reviews and comments about the controls definitions are
particularly welcome.

On the Cedrus side, the H.265 implementation covers frame pictures
with both uni-directional and bi-direction prediction modes (P/B
slices). Field pictures (interleaved), scaling lists and 10-bit output
are not supported at this point.

This series is based upon the following series:
* Cedrus driver for the Allwinner Video Engine, using media requests
* media: cedrus: Add H264 decoding support

Cheers!

Paul Kocialkowski (2):
  media: v4l: Add definitions for the HEVC slice format and controls
  media: cedrus: Add HEVC/H.265 decoding support

 .../media/uapi/v4l/extended-controls.rst      | 416 ++++++++++++++
 .../media/uapi/v4l/pixfmt-compressed.rst      |  15 +
 .../media/uapi/v4l/vidioc-queryctrl.rst       |  18 +
 .../media/videodev2.h.rst.exceptions          |   3 +
 drivers/media/v4l2-core/v4l2-ctrls.c          |  26 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |   1 +
 drivers/staging/media/sunxi/cedrus/Makefile   |   2 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c   |  19 +
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  20 +-
 .../staging/media/sunxi/cedrus/cedrus_dec.c   |   9 +
 .../staging/media/sunxi/cedrus/cedrus_h265.c  | 540 ++++++++++++++++++
 .../staging/media/sunxi/cedrus/cedrus_hw.c    |   4 +
 .../staging/media/sunxi/cedrus/cedrus_regs.h  | 290 ++++++++++
 .../staging/media/sunxi/cedrus/cedrus_video.c |  13 +
 include/media/v4l2-ctrls.h                    |   6 +
 include/uapi/linux/v4l2-controls.h            | 155 +++++
 include/uapi/linux/videodev2.h                |   7 +
 17 files changed, 1542 insertions(+), 2 deletions(-)
 create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_h265.c

-- 
2.18.0
