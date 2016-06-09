From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu,  9 Jun 2016 17:18:16 +0100
Subject: [PATCH v3 0/3] Add support for ARM Mali Display Processors
Message-ID: <1465489099-25628-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the third revision of the driver for the Mali Display Processors (Mali DP).
Currently, the driver supports the Display Engine found in Mali DP500, DP550
and DP650, with up to 3 planes that can be rotated by the hardware. There are
features that the hardware supports that are not currently implemented in the
driver, but in the current form it is capable of supporting X11 using fbdev
emulation as well as Wayland with pixman rendering.

A copy of the patchset has been published here:

git://linux-arm.org/linux-ld.git for-upstream/mali-dp

After Daniel's non-blocking series gets into linux-next I plan to add that branch
as well, in preparation for v4.8.

Changes in v3:
 - rebased on top of Daniel Vetter's drm/stuff branch that implements non-blocking
   atomic commits.
 - Addressed comments from Emil Velikov's review
 - Re-ordered the malidp_hw_regmap struct to eliminate the un-needed padding
 - Lots more functions made static if they are not shared
 - Planes are now allocated with vanilla kzalloc() rather than devm_kzalloc() and
   freed in malidp_de_planes_destroy()

Changes in v2 vs initial RFC:
 - merged malidp_crtc_mode_set_nofb into malidp_crtc_enable and removed the
   mode_set hooks. This removed the need for a custom destroy hook as well,
   switched to using drm_crtc_cleanup for that.
 - implemented proper async support for atomic page flip.
 - removed un-necessary checks and empty hooks.
 - clarifications in the bindings document for the use of interrupt-names.
 - removed the MALIDP_HW_FEATURE_DS (display split) from this version pending
   further development
 - Renamed module from malidp to mali-dp.
 - Added MAINTAINERS update

Many thanks,
Liviu


Liviu Dudau (3):
  dt/bindings: display: Add DT bindings for Mali Display Processors.
  drm/arm: Add support for Mali Display Processors
  MAINTAINERS: Add entry for Mali-DP driver

 .../devicetree/bindings/display/arm,malidp.txt     |  65 ++
 MAINTAINERS                                        |  10 +-
 drivers/gpu/drm/arm/Kconfig                        |  16 +
 drivers/gpu/drm/arm/Makefile                       |   2 +
 drivers/gpu/drm/arm/malidp_crtc.c                  | 239 +++++++
 drivers/gpu/drm/arm/malidp_drv.c                   | 500 +++++++++++++++
 drivers/gpu/drm/arm/malidp_drv.h                   |  48 ++
 drivers/gpu/drm/arm/malidp_hw.c                    | 691 +++++++++++++++++++++
 drivers/gpu/drm/arm/malidp_hw.h                    | 241 +++++++
 drivers/gpu/drm/arm/malidp_planes.c                | 271 ++++++++
 drivers/gpu/drm/arm/malidp_regs.h                  | 172 +++++
 11 files changed, 2254 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/arm,malidp.txt
 create mode 100644 drivers/gpu/drm/arm/malidp_crtc.c
 create mode 100644 drivers/gpu/drm/arm/malidp_drv.c
 create mode 100644 drivers/gpu/drm/arm/malidp_drv.h
 create mode 100644 drivers/gpu/drm/arm/malidp_hw.c
 create mode 100644 drivers/gpu/drm/arm/malidp_hw.h
 create mode 100644 drivers/gpu/drm/arm/malidp_planes.c
 create mode 100644 drivers/gpu/drm/arm/malidp_regs.h

-- 
2.8.2
