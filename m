From: arnd@arndnet.de (Arnd Hannemann)
Date: Sun, 08 Aug 2010 17:45:26 +0200
Subject: [regression] in linux-next: sh_mobile_ceu_camera broken by "ARM:
	Prohibit ioremap() on kernel managed RAM"
Message-ID: <4C5ED116.5000002@arndnet.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

your commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8
ARM: Prohibit ioremap() on kernel managed RAM

lets drivers/base/dma-coherent.c::dma_declare_coherent_memory()
fail for the sh_mobile_ceu_camera driver (see backtrace below).
I think, other configurations (i.MX31 users of the mx3_camera driver:
pcm037 and mx31moboard) will have the same problem.

Since I have no idea how to fix this, I post this regression report here...

[   49.703125] ------------[ cut here ]------------
[   49.703125] WARNING: at arch/arm/mm/ioremap.c:207 __arm_ioremap_pfn_caller+0x50/0x18c()
[   49.710937] Modules linked in: sh_mobile_ceu_camera(+) videobuf_dma_contig sh_mobile_csi2 soc_camera videobuf_core v4l2_common videodev v4l1_compat soc_mediabus tmio_mmc
[   49.726562] Backtrace:
[   49.734375] [<c0029044>] (dump_backtrace+0x0/0x110) from [<c01ffae4>] (dump_stack+0x18/0x1c)
[   49.742187]  r6:c025bab7 r5:000000cf r4:00000000 r3:c029eebc
[   49.742187] [<c01ffacc>] (dump_stack+0x0/0x1c) from [<c003525c>] (warn_slowpath_common+0x54/0x6c)
[   49.750000] [<c0035208>] (warn_slowpath_common+0x0/0x6c) from [<c0035298>] (warn_slowpath_null+0x24/0x2c)
[   49.757812]  r8:d09de000 r7:00000000 r6:00000000 r5:0004e000 r4:00800000
[   49.765625] r3:00000009
[   49.765625] [<c0035274>] (warn_slowpath_null+0x0/0x2c) from [<c002bb94>] (__arm_ioremap_pfn_caller+0x50/0x18c)
[   49.773437] [<c002bb44>] (__arm_ioremap_pfn_caller+0x0/0x18c) from [<c002bd50>] (__arm_ioremap_caller+0x60/0x68)
[   49.781250] [<c002bcf0>] (__arm_ioremap_caller+0x0/0x68) from [<c002bd6c>] (__arm_ioremap+0x14/0x18)
[   49.789062]  r5:4e000000 r4:c029d9c0
[   49.789062] [<c002bd58>] (__arm_ioremap+0x0/0x18) from [<c0158354>] (dma_declare_coherent_memory+0x44/0xe8)
[   49.796875] [<c0158310>] (dma_declare_coherent_memory+0x0/0xe8) from [<bf059834>] (sh_mobile_ceu_probe+0x1d4/0x3dc [sh_mobile_ceu_camera])
[   49.804687] [<bf059660>] (sh_mobile_ceu_probe+0x0/0x3dc [sh_mobile_ceu_camera]) from [<c0155f30>] (platform_drv_probe+0x1c/0x20)
[   49.812500] [<c0155f14>] (platform_drv_probe+0x0/0x20) from [<c0154f24>] (driver_probe_device+0xb0/0x160)
[   49.820312] [<c0154e74>] (driver_probe_device+0x0/0x160) from [<c015503c>] (__driver_attach+0x68/0x8c)
[   49.828125]  r7:00000000 r6:bf059e60 r5:c029d9f4 r4:c029d9c0
[   49.835937] [<c0154fd4>] (__driver_attach+0x0/0x8c) from [<c0154744>] (bus_for_each_dev+0x54/0x84)
[   49.843750]  r6:00000000 r5:c0154fd4 r4:bf059e60 r3:00000000
[   49.843750] [<c01546f0>] (bus_for_each_dev+0x0/0x84) from [<c0154d88>] (driver_attach+0x20/0x28)
[   49.851562]  r6:c02b22b0 r5:cf0be5a0 r4:bf059e60
[   49.851562] [<c0154d68>] (driver_attach+0x0/0x28) from [<c0154018>] (bus_add_driver+0xa8/0x228)
[   49.859375] [<c0153f70>] (bus_add_driver+0x0/0x228) from [<c0155354>] (driver_register+0xb0/0x140)
[   49.867187] [<c01552a4>] (driver_register+0x0/0x140) from [<c01561d4>] (platform_driver_register+0x4c/0x60)
[   49.875000]  r8:c0025fe4 r7:00028c36 r6:00000000 r5:00000000 r4:bf05d000
[   49.882812] r3:00000000
[   49.882812] [<c0156188>] (platform_driver_register+0x0/0x60) from [<bf05d020>] (sh_mobile_ceu_init+0x20/0x2c [sh_mobile_ceu_camera])
[   49.890625] [<bf05d000>] (sh_mobile_ceu_init+0x0/0x2c [sh_mobile_ceu_camera]) from [<c00253a8>] (do_one_initcall+0x60/0x1bc)
[   49.898437] [<c0025348>] (do_one_initcall+0x0/0x1bc) from [<c005a664>] (sys_init_module+0x9c/0x1b4)
[   49.906250]  r7:00028c36 r6:0001cfc8 r5:00000000 r4:bf059f04
[   49.914062] [<c005a5c8>] (sys_init_module+0x0/0x1b4) from [<c0025e60>] (ret_fast_syscall+0x0/0x30)
[   49.921875]  r7:00000080 r6:00000000 r5:00000000 r4:0001b070
[   49.929687] ---[ end trace 1b83ab63d709ff41 ]---
[   49.929687] sh_mobile_ceu sh_mobile_ceu.0: Unable to declare CEU memory.

Best regards,
Arnd
