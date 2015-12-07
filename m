From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon,  7 Dec 2015 12:11:01 +0000
Subject: [PATCH v5 0/4] drm: Add support for the ARM HDLCD display controller
Message-ID: <1449490265-6752-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for ARM's HDLCD display controller found in Juno
and ARM TC2 Coretile. The HDLCD outputs an RGB stream that feeds into a
single digital encoder (DVI or HDMI).

The dependencies for this patch series are now queued for the next release or
are already in the mainline.

Only the Juno functionality has been tested as the TC2 Coretile require
a working SiI9022 driver for VExpress that is not subject of this patchset.

Changelog:
v5: Queue the pending vblank events sent by userspace using a list instead of
    keeping the last event seen. Suggested by Daniel Stone <daniel@fooishbar.org>.
v4: Remove some debugging code that could return an error on a critical path
    and updated the check for valid format in hdlcd_set_pxl_fmt() to only
    WARN() if an invalid format found (unlikely case). Added the ACKs received. [1]
v3: Changed the driver to use the memory-region phandle for bespoke framebuffers. [2]
v2: Added support for atomic modeset [3]
v1: Original DRM submission [4]

[1] http://lists.freedesktop.org/archives/dri-devel/2015-December/095990.html
[2] http://lists.freedesktop.org/archives/dri-devel/2015-December/095877.html
[3] http://lists.freedesktop.org/archives/dri-devel/2015-November/094177.html
[4] http://lists.freedesktop.org/archives/dri-devel/2015-August/087685.html

Best regards,
Liviu

Liviu Dudau (4):
  drm: arm: Add DT bindings documentation for HDLCD driver.
  drm: Add support for ARM's HDLCD controller.
  arm64: Juno: Add HDLCD support to the Juno boards.
  MAINTAINERS: Add Liviu Dudau as maintainer for ARM HDLCD driver.

 .../devicetree/bindings/display/arm,hdlcd.txt      |  79 +++
 MAINTAINERS                                        |   6 +
 arch/arm64/boot/dts/arm/juno-base.dtsi             |  46 +-
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/arm/Kconfig                        |  29 ++
 drivers/gpu/drm/arm/Makefile                       |   2 +
 drivers/gpu/drm/arm/hdlcd_crtc.c                   | 329 ++++++++++++
 drivers/gpu/drm/arm/hdlcd_drv.c                    | 580 +++++++++++++++++++++
 drivers/gpu/drm/arm/hdlcd_drv.h                    |  42 ++
 drivers/gpu/drm/arm/hdlcd_regs.h                   |  87 ++++
 11 files changed, 1199 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/arm,hdlcd.txt
 create mode 100644 drivers/gpu/drm/arm/Kconfig
 create mode 100644 drivers/gpu/drm/arm/Makefile
 create mode 100644 drivers/gpu/drm/arm/hdlcd_crtc.c
 create mode 100644 drivers/gpu/drm/arm/hdlcd_drv.c
 create mode 100644 drivers/gpu/drm/arm/hdlcd_drv.h
 create mode 100644 drivers/gpu/drm/arm/hdlcd_regs.h

-- 
2.6.2
