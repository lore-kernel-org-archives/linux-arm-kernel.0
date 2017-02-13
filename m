From: thibault.saunier@osg.samsung.com (Thibault Saunier)
Date: Mon, 13 Feb 2017 16:08:32 -0300
Subject: [PATCH v4 0/4] Fixes for colorspace logic in exynos-gsc and s5p-mfc
 drivers
Message-ID: <20170213190836.26972-1-thibault.saunier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset fixes a few issues on the colorspace logic for the exynos-gsc
and s5p-mfc drivers.

We now handle the colorspace in those drivers, and make sure to respect user setting if
possible.

We also now set the 'v4l2_pix_format:field' if userspace passed ANY, avoiding GStreamer
spamming error at us about the driver not following the standard.

This is the third version of the patch serie.

Best regards,

Thibault Saunier

Changes in v4:
- Reword commit message to better back our assumptions on specifications
- Use any colorspace provided by the user as it won't affect the way we
  handle our operations (guessing it if none is provided)
- Always use output colorspace on the capture side
- Set the colorspace only if the user passed V4L2_COLORSPACE_DEFAULT, in
  all other cases just use what userspace provided.

Changes in v3:
- Added 'Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>'
- Set colorspace if user passed V4L2_COLORSPACE_DEFAULT in
- Do not check values in the g_fmt functions as Andrzej explained in previous review

Changes in v2:
- Fix a silly build error that slipped in while rebasing the patches

Javier Martinez Canillas (1):
  [media] exynos-gsc: Use 576p instead 720p as a threshold for
    colorspaces

Thibault Saunier (3):
  [media] exynos-gsc: Respect userspace colorspace setting in try_fmt
  [media] s5p-mfc: Set colorspace in VIDIO_{G,TRY}_FMT if DEFAULT
    provided
  [media] s5p-mfc: Check and set 'v4l2_pix_format:field' field in
    try_fmt

 drivers/media/platform/exynos-gsc/gsc-core.c | 20 +++++++++++++++-----
 drivers/media/platform/exynos-gsc/gsc-core.h |  1 +
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 5 deletions(-)

-- 
2.11.1
