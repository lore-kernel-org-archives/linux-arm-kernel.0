From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Wed, 10 Aug 2016 22:48:45 +0800
Subject: [PATCH v4 0/9] Add MT8173 Video Decoder Driver
Message-ID: <1470840534-4788-1-git-send-email-tiffany.lin@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

==============
 Introduction
==============

The purpose of this series is to add the driver for video codec hw embedded in the Mediatek's MT8173 SoCs.
Mediatek Video Codec is able to handle video decoding and encoding of in a range of formats.

This patch series add Mediatek compressed block format V4L2_PIX_FMT_MT21C, the decoder driver will decoded bitstream to
V4L2_PIX_FMT_MT21C format.

This patch series rely on MTK VPU driver that have been merged in v4.8-rc1 and patch "CHROMIUM: v4l: Add V4L2_PIX_FMT_VP9 definition"[1] for VP9 support.
Mediatek Video Decoder driver rely on VPU driver to load, communicate with VPU.

Internally the driver uses videobuf2 framework, and MTK IOMMU and MTK SMI both have been merged in v4.6-rc1.

[1]https://chromium-review.googlesource.com/#/c/245241/

==================
 Device interface
==================

In principle the driver bases on v4l2 memory-to-memory framework:
it provides a single video node and each opened file handle gets its own private context with separate buffer queues. Each context consist of 2 buffer 
queues: OUTPUT (for source buffers, i.e. bitstream) and CAPTURE (for destination buffers, i.e. decoded video frames).
OUTPUT and CAPTURE buffer could be MMAP or DMABUF memory type.

Change in v4:
1.Change V4L2_PIX_FMT_MT21 to v4l2_PIX_FMT_MT21C
2.Fix g/s_selection implementation
3.Refine code according to review comments and pass V4l2-compliance test


-/bin/sh: v4l2: not found
# v4l2-compliance -d /dev/video0
v4l2-compliance SHA   : fc45cdc502065bc1dfb4ef9ceb9a822bb9877bce

Driver Info:
        Driver name   : mtk-vcodec-dec
        Card type     : platform:mt8173
        Bus info      : platform:mt8173
        Driver version: 4.8.0
        Capabilities  : 0x84204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps   : 0x04204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format

Compliance test for device /dev/video0 (not using libv4l2):

Required ioctls:
        test VIDIOC_QUERYCAP: OK

Allow for multiple opens:
        test second video open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

        Control ioctls:
                test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
                test VIDIOC_QUERYCTRL: OK
                test VIDIOC_G/S_CTRL: OK
                test VIDIOC_G/S/TRY_EXT_CTRLS: OK
                test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
                test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
                Standard Controls: 2 Private Controls: 0

        Format ioctls:
                test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
                test VIDIOC_G/S_PARM: OK (Not Supported)
                test VIDIOC_G_FBUF: OK (Not Supported)
                test VIDIOC_G_FMT: OK
                test VIDIOC_TRY_FMT: OK
                test VIDIOC_S_FMT: OK
                test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
                test Cropping: OK (Not Supported)
                test Composing: OK
                test Scaling: OK

        Codec ioctls:
                test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
                test VIDIOC_G_ENC_INDEX: OK (Not Supported)
                test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

        Buffer ioctls:
                test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
                test VIDIOC_EXPBUF: OK

Test input 0:

Total: 43, Succeeded: 43, Failed: 0, Warnings: 0


Change in v3:
1. Refine vdec hw clock setting
2. Refine vp9 codec driver
3. Refine v4l2 codec driver

Change in v2:
1. Add documentation for V4L2_PIX_FMT_MT21 2. Remove DRM_FORMAT_MT21 2. Refine code according to review comments

-/bin/sh: v4l2: not found
# v4l2-compliance -d /dev/video0
v4l2-compliance SHA   : fc45cdc502065bc1dfb4ef9ceb9a822bb9877bce

Driver Info:
        Driver name   : mtk-vcodec-dec
        Card type     : platform:mt8173
        Bus info      : platform:mt8173
        Driver version: 4.8.0
        Capabilities  : 0x84204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps   : 0x04204000
                Video Memory-to-Memory Multiplanar
                Streaming
                Extended Pix Format

Compliance test for device /dev/video0 (not using libv4l2):

Required ioctls:
        test VIDIOC_QUERYCAP: OK

Allow for multiple opens:
        test second video open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

        Control ioctls:
                test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
                test VIDIOC_QUERYCTRL: OK
                test VIDIOC_G/S_CTRL: OK
                test VIDIOC_G/S/TRY_EXT_CTRLS: OK
                test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
                test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
                Standard Controls: 2 Private Controls: 0

        Format ioctls:
                test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
                test VIDIOC_G/S_PARM: OK (Not Supported)
                test VIDIOC_G_FBUF: OK (Not Supported)
                test VIDIOC_G_FMT: OK
                test VIDIOC_TRY_FMT: OK
                test VIDIOC_S_FMT: OK
                test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
                test Cropping: OK (Not Supported)
                test Composing: OK
                test Scaling: OK

        Codec ioctls:
                test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
                test VIDIOC_G_ENC_INDEX: OK (Not Supported)
                test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

        Buffer ioctls:
                test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
                test VIDIOC_EXPBUF: OK

Test input 0:


Total: 43, Succeeded: 43, Failed: 0, Warnings: 0



Andrew-CT Chen (1):
  VPU: mediatek: Add decode support

Tiffany Lin (8):
  v4l: add Mediatek compressed video block format
  docs-rst: Add compressed video formats used on MT8173 codec driver
  dt-bindings: Add a binding for Mediatek Video Decoder
  vcodec: mediatek: Add Mediatek V4L2 Video Decoder Driver
  vcodec: mediatek: Add Mediatek H264 Video Decoder Driver
  vcodec: mediatek: Add Mediatek VP8 Video Decoder Driver
  vcodec: mediatek: Add Mediatek VP9 Video Decoder Driver
  arm64: dts: mediatek: Add Video Decoder for MT8173

 .../devicetree/bindings/media/mediatek-vcodec.txt  |   57 +-
 Documentation/media/uapi/v4l/pixfmt-reserved.rst   |    7 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   44 +
 drivers/media/platform/mtk-vcodec/Makefile         |   15 +-
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 1448 ++++++++++++++++++++
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h |   88 ++
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c |  394 ++++++
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c  |  205 +++
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h  |   28 +
 drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h |   76 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c |    2 -
 .../media/platform/mtk-vcodec/mtk_vcodec_intr.c    |    4 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_intr.h    |    2 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_util.c    |   33 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_util.h    |    7 +-
 .../media/platform/mtk-vcodec/vdec/vdec_h264_if.c  |  503 +++++++
 .../media/platform/mtk-vcodec/vdec/vdec_vp8_if.c   |  630 +++++++++
 .../media/platform/mtk-vcodec/vdec/vdec_vp9_if.c   |  967 +++++++++++++
 drivers/media/platform/mtk-vcodec/vdec_drv_base.h  |   56 +
 drivers/media/platform/mtk-vcodec/vdec_drv_if.c    |  123 ++
 drivers/media/platform/mtk-vcodec/vdec_drv_if.h    |  101 ++
 drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h   |  103 ++
 drivers/media/platform/mtk-vcodec/vdec_vpu_if.c    |  168 +++
 drivers/media/platform/mtk-vcodec/vdec_vpu_if.h    |   96 ++
 drivers/media/platform/mtk-vpu/mtk_vpu.c           |   12 +
 drivers/media/platform/mtk-vpu/mtk_vpu.h           |   27 +
 drivers/media/v4l2-core/v4l2-ioctl.c               |    1 +
 include/uapi/linux/videodev2.h                     |    1 +
 28 files changed, 5168 insertions(+), 30 deletions(-)
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h
 create mode 100644 drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c
 create mode 100644 drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c
 create mode 100644 drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
 create mode 100644 drivers/media/platform/mtk-vcodec/vdec_drv_base.h
 create mode 100644 drivers/media/platform/mtk-vcodec/vdec_drv_if.c
 create mode 100644 drivers/media/platform/mtk-vcodec/vdec_drv_if.h
 create mode 100644 drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h
 create mode 100644 drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
 create mode 100644 drivers/media/platform/mtk-vcodec/vdec_vpu_if.h

-- 
1.7.9.5
