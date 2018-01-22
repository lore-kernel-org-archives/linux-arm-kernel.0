From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 11:35:29 +0100
Subject: [PATCH v2 00/19] drm/sun4i: Support more planes,
 zpos and plane-wide alpha
Message-ID: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This serie aims at enhancing the support for our planes in the current drm
driver on the first generation of Allwinner's display engine.

This also introduces a few generic stuff, as well as some conversion for
some other drivers.

This series basically implements three things that look orthogonal, but due
to the way the hardware works are kind of related.

The main feature is that instead of implementing 2 planes per backend, we
are now able to use the planes that are available in hardware. This was
unsupported before because of the way the composition works in the
hardware.

Indeed, the planes are first grouped into 2 pipes that are doing a basic
composition, in case of overlapping planes, it just takes whatever plane
has the highest priority (=> zpos). Then, the alpha blending is done
between the two pipes. This was simplified so far by only using two planes,
one for each pipe, which was allowing us to have an illusion of proper
alpha blending. This is further complicated by the bug/feature that the
lowest plane must not have any alpha at all, otherwise the pixel will turn
black, no matter what the value of alpha is. This basically means that we
can have a plane with alpha only in the second pipe.

However, as we have more and more blocks being worked on, 2 planes are
getting really limited and we need to support all 4 of them.

This is mostly possible by extending our atomic_check and to make sure that
we enforce those constraints, and assign the pipes automatically. This is
done by looking at the number of planes using an alpha component, and we
then end up in various scenarios:
  - 0 plane with alpha
    => we don't care for the pipes at all. All the planes are assigned to
       the first pipe
  - 1 plane with alpha
    => we assign all the planes without alpha below the plane with alpha to
       the first pipe, and then all the remaining planes to the second
       pipe. The plane with alpha will be the lowest plane on that pipe,
       which means that whatever plane is above it will have precedence,
       but the alpha component will remain and will be used on pixels that
       are not overlapping
  - 2-4 planes with alpha
    => we can't operate that way, we just reject the configuration.

In addition to the formats that embed an alpha component, we also add
support for plane-wide alpha property, and in order to tweak the
configuration the way we want to, we also add support for configurable
zpos.

Let me know what you think,
Maxime

Changes from v1:
  - Document the behaviour on concurrent usage of the alpha property and an
    alpha component in the format
  - Allowed for higher alpha values
  - Moved the alpha value from a helper to the struct drm_format_info
  - Collected tags

Maxime Ripard (19):
  drm/fourcc: Add a alpha field to drm_format_info
  drm/atmel-hlcdc: Use the alpha format field in drm_format_info
  drm/atmel-exynos: Use the alpha format field in drm_format_info
  drm/rockchip: Use the alpha format field in drm_format_info
  drm/vc4: Use the alpha format field in drm_format_info
  drm/blend: Add a generic alpha property
  drm/atmel-hclcdc: Convert to the new generic alpha property
  drm/rcar-du: Convert to the new generic alpha property
  drm/sun4i: backend: Fix structure indentation
  drm/sun4i: backend: Fix define typo
  drm/sun4i: framebuffer: Add a custom atomic_check
  drm/sun4i: backend: Move the coord function in the shared part
  drm/sun4i: backend: Set a default zpos in our reset hook
  drm/sun4i: backend: Add support for zpos
  drm/sun4i: backend: Check for the number of alpha planes
  drm/sun4i: backend: Assign the pipes automatically
  drm/sun4i: backend: Make zpos configurable
  drm/sun4i: Add support for plane alpha
  drm/sun4i: backend: Remove ARGB spoofing

 Documentation/gpu/kms-properties.csv            |   2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h    |  13 +--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 113 ++-------------
 drivers/gpu/drm/drm_atomic.c                    |   4 +-
 drivers/gpu/drm/drm_atomic_helper.c             |   4 +-
 drivers/gpu/drm/drm_blend.c                     |  32 ++++-
 drivers/gpu/drm/drm_fourcc.c                    |  50 +++----
 drivers/gpu/drm/exynos/exynos_mixer.c           |  14 +--
 drivers/gpu/drm/rcar-du/rcar_du_drv.h           |   1 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c           |   5 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c         |  15 +--
 drivers/gpu/drm/rcar-du/rcar_du_plane.h         |   2 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c           |  42 +------
 drivers/gpu/drm/rcar-du/rcar_du_vsp.h           |   2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c     |  13 +--
 drivers/gpu/drm/sun4i/sun4i_backend.c           | 124 +++++++++++++++--
 drivers/gpu/drm/sun4i/sun4i_backend.h           |  11 +-
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c       |  18 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c             |  84 ++----------
 drivers/gpu/drm/sun4i/sun4i_layer.h             |   1 +-
 drivers/gpu/drm/vc4/vc4_plane.c                 |  19 +--
 include/drm/drm_blend.h                         |   1 +-
 include/drm/drm_fourcc.h                        |   2 +-
 include/drm/drm_plane.h                         |   6 +-
 24 files changed, 275 insertions(+), 303 deletions(-)

base-commit: 53b519deaf2e507b121b64abcb4ba0da075bd6a7
-- 
git-series 0.9.1
