From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Dec 2013 00:33:38 +0000
Subject: [BUG] Race in spdif initialisation / ASoC oopses on module removal
Message-ID: <20131216003338.GO4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So, I have the following as modules, and Ubuntu being Ubuntu, it loads
them in an apparantly random order on each boot.  The order in which it
loaded it this time was (most recent first):

snd_soc_fsl_spdif
imx_sdma
imx_pcm_dma
snd_soc_imx_spdif
snd_soc_spdif_tx

which produced these messages:

imx-spdif sound-spdif.17: ASoC: CPU DAI (null) not registered
imx-spdif sound-spdif.17: snd_soc_register_card failed: -517
platform sound-spdif.17: Driver imx-spdif requests probe deferral
imx-spdif sound-spdif.17: ASoC: CPU DAI (null) not registered
imx-spdif sound-spdif.17: snd_soc_register_card failed: -517
platform sound-spdif.17: Driver imx-spdif requests probe deferral
imx-spdif sound-spdif.17: ASoC: CPU DAI (null) not registered
imx-spdif sound-spdif.17: snd_soc_register_card failed: -517
platform sound-spdif.17: Driver imx-spdif requests probe deferral
imx-spdif sound-spdif.17: ASoC: CPU DAI (null) not registered
imx-spdif sound-spdif.17: snd_soc_register_card failed: -517
platform sound-spdif.17: Driver imx-spdif requests probe deferral
imx-sdma 20ec000.sdma: initialized
imx-sdma 20ec000.sdma: loaded firmware 1.1

Unloading and reloading snd_soc_imx_spdif then caused this:

fsl-spdif-dai 2004000.spdif: Missing dma channel for stream: 0
fsl-spdif-dai 2004000.spdif: ASoC: pcm constructor failed: -22
imx-spdif sound-spdif.17: ASoC: can't create pcm S/PDIF PCM Playback :-22
imx-spdif sound-spdif.17: ASoC: failed to instantiate card -22
imx-spdif sound-spdif.17: snd_soc_register_card failed: -22
imx-spdif: probe of sound-spdif.17 failed with error -22
fsl-spdif-dai 2004000.spdif: Missing dma channel for stream: 0
fsl-spdif-dai 2004000.spdif: ASoC: pcm constructor failed: -22
imx-spdif sound-spdif.17: ASoC: can't create pcm S/PDIF PCM Playback :-22
imx-spdif sound-spdif.17: ASoC: failed to instantiate card -22
imx-spdif sound-spdif.17: snd_soc_register_card failed: -22

and unloading all of them (except for imx_sdma and snd_soc_spdif_tx) and
reloading them in this order (most recent first):

snd_soc_imx_spdif
snd_soc_fsl_spdif
imx_pcm_dma

then produced:

imx-spdif sound-spdif.17: dit-hifi <-> 2004000.spdif mapping ok

Clearly something isn't right here.

Unloading snd_soc_imx_spdif to then try and re-provoke the problem then
caused this:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1301 at /home/rmk/git/linux-rmk/fs/sysfs/dir.c:915 sysfs_hash_and_remove+0x84/0x90()
sysfs: can not remove 'dapm_widget', no directory
Modules linked in: snd_soc_imx_spdif(-) snd_soc_fsl_spdif imx_pcm_dma fuse bnep rfcomm bluetooth imx_sdma imx_thermal imx2_wdt snd_soc_spdif_tx hid_cypress [last unloaded: imx_pcm_dma]
CPU: 0 PID: 1301 Comm: rmmod Not tainted 3.13.0-rc4+ #387
Backtrace: 
[<c0012640>] (dump_backtrace) from [<c00127dc>] (show_stack+0x18/0x1c)
 r6:00000393 r5:c016bfa4 r4:00000000 r3:00000000
[<c00127c4>] (show_stack) from [<c0683a18>] (dump_stack+0x70/0x90)
[<c06839a8>] (dump_stack) from [<c00244e0>] (warn_slowpath_common+0x74/0x94)
 r4:dab89d30 r3:00000000
[<c002446c>] (warn_slowpath_common) from [<c00245a4>] (warn_slowpath_fmt+0x38/0x40)
 r8:c689ce00 r7:00000000 r6:00000000 r5:c077c04c r4:dba2a318
[<c0024570>] (warn_slowpath_fmt) from [<c016bfa4>] (sysfs_hash_and_remove+0x84/0x90)
 r3:c077c04c r2:c06b3c38
[<c016bf20>] (sysfs_hash_and_remove) from [<c016a00c>] (sysfs_remove_file_ns+0x18/0x1c)
 r7:da916900 r6:00000000 r5:db2c900c r4:dba2a318
[<c0169ff4>] (sysfs_remove_file_ns) from [<c03687d4>] (device_remove_file+0x20/0x24)
[<c03687b4>] (device_remove_file) from [<c04f532c>] (snd_soc_dapm_free+0x1c/0x22c)
[<c04f5310>] (snd_soc_dapm_free) from [<c04f0c98>] (soc_remove_codec+0x34/0x98)
 r10:dabae59c r9:00000000 r8:c689ce00 r7:da916900 r6:00000000 r5:db2c900c
 r4:dba2a200 r3:00000000
[<c04f0c64>] (soc_remove_codec) from [<c04f3188>] (soc_remove_dai_links.clone.28+0x3c0/0x3ec)
 r4:00000000 r3:00000000
[<c04f2dc8>] (soc_remove_dai_links.clone.28) from [<c04f3248>] (snd_soc_unregister_card+0x94/0xc8)
 r10:d8435000 r9:db924204 r8:d8435000 r7:d079d480 r6:00000001 r5:00000608
 r4:dabae4b8
[<c04f31b4>] (snd_soc_unregister_card) from [<c04ffa70>] (devm_card_release+0x14/0x18)
 r6:00000003 r5:db924010 r4:dab89e60 r3:c04ffa5c
[<c04ffa5c>] (devm_card_release) from [<c036ec74>] (release_nodes+0x190/0x1f8)
[<c036eae4>] (release_nodes) from [<c036ed94>] (devres_release_all+0x38/0x54)
 r10:00000000 r9:dab88000 r8:c000eb44 r7:bef87600 r6:db924044 r5:bf131014
 r4:db924010
[<c036ed5c>] (devres_release_all) from [<c036b7a8>] (__device_release_driver+0x80/0xd4)
 r4:db924010 r3:bf12f000
[<c036b728>] (__device_release_driver) from [<c036bf28>] (driver_detach+0xbc/0xc0)
 r5:bf131014 r4:db924010
[<c036be6c>] (driver_detach) from [<c036b490>] (bus_remove_driver+0x54/0x98)
 r6:dab89f3c r5:bf131058 r4:bf131014 r3:db0c8000
[<c036b43c>] (bus_remove_driver) from [<c036c588>] (driver_unregister+0x30/0x4c)
 r4:bf131014 r3:c68a7a80
[<c036c558>] (driver_unregister) from [<c036d21c>] (platform_driver_unregister+0x14/0x18)
 r4:00000000 r3:bf12f2d0
[<c036d208>] (platform_driver_unregister) from [<bf12f2e4>] (imx_spdif_driver_exit+0x14/0xd30 [snd_soc_imx_spdif])
[<bf12f2d0>] (imx_spdif_driver_exit [snd_soc_imx_spdif]) from [<c008d764>] (SyS_delete_module+0x140/0x190)
[<c008d624>] (SyS_delete_module) from [<c000e980>] (ret_fast_syscall+0x0/0x48)
 r7:00000081 r6:000120a8 r5:bef87600 r4:00000880
---[ end trace 09423e64ab60df46 ]---
Unable to handle kernel NULL pointer dereference at virtual address 00000008
pgd = dab9c000
[00000008] *pgd=2062f831, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1] SMP ARM
Modules linked in: snd_soc_imx_spdif(-) snd_soc_fsl_spdif imx_pcm_dma fuse bnep rfcomm bluetooth imx_sdma imx_thermal imx2_wdt snd_soc_spdif_tx hid_cypress [last unloaded: imx_pcm_dma]
CPU: 0 PID: 1301 Comm: rmmod Tainted: G        W    3.13.0-rc4+ #387
task: db0c8000 ti: dab88000 task.ti: dab88000
PC is at soc_remove_codec+0x78/0x98
LR is at trace_hardirqs_on+0x14/0x18
pc : [<c04f0cdc>]    lr : [<c0066514>]    psr: 600f0013
sp : dab89dc8  ip : 00000020  fp : dab89ddc
r10: dabae59c  r9 : 00000000  r8 : c689ce00
r7 : da916900  r6 : 00000000  r5 : db2c900c  r4 : dba2a200
r3 : 00000000  r2 : 00100100  r1 : dabac810  r0 : dabae5f8
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 2ab9c059  DAC: 00000015
Process rmmod (pid: 1301, stack limit = 0xdab88240)
Stack: (0xdab89dc8 to 0xdab8a000)
9dc0:                   00000000 00000000 dab89e24 dab89de0 c04f3188 c04f0c70
9de0: d84355bc dabae5a0 00200200 00100100 00200200 00100100 d079d480 dabae4b8
9e00: 00000608 00000001 d079d480 d8435000 db924204 d8435000 dab89e44 dab89e28
9e20: c04f3248 c04f2dd4 c04ffa5c dab89e60 db924010 00000003 dab89e54 dab89e48
9e40: c04ffa70 c04f31c0 dab89e94 dab89e58 c036ec74 c04ffa68 dab89e94 a00f0013
9e60: dabae400 d079d480 00000002 db924010 bf131014 db924044 bef87600 c000eb44
9e80: dab88000 00000000 dab89eac dab89e98 c036ed94 c036eaf0 bf12f000 db924010
9ea0: dab89ec4 dab89eb0 c036b7a8 c036ed68 db924010 bf131014 dab89ee4 dab89ec8
9ec0: c036bf28 c036b734 db0c8000 bf131014 bf131058 dab89f3c dab89efc dab89ee8
9ee0: c036b490 c036be78 c68a7a80 bf131014 dab89f14 dab89f00 c036c588 c036b448
9f00: bf12f2d0 00000000 dab89f24 dab89f18 c036d21c c036c564 dab89f34 dab89f28
9f20: bf12f2e4 c036d214 dab89fa4 dab89f38 c008d764 bf12f2dc 00000000 5f646e73
9f40: 5f636f73 5f786d69 69647073 bef80066 dab89f74 dab89f60 c005f0d4 c0069020
9f60: 0077a008 00000000 00000880 bef87600 000120a8 00000081 bf131058 00000880
9f80: dab89f84 00000000 00000880 bef87600 000120a8 00000081 00000000 dab89fa8
9fa0: c000e980 c008d630 00000880 bef87600 bef87600 00000880 00009778 bef875f4
9fc0: 00000880 bef87600 000120a8 00000081 00000001 000120bc 00000001 00000000
9fe0: b6f03840 bef875fc 00008f75 b6f0384c 800f0010 bef87600 00000000 00000000
Backtrace: 
[<c04f0c64>] (soc_remove_codec) from [<c04f3188>] (soc_remove_dai_links.clone.28+0x3c0/0x3ec)
 r4:00000000 r3:00000000
[<c04f2dc8>] (soc_remove_dai_links.clone.28) from [<c04f3248>] (snd_soc_unregister_card+0x94/0xc8)
 r10:d8435000 r9:db924204 r8:d8435000 r7:d079d480 r6:00000001 r5:00000608
 r4:dabae4b8
[<c04f31b4>] (snd_soc_unregister_card) from [<c04ffa70>] (devm_card_release+0x14/0x18)
 r6:00000003 r5:db924010 r4:dab89e60 r3:c04ffa5c
[<c04ffa5c>] (devm_card_release) from [<c036ec74>] (release_nodes+0x190/0x1f8)
[<c036eae4>] (release_nodes) from [<c036ed94>] (devres_release_all+0x38/0x54)
 r10:00000000 r9:dab88000 r8:c000eb44 r7:bef87600 r6:db924044 r5:bf131014
 r4:db924010
[<c036ed5c>] (devres_release_all) from [<c036b7a8>] (__device_release_driver+0x80/0xd4)
 r4:db924010 r3:bf12f000
[<c036b728>] (__device_release_driver) from [<c036bf28>] (driver_detach+0xbc/0xc0)
 r5:bf131014 r4:db924010
[<c036be6c>] (driver_detach) from [<c036b490>] (bus_remove_driver+0x54/0x98)
 r6:dab89f3c r5:bf131058 r4:bf131014 r3:db0c8000
[<c036b43c>] (bus_remove_driver) from [<c036c588>] (driver_unregister+0x30/0x4c)
 r4:bf131014 r3:c68a7a80
[<c036c558>] (driver_unregister) from [<c036d21c>] (platform_driver_unregister+0x14/0x18)
 r4:00000000 r3:bf12f2d0
[<c036d208>] (platform_driver_unregister) from [<bf12f2e4>] (imx_spdif_driver_exit+0x14/0xd30 [snd_soc_imx_spdif])
[<bf12f2d0>] (imx_spdif_driver_exit [snd_soc_imx_spdif]) from [<c008d764>] (SyS_delete_module+0x140/0x190)
[<c008d624>] (SyS_delete_module) from [<c000e980>] (ret_fast_syscall+0x0/0x48)
 r7:00000081 r6:000120a8 r5:bef87600 r4:00000880
Code: e594100c e5842068 e584306c e5913080 (e5930008) 
---[ end trace 09423e64ab60df47 ]---
