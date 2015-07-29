From: jianwei.wang.chn@gmail.com (Jianwei Wang)
Date: Wed, 29 Jul 2015 16:29:59 +0800
Subject: [PATCH v14 0/6] drm/layerscape: Add Freescale DCU DRM driver
Message-ID: <1438158605-28248-1-git-send-email-jianwei.wang.chn@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changed in v14

-Remove drm_modeset_lock_all before drm_mode_config_reset

Changed in v13
-set regmap_config.cache_type to REGCACHE_RBTREE
-add call drm_modeset_lock_all before drm_mode_config_reset
-adjust patch order for creating pull request

Changed in v12

-Add one patch for MAINTAINER entry for drm/layerscape
Adviced by Daniel Vetter
-Add #include <drm/drm_crtc_helper.h>

Changed in V11
-set regmap_config.cache_type to REGCACHE_FLAT
Advanced by Alexander Stein

Changed in V10
-adjust commit log, remove meaningless statement
-cleanup code for it's format and style.
-remove platform related code out, including of tcon(vf610) and scfg(ls1021a)
-remove useless sentences: encoder->crtc = crtc; and connector->encoder = encoder; and so on
-add vendor prefix for panel pandle
-make a DCU_CTRLDESCLN(x, y)  to avoid high repetition
-introduce per-SoC capability structure to avoid check on the OF node's compatible string
-Implement some functions: crtc enable and disable, enable and disable VBLANK, plane atomic_disable and atomic_enable -atomic_check and so on
-move DCU config sentence to the right place
-move get resources functions to  ->probe()
-move fsl,dcu.txt to video/ folder
-add big-endian describe
All advaced by Thierry Reding

Changed in V9

put node after calling of_drm_find_panel
split clk_prepare_enable() to clk_prepare() and clk_enable(), just call clk_prepare once, and check return value
check regmap_write/regmap_read return return value
remove useless ".owner    = THIS_MODULE,"
All advanced by Mark Yao

Changed in V8

- Remove useless code
#define DRIVER_NAME     "fsl-dcu-drm"
MODULE_ALIAS("platform:fsl-dcu-drm");
Adviced by Paul Bolle

Changed in V7

- Remove redundant functions and replace deprecated hook
Adviced by Daniel Vetter
- Replace drm_platform_init with drm_dev_alloc/register
Adviced by Daniel Vetter

Changed in V6

- Add NEC nl4827hc19_05b panel to panel-simple.c
Adviced by Mark Yao
- Add DRIVER_ATOMIC for driver_features
Adviced by Mark Yao
- check fsl_dev if it's NULL at PM suspend/resume
Adviced by Mark Yao

Changed in V5

- Update commit message
- Add layer registers initialization
- Remove unused functions
- Rename driver folder
Adviced by Stefan Agner
- Move pixel clock control functions to fsl_dcu_drm_drv.c
- remove redundant enable the clock implicitly using regmap
- Add maintainer message

Changed in V4:

-This version doesn't have functionality changed
Just a minor adjustment.

Changed in V3:

- Test driver on Vybrid board and add compatible string
- Remove unused functions
- set default crtc for encoder
- replace legacy functions with atomic help functions
Adviced by Daniel Vetter
- Set the unique name of the DRM device
- Implement irq handle function for vblank interrupt

Changed in v2:
- Add atomic support
Adviced by Daniel Vetter
- Modify bindings file
- Rename node for compatibility
- Move platform related code out for compatibility
Adviced by Stefan Agner


This patch add support for Two Dimensional Animation and Compositing
Engine (2D-ACE) on the Freescale SoCs.

2D-ACE is a Freescale display controller. 2D-ACE describes
the functionality of the module extremely well its name is a value
that cannot be used as a token in programming languages.
Instead the valid token "DCU" is used to tag the register names and
function names.

The Display Controller Unit (DCU) module is a system master that
fetches graphics stored in internal or external memory and displays
them on a TFT LCD panel. A wide range of panel sizes is supported
and the timing of the interface signals is highly configurable.
Graphics are read directly from memory and then blended in real-time,
which allows for dynamic content creation with minimal CPU
intervention.

The features:
(1) Full RGB888 output to TFT LCD panel.
(2) Blending of each pixel using up to 4 source layers
dependent
on size of panel.
(3) Each graphic layer can be placed with one pixel resolution
in either axis.
(4) Each graphic layer support RGB565 and RGB888 direct colors
without alpha channel and BGRA8888 BGRA4444 ARGB1555 direct
colors
with an alpha channel and YUV422 format.
(5) Each graphic layer support alpha blending with 8-bit
resolution.

This is a simplified version, only one primary plane, one
framebuffer, one crtc, one connector and one encoder for TFT
LCD panel.

---
 .../devicetree/bindings/video/fsl,dcu.txt          |  22 ++
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/fsl-dcu/Kconfig                    |  18 +
 drivers/gpu/drm/fsl-dcu/Makefile                   |   7 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c         | 208 +++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.h         |  19 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c          | 404 +++++++++++++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h          | 197 ++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_fbdev.c        |  23 ++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c          |  43 +++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_output.h       |  33 ++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c        | 261 +++++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.h        |  17 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          | 182 ++++++++++
 15 files changed, 1437 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/fsl,dcu.txt
 create mode 100644 drivers/gpu/drm/fsl-dcu/Kconfig
 create mode 100644 drivers/gpu/drm/fsl-dcu/Makefile
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.h
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_fbdev.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_output.h
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.h
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
