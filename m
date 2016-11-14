From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 Nov 2016 22:26:32 +0800
Subject: [PATCH 12/16] ARM: imx: use generic API for enabling SCU
In-Reply-To: <1479099731-28108-13-git-send-email-pankaj.dubey@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <1479099731-28108-13-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20161114142631.GP3310@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 10:32:07AM +0530, Pankaj Dubey wrote:
> Now as we have of_scu_enable which takes care of mapping
> scu base from DT, lets use it.
> 
> At the same time this patch cleans up mach-imx platform files by
> removing static mapping of SCU and dropping imx_scu_map_io function.

I remember that the static mapping of SCU is necessary because SCU is
being accessed at very early boot stage where dynamic mapping hasn't
been set up.

> CC: Shawn Guo <shawnguo@kernel.org>
> CC: Sascha Hauer <kernel@pengutronix.de>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-imx/common.h     |  5 -----
>  arch/arm/mach-imx/mach-imx6q.c |  8 +-------
>  arch/arm/mach-imx/platsmp.c    | 32 +++++---------------------------
>  arch/arm/mach-imx/pm-imx6.c    |  3 ++-
>  4 files changed, 8 insertions(+), 40 deletions(-)

I tested it and saw that the booting of imx6q is broken like below.

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.0-rc5-00002-g3e5aac418b91 (r65073 at dragon) (gcc version 4.9.3 20150413 (prerelease) (Linaro GCC 4.9-2015.04-1) ) #5 SMP Mon Nov 14 22:17:36 CST 2016
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt:Machine model: Freescale i.MX6 Quad SABRE Smart Device Board
[    0.000000] earlycon: ec_imx21 at MMIO 0x02020000 (options '')
[    0.000000] bootconsole [ec_imx21] enabled
[    0.000000] cma: Reserved 16 MiB at 0x4f000000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000004
[    0.000000] pgd = c0004000
[    0.000000] [00000004] *pgd=00000000
[    0.000000] Internal error: Oops: 5 [#1] SMP ARM
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.9.0-rc5-00002-g3e5aac418b91 #5
[    0.000000] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    0.000000] task: c0e086c0 task.stack: c0e00000
[    0.000000] PC is at scu_get_core_count+0xc/0x1c
[    0.000000] LR is at imx_smp_init_cpus+0x20/0x4c
[    0.000000] pc : [<c0d05438>]    lr : [<c0d0df2c>]    psr: 000000d3
[    0.000000] sp : c0e01f10  ip : c0e01f20  fp : c0e01f1c
[    0.000000] r10: c0bed850  r9 : c0e051c0  r8 : c0e75140
[    0.000000] r7 : c164c5f0  r6 : c0e09f08  r5 : c0d5d6fc  r4 : c0e08340
[    0.000000] r3 : c0e755f8  r2 : 00000000  r1 : c0120d3c  r0 : 00000000
[    0.000000] Flags: nzcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment none
[    0.000000] Control: 10c5387d  Table: 1000404a  DAC: 00000051
[    0.000000] Process swapper (pid: 0, stack limit = 0xc0e00210)
[    0.000000] Stack: (0xc0e01f10 to 0xc0e02000)
[    0.000000] 1f00:                                     c0e01f34 c0e01f20 c0d0df2c c0d05438
[    0.000000] 1f20: c0e08340 c0d5d6fc c0e01f44 c0e01f38 c0d052b8 c0d0df18 c0e01fac c0e01f48
[    0.000000] 1f40: c0d0457c c0d052a4 ffffffff 10c5387d c0e050c0 1000406a 4fffffff efffeec0
[    0.000000] 1f60: c0e01f84 c0e01f70 c017b614 c017af04 c0bebc44 c0e01fa4 c0e01f9c c0e01f88
[    0.000000] 1f80: c01cf6dc c0e75294 c0e050d8 c0d5fa44 c0e050c0 1000406a 412fc09a 00000000
[    0.000000] 1fa0: c0e01ff4 c0e01fb0 c0d009b0 c0d03d24 00000000 00000000 00000000 00000000
[    0.000000] 1fc0: 00000000 c0d5fa48 00000000 c0e75294 c0e050d8 c0d5fa44 c0e0a070 1000406a
[    0.000000] 1fe0: 412fc09a 00000000 00000000 c0e01ff8 1000807c c0d0096c 00000000 00000000
[    0.000000] Backtrace: 
[    0.000000] [<c0d0542c>] (scu_get_core_count) from [<c0d0df2c>] (imx_smp_init_cpus+0x20/0x4c)
[    0.000000] [<c0d0df0c>] (imx_smp_init_cpus) from [<c0d052b8>] (smp_init_cpus+0x20/0x28)
[    0.000000]  r5:c0d5d6fc[    0.000000]  r4:c0e08340
[    0.000000] 
[    0.000000] [<c0d05298>] (smp_init_cpus) from [<c0d0457c>] (setup_arch+0x864/0xc50)
[    0.000000] [<c0d03d18>] (setup_arch) from [<c0d009b0>] (start_kernel+0x50/0x398)
[    0.000000]  r10:00000000[    0.000000]  r9:412fc09a
 r8:1000406a[    0.000000]  r7:c0e050c0
 r6:c0d5fa44[    0.000000]  r5:c0e050d8
[    0.000000]  r4:c0e75294[    0.000000] 
[    0.000000] [<c0d00960>] (start_kernel) from [<1000807c>] (0x1000807c)
[    0.000000]  r10:00000000[    0.000000]  r9:412fc09a
 r8:1000406a[    0.000000]  r7:c0e0a070
 r6:c0d5fa44[    0.000000]  r5:c0e050d8
[    0.000000]  r4:c0e75294[    0.000000] 
[    0.000000] Code: c0e75338 e1a0c00d e92dd800 e24cb004 (e5900004) 
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
