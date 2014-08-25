From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 25 Aug 2014 19:48:25 +0800
Subject: [PATCH v2 1/2] imx-drm: imx-ldb: fix kernel Oops in imx_ldb_unbind()
In-Reply-To: <1408967306-2624-1-git-send-email-shawn.guo@freescale.com>
References: <1408967306-2624-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1408967306-2624-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unbinding imx-ldb driver on imx6q-sabresd board triggers a kernel Oops
as below.

$ echo 2000000.aips-bus\:ldb\@020e0008 > unbind
[  423.031003] Console: switching to colour dummy device 80x30
[  423.052505] drm_kms_helper: drm: unregistered panic notifier
[  423.137082] Unable to handle kernel NULL pointer dereference at virtual address 0000001c
[  423.145185] pgd = bd6cc000
[  423.147937] [0000001c] *pgd=4cd23831, *pte=00000000, *ppte=00000000
[  423.154271] Internal error: Oops: 17 [#1] SMP ARM
[  423.158983] Modules linked in:
[  423.162067] CPU: 1 PID: 1854 Comm: bash Not tainted 3.17.0-rc1-00029-gd7473b0c2e59-dirty #397
[  423.170599] task: be21f500 ti: bd446000 task.ti: bd446000
[  423.176021] PC is at imx_ldb_unbind+0x28/0x50
[  423.180393] LR is at component_unbind+0x38/0x70
[  423.184932] pc : [<804dddd0>]    lr : [<80362e5c>]    psr: 20000013
[  423.184932] sp : bd447d78  ip : bd447d98  fp : bd447d94
[  423.196416] r10: bd7cbc00  r9 : bd7cbc0c  r8 : 0000001e
[  423.201648] r7 : bd84d010  r6 : 000003a8  r5 : 00000001  r4 : bd84d010
[  423.208181] r3 : 00000000  r2 : bd942000  r1 : be1a8410  r0 : bd84d020
[  423.214717] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  423.221858] Control: 10c5387d  Table: 4d6cc04a  DAC: 00000015
[  423.227611] Process bash (pid: 1854, stack limit = 0xbd446240)
[  423.233450] Stack: (0xbd447d78 to 0xbd448000)
[  423.237815] 7d60:                                                       bd931dc0 bd931b80
[  423.246003] 7d80: bd942000 806ec058 bd447db4 bd447d98 80362e5c 804dddb4 bd8df400 be1a2c10
[  423.254190] 7da0: bd931b80 bd931dc0 bd447dd4 bd447db8 80362f0c 80362e30 be21f500 bd942000
[  423.262376] 7dc0: bd8ed910 be1a2c10 bd447dec bd447dd8 804dc740 80362ea0 bd942000 bd942000
[  423.270563] 7de0: bd447e0c bd447df0 80345cdc 804dc718 00000000 bd942000 80965ec0 be1a2c10
[  423.278749] 7e00: bd447e24 bd447e10 803467a0 80345cbc 804dc6d4 bd931b80 bd447e34 bd447e28
[  423.286936] 7e20: 804dc6e8 8034677c bd447e4c bd447e38 80362c80 804dc6e0 80965ec0 bd931dc0
[  423.295123] 7e40: bd447e6c bd447e50 80362d28 80362c60 be1a2c10 80987418 809661f8 0000001e
[  423.303310] 7e60: bd447e7c bd447e70 804dde10 80362cac bd447e8c bd447e80 80368ac0 804dde04
[  423.311497] 7e80: bd447ea4 bd447e90 8036721c 80368aac be1a2c44 be1a2c10 bd447ebc bd447ea8
[  423.319683] 7ea0: 80367298 803671b0 be1a2c10 80987418 bd447edc bd447ec0 80366398 8036727c
[  423.327870] 7ec0: bd7cbc00 0000001e bd7760c0 bd447f78 bd447eec bd447ee0 80365acc 80366340
[  423.336056] 7ee0: bd447f0c bd447ef0 8014b224 80365ab0 8014b1d0 00000000 00000000 bd7760c0
[  423.344254] 7f00: bd447f44 bd447f10 8014a564 8014b1dc 00000000 00000000 00000001 bd4d5900
[  423.352457] 7f20: 0000001e 01a35c08 bd447f78 0000001e bd446000 01a35c08 bd447f74 bd447f48
[  423.360660] 7f40: 800e7c50 8014a4a8 80102c04 80102b84 00000000 00000000 bd4d5900 bd4d5900
[  423.368863] 7f60: 0000001e 01a35c08 bd447fa4 bd447f78 800e8074 800e7bb4 00000000 00000000
[  423.377066] 7f80: 76f825e0 0000001e 01a35c08 00000004 8000ed64 00000000 00000000 bd447fa8
[  423.385269] 7fa0: 8000eba0 800e803c 76f825e0 0000001e 00000001 01a35c08 0000001e 00000000
[  423.393472] 7fc0: 76f825e0 0000001e 01a35c08 00000004 7eeb6a9c 000ad08c 00000000 01a4b888
[  423.401674] 7fe0: 0000001e 7eeb6a20 76ef196d 76f2a6bc 40000010 00000001 00000000 00000000
[  423.409864] Backtrace:
[  423.412372] [<804ddda8>] (imx_ldb_unbind) from [<80362e5c>] (component_unbind+0x38/0x70)
[  423.420479]  r7:806ec058 r6:bd942000 r5:bd931b80 r4:bd931dc0
[  423.426265] [<80362e24>] (component_unbind) from [<80362f0c>] (component_unbind_all+0x78/0xb0)
[  423.434893]  r5:bd931dc0 r4:bd931b80
[  423.438548] [<80362e94>] (component_unbind_all) from [<804dc740>] (imx_drm_driver_unload+0x34/0x58)
[  423.447610]  r6:be1a2c10 r5:bd8ed910 r4:bd942000 r3:be21f500
[  423.453401] [<804dc70c>] (imx_drm_driver_unload) from [<80345cdc>] (drm_dev_unregister+0x2c/0xa0)
[  423.462289]  r5:bd942000 r4:bd942000
[  423.465942] [<80345cb0>] (drm_dev_unregister) from [<803467a0>] (drm_put_dev+0x30/0x6c)
[  423.473963]  r6:be1a2c10 r5:80965ec0 r4:bd942000 r3:00000000
[  423.479748] [<80346770>] (drm_put_dev) from [<804dc6e8>] (imx_drm_unbind+0x14/0x18)
[  423.487420]  r4:bd931b80 r3:804dc6d4
[  423.491072] [<804dc6d4>] (imx_drm_unbind) from [<80362c80>] (take_down_master+0x2c/0x4c)
[  423.499195] [<80362c54>] (take_down_master) from [<80362d28>] (component_del+0x88/0xd0)
[  423.507214]  r4:bd931dc0 r3:80965ec0
[  423.510868] [<80362ca0>] (component_del) from [<804dde10>] (imx_ldb_remove+0x18/0x24)
[  423.518714]  r7:0000001e r6:809661f8 r5:80987418 r4:be1a2c10
[  423.524501] [<804dddf8>] (imx_ldb_remove) from [<80368ac0>] (platform_drv_remove+0x20/0x24)
[  423.532884] [<80368aa0>] (platform_drv_remove) from [<8036721c>] (__device_release_driver+0x78/0xcc)
[  423.542045] [<803671a4>] (__device_release_driver) from [<80367298>] (device_release_driver+0x28/0x34)
[  423.551367]  r5:be1a2c10 r4:be1a2c44
[  423.555015] [<80367270>] (device_release_driver) from [<80366398>] (unbind_store+0x64/0x9c)
[  423.563381]  r5:80987418 r4:be1a2c10
[  423.567034] [<80366334>] (unbind_store) from [<80365acc>] (drv_attr_store+0x28/0x34)
[  423.574794]  r7:bd447f78 r6:bd7760c0 r5:0000001e r4:bd7cbc00
[  423.580580] [<80365aa4>] (drv_attr_store) from [<8014b224>] (sysfs_kf_write+0x54/0x58)
[  423.588526] [<8014b1d0>] (sysfs_kf_write) from [<8014a564>] (kernfs_fop_write+0xc8/0x188)
[  423.596720]  r6:bd7760c0 r5:00000000 r4:00000000 r3:8014b1d0
[  423.602508] [<8014a49c>] (kernfs_fop_write) from [<800e7c50>] (vfs_write+0xa8/0x1b0)
[  423.610268]  r10:01a35c08 r9:bd446000 r8:0000001e r7:bd447f78 r6:01a35c08 r5:0000001e
[  423.618234]  r4:bd4d5900
[  423.620819] [<800e7ba8>] (vfs_write) from [<800e8074>] (SyS_write+0x44/0x90)
[  423.627884]  r10:01a35c08 r8:0000001e r7:bd4d5900 r6:bd4d5900 r5:00000000 r4:00000000
[  423.635873] [<800e8030>] (SyS_write) from [<8000eba0>] (ret_fast_syscall+0x0/0x48)
[  423.643459]  r10:00000000 r8:8000ed64 r7:00000004 r6:01a35c08 r5:0000001e r4:76f825e0
[  423.651433] Code: e0247596 e2855001 e2840010 e59430a0 (e593301c)
[  423.657672] ---[ end trace 8e42829dfb82309e ]---

It's caused by that function imx_ldb_unbind() always tries to destroy
both LDB channels without checking if both channels are created in
imx_ldb_bind().  It's pretty often that only one of the LDB channels is
created just like the case of imx6q-sabresd board, and the
connector/encoder's destroy() function pointer of the other channel
will be invalid.

Fix the issue by checking if the LDB channel is actually created/valid
before calling into its connector/encoder's destroy() function.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/imx-ldb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
index 7e3f019d7e72..795794fff034 100644
--- a/drivers/staging/imx-drm/imx-ldb.c
+++ b/drivers/staging/imx-drm/imx-ldb.c
@@ -574,6 +574,8 @@ static void imx_ldb_unbind(struct device *dev, struct device *master,
 	for (i = 0; i < 2; i++) {
 		struct imx_ldb_channel *channel = &imx_ldb->channel[i];
 
+		if (channel->ldb == NULL)
+			continue;
 		channel->connector.funcs->destroy(&channel->connector);
 		channel->encoder.funcs->destroy(&channel->encoder);
 	}
-- 
1.9.1
