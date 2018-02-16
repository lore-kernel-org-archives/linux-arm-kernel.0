From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 16 Feb 2018 18:39:28 +0100
Subject: [PATCH v3 0/8] drm/sun4i: Support more planes,
 zpos and plane-wide alpha
Message-ID: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
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

Changes from v2:
  - Rebased on current drm-misc-next
  - Removed the patches already applied
  - Split the patch implementing the automatic pipe assignment in two

Changes from v1:
  - Document the behaviour on concurrent usage of the alpha property and an
    alpha component in the format
  - Allowed for higher alpha values
  - Moved the alpha value from a helper to the struct drm_format_info
  - Collected tags
  - Rebased on current drm-misc-next

Maxime Ripard (8):
  drm/blend: Add a generic alpha property
  drm/atmel-hclcdc: Convert to the new generic alpha property
  drm/rcar-du: Convert to the new generic alpha property
  drm/sun4i: backend: Assign the pipes automatically
  drm/sun4i: Remove the plane description structure
  drm/sun4i: backend: Make zpos configurable
  drm/sun4i: Add support for plane alpha
  drm/sun4i: backend: Remove ARGB spoofing

 Documentation/gpu/kms-properties.csv            |  2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h    | 13 +---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 89 ++----------------
 drivers/gpu/drm/drm_atomic.c                    |  4 +-
 drivers/gpu/drm/drm_atomic_helper.c             |  4 +-
 drivers/gpu/drm/drm_blend.c                     | 32 ++++++-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h           |  1 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c           |  5 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c         | 15 +--
 drivers/gpu/drm/rcar-du/rcar_du_plane.h         |  2 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c           | 42 +--------
 drivers/gpu/drm/rcar-du/rcar_du_vsp.h           |  2 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c           | 64 ++++++++++---
 drivers/gpu/drm/sun4i/sun4i_backend.h           |  3 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c             | 57 ++----------
 drivers/gpu/drm/sun4i/sun4i_layer.h             |  1 +-
 include/drm/drm_blend.h                         |  1 +-
 include/drm/drm_plane.h                         |  6 +-
 18 files changed, 140 insertions(+), 203 deletions(-)

base-commit: 5db520e36bca3e1e1575ab14ca7dfb23b3d68407
-- 
git-series 0.9.1
