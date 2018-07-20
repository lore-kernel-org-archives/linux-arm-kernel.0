From: alexandru-cosmin.gheorghe@arm.com (Alexandru Gheorghe)
Date: Fri, 20 Jul 2018 22:14:59 +0100
Subject: [PATCH 00/10] Add helper for plane reset
In-Reply-To: <20180713161407.GQ20303@art_vandelay>
References: <20180713161407.GQ20303@art_vandelay>
Message-ID: <20180720211509.23605-1-alexandru-cosmin.gheorghe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drivers that subclass drm_plane need to copy the logic for linking the
drm_plane with its state and to initialize core properties to their
default values. E.g (alpha and rotation)

Having a helper to reset the plane_state makes sense because of multiple
reasons:
1. Eliminate code duplication.
2. Add a single place for initializing core properties to their
default values, no need for driver to do it if what the helper sets
makes sense for them.
3. No need to debug the driver when you enable a core property and
observe it doesn't have a proper default value.

Tested with mali-dp the other drivers are just built-tested.


Alexandru Gheorghe (10):
  drm/atomic: Add  __drm_atomic_helper_plane_reset
  drm/amd/display: Use __drm_atomic_helper_plane_reset instead of
    copying the logic
  drm: mali-dp: Use __drm_atomic_helper_plane_reset instead of copying
    the logic
  drm: atmel-hlcdc: Use __drm_atomic_helper_plane_reset instead of
    copying the logic
  drm/exynos: Use __drm_atomic_helper_plane_reset instead of copying the
    logic
  drm/imx: Use __drm_atomic_helper_plane_reset instead of copying the
    logic
  drm: rcar-du: Use __drm_atomic_helper_plane_reset instead of copying
    the logic
  drm/sun4i: Use __drm_atomic_helper_plane_reset instead of copying the
    logic
  drm/vc4: Use __drm_atomic_helper_plane_reset instead of copying the
    logic
  drm/vmwgfx: Use __drm_atomic_helper_plane_reset instead of copying the
    logic

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 ++--
 drivers/gpu/drm/arm/malidp_planes.c           |  7 ++--
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   |  5 +--
 drivers/gpu/drm/drm_atomic_helper.c           | 32 +++++++++++++------
 drivers/gpu/drm/exynos/exynos_drm_plane.c     |  3 +-
 drivers/gpu/drm/imx/ipuv3-plane.c             |  8 ++---
 drivers/gpu/drm/rcar-du/rcar_du_plane.c       |  4 +--
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c         |  4 +--
 drivers/gpu/drm/sun4i/sun4i_layer.c           |  4 +--
 drivers/gpu/drm/vc4/vc4_plane.c               |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c           |  4 +--
 include/drm/drm_atomic_helper.h               |  2 ++
 12 files changed, 39 insertions(+), 45 deletions(-)

-- 
2.18.0
