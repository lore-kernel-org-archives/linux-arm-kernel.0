From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  2 Jun 2016 16:31:27 +0200
Subject: [PATCH 00/20] drm/atomic: Provide default ->best_encoder() behavior
Message-ID: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series aims at replacing all dummy ->best_encoder()
implementations where we have a 1:1 relationship between encoders
and connectors.
The core already provides the drm_atomic_helper_best_encoder()
function which is taking the first encoder attached to the
connector (after making sure only one encoder was attached to the
connector), but it's not automatically used, and drivers wanting
to rely on this default behavior have to explicitly assign their
->best_encoder() hook to drm_atomic_helper_best_encoder().

The first patch fixes remaining places where
drm_atomic_helper_best_encoder() should be called when ->best_encoder()
is NULL, so that drivers using the atomic helpers can get rid of the
explicit ->best_encoder assignment if they need to rely on the default
drm_atomic_helper_best_encoder() implementation.

The following patches are killing all open coded ->best_encoder()
implementations that could be replaced by
drm_atomic_helper_best_encoder().

All modifications have been compile tested except for the changed on
the intel driver.
I've also tested on an atmel board, but I recommend waiting for DRM
driver maintainers feedback before applying the associated changes.

Note that once patch 1 is applied, the other patches can be applied
independently.

Best Regards,

Boris 

Boris Brezillon (20):
  drm/atomic: Fix remaining places where !funcs->best_encoder is valid
  drm: arc: Rely on the default ->best_encoder() behavior
  drm: atmel-hlcdc: Rely on the default ->best_encoder() behavior
  drm: exynos: Rely on the default ->best_encoder() behavior
  drm: fsl-dcu: Rely on the default ->best_encoder() behavior
  drm: i915: Rely on the default ->best_encoder() behavior where
    appropriate
  drm: mediatek: Rely on the default ->best_encoder() behavior
  drm: msm: Rely on the default ->best_encoder() behavior where
    appropriate
  drm: rcar-du: Rely on the default ->best_encoder() behavior
  drm: rockchip: Rely on the default ->best_encoder() behavior
  drm: sti: Rely on the default ->best_encoder() behavior
  drm: sun4i: Rely on the default ->best_encoder() behavior
  drm: tegra: Rely on the default ->best_encoder() behavior
  drm: vc4: Rely on the default ->best_encoder() behavior
  drm: virtgpu: Rely on the default ->best_encoder() behavior
  drm: omap: Rely on the default ->best_encoder() behavior
  drm/bridge: anx78xx: Rely on the default ->best_encoder() behavior
  drm/bridge: ptn3460: Rely on the default ->best_encoder() behavior
  drm/bridge: ps8622: Rely on the default ->best_encoder() behavior
  drm/bridge: dw-hdmi: Use drm_atomic_helper_best_encoder()

 drivers/gpu/drm/arc/arcpgu_hdmi.c                  | 18 ------------------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 12 ------------
 drivers/gpu/drm/bridge/analogix-anx78xx.c          |  8 --------
 drivers/gpu/drm/bridge/dw-hdmi.c                   | 11 +----------
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |  8 --------
 drivers/gpu/drm/bridge/parade-ps8622.c             | 10 ----------
 drivers/gpu/drm/drm_atomic_helper.c                |  4 +++-
 drivers/gpu/drm/drm_fb_helper.c                    | 13 ++++++++++++-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |  9 ---------
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |  9 ---------
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |  8 --------
 drivers/gpu/drm/exynos/exynos_hdmi.c               |  8 --------
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |  9 ---------
 drivers/gpu/drm/i915/intel_crt.c                   |  1 -
 drivers/gpu/drm/i915/intel_display.c               |  8 --------
 drivers/gpu/drm/i915/intel_dp.c                    |  1 -
 drivers/gpu/drm/i915/intel_drv.h                   |  1 -
 drivers/gpu/drm/i915/intel_dsi.c                   |  1 -
 drivers/gpu/drm/i915/intel_dvo.c                   |  1 -
 drivers/gpu/drm/i915/intel_hdmi.c                  |  1 -
 drivers/gpu/drm/i915/intel_lvds.c                  |  1 -
 drivers/gpu/drm/i915/intel_sdvo.c                  |  1 -
 drivers/gpu/drm/i915/intel_tv.c                    |  1 -
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |  9 ---------
 drivers/gpu/drm/msm/edp/edp_connector.c            | 10 ----------
 drivers/gpu/drm/msm/hdmi/hdmi_connector.c          |  8 --------
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_lvds_connector.c |  9 ---------
 drivers/gpu/drm/omapdrm/omap_connector.c           |  8 --------
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          | 12 ------------
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h          |  3 ---
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c          |  1 -
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c          |  1 -
 drivers/gpu/drm/rcar-du/rcar_du_vgacon.c           |  1 -
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c             |  9 ---------
 drivers/gpu/drm/rockchip/inno_hdmi.c               |  9 ---------
 drivers/gpu/drm/sti/sti_dvo.c                      | 10 ----------
 drivers/gpu/drm/sti/sti_hda.c                      | 10 ----------
 drivers/gpu/drm/sti/sti_hdmi.c                     | 10 ----------
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  | 10 ----------
 drivers/gpu/drm/sun4i/sun4i_tv.c                   |  9 ---------
 drivers/gpu/drm/tegra/drm.h                        |  2 --
 drivers/gpu/drm/tegra/dsi.c                        |  1 -
 drivers/gpu/drm/tegra/hdmi.c                       |  1 -
 drivers/gpu/drm/tegra/output.c                     |  8 --------
 drivers/gpu/drm/tegra/rgb.c                        |  1 -
 drivers/gpu/drm/tegra/sor.c                        |  1 -
 drivers/gpu/drm/vc4/vc4_dpi.c                      |  9 ---------
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  9 ---------
 drivers/gpu/drm/virtio/virtgpu_display.c           | 10 ----------
 49 files changed, 16 insertions(+), 299 deletions(-)

-- 
2.7.4
