From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 14 Sep 2016 21:54:53 +0900
Subject: [PATCH 0/8] drm/rockchip: Flip wait clean-up
Message-ID: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The display controller found on Rockchip SoCs supported by Rockchip DRM
driver (VOP) is a bit problematic, because it does not provide hardware
vblank counter. Because vblank interrupt is used to feed the software
counter, the driver had custom code to wait for flip completion to avoid
race between atomic flush and vblank interrupt handler.

This, however, brought a different set of issues. In fact, even with the
custom wait code, there is stil a race between the handler and driver
state update (of the values used to compare with registers to determine
if flip has completed). On top of that, legacy cursor updates are not
implemented properly and have to wait for vblank to complete, which
is against the API specification.

This series attempts to clean up the driver from this custom waiting code,
eliminating related races and bringing correct handling of legacy cursor
plane. It also gives a nice effect of more than 100 lines of code removed.

This is a forward port of patches from 4.4 kernel used by ChromiumOS and
tested there. Even though the code base has not changed significantly, it
would be nice if someone with proper testing environment could give them
a try.

Based on for-next branch of Sean Paul's dogwood tree:
https://cgit.freedesktop.org/~seanpaul/dogwood/log/?h=for-next
git://people.freedesktop.org/~seanpaul/dogwood

Tomasz Figa (8):
  drm/rockchip: Clear interrupt status bits before enabling
  drm/rockchip: Get rid of some unnecessary code
  drm/rockchip: Avoid race with vblank count increment
  drm/rockchip: Unreference framebuffers from flip work
  drm/rockchip: Replace custom wait_for_vblanks with helper
  drm/rockchip: Do not enable vblank without event
  drm/rockchip: Always signal event in next vblank after cfg_done
  drm/rockchip: Kill vop_plane_state

 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   1 -
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |  64 +------
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 247 +++++++++++-----------------
 3 files changed, 95 insertions(+), 217 deletions(-)

-- 
2.8.0.rc3.226.g39d4020
