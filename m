From: mjourdan@baylibre.com (Maxime Jourdan)
Date: Wed, 7 Nov 2018 10:41:27 +0100
Subject: [PATCH 1/3] drm/meson: Support Overlay plane for video rendering
In-Reply-To: <1541497202-20570-2-git-send-email-narmstrong@baylibre.com>
References: <1541497202-20570-1-git-send-email-narmstrong@baylibre.com>
 <1541497202-20570-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAMO6nay=te3W67b83LKv35tXL8+09rvE9EaFwLDrRBhwpEgMvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 6, 2018 at 10:40 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic Meson GX SoCs support an Overlay plane behind the primary
> plane for video rendering.
>
> This Overlay plane support various YUV layouts :
> - YUYV
> - NV12 / NV21
> - YUV444 / 422 / 420 / 411 / 410
>
> The scaler supports a wide range of scaling ratios, but for simplicity,
> plane atomic check limits the scaling from x5 to /5 in vertical and
> horizontal scaling.
>
> The z-order is fixed and always behind the primary plane and cannot be changed.
>
> The scaling parameter algorithm was taken from the Amlogic vendor kernel
> code and rewritten to match the atomic universal plane requirements.
>
> The video rendering using this overlay plane support has been tested using
> the new Kodi DRM-KMS Prime rendering path along the in-review V4L2 Mem2Mem
> Hardware Video Decoder up to 3840x2160 NV12 frames on various display modes.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/Makefile          |   2 +-
>  drivers/gpu/drm/meson/meson_canvas.c    |   7 +-
>  drivers/gpu/drm/meson/meson_canvas.h    |  11 +-
>  drivers/gpu/drm/meson/meson_crtc.c      | 216 +++++++++++-
>  drivers/gpu/drm/meson/meson_drv.c       |  29 +-
>  drivers/gpu/drm/meson/meson_drv.h       |  52 +++
>  drivers/gpu/drm/meson/meson_overlay.c   | 586 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/meson/meson_overlay.h   |  14 +
>  drivers/gpu/drm/meson/meson_registers.h |   3 +
>  drivers/gpu/drm/meson/meson_viu.c       |  15 +
>  drivers/gpu/drm/meson/meson_vpp.c       |  44 ++-
>  11 files changed, 971 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/gpu/drm/meson/meson_overlay.c
>  create mode 100644 drivers/gpu/drm/meson/meson_overlay.h
>

Tested by rendering video with:
 - gstreamer 1.14.4 using kmssink
 - ffmpeg-drm (https://github.com/Elyotna/ffmpeg-drm),
by applying this patch on top of the video decoder patch series.

Used different resolutions and pixel aspect ratios.

Tested-by: Maxime Jourdan <mjourdan@baylibre.com>

[snip]
