From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 1 Dec 2014 15:00:47 -0200
Subject: [PATCH] ARM: imx: irq: fix buggy usage of irq_data irq field
In-Reply-To: <1417451109-30276-1-git-send-email-marc.zyngier@arm.com>
References: <1417451109-30276-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAOMZO5DoR57Afc3SH-gV3-dZkHvBab1LXKCWDajpf_sRDKpzSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Mon, Dec 1, 2014 at 2:25 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> mach-imx directly references to the irq field in
> struct irq_data, and uses this to directly poke hardware register.
>
> But irq is the *virtual* irq number, something that has nothing
> to do with the actual HW irq (stored in the hwirq field). And once
> we put the stacked domain code in action, the whole thing explodes,
> as these two values are *very* different.
>
> Just replacing all instances of irq with hwirq fixes the issue.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

I tested your patch and I still have the following problem on a mx6q:

[    0.000000] Unable to handle kernel NULL pointer dereference at
virtual address 00000008
[    0.000000] pgd = 80004000
[    0.000000] [00000008] *pgd=00000000
[    0.000000] Internal error: Oops: 5 [#1] SMP ARM
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
3.18.0-rc6-next-20141201-dirty #341
[    0.000000] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    0.000000] task: 8097c2b0 ti: 80970000 task.ti: 80970000
[    0.000000] PC is at imx_gpc_irq_unmask+0xc/0x4c
[    0.000000] LR is at imx6q_set_lpm+0x80/0x10c
[    0.000000] pc : [<80026598>]    lr : [<8002757c>]    psr: 800001d3
[    0.000000] sp : 80971ea8  ip : 80971eb8  fp : 80971eb4
[    0.000000] r10: c0818078  r9 : 809d8524  r8 : c0818074
[    0.000000] r7 : 00000000  r6 : 809d8fec  r5 : 00000000  r4 : 00000078
[    0.000000] r3 : c0818000  r2 : 00000079  r1 : 00000020  r0 : 00000000
[    0.000000] Flags: Nzcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM
Segment kernel
[    0.000000] Control: 10c5387d  Table: 1000404a  DAC: 00000015
[    0.000000] Process swapper/0 (pid: 0, stack limit = 0x80970238)
[    0.000000] Stack: (0x80971ea8 to 0x80972000)
[    0.000000] 1ea0:                   80971ed4 80971eb8 8002757c
80026598 809d8524 809d8524
[    0.000000] 1ec0: 80968a18 809d8524 80971f64 80971ed8 809293f4
80027508 c0818060 00000018
[    0.000000] 1ee0: 00000000 8097f348 00000000 8097f348 0000001a
be7cfe84 c081803c c0818020
[    0.000000] 1f00: c0818024 c0818028 c0818034 c0818048 c0818060
c0818038 c081802c c0818068
[    0.000000] 1f20: c0818030 c0818014 c081801c c081806c c0818018
c0818080 016e3600 00000001
[    0.000000] 1f40: be7cfe84 be0027c0 809c7e2c 00000000 809c7d18
809c7e34 80971fa4 80971f68
[    0.000000] 1f60: 80950984 80925cac 00000008 00000001 00000000
00000000 00000000 00000000
[    0.000000] 1f80: 00000001 ffffffff 809d7a00 8095e9d8 412fc09a
befffa40 80971fb4 80971fa8
[    0.000000] 1fa0: 809175fc 809508bc 80971ff4 80971fb8 80913b9c
809175dc ffffffff ffffffff
[    0.000000] 1fc0: 809136d4 00000000 00000000 8095e9d8 809d7c94
80978968 8095e9d4 8097d9fc
[    0.000000] 1fe0: 1000406a 00000000 00000000 80971ff8 10008074
8091395c 00000000 00000000
[    0.000000] Backtrace:
[    0.000000] [<8002658c>] (imx_gpc_irq_unmask) from [<8002757c>]
(imx6q_set_lpm+0x80/0x10c)
[    0.000000] [<800274fc>] (imx6q_set_lpm) from [<809293f4>]
(imx6q_clocks_init+0x3754/0x375c)
[    0.000000]  r7:809d8524 r6:80968a18 r5:809d8524 r4:809d8524
[    0.000000] [<80925ca0>] (imx6q_clocks_init) from [<80950984>]
(of_clk_init+0xd4/0x1a0)
[    0.000000]  r10:809c7e34 r9:809c7d18 r8:00000000 r7:809c7e2c
r6:be0027c0 r5:be7cfe84
[    0.000000]  r4:00000001
[    0.000000] [<809508b0>] (of_clk_init) from [<809175fc>]
(time_init+0x2c/0x38)
[    0.000000]  r10:befffa40 r9:412fc09a r8:8095e9d8 r7:809d7a00
r6:ffffffff r5:00000001
[    0.000000]  r4:00000000
[    0.000000] [<809175d0>] (time_init) from [<80913b9c>]
(start_kernel+0x24c/0x3d8)
[    0.000000] [<80913950>] (start_kernel) from [<10008074>] (0x10008074)
[    0.000000]  r10:00000000 r8:1000406a r7:8097d9fc r6:8095e9d4
r5:80978968 r4:809d7c94
[    0.000000] Code: 809d84f0 e1a0c00d e92dd800 e24cb004 (e5903008)
[    0.000000] ---[ end trace cb88537fdc8fa200 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task!

This issue does not happen on linux-next 20141126, but it stats at 201411267.

I haven't bisect it yet, but if you have any ideas, please let me know. Thanks
