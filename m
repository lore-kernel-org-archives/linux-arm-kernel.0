From: keiichiw@chromium.org (Keiichi Watanabe)
Date: Thu, 14 Jun 2018 16:46:49 +0900
Subject: [PATCH v3 0/3] Add controls for VP8/VP9 profile
Message-ID: <20180614074652.162796-1-keiichiw@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add new menu controls V4L2_CID_MPEG_VIDEO_VP8_PROFILE and
V4L2_CID_MPEG_VIDEO_VP9_PROFILE for VP8/VP9 profiles. These controls can be used
to select a desired profile for VP8/VP9 encoders. In addition, they are also
used to query for supported profiles by an encoder or a decoder.

Patch 1 adds a control V4L2_CID_MPEG_VIDEO_VP8_PROFILE for VP8 profile. Though
V4L2_CID_MPEG_VIDEO_VPX_PROFILE is originally used for VP8 profile, this control
is not good by the following reasons:
(i) Despite the name contains 'VPX', it cannot be used for VP9 because supported
profiles differ between VP8 and VP9.
(ii) Unlike other controls for profiles (e.g. H264), this is not a menu control
but an integer control, which cannot be used to query for supported profiles.

Thus, V4L2_CID_MPEG_VIDEO_VPX_PROFILE is deprecated and become an alias of
V4L2_CID_MPEG_VIDEO_VP8_PROFILE. In addition, Patch 1 fixes the use of
V4L2_CID_MPEG_VIDEO_VPX_PROFILE in existing venus/s5p_mfc drivers.

Patch 2 adds a control V4L2_CID_MPEG_VIDEO_VP9_PROFILE for VP9 profile.

By patch 3, this control is supported in MediaTek decoder's driver, which
supports VP9 profile 0.

Version 3 changes:
- Add V4L2_CID_MPEG_VIDEO_VP8_PROFILE in v4l2-controls.
- Make V4L2_CID_MPEG_VIDEO_VPX_PROFILE to be an alias of
  V4L2_CID_MPEG_VIDEO_VP8_PROFILE.
- Fix the use of V4L2_CID_MPEG_VIDEO_VPX_PROFILE in venus/s5p_mfc drivers.
- Small fix in mtk_vcodec_dec.

Version 2 changes:
- Support V4L2_CID_MPEG_VIDEO_VP9_PROFILE in MediaTek decoder's driver.

Version 1 changes:
- Add V4L2_CID_MPEG_VIDEO_VP9_PROFILE in v4l2-controls.

Keiichi Watanabe (3):
  media: v4l2-ctrl: Change control for VP8 profile to menu control
  media: v4l2-ctrl: Add control for VP9 profile
  media: mtk-vcodec: Support VP9 profile in decoder

 .../media/uapi/v4l/extended-controls.rst      | 52 +++++++++++++++++--
 .../platform/mtk-vcodec/mtk_vcodec_dec.c      |  5 ++
 drivers/media/platform/qcom/venus/core.h      |  2 +-
 .../media/platform/qcom/venus/hfi_helper.h    | 12 ++---
 .../media/platform/qcom/venus/vdec_ctrls.c    | 10 ++--
 drivers/media/platform/qcom/venus/venc.c      | 14 ++---
 .../media/platform/qcom/venus/venc_ctrls.c    | 12 +++--
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c  | 15 +++---
 drivers/media/v4l2-core/v4l2-ctrls.c          | 23 +++++++-
 include/uapi/linux/v4l2-controls.h            | 18 ++++++-
 10 files changed, 127 insertions(+), 36 deletions(-)

--
2.18.0.rc1.242.g61856ae69a-goog
