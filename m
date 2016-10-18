From: zourongrong@gmail.com (Rongrong Zou)
Date: Tue, 18 Oct 2016 12:01:15 +0800
Subject: [PATCH v4 0/9] Add DRM driver for Hisilicon Hibmc
Message-ID: <1476763284-100508-1-git-send-email-zourongrong@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a new drm driver for Hisilicon Hibmc. Hibmc is a
BMC SoC with a display controller intergrated, usually it is used on
server for Out-of-band management purpose. In this patch set, we just
support basic function for Hibmc display subsystem. Hibmc display
subsystem is connected to host CPU by PCIe as blow:

+----------+       +----------+
|          | PCIe  |  Hibmc   |
|host CPU( |<----->| display  |
|arm64,x86)|       |subsystem |
+----------+       +----------+

Hardware Detail for Hibmc display subsystem
-----------

  The display subsystem of Hibmc is show as bellow:
  +----+      +----+      +----+     +--------+
  |    |      |    |      |    |     |        |
  | FB |----->| DE |----->|VDAC|---->|external|
  |    |      |    |      |    |     | VGA    |
  +----+      +----+      +----+     +--------+

  -DE(Display Engine) is the display controller.
  -VDAC(Video Digital-to-Analog converter) converts the RGB diaital data
  stream from DE to VGA analog signals.

Change History
------------

Changes in v4:
  -remove unused include files, and include header file when it is needed.
  -remove unused FLAG in Kconfig: DRM_GEM_CMA_HELPER/DRM_KMS_CMA_HELPER.
  -remove drm_helper_disable_unused_functions, since we use DRIVER_ATOMIC.

Changes in v3:
  -enable KMS, in v2, only fbdev is enabled.
  -management video memory with ttm.
  -add vblank interrupt.
  -remove drm_connector_register_all() and drm_connector_unregister_all().
  -I have a basic test with igt.

Changes in v2:
  -Remove self-defined macros for bit operations.
  -Remove unused register.
  -Replace those deprecated functions with new version of them.
  -use drm_connector_register_all() to register connector after
   drm_dev_register().

The patch v2 is at
https://lists.freedesktop.org/archives/dri-devel/2016-May/108661.html

Rongrong Zou (9):
  drm/hisilicon/hibmc: Add hisilicon hibmc drm master driver
  drm/hisilicon/hibmc: Add video memory management
  drm/hisilicon/hibmc: Add support for frame buffer
  drm/hisilicon/hibmc: Add plane for DE
  drm/hisilicon/hibmc: Add crtc for DE
  drm/hisilicon/hibmc: Add encoder for VDAC
  drm/hisilicon/hibmc: Add connector for VDAC
  drm/hisilicon/hibmc: Add vblank interruput
  MAINTAINERS: Update HISILICON DRM entries

 MAINTAINERS                                       |   1 +
 drivers/gpu/drm/hisilicon/Kconfig                 |   1 +
 drivers/gpu/drm/hisilicon/Makefile                |   1 +
 drivers/gpu/drm/hisilicon/hibmc/Kconfig           |   9 +
 drivers/gpu/drm/hisilicon/hibmc/Makefile          |   5 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 489 +++++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.h    |  29 ++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 421 ++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   | 116 +++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c | 257 ++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.c |  85 ++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.h |  28 ++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h  | 212 ++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 166 +++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c       | 564 ++++++++++++++++++++++
 15 files changed, 2384 insertions(+)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/Kconfig
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/Makefile
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c

-- 
1.9.1
