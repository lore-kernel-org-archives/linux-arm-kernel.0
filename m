From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Wed, 20 Dec 2017 19:20:42 +0100
Subject: [PATCH 0/2] drm/rockchip: Fix sleeping function called from invalid
 context
Message-ID: <20171220182044.20331-1-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

After enable the debug option to check sleep inside atomic section I got
lots of messages from the drm/rockchip driver using current 4.15-rc4

 BUG: sleeping function called from invalid context at kernel/locking/mutex.c:238
 in_atomic(): 1, irqs_disabled(): 128, pid: 3457, name: Xorg
 CPU: 3 PID: 3457 Comm: Xorg Tainted: G        W        4.15.0-rc4+ #56
 Hardware name: Google Kevin (DT)
 Call trace:
  dump_backtrace+0x0/0x1a8
  show_stack+0x24/0x30
  dump_stack+0xb8/0xf0
  ___might_sleep+0x110/0x140
  __might_sleep+0x58/0x90
  mutex_lock+0x2c/0x68
  analogix_dp_psr_set+0x78/0x100
  rockchip_drm_do_flush+0x6c/0x88
  rockchip_drm_psr_flush_all+0x48/0x70
  rockchip_drm_fb_dirty+0x20/0x30
  drm_mode_dirtyfb_ioctl+0x1c4/0x1f8
  drm_ioctl_kernel+0x74/0xd0
  drm_ioctl+0x2b8/0x3c0
  do_vfs_ioctl+0xb0/0x818
  SyS_ioctl+0x94/0xa8
  el0_svc_naked+0x20/0x24

The two patches in this patchset were sent by Sean Paul some time ago
([1][2]) but never landed in mainline, the patches in question can fix the
issue reported and I think that could be interesting include both in this
release cycle, hence I'm resending it. The patches were rebased on top of
mainline.

[1] https://patchwork.kernel.org/patch/9382847/
[2] https://patchwork.kernel.org/patch/9614679/

Best regards,
 Enric

Sean Paul (2):
  drm/rockchip: Don't use atomic constructs for psr
  drm/rockchip: Remove analogix psr worker.

 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 30 +-----------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c     |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h     |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c     | 63 +++++++++++--------------
 4 files changed, 31 insertions(+), 66 deletions(-)

-- 
2.9.3
