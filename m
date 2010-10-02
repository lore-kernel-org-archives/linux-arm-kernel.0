From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Sat, 02 Oct 2010 15:55:00 +0200
Subject: I.MX35 GPIO IRQ + Preempt -> Oops
Message-ID: <4CA739B4.1020506@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

using 2.6.36-rc6 on i.MX35 (arm1136jf-s supported in mach-mx3/mach-cpuimx35.c), I can easily 
generate Oops when triggering several consecutive interrupts on a GPIO.

To trigger the problem, I simply launch ts_test and press the touchscreen (a TSC2007 connected to 
i.MX35 through i2c) to generate interrupts on the GPIO. This works fine for a (short) random time 
but then, I get sometimes an "undefined instruction 0" and often an "Unable to handle kernel paging 
request at virtual address" (several crash messages are attached at the end of this mail).

I tried several compilers / binutils combinations (4.3.3 + 2.18 generated using OpenEmbedded and 
4.4.1 + 2.19.51.20090709 from Codesourcery) and several kernel configurations :
- imx i2c controler/GPIO i2c controler,
- Preempt/No Preempt,
- CPU idle/No CPU idle support,
- Tickless/No Tickless,
- HRT/No HRT
and the only change which seems to solve the problem is when I disable preempt (CONFIG_PREEMPT_NONE=y).

When preempt is disabled I can tap the touchscreen for several minutes, when preempt is enabled it 
crashes in a few tenth of seconds.
When preempt is enabled, it seems that having a high CPU load increase the time to reproduce the 
problem (I have a heartbeat timer triggering a led using a GPIO on the same bank as the TSC2007's 
IRQ - this could have explained why a high CPU load changes the time to reproduce the problem if the 
problem is related to accesses to the GPIO registers but I tried to disable the led trigger and the 
problem is still present).

A similar problem was discussed here http://ns.spinics.net/lists/arm-kernel/msg75037.html

Do you have any idea of where to search for this problem's reason ?

Thanks
Eric

PS: lines length of this mail is over 80 in order to have a readable log below, sorry in advance if 
this was not a good idea.

Internal error: Oops - undefined instruction: 0 [#1] PREEMPT
last sysfs file: /sys/class/vc/vcs3/dev
Modules linked in:
CPU: 0    Not tainted  (2.6.36-rc6-00050-g4ac6ae6-dirty #33)
PC is at default_idle+0x24/0x28
LR is at default_idle+0x20/0x28
pc : [<c0026fa8>]    lr : [<c0026fa4>]    psr: 60000013
sp : c0425fc8  ip : c7be8044  fp : 00000000
r10: 8001d9a0  r9 : 4117b363  r8 : 8001da08
r7 : c0427ba0  r6 : c001ef04  r5 : c001ef08  r4 : c0424000
r3 : 00000000  r2 : c0425fc8  r1 : 00000000  r0 : 00000001
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387d  Table: 87b70008  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc0424268)
Stack: (0xc0425fc8 to 0xc0426000)
5fc0:                   c0026f84 c002748c c0453054 c00088f0 c00084a8 00000000
5fe0: 00000000 c001ef08 00000000 00c5387d c044b9e0 80008034 00000000 00000000
[<c0026fa8>] (default_idle+0x24/0x28) from [<c002748c>] (cpu_idle+0x40/0x8c)
[<c002748c>] (cpu_idle+0x40/0x8c) from [<c00088f0>] (start_kernel+0x20c/0x250)
[<c00088f0>] (start_kernel+0x20c/0x250) from [<80008034>] (0x80008034)
Code: e3130002 1a000000 eb001f1f f1080080 (e8bd8008)
---[ end trace b72dcd3cf24a984c ]---
Kernel panic - not syncing: Attempted to kill the idle task!
[<c002b528>] (unwind_backtrace+0x0/0xe4) from [<c0317b34>] (panic+0x58/0x174)
[<c0317b34>] (panic+0x58/0x174) from [<c003b730>] (do_exit+0x68/0x61c)
[<c003b730>] (do_exit+0x68/0x61c) from [<c0029828>] (die+0x1b4/0x1e0)
[<c0029828>] (die+0x1b4/0x1e0) from [<c00251e8>] (do_undefinstr+0x154/0x174)
[<c00251e8>] (do_undefinstr+0x154/0x174) from [<c0025b44>] (__und_svc+0x44/0x60)
Exception stack(0xc0425f80 to 0xc0425fc8)
5f80: 00000001 00000000 c0425fc8 00000000 c0424000 c001ef08 c001ef04 c0427ba0
5fa0: 8001da08 4117b363 8001d9a0 00000000 c7be8044 c0425fc8 c0026fa4 c0026fa8
5fc0: 60000013 ffffffff
[<c0025b44>] (__und_svc+0x44/0x60) from [<c0026fa8>] (default_idle+0x24/0x28)
[<c0026fa8>] (default_idle+0x24/0x28) from [<c002748c>] (cpu_idle+0x40/0x8c)
[<c002748c>] (cpu_idle+0x40/0x8c) from [<c00088f0>] (start_kernel+0x20c/0x250)
[<c00088f0>] (start_kernel+0x20c/0x250) from [<80008034>] (0x80008034)


Unable to handle kernel paging request at virtual address 80020054
pgd = c0004000
[80020054] *pgd=00000000
Internal error: Oops: 805 [#1] PREEMPT
last sysfs file: /sys/class/i2c-dev/i2c-0/dev
Modules linked in:
CPU: 0    Not tainted  (2.6.36-rc6-00046-g6e4172c-dirty #4)
PC is at default_idle+0x24/0x2c
LR is at default_idle+0x20/0x2c
pc : [<c002a008>]    lr : [<c002a004>]    psr: 60000013
sp : c043bfc0  ip : c0440438  fp : 00000000
r10: 8001ffb8  r9 : 4117b363  r8 : 80020020
r7 : c043daf8  r6 : c045e850  r5 : c043db04  r4 : c043a000
r3 : 00000000  r2 : 60000013  r1 : 00000000  r0 : 2625a000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387d  Table: 87018008  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc043a268)
Stack: (0xc043bfc0 to 0xc043c000)
bfc0: 00000000 c002a4f8 c0465f5c c045e7c4 c0021520 c0008964 c00084c0 00000000
bfe0: 00000000 c0021520 00c5387d c045e890 c0021924 80008034 00000000 00000000
[<c002a008>] (default_idle+0x24/0x2c) from [<c002a4f8>] (cpu_idle+0x44/0x9c)
[<c002a4f8>] (cpu_idle+0x44/0x9c) from [<c0008964>] (start_kernel+0x21c/0x26c)
[<c0008964>] (start_kernel+0x21c/0x26c) from [<80008034>] (0x80008034)
Code: e3130002 1a000000 eb0020e7 f1080080 (e28dd004)
---[ end trace 6bbb53675faf5922 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
[<c002e824>] (unwind_backtrace+0x0/0xec) from [<c03318d0>] (panic+0x60/0x18c)
[<c03318d0>] (panic+0x60/0x18c) from [<c0042ecc>] (do_exit+0x64/0x634)
[<c0042ecc>] (do_exit+0x64/0x634) from [<c002cb78>] (die+0x2bc/0x2fc)
[<c002cb78>] (die+0x2bc/0x2fc) from [<c002f6b4>] (__do_kernel_fault+0x64/0x84)
[<c002f6b4>] (__do_kernel_fault+0x64/0x84) from [<c002f8ac>] (do_page_fault+0x1d8/0x1f0)
[<c002f8ac>] (do_page_fault+0x1d8/0x1f0) from [<c00282c4>] (do_DataAbort+0x34/0x94)
[<c00282c4>] (do_DataAbort+0x34/0x94) from [<c0028a4c>] (__dabt_svc+0x4c/0x80)
Exception stack(0xc043bf78 to 0xc043bfc0)
bf60:                                                       2625a000 00000000
bf80: 60000013 00000000 c043a000 c043db04 c045e850 c043daf8 80020020 4117b363
bfa0: 8001ffb8 00000000 c0440438 c043bfc0 c002a004 c002a008 60000013 ffffffff
[<c0028a4c>] (__dabt_svc+0x4c/0x80) from [<c002a008>] (default_idle+0x24/0x2c)
[<c002a008>] (default_idle+0x24/0x2c) from [<c002a4f8>] (cpu_idle+0x44/0x9c)
[<c002a4f8>] (cpu_idle+0x44/0x9c) from [<c0008964>] (start_kernel+0x21c/0x26c)
[<c0008964>] (start_kernel+0x21c/0x26c) from [<80008034>] (0x80008034)

Unable to handle kernel NULL pointer dereference at virtual address 00000085
pgd = c0004000
[00000085] *pgd=00000000
Internal error: Oops: 17 [#1] PREEMPT
last sysfs file: /sys/class/vc/vcs3/dev
Modules linked in:
CPU: 0    Not tainted  (2.6.36-rc6-00050-g4ac6ae6-dirty #35)
PC is at arch_randomize_brk+0x8/0x24
LR is at default_idle+0x20/0x28
pc : [<c0026fb4>]    lr : [<c0026fa4>]    psr: 60000013
sp : c0425fc0  ip : c753e044  fp : 00000000
r10: 8001d99c  r9 : 4117b363  r8 : 8001da04
r7 : c0427ba0  r6 : c001ef04  r5 : c001ef08  r4 : 00000001
r3 : 00000000  r2 : c0425fc8  r1 : 00000000  r0 : 00000001
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387d  Table: 874e4008  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc0424268)
Stack: (0xc0425fc0 to 0xc0426000)
5fc0: c0424000 c0026fa4 c0026f84 c002748c c0453054 c00088f0 c00084a8 00000000
5fe0: 00000000 c001ef08 00000000 00c5387d c044b9e0 80008034 00000000 00000000
[<c0026fb4>] (arch_randomize_brk+0x8/0x24) from [<c0026fa4>] (default_idle+0x20/0x28)
[<c0026fa4>] (default_idle+0x20/0x28) from [<c002748c>] (cpu_idle+0x40/0x8c)
[<c002748c>] (cpu_idle+0x40/0x8c) from [<c00088f0>] (start_kernel+0x20c/0x250)
[<c00088f0>] (start_kernel+0x20c/0x250) from [<80008034>] (0x80008034)
Code: f1080080 e8bd8008 e92d4010 e1a04000 (e5900084)
---[ end trace 876431db1d07c298 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
[<c002b528>] (unwind_backtrace+0x0/0xe4) from [<c0317b74>] (panic+0x58/0x174)
[<c0317b74>] (panic+0x58/0x174) from [<c003b768>] (do_exit+0x68/0x61c)
[<c003b768>] (do_exit+0x68/0x61c) from [<c0029828>] (die+0x1b4/0x1e0)
[<c0029828>] (die+0x1b4/0x1e0) from [<c002c3fc>] (__do_kernel_fault+0x64/0x84)
[<c002c3fc>] (__do_kernel_fault+0x64/0x84) from [<c002c5e0>] (do_page_fault+0x1c4/0x1d8)
[<c002c5e0>] (do_page_fault+0x1c4/0x1d8) from [<c00252d4>] (do_DataAbort+0x34/0x98)
[<c00252d4>] (do_DataAbort+0x34/0x98) from [<c0025a0c>] (__dabt_svc+0x4c/0x80)
Exception stack(0xc0425f78 to 0xc0425fc0)
5f60:                                                       00000001 00000000
5f80: c0425fc8 00000000 00000001 c001ef08 c001ef04 c0427ba0 8001da04 4117b363
5fa0: 8001d99c 00000000 c753e044 c0425fc0 c0026fa4 c0026fb4 60000013 ffffffff
[<c0025a0c>] (__dabt_svc+0x4c/0x80) from [<c0026fb4>] (arch_randomize_brk+0x8/0x24)
[<c0026fb4>] (arch_randomize_brk+0x8/0x24) from [<c0026fa4>] (default_idle+0x20/0x28)
[<c0026fa4>] (default_idle+0x20/0x28) from [<c002748c>] (cpu_idle+0x40/0x8c)
[<c002748c>] (cpu_idle+0x40/0x8c) from [<c00088f0>] (start_kernel+0x20c/0x250)
[<c00088f0>] (start_kernel+0x20c/0x250) from [<80008034>] (0x80008034)

Unable to handle kernel paging request at virtual address eaf440c4
pgd = c7548000
[eaf440c4] *pgd=00000000
Internal error: Oops: 80000005 [#1] PREEMPT
last sysfs file: /sys/class/vc/vcs3/dev
Modules linked in:
CPU: 0    Not tainted  (2.6.36-rc6-00050-g4ac6ae6-dirty #39)
PC is at 0xeaf440c4
LR is at mxc_audmux_v2_configure_port+0x50/0xac
pc : [<eaf440c4>]    lr : [<c0030650>]    psr: a0000033
sp : c0421fc0  ip : c74ea044  fp : 00000000
r10: 8001dc88  r9 : 4117b363  r8 : 8001dcf0
r7 : c0423ba0  r6 : 00000000  r5 : c001f1dc  r4 : c0420000
r3 : eaf440c5  r2 : c0421fc8  r1 : 00000000  r0 : c0318094
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment kernel
Control: 00c5387d  Table: 87548008  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc0420268)
Stack: (0xc0421fc0 to 0xc0422000)
1fc0: 00000000 c0026fa4 c0026f84 c002748c c044edd4 c00088f0 c00084a8 00000000
1fe0: 00000000 c001f1dc 00000000 00c5387d c0447760 80008034 00000000 00000000
[<c0030650>] (mxc_audmux_v2_configure_port+0x50/0xac) from [<c002748c>] (cpu_idle+0x40/0x8c)
[<c002748c>] (cpu_idle+0x40/0x8c) from [<c00088f0>] (start_kernel+0x20c/0x250)
[<c00088f0>] (start_kernel+0x20c/0x250) from [<80008034>] (0x80008034)
Code: bad PC value
---[ end trace a30956c8778d07c3 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
[<c002b528>] (unwind_backtrace+0x0/0xe4) from [<c0315c54>] (panic+0x58/0x174)
[<c0315c54>] (panic+0x58/0x174) from [<c003b730>] (do_exit+0x68/0x61c)
[<c003b730>] (do_exit+0x68/0x61c) from [<c0029828>] (die+0x1b4/0x1e0)
[<c0029828>] (die+0x1b4/0x1e0) from [<c002c3fc>] (__do_kernel_fault+0x64/0x84)
[<c002c3fc>] (__do_kernel_fault+0x64/0x84) from [<c002c6f8>] (do_translation_fault+0x98/0xa4)
[<c002c6f8>] (do_translation_fault+0x98/0xa4) from [<c002523c>] (do_PrefetchAbort+0x34/0x98)
[<c002523c>] (do_PrefetchAbort+0x34/0x98) from [<c0025bb0>] (__pabt_svc+0x50/0xa0)
Exception stack(0xc0421f78 to 0xc0421fc0)
1f60:                                                       c0318094 00000000
1f80: c0421fc8 eaf440c5 c0420000 c001f1dc 00000000 c0423ba0 8001dcf0 4117b363
1fa0: 8001dc88 00000000 c74ea044 c0421fc0 c0030650 eaf440c4 a0000033 ffffffff
[<c0025bb0>] (__pabt_svc+0x50/0xa0) from [<eaf440c4>] (0xeaf440c4)
