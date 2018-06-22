From: dannf@dannf.org (dann frazier)
Date: Fri, 22 Jun 2018 17:09:43 -0600
Subject: arm64 regression bisected to "bpf: reject any prog that failed
 read-only lock"
Message-ID: <20180622230943.GA27737@xps13.dannf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fyi, I'm seeing a regression that I've bisected down to:
  9facc336876f bpf: reject any prog that failed read-only lock

A snippet of the boot messages are below. I'll be out of pocket until
Monday, so apologies in advance for delays in responding to follow-ups.

[   28.544142] Internal error: SP/PC alignment exception: 8a000000 [#21] SMP
[   28.550918] Modules linked in: btrfs zstd_compress hid_generic raid10 raid456 usbhid async_raid6_recov async_memcpy async_pq async_xor hid async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear marvell hibmc_drm aes_ce_blk ttm aes_ce_cipher drm_kms_helper crc32_ce crct10dif_ce syscopyarea ghash_ce qla2xxx sysfillrect sha2_ce sysimgblt fb_sys_fops sha256_arm64 sha1_ce hns3 mpt3sas nvme_fc hisi_sas_v3_hw nvme_fabrics drm ixgbe hisi_sas_main scsi_transport_fc hclge libsas ahci raid_class hnae3 libahci scsi_transport_sas mdio aes_neon_bs aes_neon_blk crypto_simd cryptd aes_arm64
[   28.602352] CPU: 19 PID: 1423 Comm: systemd-udevd Tainted: G      D           4.18.0-rc1+ #19
[   28.610861] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 EC UEFI Nemo 2.0 RC0 - B308 (V0.38) 06/02/2018
[   28.620674] pstate: 40400009 (nZcv daif +PAN -UAO)
[   28.625451] pc : 0xffff00000327f857
[   28.628928] lr : sk_filter_trim_cap+0x8c/0x1b8
[   28.633358] sp : ffff00002b1bba80
[   28.636659] x29: ffff00002b1bba80 x28: 0000000000000001 
[   28.641958] x27: ffff803f71e25800 x26: ffff803f6b16d000 
[   28.647257] x25: 0000000000000000 x24: 0000000000000000 
[   28.652555] x23: 0000000000000001 x22: ffff00002ab06000 
[   28.657854] x21: 0000000000000000 x20: ffff0000095c8000 
[   28.663152] x19: ffff803f73c7a700 x18: 0000fffff53ce450 
[   28.668451] x17: 0000ffffb96575f8 x16: ffff0000089c1c38 
[   28.673750] x15: 0000000000000020 x14: 5953425553003331 
[   28.679049] x13: 3a303a332d796870 x12: 2f7968705f736173 
[   28.684347] x11: 2f33313a303a332d x10: 00000000000000db 
[   28.689646] x9 : ffff00002b1bbd50 x8 : ffff803f73c7a700 
[   28.694945] x7 : ffff803f73c7be00 x6 : 0000000000001900 
[   28.700243] x5 : 0000000000000183 x4 : ffff803f80ccf9d0 
[   28.705542] x3 : 0000000000000000 x2 : ffff00000327f857 
[   28.710840] x1 : ffff00002ab06038 x0 : ffff803f73c7a700 
[   28.716140] Process systemd-udevd (pid: 1423, stack limit = 0x(____ptrval____))
[   28.723434] Call trace:
[   28.725867]  0xffff00000327f857
[   28.728995]  netlink_broadcast_filtered+0x234/0x418
[   28.733860]  netlink_sendmsg+0x354/0x360
[   28.737769]  sock_sendmsg+0x4c/0x68
[   28.741244]  ___sys_sendmsg+0x2ac/0x2f0
[   28.745067]  __sys_sendmsg+0x7c/0xd0
[   28.748629]  sys_sendmsg+0x38/0x48
[   28.752017]  el0_svc_naked+0x30/0x34
[   28.755580] Code: 202000d4 202000d4 202000d4 202000d4 (a9bf7bfd) 
[   28.761660] ---[ end trace 4451ed1a5b395c65 ]---
[   28.766267] Internal error: SP/PC alignment exception: 8a000000 [#22] SMP
[   28.773044] Modules linked in: btrfs zstd_compress hid_generic raid10 raid456 usbhid async_raid6_recov async_memcpy async_pq async_xor hid async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear marvell hibmc_drm aes_ce_blk ttm aes_ce_cipher drm_kms_helper crc32_ce crct10dif_ce syscopyarea ghash_ce qla2xxx sysfillrect sha2_ce sysimgblt fb_sys_fops sha256_arm64 sha1_ce hns3 mpt3sas nvme_fc hisi_sas_v3_hw nvme_fabrics drm ixgbe hisi_sas_main scsi_transport_fc hclge libsas ahci raid_class hnae3 libahci scsi_transport_sas mdio aes_neon_bs aes_neon_blk crypto_simd cryptd aes_arm64
[   28.824485] CPU: 20 PID: 1424 Comm: systemd-udevd Tainted: G      D           4.18.0-rc1+ #19
[   28.832994] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 EC UEFI Nemo 2.0 RC0 - B308 (V0.38) 06/02/2018
[   28.842805] pstate: 40400009 (nZcv daif +PAN -UAO)
[   28.847583] pc : 0xffff00000327f857
[   28.851060] lr : sk_filter_trim_cap+0x8c/0x1b8
[   28.855490] sp : ffff00002b1c3a80
[   28.858791] x29: ffff00002b1c3a80 x28: 0000000000000001 
[   28.864090] x27: ffff803f71e25800 x26: ffff803f6b169000 
[   28.869388] x25: 0000000000000000 x24: 0000000000000000 
[   28.874687] x23: 0000000000000001 x22: ffff00002ab06000 
[   28.879985] x21: 0000000000000000 x20: ffff0000095c8000 
[   28.885284] x19: ffff803f742c0900 x18: 0000fffff53ce450 
[   28.890583] x17: 0000ffffb96575f8 x16: ffff0000089c1c38 
[   28.895881] x15: 0000000000000020 x14: 5953425553003431 
[   28.901180] x13: 3a303a332d796870 x12: 2f7968705f736173 
[   28.906478] x11: 2f34313a303a332d x10: 00000000000000db 
[   28.911777] x9 : ffff00002b1c3d50 x8 : ffff803f742c0900 
[   28.917075] x7 : ffff803f742c0c00 x6 : 0000000000000500 
[   28.922374] x5 : 0000000000000045 x4 : ffff803f80ce89d0 
[   28.927673] x3 : 0000000000000000 x2 : ffff00000327f857 
[   28.932971] x1 : ffff00002ab06038 x0 : ffff803f742c0900 
[   28.938271] Process systemd-udevd (pid: 1424, stack limit = 0x(____ptrval____))
[   28.945565] Call trace:
[   28.947998]  0xffff00000327f857
[   28.951127]  netlink_broadcast_filtered+0x234/0x418
[   28.955991]  netlink_sendmsg+0x354/0x360
[   28.959901]  sock_sendmsg+0x4c/0x68
[   28.963377]  ___sys_sendmsg+0x2ac/0x2f0
[   28.967199]  __sys_sendmsg+0x7c/0xd0
[   28.970761]  sys_sendmsg+0x38/0x48
[   28.974150]  el0_svc_naked+0x30/0x34
[   28.977713] Code: 202000d4 202000d4 202000d4 202000d4 (a9bf7bfd) 
[   28.983793] ---[ end trace 4451ed1a5b395c66 ]---
[   28.988399] Internal error: SP/PC alignment exception: 8a000000 [#23] SMP
[   28.995175] Modules linked in: btrfs zstd_compress hid_generic raid10 raid456 usbhid async_raid6_recov async_memcpy async_pq async_xor hid async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear marvell hibmc_drm aes_ce_blk ttm aes_ce_cipher drm_kms_helper crc32_ce crct10dif_ce syscopyarea ghash_ce qla2xxx sysfillrect sha2_ce sysimgblt fb_sys_fops sha256_arm64 sha1_ce hns3 mpt3sas nvme_fc hisi_sas_v3_hw nvme_fabrics drm ixgbe hisi_sas_main scsi_transport_fc hclge libsas ahci raid_class hnae3 libahci scsi_transport_sas mdio aes_neon_bs aes_neon_blk crypto_simd cryptd aes_arm64
[   29.046612] CPU: 22 PID: 1425 Comm: systemd-udevd Tainted: G      D           4.18.0-rc1+ #19
[   29.055121] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 EC UEFI Nemo 2.0 RC0 - B308 (V0.38) 06/02/2018
[   29.064932] pstate: 40400009 (nZcv daif +PAN -UAO)
[   29.069710] pc : 0xffff00000327f857
[   29.073187] lr : sk_filter_trim_cap+0x8c/0x1b8
[   29.077616] sp : ffff00002b1cba80
[   29.080917] x29: ffff00002b1cba80 x28: 0000000000000001 
[   29.086216] x27: ffff803f71e25800 x26: ffff803f6b16b000 
[   29.091515] x25: 0000000000000000 x24: 0000000000000000 
[   29.096813] x23: 0000000000000001 x22: ffff00002ab06000 
[   29.102112] x21: 0000000000000000 x20: ffff0000095c8000 
[   29.107411] x19: ffff803f74362c00 x18: 0000fffff53ce450 
[   29.112709] x17: 0000ffffb96575f8 x16: ffff0000089c1c38 
[   29.118008] x15: 0000000000000020 x14: 5953425553003531 
[   29.123306] x13: 3a303a332d796870 x12: 2f7968705f736173 
[   29.128605] x11: 2f35313a303a332d x10: 00000000000000db 
[   29.133904] x9 : ffff00002b1cbd50 x8 : ffff803f74362c00 
[   29.139202] x7 : ffff803f74363900 x6 : 0000000000001500 
[   29.144501] x5 : 00000000000000c2 x4 : ffff803f80d1a9d0 
[   29.149799] x3 : 0000000000000000 x2 : ffff00000327f857 
[   29.155098] x1 : ffff00002ab06038 x0 : ffff803f74362c00 
[   29.160397] Process systemd-udevd (pid: 1425, stack limit = 0x(____ptrval____))
[   29.167691] Call trace:
[   29.170125]  0xffff00000327f857
[   29.173254]  netlink_broadcast_filtered+0x234/0x418
[   29.178118]  netlink_sendmsg+0x354/0x360
[   29.182027]  sock_sendmsg+0x4c/0x68
[   29.185503]  ___sys_sendmsg+0x2ac/0x2f0
[   29.189325]  __sys_sendmsg+0x7c/0xd0
[   29.192888]  sys_sendmsg+0x38/0x48
[   29.196276]  el0_svc_naked+0x30/0x34
[   29.199839] Code: 202000d4 202000d4 202000d4 202000d4 (a9bf7bfd) 
[   29.205919] ---[ end trace 4451ed1a5b395c67 ]---
