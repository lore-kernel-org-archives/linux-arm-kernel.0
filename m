From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 19 Aug 2014 17:49:55 +0800
Subject: [PATCH 2/2] imx-drm: ipuv3-plane: fix kernel Oops in ipu_dp_put()
In-Reply-To: <1408441795-24719-1-git-send-email-shawn.guo@freescale.com>
References: <1408441795-24719-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1408441795-24719-3-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unbinding imx-hdmi or imx-ldb driver triggers a kernel Oops in function
ipu_dp_put() as below.

$ echo 120000.hdmi > /sys/devices/soc0/soc/2000000.aips-bus/120000.hdmi/driver/unbind
[   66.411700] Console: switching to colour dummy device 80x30
[   66.432543] drm_kms_helper: drm: unregistered panic notifier
[   66.515313] Unable to handle kernel NULL pointer dereference at virtual address 00000004
[   66.523445] pgd = bc494000
[   66.526161] [00000004] *pgd=4da3b831, *pte=00000000, *ppte=00000000
[   66.532521] Internal error: Oops: 817 [#1] SMP ARM
[   66.537320] Modules linked in:
[   66.540403] CPU: 1 PID: 1874 Comm: bash Not tainted 3.17.0-rc1-00030-gcbc339c9c4c0-dirty #398
[   66.548937] task: bc697500 ti: bc468000 task.ti: bc468000
[   66.554354] PC is at ipu_dp_put+0x10/0x18
[   66.558376] LR is at ipu_plane_dpms+0x60/0x8c
[   66.562743] pc : [<80360904>]    lr : [<804df730>]    psr: 20000013
[   66.562743] sp : bc469d50  ip : bc469d60  fp : bc469d5c
[   66.574227] r10: 00100100  r9 : bd94a474  r8 : 00200200
[   66.579459] r7 : bd94a3f4  r6 : bd94a400  r5 : 00000003  r4 : bd943c00
[   66.585992] r3 : 00000000  r2 : 00000000  r1 : bc6979d0  r0 : 00000000
[   66.592528] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   66.599670] Control: 10c5387d  Table: 4c49404a  DAC: 00000015
[   66.605422] Process bash (pid: 1874, stack limit = 0xbc468240)
[   66.611262] Stack: (0xbc469d50 to 0xbc46a000)
[   66.615629] 9d40:                                     bc469d74 bc469d60 804df730 80360900
[   66.623817] 9d60: bd943c00 bd94a000 bc469d8c bc469d78 804df788 804df6dc 00000000 bd943c00
[   66.632005] 9d80: bc469da4 bc469d90 804df7e8 804df768 804df7c0 bd943e00 bc469dd4 bc469da8
[   66.640202] 9da0: 8034e5b8 804df7cc bc697500 bd94a000 bd932a90 be1a3010 806ec3c0 0000000c
[   66.648406] 9dc0: bd5a4a0c bd5a4a00 bc469dec bc469dd8 804dc750 8034e3f4 bd94a000 bd94a000
[   66.656609] 9de0: bc469e0c bc469df0 80345cdc 804dc718 00000000 bd94a000 80965ec0 be1a3010
[   66.664813] 9e00: bc469e24 bc469e10 803467a0 80345cbc 804dc6d4 bd930a40 bc469e34 bc469e28
[   66.673017] 9e20: 804dc6e8 8034677c bc469e4c bc469e38 80362c80 804dc6e0 bd930fc0 bd932100
[   66.681219] 9e40: bc469e6c bc469e50 80362d28 80362c60 be1a3010 80987574 809661f8 0000000c
[   66.689423] 9e60: bc469e7c bc469e70 804e00f8 80362cac bc469e8c bc469e80 80368ac0 804e00ec
[   66.697627] 9e80: bc469ea4 bc469e90 8036721c 80368aac be1a3044 be1a3010 bc469ebc bc469ea8
[   66.705831] 9ea0: 80367298 803671b0 be1a3010 80987574 bc469edc bc469ec0 80366398 8036727c
[   66.714033] 9ec0: bd5a4a00 0000000c bd4fc580 bc469f78 bc469eec bc469ee0 80365acc 80366340
[   66.722237] 9ee0: bc469f0c bc469ef0 8014b224 80365ab0 8014b1d0 00000000 00000000 bd4fc580
[   66.730439] 9f00: bc469f44 bc469f10 8014a564 8014b1dc 00000000 00000000 00000001 bd66d040
[   66.738644] 9f20: 0000000c 0032ac08 bc469f78 0000000c bc468000 0032ac08 bc469f74 bc469f48
[   66.746847] 9f40: 800e7c50 8014a4a8 80102c04 80102b84 00000000 00000000 bd66d040 bd66d040
[   66.755050] 9f60: 0000000c 0032ac08 bc469fa4 bc469f78 800e8074 800e7bb4 00000000 00000000
[   66.763253] 9f80: 76ec85e0 0000000c 0032ac08 00000004 8000ed64 00000000 00000000 bc469fa8
[   66.771455] 9fa0: 8000eba0 800e803c 76ec85e0 0000000c 00000001 0032ac08 0000000c 00000000
[   66.779659] 9fc0: 76ec85e0 0000000c 0032ac08 00000004 7ee29a9c 000ad08c 00000000 003402e8
[   66.787862] 9fe0: 0000000c 7ee29a20 76e3796d 76e706bc 40000010 00000001 00000000 00000000
[   66.796052] Backtrace:
[   66.798558] [<803608f4>] (ipu_dp_put) from [<804df730>] (ipu_plane_dpms+0x60/0x8c)
[   66.806159] [<804df6d0>] (ipu_plane_dpms) from [<804df788>] (ipu_disable_plane+0x2c/0x64)
[   66.814352]  r5:bd94a000 r4:bd943c00
[   66.818002] [<804df75c>] (ipu_disable_plane) from [<804df7e8>] (ipu_plane_destroy+0x28/0x64)
[   66.826456]  r4:bd943c00 r3:00000000
[   66.830112] [<804df7c0>] (ipu_plane_destroy) from [<8034e5b8>] (drm_mode_config_cleanup+0x1d0/0x274)
[   66.839260]  r4:bd943e00 r3:804df7c0
[   66.842921] [<8034e3e8>] (drm_mode_config_cleanup) from [<804dc750>] (imx_drm_driver_unload+0x44/0x58)
[   66.852243]  r10:bd5a4a00 r9:bd5a4a0c r8:0000000c r7:806ec3c0 r6:be1a3010 r5:bd932a90
[   66.860210]  r4:bd94a000 r3:bc697500
[   66.863870] [<804dc70c>] (imx_drm_driver_unload) from [<80345cdc>] (drm_dev_unregister+0x2c/0xa0)
[   66.872758]  r5:bd94a000 r4:bd94a000
[   66.876411] [<80345cb0>] (drm_dev_unregister) from [<803467a0>] (drm_put_dev+0x30/0x6c)
[   66.884431]  r6:be1a3010 r5:80965ec0 r4:bd94a000 r3:00000000
[   66.890214] [<80346770>] (drm_put_dev) from [<804dc6e8>] (imx_drm_unbind+0x14/0x18)
[   66.897886]  r4:bd930a40 r3:804dc6d4
[   66.901542] [<804dc6d4>] (imx_drm_unbind) from [<80362c80>] (take_down_master+0x2c/0x4c)
[   66.909663] [<80362c54>] (take_down_master) from [<80362d28>] (component_del+0x88/0xd0)
[   66.917682]  r4:bd932100 r3:bd930fc0
[   66.921334] [<80362ca0>] (component_del) from [<804e00f8>] (imx_hdmi_platform_remove+0x18/0x24)
[   66.930048]  r7:0000000c r6:809661f8 r5:80987574 r4:be1a3010
[   66.935838] [<804e00e0>] (imx_hdmi_platform_remove) from [<80368ac0>] (platform_drv_remove+0x20/0x24)
[   66.945089] [<80368aa0>] (platform_drv_remove) from [<8036721c>] (__device_release_driver+0x78/0xcc)
[   66.954251] [<803671a4>] (__device_release_driver) from [<80367298>] (device_release_driver+0x28/0x34)
[   66.963572]  r5:be1a3010 r4:be1a3044
[   66.967221] [<80367270>] (device_release_driver) from [<80366398>] (unbind_store+0x64/0x9c)
[   66.975588]  r5:80987574 r4:be1a3010
[   66.979246] [<80366334>] (unbind_store) from [<80365acc>] (drv_attr_store+0x28/0x34)
[   66.987005]  r7:bc469f78 r6:bd4fc580 r5:0000000c r4:bd5a4a00
[   66.992793] [<80365aa4>] (drv_attr_store) from [<8014b224>] (sysfs_kf_write+0x54/0x58)
[   67.000741] [<8014b1d0>] (sysfs_kf_write) from [<8014a564>] (kernfs_fop_write+0xc8/0x188)
[   67.008933]  r6:bd4fc580 r5:00000000 r4:00000000 r3:8014b1d0
[   67.014722] [<8014a49c>] (kernfs_fop_write) from [<800e7c50>] (vfs_write+0xa8/0x1b0)
[   67.022482]  r10:0032ac08 r9:bc468000 r8:0000000c r7:bc469f78 r6:0032ac08 r5:0000000c
[   67.030450]  r4:bd66d040
[   67.033037] [<800e7ba8>] (vfs_write) from [<800e8074>] (SyS_write+0x44/0x90)
[   67.040102]  r10:0032ac08 r8:0000000c r7:bd66d040 r6:bd66d040 r5:00000000 r4:00000000
[   67.048092] [<800e8030>] (SyS_write) from [<8000eba0>] (ret_fast_syscall+0x0/0x48)
[   67.055677]  r10:00000000 r8:8000ed64 r7:00000004 r6:0032ac08 r5:0000000c r4:76ec85e0
[   67.063656] Code: e1a0c00d e92dd800 e24cb004 e3a03000 (e5c03004)
[   67.069914] ---[ end trace d739aae75ff0ad16 ]---

>From the call stack, the issue is caused by that ipu_dp_put() is called
from ipu_plane_dpms() with ipu_plane->dp being NULL.  Rather than
being called unconditionally, ipu_dp_put() should be called only when
ipu_plane->dp is valid, just like what ipu_plane_put_resources() does.
Acutally, all those ipu_*_put() calls in ipu_plane_dpms() are
unnecessary, because the only occurrence of ipu_plane_dpms() with 'mode'
not being DRM_MODE_DPMS_ON is from function ipu_disable_plane(), which
already has a ipu_plane_put_resources() call right after
ipu_plane_dpms().

The patch fixes above kernel Oops by removing those buggy and
unnecessary ipu_*_put() calls from ipu_plane_dpms().

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/staging/imx-drm/ipuv3-plane.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/imx-drm/ipuv3-plane.c b/drivers/staging/imx-drm/ipuv3-plane.c
index 6f393a11f44d..a79ae7731a03 100644
--- a/drivers/staging/imx-drm/ipuv3-plane.c
+++ b/drivers/staging/imx-drm/ipuv3-plane.c
@@ -274,15 +274,10 @@ static void ipu_plane_dpms(struct ipu_plane *ipu_plane, int mode)
 	if (enable == ipu_plane->enabled)
 		return;
 
-	if (enable) {
+	if (enable)
 		ipu_plane_enable(ipu_plane);
-	} else {
+	else
 		ipu_plane_disable(ipu_plane);
-
-		ipu_idmac_put(ipu_plane->ipu_ch);
-		ipu_dmfc_put(ipu_plane->dmfc);
-		ipu_dp_put(ipu_plane->dp);
-	}
 }
 
 /*
-- 
1.9.1
