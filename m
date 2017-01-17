From: randy.li@rock-chips.com (Randy Li)
Date: Tue, 17 Jan 2017 15:58:13 +0800
Subject: drm: rockchip: CONFIG_DRM_FBDEV_EMULATION will crash the HDMI down
 sometimes
Message-ID: <edb88801-6ea1-3909-2e4e-ba78df6d3c7c@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello:
   I want to enable the video output at RK3288 Firefly board, but I 
found if I enable CONFIG_DRM_FBDEV_EMULATION, the HDMI would crash down 
sometimes but sometimes it works. After disable that opinion, I never 
meet a problem. I have not verified it with eDP as I meet a big problem 
in there.

[  OK  ] Stopped LSB: Load kernel modules needed to enable cpufreq scaling.
[   33.282843] [drm:drm_atomic_helper_commit_cleanup_done 
[drm_kms_helper]] *ERROR* [CRTC:27:crtc-0] flip_done timed out
[   33.361489] ------------[ cut here ]------------
[   33.366251] WARNING: CPU: 2 PID: 476 at 
/home/ayaka/workspace/rk3288/kernel/linux-kernel/drivers/gpu/drm/rockchip/rockchip_drm$
vop.c:730 vop_plane_atomic_update+0x1218/0x177c [rockchipdrm]
[   33.383071] Modules linked in: rockchip_vop_reg rockchipdrm 
dw_hdmi_rockchip dw_hdmi drm_kms_helper cfbfillrect mali_kbase sys$
opyarea gpio_ir_recv cfbimgblt sysfillrect rc_core dwc2 sysimgblt 
fb_sys_fops panel_simple cfbcopyarea rk_crypto drm nvmem_rockch$
p_efuse udc_core des_generic phy_rockchip_usb pwm_rockchip pwm_bl 
backlight fb
[   33.412751] CPU: 2 PID: 476 Comm: X Tainted: G        W 
4.10.0-rc3-next-20170111+ #148
[   33.421182] Hardware name: Rockchip (Device Tree)
[   33.425905] [<c0112b98>] (unwind_backtrace) from [<c010dab8>] 
(show_stack+0x20/0x24)
[   33.433652] [<c010dab8>] (show_stack) from [<c044973c>] 
(dump_stack+0x8c/0xa0)
[   33.440881] [<c044973c>] (dump_stack) from [<c0125f88>] 
(__warn+0xf8/0x110)
[   33.447839] [<c0125f88>] (__warn) from [<c01260b8>] 
(warn_slowpath_null+0x30/0x38)
[   33.455431] [<c01260b8>] (warn_slowpath_null) from [<bf5cb4dc>] 
(vop_plane_atomic_update+0x1218/0x177c [rockchipdrm])
[   33.466126] [<bf5cb4dc>] (vop_plane_atomic_update [rockchipdrm]) from 
[<bf4d8590>] (drm_atomic_helper_commit_planes+0xd4/0x2b8
[drm_kms_helper])
[   33.479160] [<bf4d8590>] (drm_atomic_helper_commit_planes 
[drm_kms_helper]) from [<bf5c6a88>] (rockchip_atomic_commit_tail+0x4$
/0x68 [rockchipdrm])
[   33.492451] [<bf5c6a88>] (rockchip_atomic_commit_tail [rockchipdrm]) 
from [<bf4dc714>] (commit_tail+0x50/0xb8 [drm_kms_helper]$
[   33.504061] [<bf4dc714>] (commit_tail [drm_kms_helper]) from 
[<bf4dc870>] (drm_atomic_helper_commit+0xd4/0x13c [drm_kms_helper$
)
[   33.515850] [<bf4dc870>] (drm_atomic_helper_commit [drm_kms_helper]) 
from [<bf09318c>] (drm_atomic_commit+0x5c/0x68 [drm])
[   33.527126] [<bf09318c>] (drm_atomic_commit [drm]) from [<bf4e00f8>] 
(restore_fbdev_mode+0x160/0x300 [drm_kms_helper])
[   33.537952] [<bf4e00f8>] (restore_fbdev_mode [drm_kms_helper]) from 
[<bf4e171c>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x$
0/0x84 [drm_kms_helper])
[   33.551590] [<bf4e171c>] (drm_fb_helper_restore_fbdev_mode_unlocked 
[drm_kms_helper]) from [<bf5c6218>] (rockchip_drm_lastclos$
+0x1c/0x20 [rockchipdrm])
[   33.565404] [<bf5c6218>] (rockchip_drm_lastclose [rockchipdrm]) from 
[<bf07d20c>] (drm_lastclose+0x48/0xd8 [drm])
[   33.575977] [<bf07d20c>] (drm_lastclose [drm]) from [<bf07d560>] 
(drm_release+0x2c4/0x36c [drm])
[   33.584927] [<bf07d560>] (drm_release [drm]) from [<c02d7b34>] 
(__fput+0x9c/0x1e8)
[   33.592501] [<c02d7b34>] (__fput) from [<c02d7cf0>] (____fput+0x18/0x1c)
[   33.599206] [<c02d7cf0>] (____fput) from [<c0146ed4>] 
(task_work_run+0xcc/0xf0)
[   33.606519] [<c0146ed4>] (task_work_run) from [<c010d1b0>] 
(do_work_pending+0xd0/0xd4)
[   33.614439] [<c010d1b0>] (do_work_pending) from [<c0108e28>] 
(slow_work_pending+0xc/0x20)
[   33.622674] ---[ end trace 95ed2c3f167607d2 ]---
[   33.627327] ------------[ cut here ]------------
[   33.632013] WARNING: CPU: 2 PID: 476 at 
/home/ayaka/workspace/rk3288/kernel/linux-kernel/drivers/gpu/drm/rockchip/rockchip_drm_
vop.c:1017 vop_crtc_atomic_flush+0x27c/0x2b8 [rockchipdrm]
[   33.648542] Modules linked in: rockchip_vop_reg rockchipdrm 
dw_hdmi_rockchip dw_hdmi drm_kms_helper cfbfillrect mali_kbase sysc
opyarea gpio_ir_recv cfbimgblt sysfillrect rc_core dwc2 sysimgblt 
fb_sys_fops panel_simple cfbcopyarea rk_crypto drm nvmem_rockchi
p_efuse udc_core des_generic phy_rockchip_usb pwm_rockchip pwm_bl 
backlight fb
[   33.678191] CPU: 2 PID: 476 Comm: X Tainted: G        W 
4.10.0-rc3-next-20170111+ #148
[   33.686621] Hardware name: Rockchip (Device Tree)
[   33.691339] [<c0112b98>] (unwind_backtrace) from [<c010dab8>] 
(show_stack+0x20/0x24)
[   33.699084] [<c010dab8>] (show_stack) from [<c044973c>] 
(dump_stack+0x8c/0xa0)
[   33.706309] [<c044973c>] (dump_stack) from [<c0125f88>] 
(__warn+0xf8/0x110)
[   33.713275] [<c0125f88>] (__warn) from [<c01260b8>] 
(warn_slowpath_null+0x30/0x38)
[   33.720864] [<c01260b8>] (warn_slowpath_null) from [<bf5c83e0>] 
(vop_crtc_atomic_flush+0x27c/0x2b8 [rockchipdrm])
[   33.731208] [<bf5c83e0>] (vop_crtc_atomic_flush [rockchipdrm]) from 
[<bf4d868c>] (drm_atomic_helper_commit_planes+0x1d0/0x2b8 [
drm_kms_helper])
[   33.744159] [<bf4d868c>] (drm_atomic_helper_commit_planes 
[drm_kms_helper]) from [<bf5c6a88>] (rockchip_atomic_commit_tail+0x44
/0x68 [rockchipdrm])
[   33.757451] [<bf5c6a88>] (rockchip_atomic_commit_tail [rockchipdrm]) 
from [<bf4dc714>] (commit_tail+0x50/0xb8 [drm_kms_helper])
[   33.769064] [<bf4dc714>] (commit_tail [drm_kms_helper]) from 
[<bf4dc870>] (drm_atomic_helper_commit+0xd4/0x13c [drm_kms_helper]
)
[   33.780861] [<bf4dc870>] (drm_atomic_helper_commit [drm_kms_helper]) 
from [<bf09318c>] (drm_atomic_commit+0x5c/0x68 [drm])
[   33.792131] [<bf09318c>] (drm_atomic_commit [drm]) from [<bf4e00f8>] 
(restore_fbdev_mode+0x160/0x300 [drm_kms_helper])
[   33.802956] [<bf4e00f8>] (restore_fbdev_mode [drm_kms_helper]) from 
[<bf4e171c>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x4
0/0x84 [drm_kms_helper])
[   33.816590] [<bf4e171c>] (drm_fb_helper_restore_fbdev_mode_unlocked 
[drm_kms_helper]) from [<bf5c6218>] (rockchip_drm_lastclose
+0x1c/0x20 [rockchipdrm])
[   33.830406] [<bf5c6218>] (rockchip_drm_lastclose [rockchipdrm]) from 
[<bf07d20c>] (drm_lastclose+0x48/0xd8 [drm])
[   33.840975] [<bf07d20c>] (drm_lastclose [drm]) from [<bf07d560>] 
(drm_release+0x2c4/0x36c [drm])
[   33.849923] [<bf07d560>] (drm_release [drm]) from [<c02d7b34>] 
(__fput+0x9c/0x1e8)
[   33.857497] [<c02d7b34>] (__fput) from [<c02d7cf0>] (____fput+0x18/0x1c)
[   33.864201] [<c02d7cf0>] (____fput) from [<c0146ed4>] 
(task_work_run+0xcc/0xf0)
[   33.871514] [<c0146ed4>] (task_work_run) from [<c010d1b0>] 
(do_work_pending+0xd0/0xd4)
[   33.879434] [<c010d1b0>] (do_work_pending) from [<c0108e28>] 
(slow_work_pending+0xc/0x20)
[   33.887671] ---[ end trace 95ed2c3f167607d3 ]---
[   33.892322] ------------[ cut here ]------------
[   33.897058] WARNING: CPU: 2 PID: 476 at 
/home/ayaka/workspace/rk3288/kernel/linux-kernel/drivers/gpu/drm/drm_atomic_helper.c:15
63 drm_atomic_helper_commit_hw_done+0xc0/0xc8 [drm_kms_helper]
[   33.913937] Modules linked in: rockchip_vop_reg rockchipdrm 
dw_hdmi_rockchip dw_hdmi drm_kms_helper cfbfillrect mali_kbase sysc
opyarea gpio_ir_recv cfbimgblt sysfillrect rc_core dwc2 sysimgblt 
fb_sys_fops panel_simple cfbcopyarea rk_crypto drm nvmem_rockchi
p_efuse udc_core des_generic phy_rockchip_usb pwm_rockchip pwm_bl 
backlight fb
[   33.943581] CPU: 2 PID: 476 Comm: X Tainted: G        W 
4.10.0-rc3-next-20170111+ #148
[   33.952010] Hardware name: Rockchip (Device Tree)
[   33.956726] [<c0112b98>] (unwind_backtrace) from [<c010dab8>] 
(show_stack+0x20/0x24)
[   33.964470] [<c010dab8>] (show_stack) from [<c044973c>] 
(dump_stack+0x8c/0xa0)
[   33.971695] [<c044973c>] (dump_stack) from [<c0125f88>] 
(__warn+0xf8/0x110)
[   33.978661] [<c0125f88>] (__warn) from [<c01260b8>] 
(warn_slowpath_null+0x30/0x38)
[   33.986301] [<c01260b8>] (warn_slowpath_null) from [<bf4d9410>] 
(drm_atomic_helper_commit_hw_done+0xc0/0xc8 [drm_kms_helper])
[   33.997686] [<bf4d9410>] (drm_atomic_helper_commit_hw_done 
[drm_kms_helper]) from [<bf5c6a90>] (rockchip_atomic_commit_tail+0x4
c/0x68 [rockchipdrm])
[   34.011062] [<bf5c6a90>] (rockchip_atomic_commit_tail [rockchipdrm]) 
from [<bf4dc714>] (commit_tail+0x50/0xb8 [drm_kms_helper])
[   34.022670] [<bf4dc714>] (commit_tail [drm_kms_helper]) from 
[<bf4dc870>] (drm_atomic_helper_commit+0xd4/0x13c [drm_kms_helper]
)
[   34.034458] [<bf4dc870>] (drm_atomic_helper_commit [drm_kms_helper]) 
from [<bf09318c>] (drm_atomic_commit+0x5c/0x68 [drm])
[   34.045728] [<bf09318c>] (drm_atomic_commit [drm]) from [<bf4e00f8>] 
(restore_fbdev_mode+0x160/0x300 [drm_kms_helper])
[   34.056555] [<bf4e00f8>] (restore_fbdev_mode [drm_kms_helper]) from 
[<bf4e171c>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x4
0/0x84 [drm_kms_helper])
[   34.070190] [<bf4e171c>] (drm_fb_helper_restore_fbdev_mode_unlocked 
[drm_kms_helper]) from [<bf5c6218>] (rockchip_drm_lastclose
+0x1c/0x20 [rockchipdrm])
[   34.084005] [<bf5c6218>] (rockchip_drm_lastclose [rockchipdrm]) from 
[<bf07d20c>] (drm_lastclose+0x48/0xd8 [drm])
[   34.094581] [<bf07d20c>] (drm_lastclose [drm]) from [<bf07d560>] 
(drm_release+0x2c4/0x36c [drm])
[   34.103526] [<bf07d560>] (drm_release [drm]) from [<c02d7b34>] 
(__fput+0x9c/0x1e8)
[   34.111099] [<c02d7b34>] (__fput) from [<c02d7cf0>] (____fput+0x18/0x1c)
[   34.117802] [<c02d7cf0>] (____fput) from [<c0146ed4>] 
(task_work_run+0xcc/0xf0)
[   34.125115] [<c0146ed4>] (task_work_run) from [<c010d1b0>] 
(do_work_pending+0xd0/0xd4)
[   34.133034] [<c010d1b0>] (do_work_pending) from [<c0108e28>] 
(slow_work_pending+0xc/0x20)
[   34.141250] ---[ end trace 95ed2c3f167607d4 ]---
[   34.145921] ------------[ cut here ]------------
[   34.150566] WARNING: CPU: 2 PID: 476 at 
/home/ayaka/workspace/rk3288/kernel/linux-kernel/drivers/gpu/drm/rockchip/rockchip_drm_
vop.c:828 vop_crtc_enable_vblank+0x1ac/0x1b4 [rockchipdrm]
[   34.167054] Modules linked in: rockchip_vop_reg rockchipdrm 
dw_hdmi_rockchip dw_hdmi drm_kms_helper cfbfillrect mali_kbase sysc
opyarea gpio_ir_recv cfbimgblt sysfillrect rc_core dwc2 sysimgblt 
fb_sys_fops panel_simple cfbcopyarea rk_crypto drm nvmem_rockchi
p_efuse udc_core des_generic phy_rockchip_usb pwm_rockchip pwm_bl 
backlight fb
[   34.196651] CPU: 2 PID: 476 Comm: X Tainted: G        W 
4.10.0-rc3-next-20170111+ #148
[   34.205078] Hardware name: Rockchip (Device Tree)
[   34.209794] [<c0112b98>] (unwind_backtrace) from [<c010dab8>] 
(show_stack+0x20/0x24)
[   34.217538] [<c010dab8>] (show_stack) from [<c044973c>] 
(dump_stack+0x8c/0xa0)
[   34.224763] [<c044973c>] (dump_stack) from [<c0125f88>] 
(__warn+0xf8/0x110)
[   34.231729] [<c0125f88>] (__warn) from [<c01260b8>] 
(warn_slowpath_null+0x30/0x38)
[   34.239318] [<c01260b8>] (warn_slowpath_null) from [<bf5c7b7c>] 
(vop_crtc_enable_vblank+0x1ac/0x1b4 [rockchipdrm])
[   34.249693] [<bf5c7b7c>] (vop_crtc_enable_vblank [rockchipdrm]) from 
[<bf5c61f0>] (rockchip_drm_crtc_enable_vblank+0x48/0x54 [r
ockchipdrm])
[   34.262378] [<bf5c61f0>] (rockchip_drm_crtc_enable_vblank 
[rockchipdrm]) from [<bf07ff80>] (drm_vblank_enable+0x8c/0xf8 [drm])
[   34.274077] [<bf07ff80>] (drm_vblank_enable [drm]) from [<bf0800b4>] 
(drm_vblank_get+0xc8/0xf0 [drm])
[   34.283616] [<bf0800b4>] (drm_vblank_get [drm]) from [<bf0800fc>] 
(drm_crtc_vblank_get+0x20/0x24 [drm])
[   34.293239] [<bf0800fc>] (drm_crtc_vblank_get [drm]) from 
[<bf4dc00c>] (drm_atomic_helper_wait_for_vblanks.part.0+0xa8/0x2a8 [d
rm_kms_helper])
[   34.306146] [<bf4dc00c>] (drm_atomic_helper_wait_for_vblanks.part.0 
[drm_kms_helper]) from [<bf4dc230>] (drm_atomic_helper_wait
_for_vblanks+0x24/0x28 [drm_kms_helper])
[   34.321176] [<bf4dc230>] (drm_atomic_helper_wait_for_vblanks 
[drm_kms_helper]) from [<bf5c6a9c>] (rockchip_atomic_commit_tail+0
x58/0x68 [rockchipdrm])
[   34.334725] [<bf5c6a9c>] (rockchip_atomic_commit_tail [rockchipdrm]) 
from [<bf4dc714>] (commit_tail+0x50/0xb8 [drm_kms_helper])
[   34.346330] [<bf4dc714>] (commit_tail [drm_kms_helper]) from 
[<bf4dc870>] (drm_atomic_helper_commit+0xd4/0x13c [drm_kms_helper]
)
[   34.358117] [<bf4dc870>] (drm_atomic_helper_commit [drm_kms_helper]) 
from [<bf09318c>] (drm_atomic_commit+0x5c/0x68 [drm])
[   34.369386] [<bf09318c>] (drm_atomic_commit [drm]) from [<bf4e00f8>] 
(restore_fbdev_mode+0x160/0x300 [drm_kms_helper])
[   34.380209] [<bf4e00f8>] (restore_fbdev_mode [drm_kms_helper]) from 
[<bf4e171c>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x4
0/0x84 [drm_kms_helper])
[   34.393845] [<bf4e171c>] (drm_fb_helper_restore_fbdev_mode_unlocked 
[drm_kms_helper]) from [<bf5c6218>] (rockchip_drm_lastclose
+0x1c/0x20 [rockchipdrm])
[   34.407664] [<bf5c6218>] (rockchip_drm_lastclose [rockchipdrm]) from 
[<bf07d20c>] (drm_lastclose+0x48/0xd8 [drm])
[   34.418237] [<bf07d20c>] (drm_lastclose [drm]) from [<bf07d560>] 
(drm_release+0x2c4/0x36c [drm])
[   34.427179] [<bf07d560>] (drm_release [drm]) from [<c02d7b34>] 
(__fput+0x9c/0x1e8)
[   34.434754] [<c02d7b34>] (__fput) from [<c02d7cf0>] (____fput+0x18/0x1c)
[   34.441458] [<c02d7cf0>] (____fput) from [<c0146ed4>] 
(task_work_run+0xcc/0xf0)
[   34.448769] [<c0146ed4>] (task_work_run) from [<c010d1b0>] 
(do_work_pending+0xd0/0xd4)
[   34.456688] [<c010d1b0>] (do_work_pending) from [<c0108e28>] 
(slow_work_pending+0xc/0x20)
[   34.464856] ---[ end trace 95ed2c3f167607d5 ]---
-- 
Randy Li
The third produce department
===========================================================================
This email message, including any attachments, is for the sole
use of the intended recipient(s) and may contain confidential and
privileged information. Any unauthorized review, use, disclosure or
distribution is prohibited. If you are not the intended recipient, please
contact the sender by reply e-mail and destroy all copies of the original
message. [Fuzhou Rockchip Electronics, INC. China mainland]
===========================================================================
