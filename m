From: tyler.baker@linaro.org (Tyler Baker)
Date: Thu, 3 Dec 2015 15:38:53 -0800
Subject: [PATCH v2] ARM: Enable GICv2m on 32-bit virt machine
In-Reply-To: <1448624071-9552-1-git-send-email-p.fedin@samsung.com>
References: <1448624071-9552-1-git-send-email-p.fedin@samsung.com>
Message-ID: <CANMBJr6D=-meT6MEQtgyiG2rZ+vzsq-AgLEBAJ7ob-ak2-87wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On 27 November 2015 at 03:34, Pavel Fedin <p.fedin@samsung.com> wrote:
> Modern qemu includes GICv2m support for both 64 and 32 bits, therefore
> 32-bit guests may also use MSI.
>
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>

The kernelci.org bot reported new boot failures[1] in Russell's tree
today. Specifically, it is causing boot regressions with
multi_v7_defconfig variants on the tegra124-jetson-tk1,
tegra30-beaver, and the armada-370-mirabox platforms, all of which
have PCI support. I had the bot bisect[2] the boot failures, and it
pointed to this commit. I reverted this commit locally and confirmed
it resolved the boot failures.

The tegra platforms report the following stack traces[3][4].

[    3.606836] pcieport 0000:00:01.0: enabling device (0140 -> 0143)
[    3.612942] Unable to handle kernel paging request at virtual
address ee2f2814
[    3.620146] pgd = c0204000
[    3.622840] [ee2f2814] *pgd=ae21141e(bad)
[    3.626851] Internal error: Oops: 8000000d [#1] SMP ARM
[    3.632059] Modules linked in:
[    3.635109] CPU: 2 PID: 64 Comm: kworker/u8:1 Not tainted
4.4.0-rc1-00015-g804df43a28db #1
[    3.643351] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    3.649612] Workqueue: deferwq deferred_probe_work_func
[    3.654825] task: ee0d3dc0 ti: ee642000 task.ti: ee642000
[    3.660208] PC is at 0xee2f2814
[    3.663351] LR is at msi_domain_alloc_irqs+0x2c/0x198
[    3.668387] pc : []    lr : []    psr: a0000113
[    3.668387] sp : ee643c08  ip : ee6d0040  fp : 00000000
[    3.679837] r10: ee710000  r9 : ee6fa000  r8 : ee6ea0f4
[    3.685044] r7 : ee17dc10  r6 : 00000003  r5 : 00000001  r4 : 00000001
[    3.691552] r3 : ee2f2814  r2 : ee6fa068  r1 : ee6ea0f4  r0 : ee710000
[    3.698063] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    3.705177] Control: 10c5387d  Table: 8020404a  DAC: 00000051
[    3.710905] Process kworker/u8:1 (pid: 64, stack limit = 0xee642220)
[    3.717242] Stack: (0xee643c08 to 0xee644000)
[    3.721586] 3c00:                   ee6fa000 ee6fa068 00000000
ee6fa068 00000002 ee6f9c00
[    3.729742] 3c20: ee643c5e c04f0ad4 ee643c3c ee6d0040 00000001
00000003 00000001 00000001
[    3.737900] 3c40: ee6fa000 ee6fa068 00000000 c0509af0 00000004
ee6fa174 ee6fa000 00820001
[    3.746056] 3c60: 00000002 00000000 ee6fa000 00000002 00000001
00000000 ee643d88 c0a65b2c
[    3.754213] 3c80: c0ff494c c0506298 ee6cf9b0 c03663a4 ee6fa068
00000000 00000000 00000000
[    3.762370] 3ca0: 00000001 c0366634 00000004 ee6c8b90 ee3f6aa0
ee6fa068 ee6fa0cc ee6fa000
[    3.770526] 3cc0: c0f475cc ee6fa000 c0f47600 00000000 ee643d88
c0a65b2c c0ff494c c050656c
[    3.778683] 3ce0: c0506530 ee6fa068 c0f475cc c04fafa4 c04faf20
ee6fa068 c1008f20 00000000
[    3.786840] 3d00: c0f47600 00000009 00000100 c06343f0 00000000
ee643d40 c06346a4 00000000
[    3.794996] 3d20: 00010000 c0632a7c ee041c70 ee3f5538 ee6fa068
ee6fa09c ee6f9c00 c0634184
[    3.803153] 3d40: ee6fa068 00000000 ee6f9c14 ee6fa000 ee6f9c14
ee6f9c00 ee6f9c00 c04f1d98
[    3.811310] 3d60: ee6fa000 c04f1eb8 ee6f9c0c ee6ca800 ee6f9c0c
c0215e94 ee6ca820 ee6ea0f4
[    3.819467] 3d80: c0636d9c ee17dc10 ee6ca800 ee6ca800 ee6ea154
ee6ea010 ee6ea0f4 ee643ddc
[    3.827624] 3da0: ee6b7810 f087e928 ee6ea010 c0a660e4 ee6ea010
c050f280 c0c97324 ee6ea010
[    3.835780] 3dc0: 00000000 ee17dc10 ee17dc00 00000033 c0a664f4
ee6ea158 c100e0fc ee6ea010
[    3.843937] 3de0: eefc5b34 c1f003e4 c1f003e4 00000006 00000001
28000000 3fffffff eefc5b8c
[    3.852094] 3e00: 00002200 00000000 00000000 00000000 2d646476
62786570 7075732d 00796c70
[    3.860251] 3e20: 796c7000 00000000 00000000 00000000 ee6ea0f4
c0f479e4 00000001 ee643ddc
[    3.868407] 3e40: c050df88 00000000 00000000 00000000 00000000
c050df4c 00000000 ee16ec80
[    3.876564] 3e60: 00000001 fffffffe ee17dc10 fffffdfb c0f47920
00000008 ee51eb00 00000000
[    3.884720] 3e80: ee00b800 c0635a88 c0635a38 ee17dc10 c1008f20
00000000 c0f47920 c06343f0
[    3.892877] 3ea0: 00000000 ee643ed0 c06346a4 00000001 00000000
c0632a7c ee03af70 ee3f5738
[    3.901033] 3ec0: ee17dc10 ee17dc44 c0f62978 c0634184 ee17dc10
00000001 00000000 ee17dc10
[    3.909190] 3ee0: ee17dc10 c0f62978 ee660700 c06338fc ee17dc10
c0f62918 c0f62900 c0633cd8
[    3.917347] 3f00: ee51eb00 c0f62934 ee00b800 c025ec38 ee00b814
ee00b964 ee00b848 ee00b814
[    3.925503] 3f20: 00000001 ee00b800 ee51eb18 00000088 ee51eb00
ee00b800 ee00b800 c025ee98
[    3.933660] 3f40: ee0d3dc0 ee51f440 00000000 ee51eb00 c025ee70
00000000 00000000 00000000
[    3.941816] 3f60: 00000000 c0264010 ee073440 00000000 ffffffff
ee51eb00 00000000 00000000
[    3.949973] 3f80: ee643f80 ee643f80 00000000 00000000 ee643f90
ee643f90 ee643fac ee51f440
[    3.958129] 3fa0: c0263f38 00000000 00000000 c0210c38 00000000
00000000 00000000 00000000
[    3.966286] 3fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    3.974443] 3fe0: 00000000 00000000 00000000 00000000 00000013
00000000 ffffffff ffffffff
[    3.982618] [] (msi_domain_alloc_irqs) from []
(pci_enable_msi_range+0x1b0/0x2e0)
[    3.991829] [] (pci_enable_msi_range) from []
(pcie_port_device_register+0x2e8/0x440)
[    4.001377] [] (pcie_port_device_register) from []
(pcie_portdrv_probe+0x3c/0x68)
[    4.010587] [] (pcie_portdrv_probe) from [] (pci_device_probe+0x84/0xd4)
[    4.019010] [] (pci_device_probe) from [] (driver_probe_device+0x1e0/0x2a8)
[    4.027692] [] (driver_probe_device) from [] (bus_for_each_drv+0x44/0x8c)
[    4.036197] [] (bus_for_each_drv) from [] (__device_attach+0xa0/0x104)
[    4.044450] [] (__device_attach) from [] (pci_bus_add_device+0x34/0x60)
[    4.052783] [] (pci_bus_add_device) from [] (pci_bus_add_devices+0x3c/0x84)
[    4.061465] [] (pci_bus_add_devices) from []
(pci_common_init_dev+0x180/0x324)
[    4.070409] [] (pci_common_init_dev) from [] (tegra_pcie_probe+0x1138/0x198c)
[    4.079264] [] (tegra_pcie_probe) from [] (platform_drv_probe+0x50/0xac)
[    4.087683] [] (platform_drv_probe) from [] (driver_probe_device+0x1e0/0x2a8)
[    4.096534] [] (driver_probe_device) from [] (bus_for_each_drv+0x44/0x8c)
[    4.105037] [] (bus_for_each_drv) from [] (__device_attach+0xa0/0x104)
[    4.113281] [] (__device_attach) from [] (bus_probe_device+0x84/0x8c)
[    4.121440] [] (bus_probe_device) from []
(deferred_probe_work_func+0x5c/0x88)
[    4.130383] [] (deferred_probe_work_func) from []
(process_one_work+0x134/0x338)
[    4.139495] [] (process_one_work) from [] (worker_thread+0x28/0x4cc)
[    4.147573] [] (worker_thread) from [] (kthread+0xd8/0xf4)
[    4.154786] [] (kthread) from [] (ret_from_fork+0x14/0x3c)
[    4.161992] Code: 00000000 ee542808 ee699580 ee51fd00 (ee73800c)
[    4.168070] ---[ end trace acac6abc238bf853 ]---
[    4.172740] Unable to handle kernel paging request at virtual
address ffffffec
[    4.179943] pgd = c0204000
[    4.182637] [ffffffec] *pgd=afffd861, *pte=00000000, *ppte=00000000
[    4.188902] Internal error: Oops: 37 [#2] SMP ARM
[    4.193589] Modules linked in:
[    4.196637] CPU: 2 PID: 64 Comm: kworker/u8:1 Tainted: G      D
    4.4.0-rc1-00015-g804df43a28db #1
[    4.206092] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    4.212345] task: ee0d3dc0 ti: ee642000 task.ti: ee642000
[    4.217731] PC is at kthread_data+0x4/0xc
[    4.221728] LR is at wq_worker_sleeping+0xc/0xd0
[    4.226331] pc : []    lr : []    psr: 00000193
[    4.226331] sp : ee6439e8  ip : 00000001  fp : ee643a34
[    4.237780] r10: c0ec467c  r9 : ee0d3dc0  r8 : c0ec0080
[    4.242988] r7 : 00000002  r6 : ee0d4050  r5 : c0ec0080  r4 : 00000002
[    4.249496] r3 : 00000000  r2 : 00000000  r1 : 00000002  r0 : ee0d3dc0
[    4.256004] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment none
[    4.263206] Control: 10c5387d  Table: 8020404a  DAC: 00000051
[    4.268934] Process kworker/u8:1 (pid: 64, stack limit = 0xee642220)
[    4.275268] Stack: (0xee6439e8 to 0xee644000)
[    4.279611] 39e0:                   eefaf080 c09c68f4 00000000
ee396400 c0fcb754 00000000
[    4.287769] 3a00: ee0d3dc0 c09c6ca8 00000000 2e0ef000 00000000
ee64381c ee070000 ee0d3fc8
[    4.295925] 3a20: ee643a40 0000000b 00000001 00000001 ee643a3c
c09c6ca8 ee0d3dc0 c024d3d4
[    4.304082] 3a40: ee643a40 ee643a40 00000001 c0fc9604 ee643bb8
c0ec955c 60000193 0000000b
[    4.312239] 3a60: 00000001 ee2f2816 ee2f2818 c02141c4 ee642220
0000000b 00000000 c0ec955c
[    4.320396] 3a80: 00000000 00000008 30000000 30303030 20303030
34356565 38303832 36656520
[    4.328552] 3aa0: 38353939 65652030 64663135 28203030 33376565
63303038 c0002029 ee643adc
[    4.336709] 3ac0: c0fef370 ee2f2814 8000000d c0efa440 ee643bb8
ee643bb8 ee6fa000 ee710000
[    4.344866] 3ae0: 00000000 c0224e80 c0efa440 c02203d8 60000113
00000000 00000000 0000000d
[    4.353023] 3b00: c0220488 c0ec9bec ee2f2814 c0220490 0000000d
c020a330 ee643bf4 c0cb7348
[    4.361180] 3b20: 0000000e c0630e50 c0cb7348 ee643bf4 60000113
00000004 53425553 45545359
[    4.369336] 3b40: 63703d4d 45440069 45434956 63702b3d 30303a69
303a3030 31303a30 c000302e
[    4.377493] 3b60: 60000113 ffffffff 00000101 c02885d0 00000400
c0286a4c 00000101 00000000
[    4.385650] 3b80: c0fec998 60000113 00000001 c0fccf34 00000000
c0fcca18 0000003f 00000003
[    4.393807] 3ba0: ee2f2814 a0000113 ffffffff ee643bec ee6ea0f4
c02149cc ee710000 ee6ea0f4
[    4.401963] 3bc0: ee6fa068 ee2f2814 00000001 00000001 00000003
ee17dc10 ee6ea0f4 ee6fa000
[    4.410119] 3be0: ee710000 00000000 ee6d0040 ee643c08 c0291fc0
ee2f2814 a0000113 ffffffff
[    4.418276] 3c00: 00000051 00000001 ee6fa000 ee6fa068 00000000
ee6fa068 00000002 ee6f9c00
[    4.426433] 3c20: ee643c5e c04f0ad4 ee643c3c ee6d0040 00000001
00000003 00000001 00000001
[    4.434590] 3c40: ee6fa000 ee6fa068 00000000 c0509af0 00000004
ee6fa174 ee6fa000 00820001
[    4.442747] 3c60: 00000002 00000000 ee6fa000 00000002 00000001
00000000 ee643d88 c0a65b2c
[    4.450903] 3c80: c0ff494c c0506298 ee6cf9b0 c03663a4 ee6fa068
00000000 00000000 00000000
[    4.459060] 3ca0: 00000001 c0366634 00000004 ee6c8b90 ee3f6aa0
ee6fa068 ee6fa0cc ee6fa000
[    4.467217] 3cc0: c0f475cc ee6fa000 c0f47600 00000000 ee643d88
c0a65b2c c0ff494c c050656c
[    4.475373] 3ce0: c0506530 ee6fa068 c0f475cc c04fafa4 c04faf20
ee6fa068 c1008f20 00000000
[    4.483530] 3d00: c0f47600 00000009 00000100 c06343f0 00000000
ee643d40 c06346a4 00000000
[    4.491687] 3d20: 00010000 c0632a7c ee041c70 ee3f5538 ee6fa068
ee6fa09c ee6f9c00 c0634184
[    4.499843] 3d40: ee6fa068 00000000 ee6f9c14 ee6fa000 ee6f9c14
ee6f9c00 ee6f9c00 c04f1d98
[    4.508002] 3d60: ee6fa000 c04f1eb8 ee6f9c0c ee6ca800 ee6f9c0c
c0215e94 ee6ca820 ee6ea0f4
[    4.516160] 3d80: c0636d9c ee17dc10 ee6ca800 ee6ca800 ee6ea154
ee6ea010 ee6ea0f4 ee643ddc
[    4.524318] 3da0: ee6b7810 f087e928 ee6ea010 c0a660e4 ee6ea010
c050f280 c0c97324 ee6ea010
[    4.532475] 3dc0: 00000000 ee17dc10 ee17dc00 00000033 c0a664f4
ee6ea158 c100e0fc ee6ea010
[    4.540632] 3de0: eefc5b34 c1f003e4 c1f003e4 00000006 00000001
28000000 3fffffff eefc5b8c
[    4.548788] 3e00: 00002200 00000000 00000000 00000000 2d646476
62786570 7075732d 00796c70
[    4.556945] 3e20: 796c7000 00000000 00000000 00000000 ee6ea0f4
c0f479e4 00000001 ee643ddc
[    4.565101] 3e40: c050df88 00000000 00000000 00000000 00000000
c050df4c 00000000 ee16ec80
[    4.573258] 3e60: 00000001 fffffffe ee17dc10 fffffdfb c0f47920
00000008 ee51eb00 00000000
[    4.581414] 3e80: ee00b800 c0635a88 c0635a38 ee17dc10 c1008f20
00000000 c0f47920 c06343f0
[    4.589571] 3ea0: 00000000 ee643ed0 c06346a4 00000001 00000000
c0632a7c ee03af70 ee3f5738
[    4.597727] 3ec0: ee17dc10 ee17dc44 c0f62978 c0634184 ee17dc10
00000001 00000000 ee17dc10
[    4.605884] 3ee0: ee17dc10 c0f62978 ee660700 c06338fc ee17dc10
c0f62918 c0f62900 c0633cd8
[    4.614040] 3f00: ee51eb00 c0f62934 ee00b800 c025ec38 ee00b814 ee00b9

The Mirabox reports the following stack trace[5].

[    1.620587] xhci_hcd 0000:02:00.0: hcc params 0x0200f181 hci
version 0x96 quirks 0x00000000
[    1.629057] Unable to handle kernel NULL pointer dereference at
virtual address 00000004
[    1.637200] pgd = c0204000
[    1.639919] [00000004] *pgd=00000000
[    1.643540] Internal error: Oops: 17 [#1] SMP ARM
[    1.648265] Modules linked in:
[    1.651346] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.4.0-rc1-00015-g804df43a28db #1
[    1.659296] Hardware name: Marvell Armada 370/XP (Device Tree)
[    1.665155] task: db050000 ti: db04a000 task.ti: db04a000
[    1.670589] PC is at msi_domain_alloc_irqs+0x1c/0x198
[    1.675666] LR is at pci_enable_msix+0x244/0x3d8
[    1.680305] pc : []    lr : []    psr: a0000013
[    1.680305] sp : db04bd30  ip : 00000000  fp : 00000002
[    1.691832] r10: db006000  r9 : db229174  r8 : 00000000
[    1.697079] r7 : db229068  r6 : db428f40  r5 : db229000  r4 : 00000002
[    1.703634] r3 : db006000  r2 : db229068  r1 : db229068  r0 : db006000
[    1.710190] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    1.717356] Control: 10c5387d  Table: 1b438019  DAC: 00000051
[    1.723125] Process swapper/0 (pid: 1, stack limit = 0xdb04a220)
[    1.729157] Stack: (0xdb04bd30 to 0xdb04c000)
[    1.733535] bd20:                                     00000000
024080c0 db229068 db229068
[    1.741751] bd40: db229174 00000001 00000000 c03056d4 db229068
00000002 db229000 db428f40
[    1.749967] bd60: db229068 e086c000 db229174 00000001 00000002
c0509ea4 00070013 00002000
[    1.758183] bd80: e08398c0 00000002 db428f40 db229000 00000002
db440000 db229068 00000001
[    1.766400] bda0: 00000003 c050a064 00000002 db440000 db440150
db440150 db440000 c07a43a8
[    1.774615] bdc0: db229000 00000000 db440000 db229000 00000000
db440000 00000000 db4400c0
[    1.782831] bde0: 00000000 00000080 c100cb0c 00000001 00000003
c076baec 00000004 00000000
[    1.791048] be00: db229000 db45a000 db440000 db229000 c0adaef4
db440000 c0ec5ad8 00000000
[    1.799264] be20: 00000000 db229068 00000001 c077b4f4 00000000
db218370 db4241e0 db229000
[    1.807480] be40: db229130 db229000 c0ec5ad8 00000000 c0e5683c
c0adaef4 00000000 c07b3690
[    1.815697] be60: db229068 c0f77f64 db229000 c0f77f98 00000000
c04fafa4 c04faf20 db229068
[    1.823913] be80: c1008f20 00000000 c0f77f98 00000000 00000000
c06343f0 db229068 c0f77f98
[    1.832129] bea0: db22909c 00000000 c0df993c c0634544 00000000
c0f77f98 c06344b8 c0632b18
[    1.840346] bec0: db07955c db20dfb4 c0f77f98 db429a00 c0f47178
c0633ae0 c0adaee8 c0ec5ad8
[    1.848562] bee0: c0f77f98 c0f77f98 c0ec8218 db428a00 c0fc9000
c0634d30 c0f77f64 c0ec8218
[    1.856779] bf00: c0ec8218 c020ad08 00000010 c0fc9000 c0d7143c
c0e5683c 00000000 c035d6fc
[    1.864995] bf20: 00000000 c0ef6dd4 dbfffe5b c09e8848 00000108
c02639d8 c0e5683c c0ce6d84
[    1.873211] bf40: c0d6ff9c 00000000 00000006 00000006 c0ef6d9c
dbfffe40 c0ebb6c8 00000006
[    1.881427] bf60: c0e56830 c0fc9000 00000108 c0e5683c c0dbb598
c0dbbd9c 00000006 00000006
[    1.889643] bf80: 00000000 c0dbb598 00000000 c09c527c 00000000
00000000 00000000 00000000
[    1.897859] bfa0: 00000000 c09c5284 00000000 c0210c38 00000000
00000000 00000000 00000000
[    1.906075] bfc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    1.914291] bfe0: 00000000 00000000 00000000 00000000 00000013
00000000 ffff0000 ffff0000
[    1.922514] [] (msi_domain_alloc_irqs) from [] (pci_enable_msix+0x244/0x3d8)
[    1.931343] [] (pci_enable_msix) from [] (pci_enable_msix_range+0x2c/0x64)
[    1.939999] [] (pci_enable_msix_range) from [] (xhci_run+0x130/0x628)
[    1.948225] [] (xhci_run) from [] (usb_add_hcd+0x38c/0x830)
[    1.955573] [] (usb_add_hcd) from [] (usb_hcd_pci_probe+0x198/0x370)
[    1.963708] [] (usb_hcd_pci_probe) from [] (xhci_pci_probe+0x2c/0x11c)
[    1.972017] [] (xhci_pci_probe) from [] (pci_device_probe+0x84/0xd4)
[    1.980151] [] (pci_device_probe) from [] (driver_probe_device+0x1e0/0x2a8)
[    1.988891] [] (driver_probe_device) from [] (__driver_attach+0x8c/0x90)
[    1.997368] [] (__driver_attach) from [] (bus_for_each_dev+0x54/0x88)
[    2.005584] [] (bus_for_each_dev) from [] (bus_add_driver+0xe8/0x1f4)
[    2.013801] [] (bus_add_driver) from [] (driver_register+0x78/0xf4)
[    2.021844] [] (driver_register) from [] (do_one_initcall+0x84/0x1d4)
[    2.030062] [] (do_one_initcall) from [] (kernel_init_freeable+0x11c/0x1e8)
[    2.038809] [] (kernel_init_freeable) from [] (kernel_init+0x8/0xec)
[    2.046942] [] (kernel_init) from [] (ret_from_fork+0x14/0x3c)
[    2.054548] Code: e1a04002 e58d100c e1a02001 e1a0a000 (e5987004)
[    2.060713] ---[ end trace d8caeed57a0ae8f6 ]---

I have not had the time to dig much deeper, so I figured I would send
this report for wider review. I am always willing to re-test any fixes
that may come about from this discussion, just let me know!

Cheers,

Tyler

[1] http://kernelci.org/boot/all/job/rmk/kernel/v4.4-rc1-15-g804df43a28db/
[2] http://hastebin.com/afegogaqeg.sql
[3] http://storage.kernelci.org/rmk/v4.4-rc1-15-g804df43a28db/arm-multi_v7_defconfig/lab-tbaker/boot-tegra124-jetson-tk1.txt
[4] http://storage.kernelci.org/rmk/v4.4-rc1-15-g804df43a28db/arm-multi_v7_defconfig/lab-khilman/boot-tegra30-beaver.txt
[5] http://storage.kernelci.org/rmk/v4.4-rc1-15-g804df43a28db/arm-multi_v7_defconfig/lab-khilman/boot-armada-370-mirabox.txt
