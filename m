From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 11 Dec 2015 15:04:43 +0000
Subject: [PATCH v6 0/4] drm: Add support for the ARM HDLCD display controller
Message-ID: <1449846287-21398-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for ARM's HDLCD display controller found in Juno
and ARM TC2 Coretile. The HDLCD outputs an RGB stream that feeds into a
single digital encoder (DVI or HDMI).

Most of the dependencies for this patch series are now queued for the next
release or are already in the mainline. The one dependency that I'm not sure
about its future is Thierry Reding's cleanup of the connector->encoder being
set in the drivers [1]. It is not blocking the HDLCD functionality but avoids
having an ugly WARNING splat at boot time.

Only the Juno functionality has been tested as the TC2 Coretile require
a working SiI9022 driver for VExpress that is not subject of this patchset.

I think I have addressed most of the comments and I would like to add the series
to some queue for v4.5. David Airlie's tree feels the most appropriate, even
if only 1 patch touches drivers/gpu/drm, but I'm open to suggestions.

Changelog:
v6: Addressed the style nits pointed by Robin Murphy and fixed the use of
    default color to highlight underrun errors. Also modified MAINTAINERS file
    to change the status to Supported for HDLCD.
v5: Queue the pending vblank events sent by userspace using a list instead of
    keeping the last event seen. Suggested by Daniel Stone <daniel@fooishbar.org>. [2]
v4: Remove some debugging code that could return an error on a critical path
    and updated the check for valid format in hdlcd_set_pxl_fmt() to only
    WARN() if an invalid format found (unlikely case). Added the ACKs received. [3]
v3: Changed the driver to use the memory-region phandle for bespoke framebuffers. [4]
v2: Added support for atomic modeset [5]
v1: Original DRM submission [6]

[1] http://lists.freedesktop.org/archives/dri-devel/2015-November/094576.html
[2] http://lists.freedesktop.org/archives/dri-devel/2015-December/096432.html
[3] http://lists.freedesktop.org/archives/dri-devel/2015-December/095990.html
[4] http://lists.freedesktop.org/archives/dri-devel/2015-December/095877.html
[5] http://lists.freedesktop.org/archives/dri-devel/2015-November/094177.html
[6] http://lists.freedesktop.org/archives/dri-devel/2015-August/087685.html

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
 drivers/gpu/drm/arm/hdlcd_drv.c                    | 579 +++++++++++++++++++++
 drivers/gpu/drm/arm/hdlcd_drv.h                    |  42 ++
 drivers/gpu/drm/arm/hdlcd_regs.h                   |  87 ++++
 11 files changed, 1196 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/arm,hdlcd.txt
 create mode 100644 drivers/gpu/drm/arm/Kconfig
 create mode 100644 drivers/gpu/drm/arm/Makefile
 create mode 100644 drivers/gpu/drm/arm/hdlcd_crtc.c
 create mode 100644 drivers/gpu/drm/arm/hdlcd_drv.c
 create mode 100644 drivers/gpu/drm/arm/hdlcd_drv.h
 create mode 100644 drivers/gpu/drm/arm/hdlcd_regs.h

-- 
2.6.4
