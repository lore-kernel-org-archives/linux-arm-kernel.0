From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 31 Oct 2016 17:17:22 +0800
Subject: [PATCH v4 0/3] Add initial ZTE VOU DRM/KMS driver
Message-ID: <1477905445-4983-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

The series adds the initial ZTE VOU display controller DRM/KMS driver.
There are still some features to be added, like overlay plane, scaling,
and more output devices support.  But it's already useful with dual
CRTCs and HDMI display working.

Changes for v4:
 - Move the hardware setup done in zx_hdmi_hw_init() and clock enable
   into .enable hook of drm_encoder_helper_funcs.
 - Compare pipe to crtc->index instead of using our own index counter.
 - Save the pipe check in zx_vou_enable[disable]_vblank by putting frame
   interrupt bit into zx_crtc_bits.
 - Use DRM_DEV_* for log messages instead of old dev_* functions
 - Return directly in case of -ETIMEDOUT in zx_hdmi_i2c_read to simplify
   the code for error condition.
 - Shuffle things around to make the crtc and plane state check in
   zx_gl_plane_atomic_check a bit clearer
 - Move hardware register definitions into headers instead of disturbing
   C file reading.
 - Save the call to drm_connector_unregister(), so that
   drm_connector_cleanup can directly be used as drm_connector_funcs
   .destroy hook.
 - Move vblank notification from .atomic_begin hook to .atomic_flush,
   so that vblank event is sent to user space after planes are committed
   rather than before.

Changes for v3:
 - Rebase to v4.9-rc1
 - Update bindings doc to use 'ranges' for address translation between
   parent and child devices.
 - Call drm_dev_register() last in bind function and drm_dev_unregister()
   first in unbind, so that drm_connector_regiser() can be saved from
   HDMI driver.
 - Instead of using open-coded drm_do_get_edid(), add an I2C adapter for
   HDMI DDC read and use drm_get_edid().
 - Improve the plane .atomic_check implementation by calling helper
   function drm_plane_helper_check_state().
 - Rename zx_crtc.c to zx_vou.c to avoid the confusion that the file
   implements crtc instance.
 - Store vou pointer in zx_crtc, so that we do not need to embed the
   pointer in zx_drm_private.
 - Create zx_readl/zx_writel/zx_writel_mask for register access.
 - Define a few macro helpers to ease the register bit setting, like
   SYNC_WIDE, BACK_PORCH and FRONT_PORCH.
 - Define main/aux channel specific register offset and bits in zx_crtc
   to save the use of is_main check
 - Sort include headers alphabetically
 - Removing encoder pointer out of the structure and constify struct
   vou_inf
 - Add log message for error conditions
 - Make the function calls in teardown path asymmetrical
 - A few coding style improvements like defining macro for sub-module
   address and changing code to save indentation level
 - Add a MAINTAINERS entry for ZTE ZX DRM driver

Changes for v2:
 - Change device tree bindings to kill the virtual display-subsystem
   node make VOU the parent node.

Shawn Guo (3):
  dt-bindings: add bindings doc for ZTE VOU display controller
  drm: zte: add initial vou drm driver
  MAINTAINERS: add an entry for ZTE ZX DRM driver

 .../devicetree/bindings/display/zte,vou.txt        |  84 +++
 MAINTAINERS                                        |   7 +
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/zte/Kconfig                        |   8 +
 drivers/gpu/drm/zte/Makefile                       |   7 +
 drivers/gpu/drm/zte/zx_drm_drv.c                   | 267 +++++++++
 drivers/gpu/drm/zte/zx_drm_drv.h                   |  36 ++
 drivers/gpu/drm/zte/zx_hdmi.c                      | 624 +++++++++++++++++++
 drivers/gpu/drm/zte/zx_hdmi_regs.h                 |  56 ++
 drivers/gpu/drm/zte/zx_plane.c                     | 299 ++++++++++
 drivers/gpu/drm/zte/zx_plane.h                     |  26 +
 drivers/gpu/drm/zte/zx_plane_regs.h                |  91 +++
 drivers/gpu/drm/zte/zx_vou.c                       | 661 +++++++++++++++++++++
 drivers/gpu/drm/zte/zx_vou.h                       |  46 ++
 drivers/gpu/drm/zte/zx_vou_regs.h                  | 157 +++++
 16 files changed, 2372 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/zte,vou.txt
 create mode 100644 drivers/gpu/drm/zte/Kconfig
 create mode 100644 drivers/gpu/drm/zte/Makefile
 create mode 100644 drivers/gpu/drm/zte/zx_drm_drv.c
 create mode 100644 drivers/gpu/drm/zte/zx_drm_drv.h
 create mode 100644 drivers/gpu/drm/zte/zx_hdmi.c
 create mode 100644 drivers/gpu/drm/zte/zx_hdmi_regs.h
 create mode 100644 drivers/gpu/drm/zte/zx_plane.c
 create mode 100644 drivers/gpu/drm/zte/zx_plane.h
 create mode 100644 drivers/gpu/drm/zte/zx_plane_regs.h
 create mode 100644 drivers/gpu/drm/zte/zx_vou.c
 create mode 100644 drivers/gpu/drm/zte/zx_vou.h
 create mode 100644 drivers/gpu/drm/zte/zx_vou_regs.h

-- 
1.9.1
