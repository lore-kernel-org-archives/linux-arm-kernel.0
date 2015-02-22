From: jan.kiszka@web.de (Jan Kiszka)
Date: Sun, 22 Feb 2015 21:34:35 +0100
Subject: sun7i: suspicious crash since d347efeb16
Message-ID: <54EA3D5B.8040303@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm getting the follow crash on a banana-pi with upstream kernels since
"mutex: remove unused field "name" in debug mode" (d347efeb16):

[    2.871658] Unable to handle kernel paging request at virtual address bd809e64
[    2.878936] pgd = c0004000
[    2.881657] [bd809e64] *pgd=00000000
[    2.885272] Internal error: Oops: 5 [#1] SMP ARM
[    2.889907] Modules linked in:
[    2.892997] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 3.19.0-05375-gd347efe #51
[    2.900330] Hardware name: Allwinner sun7i (A20) Family
[    2.905575] task: de100000 ti: de0b6000 task.ti: de0b6000
[    2.911005] PC is at sunxi_sc_nmi_set_type+0x104/0x174
[    2.916163] LR is at 0xc
[    2.918713] pc : [<c02fbaa0>]    lr : [<0000000c>]    psr: 60000193
[    2.918713] sp : de0b7ab8  ip : 00000002  fp : de0b7adc
[    2.930221] r10: c1102914  r9 : 00000008  r8 : de005e50
[    2.935465] r7 : de15b600  r6 : de005e34  r5 : 00000000  r4 : de005c18
[    2.942012] r3 : bd809e64  r2 : 00000002  r1 : c090959d  r0 : 00000000
[    2.948563] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    2.955984] Control: 10c5387d  Table: 4000406a  DAC: 00000015
[    2.961749] Process swapper/0 (pid: 1, stack limit = 0xde0b6210)
[    2.967775] Stack: (0xde0b7ab8 to 0xde0b8000)
[    2.972151] 7aa0:                                                       00000053 de15b600
[    2.980360] 7ac0: 00000000 de005c7c 00000008 00000053 de0b7b04 de0b7ae0 c0084b34 c02fb9a8
[    2.988568] 7ae0: 00000053 de15b600 00000008 00000000 c08ea118 c08ed9fc de0b7b2c de0b7b08
[    2.996777] 7b00: c0085fa4 c0084ad0 c0082748 60000113 de0b7b2c 00000053 00000008 dd5dc020
[    3.004986] 7b20: de0b7b54 de0b7b30 c0089a18 c0085f68 de0b7b38 de0b7b3c 00000000 00000008
[    3.013195] 7b40: dd5dc000 c1102958 de0b7bac de0b7b58 c04190e4 c00898d8 de772ea8 00000002
[    3.021404] 7b60: 00000000 00000008 c08ed9fc c1102914 de0b7ba4 de0b7b80 c01c58ec c01c20cc
[    3.029613] 7b80: dd5dc020 00000000 dd5dc028 00000000 c08ea118 c08ed9fc de0b7bb4 c03e6a40
[    3.037822] 7ba0: de0b7bd4 de0b7bb0 c03e6a64 c04190ac dd5dc020 c1102958 00000000 00000000
[    3.046031] 7bc0: c08ea118 c08ed9fc de0b7bfc de0b7bd8 c034e984 c03e6a30 c08ea118 dd5dc020
[    3.054240] 7be0: c034eacc dd5d0108 00000000 c08ed9fc de0b7c14 de0b7c00 c034eb04 c034e8c8
[    3.062449] 7c00: 00000000 dd5dc020 de0b7c3c de0b7c18 c034cf28 c034ead8 de1d68d4 de327c54
[    3.070658] 7c20: dd5d0108 dd5dc020 c08eda2c dd5dc054 de0b7c5c de0b7c40 c034e868 c034cea0
[    3.078867] 7c40: dd5dc020 c08eda2c dd5dc020 dd5d0108 de0b7c7c de0b7c60 c034de60 c034e7fc
[    3.087076] 7c60: dd5dc020 dd5dc028 00000000 dd5d0108 de0b7cbc de0b7c80 c034c0ec c034de34
[    3.095285] 7c80: dd5dc020 00000000 c1102914 dd5dc004 de0b7cbc dd5dc020 dd5dc020 dd5d00b0
[    3.103494] 7ca0: dd5dc004 dd5d0108 0000000b 016e3600 de0b7cd4 de0b7cc0 c034c220 c034bd28
[    3.111704] 7cc0: dd5dc000 dd5dc020 de0b7d0c de0b7cd8 c03e934c c034c208 dd5d00b0 dd5d0108
[    3.119912] 7ce0: de77cf34 00000034 00000000 dd5d00b0 dd5d0108 de77cf34 00000000 00000000
[    3.128121] 7d00: de0b7d64 de0b7d10 c03e9888 c03e9228 60000113 00000004 00000000 00000000
[    3.132166] ata1: SATA link down (SStatus 0 SControl 300)
[    3.141739] 7d20: 32707861 00003930 00000000 00000000 00000000 00340000 00000000 de0b7d18
[    3.149948] 7d40: de77cf34 00000000 00000000 dd5d00b0 00000000 de77cc40 de0b7d84 de0b7d68
[    3.158158] 7d60: c03e9cc4 c03e958c 000000d0 dd5d0010 dd5d0010 00000000 de0b7d94 de0b7d88
[    3.166367] 7d80: c03e9d00 c03e9c38 de0b7de4 de0b7d98 c03eb394 c03e9ce8 c0774693 dd5d0010
[    3.174575] 7da0: 00000014 7fffffff 000000f0 000186a0 de1df010 000186a0 de1df018 ffffffed
[    3.182785] 7dc0: de1df010 c08edf60 00000000 c08edf60 c0908640 00000000 de0b7e04 de0b7de8
[    3.190993] 7de0: c0350c4c c03eb028 de1df010 c1102958 00000000 00000000 de0b7e2c de0b7e08
[    3.199202] 7e00: c034e984 c0350c00 de1df010 de1df044 c08edf60 c08e8918 00000000 c0908640
[    3.207411] 7e20: de0b7e4c de0b7e30 c034eba0 c034e8c8 00000000 c08edf60 c034eb20 c08e8918
[    3.215620] 7e40: de0b7e74 de0b7e50 c034ce44 c034eb2c de14aea4 de1b5850 de14aed4 c08edf60
[    3.223829] 7e60: 00000000 de378000 de0b7e84 de0b7e78 c034e47c c034cdd4 de0b7eac de0b7e88
[    3.232039] 7e80: c034e0c8 c034e460 c0774693 de0b7e98 c08edf60 c0866298 c08b3760 c08b3760
[    3.240248] 7ea0: de0b7ec4 de0b7eb0 c034fafc c034dfe0 dd5f7040 c0866298 de0b7ed4 de0b7ec8
[    3.248457] 7ec0: c0350b68 c034fa5c de0b7ee4 de0b7ed8 c08662b0 c0350b1c de0b7f5c de0b7ee8
[    3.256666] 7ee0: c0008a74 c08662a4 c0073764 c0073588 de0b7f2c c00455e8 de0b7f00 de0b7f08
[    3.264875] 7f00: c0838600 c02d333c de76c231 de76c229 de0b7f5c de0b7f20 c0045828 c08385f0
[    3.273083] 7f20: 000000a2 00000006 00000006 000000a3 c08bb590 00000006 000000a3 00000006
[    3.281292] 7f40: 000000a3 c08854e0 c08a8ab8 c0908640 de0b7f94 de0b7f60 c0838f4c c000896c
[    3.289500] 7f60: 00000006 00000006 c08385e4 00000000 00000000 c05d5108 00000000 00000000
[    3.297708] 7f80: 00000000 00000000 de0b7fac de0b7f98 c05d5120 c0838d4c 00000000 c05d5108
[    3.305916] 7fa0: 00000000 de0b7fb0 c000e550 c05d5114 00000000 00000000 00000000 00000000
[    3.314124] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    3.322331] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
[    3.330561] [<c02fbaa0>] (sunxi_sc_nmi_set_type) from [<c0084b34>] (__irq_set_trigger+0x70/0x120)
[    3.339475] [<c0084b34>] (__irq_set_trigger) from [<c0085fa4>] (irq_set_irq_type+0x48/0x68)
[    3.347863] [<c0085fa4>] (irq_set_irq_type) from [<c0089a18>] (irq_create_of_mapping+0x14c/0x164)
[    3.356776] [<c0089a18>] (irq_create_of_mapping) from [<c04190e4>] (of_irq_get+0x44/0x4c)
[    3.364993] [<c04190e4>] (of_irq_get) from [<c03e6a64>] (i2c_device_probe+0x40/0x128)
[    3.372859] [<c03e6a64>] (i2c_device_probe) from [<c034e984>] (driver_probe_device+0xc8/0x210)
[    3.381508] [<c034e984>] (driver_probe_device) from [<c034eb04>] (__device_attach+0x38/0x54)
[    3.389983] [<c034eb04>] (__device_attach) from [<c034cf28>] (bus_for_each_drv+0x94/0xa4)
[    3.398196] [<c034cf28>] (bus_for_each_drv) from [<c034e868>] (device_attach+0x78/0x9c)
[    3.406233] [<c034e868>] (device_attach) from [<c034de60>] (bus_probe_device+0x38/0xac)
[    3.414272] [<c034de60>] (bus_probe_device) from [<c034c0ec>] (device_add+0x3d0/0x4e0)
[    3.422224] [<c034c0ec>] (device_add) from [<c034c220>] (device_register+0x24/0x28)
[    3.429915] [<c034c220>] (device_register) from [<c03e934c>] (i2c_new_device+0x130/0x1a4)
[    3.438128] [<c03e934c>] (i2c_new_device) from [<c03e9888>] (i2c_register_adapter+0x308/0x42c)
[    3.446774] [<c03e9888>] (i2c_register_adapter) from [<c03e9cc4>] (i2c_add_adapter+0x98/0xb0)
[    3.455334] [<c03e9cc4>] (i2c_add_adapter) from [<c03e9d00>] (i2c_add_numbered_adapter+0x24/0x30)
[    3.464242] [<c03e9d00>] (i2c_add_numbered_adapter) from [<c03eb394>] (mv64xxx_i2c_probe+0x378/0x438)
[    3.473499] [<c03eb394>] (mv64xxx_i2c_probe) from [<c0350c4c>] (platform_drv_probe+0x58/0xa8)
[    3.482059] [<c0350c4c>] (platform_drv_probe) from [<c034e984>] (driver_probe_device+0xc8/0x210)
[    3.490877] [<c034e984>] (driver_probe_device) from [<c034eba0>] (__driver_attach+0x80/0xa4)
[    3.499349] [<c034eba0>] (__driver_attach) from [<c034ce44>] (bus_for_each_dev+0x7c/0xa0)
[    3.507562] [<c034ce44>] (bus_for_each_dev) from [<c034e47c>] (driver_attach+0x28/0x30)
[    3.515599] [<c034e47c>] (driver_attach) from [<c034e0c8>] (bus_add_driver+0xf4/0x1dc)
[    3.523548] [<c034e0c8>] (bus_add_driver) from [<c034fafc>] (driver_register+0xac/0xf0)
[    3.531586] [<c034fafc>] (driver_register) from [<c0350b68>] (__platform_driver_register+0x58/0x6c)
[    3.540670] [<c0350b68>] (__platform_driver_register) from [<c08662b0>] (mv64xxx_i2c_driver_init+0x18/0x20)
[    3.550450] [<c08662b0>] (mv64xxx_i2c_driver_init) from [<c0008a74>] (do_one_initcall+0x114/0x1c8)
[    3.559448] [<c0008a74>] (do_one_initcall) from [<c0838f4c>] (kernel_init_freeable+0x20c/0x2d8)
[    3.568186] [<c0838f4c>] (kernel_init_freeable) from [<c05d5120>] (kernel_init+0x18/0xf4)
[    3.576400] [<c05d5120>] (kernel_init) from [<c000e550>] (ret_from_fork+0x14/0x24)
[    3.584002] Code: e12fff33 ea000003 e5943020 e0833006 (e5930000)
[    3.590163] ---[ end trace d9b08e9c8d4ef013 ]---

CONFIG_DEBUG_MUTEX is on here, and that the removal of an unused field
is sufficient to trigger this indicates that some evil bug is hiding
behind the curtains, likely for more configs. Any ideas? .config
attached.

Jan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.xz
Type: application/x-xz
Size: 13848 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150222/d6760070/attachment-0001.xz>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150222/d6760070/attachment-0001.sig>
