From: robherring2@gmail.com (Rob Herring)
Date: Wed, 15 May 2013 15:30:44 -0500
Subject: ux500 breaking multi-platform kernels
Message-ID: <CAL_JsqJzf8Aj6+K_qEYo3JbAoeJn36EerBfaGYT9EQj-zPaHUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee, Linus,

There are some initcalls on ux500 that are not properly
conditionalized. The first is in ux500_l2x0_init and here is a fix:

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index f58615b..e066d32 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -39,10 +39,10 @@ static int __init ux500_l2x0_init(void)
 {
        u32 aux_val = 0x3e000000;

-       if (cpu_is_u8500_family() || cpu_is_ux540_family())
-               l2x0_base = __io_address(U8500_L2CC_BASE);
-       else
-               ux500_unknown_soc();
+       if (!(cpu_is_u8500_family() || cpu_is_ux540_family()))
+               return -ENODEV;
+
+       l2x0_base = __io_address(U8500_L2CC_BASE);

        /* Unlock before init */
        ux500_l2x0_unlock();


Here is the second problem with cpuidle driver:

[    4.514645] Unable to handle kernel NULL pointer dereference at
virtual address 000000fc
[    4.522729] pgd = c0004000
[    4.525429] [000000fc] *pgd=00000000
[    4.529009] Internal error: Oops: 5 [#1] SMP ARM
[    4.533620] Modules linked in:
[    4.536679] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
3.10.0-rc1-00013-g5d170cd-dirty #527
[    4.545893] task: ed888000 ti: ed884000 task.ti: ed884000
[    4.551297] PC is at config_wakeups+0x6c/0x14c
[    4.555740] LR is at db8500_prcmu_enable_wakeups+0x64/0x7c
[    4.561223] pc : [<c06f4948>]    lr : [<c06f64f4>]    psr: 20000193
[    4.561223] sp : ed885ec8  ip : ed885ef8  fp : ed885ef4
[    4.572693] r10: c2d69494  r9 : 00000000  r8 : c31d92bc
[    4.577911] r7 : 00028881  r6 : 00000000  r5 : c31d92bc  r4 : 00000000
[    4.584431] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 60000113
[    4.590954] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[    4.598342] Control: 10c53c7d  Table: 0000404a  DAC: 00000017
[    4.604082] Process swapper/0 (pid: 1, stack limit = 0xed884240)
[    4.610083] Stack: (0xed885ec8 to 0xed886000)
[    4.614436] 5ec0:                   00000000 04019494 c31d92bc
00020081 60000113 c3137440
[    4.622611] 5ee0: 00000000 c2d69494 ed885f14 ed885ef8 c06f64f4
c06f48e8 ed884000 00000006
[    4.630786] 5f00: c2d69488 c2c9abdc ed885f24 ed885f18 c2c9abf0
c06f649c ed885f5c ed885f28
[    4.638960] 5f20: c0008a78 c2c9abe8 00000be1 c2a527f4 ed885f5c
00000006 c2d69484 00000006
[    4.647134] 5f40: c2d69488 c2df9efc c3137440 00000be1 ed885f94
ed885f60 c2c71a98 c00089bc
[    4.655307] 5f60: 00000006 00000006 c2c711ac c010ed98 00000000
c1c95000 00000000 00000000
[    4.663479] 5f80: 00000000 00000000 ed885fac ed885f98 c1c95018
c2c718f8 00000000 00000000
[    4.671651] 5fa0: 00000000 ed885fb0 c000ed98 c1c9500c 00000000
00000000 00000000 00000000
[    4.679824] 5fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    4.687997] 5fe0: 00000000 00000000 00000000 00000000 00000013
00000000 00000000 00000000
[    4.696183] [<c06f4948>] (config_wakeups+0x6c/0x14c) from
[<c06f64f4>] (db8500_prcmu_enable_wakeups+0x64/0x7c)
[    4.706189] [<c06f64f4>] (db8500_prcmu_enable_wakeups+0x64/0x7c)
from [<c2c9abf0>] (ux500_idle_init+0x14/0x2c)
[    4.716195] [<c2c9abf0>] (ux500_idle_init+0x14/0x2c) from
[<c0008a78>] (do_one_initcall+0xc8/0x184)
[    4.725247] [<c0008a78>] (do_one_initcall+0xc8/0x184) from
[<c2c71a98>] (kernel_init_freeable+0x1ac/0x284)
[    4.734906] [<c2c71a98>] (kernel_init_freeable+0x1ac/0x284) from
[<c1c95018>] (kernel_init+0x18/0xf4)
[    4.744128] [<c1c95018>] (kernel_init+0x18/0xf4) from [<c000ed98>]
(ret_from_fork+0x14/0x20)
[    4.752565] Code: ea000001 e59f50dc e1a08005 e5953054 (e59320fc)
[    4.758656] ---[ end trace 47a577e4e96d6f0b ]---
[    4.763269] Kernel panic - not syncing: Fatal exception
