From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 22 Dec 2015 17:41:45 +0000
Subject: [PATCH v7 0/4] drm: Add support for the ARM HDLCD display controller
Message-ID: <1450806109-470-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for ARM's HDLCD display controller found in Juno
and ARM TC2 Coretile. The HDLCD outputs an RGB stream that feeds into a
single digital encoder (DVI or HDMI).

A few days after sending the v6 series and a timid pull request I've discovered
that the changes piled in linux-next will break my driver, so this is a refresh
to make it compile on top of Dave Airlie's drm-next.

There are still a few dependencies that haven't made it in linux-next that will
hamper testing of the series, so I've pushed the full set into [1]. Those of
you lucky enough to have a Juno board can give it a spin.

Only the Juno functionality has been tested as the TC2 Coretile require
a working SiI9022 driver for VExpress that is not subject of this patchset.

I haven't got any answer from Dave on my pull request, so I'm guessing he is not
ready to take it. I would appreciate some feedback on this version if he thinks
there are still issues to address.

Changelog:
v7: Updated the use of component API to match the updates queued by Russell King,
    as well as all the DRM changes that happened since 4.3-rc3 (remove
    drm_dev_set_unique() that is now done in drm_dev_alloc(), add the missing
    parameter in drm_universal_plane_init() and drm_crtc_init_with_planes()).
    This should compile cleanly on top of drm-next as of 22nd of December.
v6: Addressed the style nits pointed by Robin Murphy and fixed the use of
    default color to highlight underrun errors. Also modified MAINTAINERS file
    to change the status to Supported for HDLCD. [2]
v5: Queue the pending vblank events sent by userspace using a list instead of
    keeping the last event seen. Suggested by Daniel Stone <daniel@fooishbar.org>. [3]
v4: Remove some debugging code that could return an error on a critical path
    and updated the check for valid format in hdlcd_set_pxl_fmt() to only
    WARN() if an invalid format found (unlikely case). Added the ACKs received. [4]
v3: Changed the driver to use the memory-region phandle for bespoke framebuffers. [5]
v2: Added support for atomic modeset [6]
v1: Original DRM submission [7]

[1] git://linux-arm.org/linux-ld testing/hdlcd
[2] http://lists.freedesktop.org/archives/dri-devel/2015-December/096872.html
[3] http://lists.freedesktop.org/archives/dri-devel/2015-December/096432.html
[4] http://lists.freedesktop.org/archives/dri-devel/2015-December/095990.html
[5] http://lists.freedesktop.org/archives/dri-devel/2015-December/095877.html
[6] http://lists.freedesktop.org/archives/dri-devel/2015-November/094177.html
[7] http://lists.freedesktop.org/archives/dri-devel/2015-August/087685.html

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
 drivers/gpu/drm/arm/hdlcd_crtc.c                   | 327 ++++++++++++
 drivers/gpu/drm/arm/hdlcd_drv.c                    | 567 +++++++++++++++++++++
 drivers/gpu/drm/arm/hdlcd_drv.h                    |  42 ++
 drivers/gpu/drm/arm/hdlcd_regs.h                   |  87 ++++
 11 files changed, 1184 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/arm,hdlcd.txt
 create mode 100644 drivers/gpu/drm/arm/Kconfig
 create mode 100644 drivers/gpu/drm/arm/Makefile
 create mode 100644 drivers/gpu/drm/arm/hdlcd_crtc.c
 create mode 100644 drivers/gpu/drm/arm/hdlcd_drv.c
 create mode 100644 drivers/gpu/drm/arm/hdlcd_drv.h
 create mode 100644 drivers/gpu/drm/arm/hdlcd_regs.h

-- 
2.6.4
