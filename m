From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 28 Sep 2018 15:32:46 +0200
Subject: [PATCH] ARM: SAMSUNG: limit SAMSUNG_PM_CHECK config option to
 non-Exynos platforms
References: <CGME20180928133248eucas1p27feaea76c3193825e319943c60491962@eucas1p2.samsung.com>
Message-ID: <20180928133248eucas1p27feaea76c3193825e319943c60491962~Yk5t7fL-z0673006730eucas1p2K@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"S3C2410 PM Suspend Memory CRC" feature (controlled by
SAMSUNG_PM_CHECK config option) is incompatible with highmem
(uses phys_to_virt() instead of proper mapping) which is used by
the majority of Exynos boards. The issue manifests itself in OOPS
on affected boards, i.e. on Odroid-U3 I got the following one:

[   18.757127] Unable to handle kernel paging request at virtual address f0000000
[   18.757127] pgd = 1c0f9bb4
[   18.757127] [f0000000] *pgd=00000000
[   18.757127] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[   18.757127] Modules linked in:
[   18.757127] CPU: 0 PID: 1357 Comm: rtcwake Not tainted 4.19.0-rc1-next-20180830 #35
[   18.757127] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   18.757127] PC is at crc32_le+0x30/0x150
[   18.757127] LR is at s3c_pm_makecheck+0x34/0x54
[   18.757127] pc : [<c0458034>]    lr : [<c0121f8c>]    psr: 000000d3
[   18.757127] sp : ed2e3db0  ip : 00002000  fp : 00002000
[   18.757127] r10: 00000000  r9 : c0c2f6e8  r8 : c0fc0734
[   18.757127] r7 : 01000200  r6 : efffce40  r5 : ec68c000  r4 : effffffc
[   18.757127] r3 : c0a25dc0  r2 : 00000000  r1 : effffffc  r0 : ffffffff
[   18.757127] Flags: nzcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment none
[   18.757127] Control: 10c5387d  Table: 6d24c04a  DAC: 00000051
[   18.757127] Process rtcwake (pid: 1357, stack limit = 0x104b670f)
[   18.757127] Stack: (0xed2e3db0 to 0xed2e4000)
[   18.757127] 3da0:                                     c0fc0734 00000000 70000000 ec68c000
[   18.757127] 3dc0: efffce40 01000200 c0fc0734 c0c2f6e8 00000000 c0fac13c efffce40 ec680000
[   18.757127] 3de0: c0121f58 c0121efc c0fc773c c0f0f3cc ec680000 c0121f58 01000200 c0121ecc
[   18.757127] 3e00: c0fc773c c0f0d9e0 c0ce4d00 00000000 c0fac13c c01210b8 c0121054 c16d17ec
[   18.757127] 3e20: 00000003 c018893c c0f07470 ec60b300 ec60b880 c017cc5c 00000000 60000053
[   18.757127] 3e40: c0f07470 c0faa913 00000003 c0f07470 c0fac13c c0c2f6f8 c0faa913 c0a035c4
[   18.757127] 3e60: c0c2f71c c0189534 00000001 00000006 00000000 00000003 c0c286c8 c16d180c
[   18.757127] 3e80: 00000003 ec41c940 00000000 00000004 00000000 c0186ce8 00000004 ec4210c0
[   18.757127] 3ea0: 00000004 ec41c940 00000004 00000000 ec4210d0 c09db434 00000004 c02fa63c
[   18.757127] 3ec0: ec4210c0 ec41c940 ed2e3f80 c02f97a4 00000000 00000000 c0a0dec4 b6f1a000
[   18.757127] 3ee0: ed1f8f00 ed2e3f80 00000004 ed2e2000 b6f1a000 c027b198 00000001 c017ccd4
[   18.757127] 3f00: 00000001 c0f53b64 ed1301f4 c0198fa4 c0faa925 c01992d8 d166c958 00000000
[   18.757127] 3f20: 00000000 c027cad0 00000001 00000000 c027b4b8 00000000 ed118554 ed1f8f00
[   18.757127] 3f40: ed1f8f00 00000004 b6f1a000 00000000 ed2e3f80 c027b418 b6f1a000 c023e65c
[   18.757127] 3f60: 00000022 00000000 00000000 ed1f8f00 ed1f8f00 00000004 b6f1a000 c027b5d8
[   18.757127] 3f80: 00000000 00000000 00000000 00000004 b6f1a000 000160e0 00000004 c01011c4
[   18.757127] 3fa0: 00000004 c0101000 00000004 b6f1a000 00000004 b6f1a000 00000004 00000000
[   18.757127] 3fc0: 00000004 b6f1a000 000160e0 00000004 00000004 b6f1a000 00000004 00000000
[   18.757127] 3fe0: 00000000 be880b2c b6e21a6c b6e77a0c 60000050 00000004 00000000 00000000
[   18.757127] [<c0458034>] (crc32_le) from [<c0121f8c>] (s3c_pm_makecheck+0x34/0x54)
[   18.757127] [<c0121f8c>] (s3c_pm_makecheck) from [<c0121efc>] (s3c_pm_run_res+0x74/0x8c)
[   18.757127] [<c0121efc>] (s3c_pm_run_res) from [<c0121ecc>] (s3c_pm_run_res+0x44/0x8c)
[   18.757127] [<c0121ecc>] (s3c_pm_run_res) from [<c01210b8>] (exynos_suspend_enter+0x64/0x148)
[   18.757127] [<c01210b8>] (exynos_suspend_enter) from [<c018893c>] (suspend_devices_and_enter+0x9ec/0xe74)
[   18.757127] [<c018893c>] (suspend_devices_and_enter) from [<c0189534>] (pm_suspend+0x770/0xc04)
[   18.757127] [<c0189534>] (pm_suspend) from [<c0186ce8>] (state_store+0x6c/0xcc)
[   18.757127] [<c0186ce8>] (state_store) from [<c09db434>] (kobj_attr_store+0x14/0x20)
[   18.757127] [<c09db434>] (kobj_attr_store) from [<c02fa63c>] (sysfs_kf_write+0x4c/0x50)
[   18.757127] [<c02fa63c>] (sysfs_kf_write) from [<c02f97a4>] (kernfs_fop_write+0xfc/0x1e4)
[   18.757127] [<c02f97a4>] (kernfs_fop_write) from [<c027b198>] (__vfs_write+0x2c/0x140)
[   18.757127] [<c027b198>] (__vfs_write) from [<c027b418>] (vfs_write+0xa4/0x160)
[   18.757127] [<c027b418>] (vfs_write) from [<c027b5d8>] (ksys_write+0x40/0x8c)
[   18.757127] [<c027b5d8>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
[   18.757127] Exception stack(0xed2e3fa8 to 0xed2e3ff0)
[   18.757127] 3fa0:                   00000004 b6f1a000 00000004 b6f1a000 00000004 00000000
[   18.757127] 3fc0: 00000004 b6f1a000 000160e0 00000004 00000004 b6f1a000 00000004 00000000
[   18.757127] 3fe0: 00000000 be880b2c b6e21a6c b6e77a0c
[   18.757127] Code: 0a00002a e59f3120 e1a04001 e1a0c00b (e5945004)
[   18.757127] ---[ end trace 213166221066122e ]---

Add PLAT_S3C24XX, ARCH_S3C64XX and ARCH_S5PV210 dependencies to
SAMSUNG_PM_CHECK config option to hide it on Exynos platforms.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/plat-samsung/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/arch/arm/plat-samsung/Kconfig
===================================================================
--- a/arch/arm/plat-samsung/Kconfig	2018-09-28 15:20:00.057911275 +0200
+++ b/arch/arm/plat-samsung/Kconfig	2018-09-28 15:20:00.053911275 +0200
@@ -256,7 +256,7 @@ config S3C_PM_DEBUG_LED_SMDK
 
 config SAMSUNG_PM_CHECK
 	bool "S3C2410 PM Suspend Memory CRC"
-	depends on PM
+	depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210)
 	select CRC32
 	help
 	  Enable the PM code's memory area checksum over sleep. This option
