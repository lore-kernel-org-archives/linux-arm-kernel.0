From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 15 Jun 2016 15:51:32 +0100
Subject: [PATCH v5 0/3] Add support for ARM Mali Display Processors
Message-ID: <1466002295-24813-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the fifth revision of the driver for the Mali Display Processors (Mali DP).
Currently, the driver supports the Display Engine found in Mali DP500, DP550
and DP650, with up to 3 planes that can be rotated by the hardware. There are
features that the hardware supports that are not currently implemented in the
driver, but in the current form it is capable of supporting X11 using fbdev
emulation as well as Wayland with pixman rendering.

A copy of the patchset has been published here:

git://linux-arm.org/linux-ld.git for-upstream/mali-dp

Daniel's non-blocking series is now on drm-misc so this branch is based on that
(tag topic/drm-misc-2016-06-14). Correct functionality of the driver depends on
two other patches from Daniel [1][2].

I will add my branch to linux-next soon.

Changes in v5:
 - Call drm_atomic_helper_commit_planes() with active_only = true, rather than false.
 - Add missing drm_crtc_vblank_{on,off} calls in malidp_crtc_{enable,disable}

Changes in v4:
 - Removed check for active crtc in malidp_crtc_disable() as this was unnecessary
 - Moved the dispatching of state events from malidp_crtc_atomic_flush() into the
   malidp_atomic_commit_hw_done() function where we can guarantee the GO status bit
   has been raised by the HW.
 - Used gem_free_object_unlocked hook instead of gem_free_object one.
 - Introduce a malidp_state structure to track per plane->state data related to the
   rotation memory usage so as not to break the TEST_ONLY atomic commits.

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

[1] https://lists.freedesktop.org/archives/dri-devel/2016-June/110855.html
[2] https://lists.freedesktop.org/archives/dri-devel/2016-June/110922.html


Liviu Dudau (3):
  dt/bindings: display: Add DT bindings for Mali Display Processors.
  drm/arm: Add support for Mali Display Processors
  MAINTAINERS: Add entry for Mali-DP driver

 .../devicetree/bindings/display/arm,malidp.txt     |  65 ++
 MAINTAINERS                                        |  10 +-
 drivers/gpu/drm/arm/Kconfig                        |  16 +
 drivers/gpu/drm/arm/Makefile                       |   2 +
 drivers/gpu/drm/arm/malidp_crtc.c                  | 216 +++++++
 drivers/gpu/drm/arm/malidp_drv.c                   | 512 +++++++++++++++
 drivers/gpu/drm/arm/malidp_drv.h                   |  54 ++
 drivers/gpu/drm/arm/malidp_hw.c                    | 691 +++++++++++++++++++++
 drivers/gpu/drm/arm/malidp_hw.h                    | 241 +++++++
 drivers/gpu/drm/arm/malidp_planes.c                | 298 +++++++++
 drivers/gpu/drm/arm/malidp_regs.h                  | 172 +++++
 11 files changed, 2276 insertions(+), 1 deletion(-)
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
