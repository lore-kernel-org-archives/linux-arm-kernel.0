From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Nov 2017 10:49:31 +0100
Subject: mainline boot: 8 passed 1 failed (mainline/v4.14)
In-Reply-To: <5a16144d.0be9620a.4490d.4375@mx.google.com>
References: <5a16144d.0be9620a.4490d.4375@mx.google.com>
Message-ID: <CAK8P3a1OWob9We9zfvhBRN=fQYsw+nkZpqMJ9z6Q_A-N9_V3rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 1:20 AM, Olof's autobooter <build@lixom.net> wrote:
>
> Full logs are available at http://arm-soc.lixom.net/bootlogs/mainline/v4.14/
>
> Failed boards:
>
>     arndale            arm-multi_v7_nosmp_defconfig  :  FAILED          1:15.09
>
> Successful boards:
>     cubie2             arm-multi_v7_nosmp_defconfig  :  warnings        0:46.50
> ...
>
>         Last entries of failed logs below:

It looks like Olof's boot bot came back after a time without running
any tests, and found
a regression on Arndale when running with CONFIG_SMP disabled. cubie2 did not
run into the same problem.

The backtrace looks a bit suspicous. I can see __switch_to() calling
the notifiers, which would be vfp_notifier_block and contextidr_notifier_block
on both those machines.

I don't see how one of those would end up calling cpu_init(), or where
cpu_init()
might call a NULL function pointer.

It's possible that the panic happens on a secondary CPU that should not be
running any code, but then I don't see where we get to that back trace either.

       Arnd

> ========================================================================
>
>         Board arndale-arm-multi_v7_nosmp_defconfig failure log:
>         -------------------------------------------------
>
> [....] Configuring network interfaces...Cannot find device "eth0"
> Failed to bring up eth0.
>  [?25l [?1c 7 [1G[ [32m ok  [39;49m 8 [?25h [?0cdone.
> [....] Cleaning up temporary files... [?25l [?1c 7 [1G[ [32m ok  [39;49m 8 [?25h [?0c.
> INIT: Entering runleve[    6.106173] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [    6.113488] pgd = c0204000
> [    6.116180] [00000000] *pgd=00000000
> [    6.119743] Internal error: Oops: 80000005 [#1] ARM
> [    6.124600] Modules linked in:
> [    6.127640] CPU: 0 PID: 0 Comm: swapper Tainted: G        W       4.14.0 #1
> [    6.134580] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [    6.140657] task: c14071f8 task.stack: c1400000
> [    6.145172] PC is at 0x0
> [    6.147693] LR is at cpu_init+0x14/0x54
> [    6.151507] pc : [<00000000>]    lr : [<c030a970>]    psr: 400001d3
> [    6.157756] sp : c1401f48  ip : 00000000  fp : ed565c80
> [    6.162964] r10: c156fe94  r9 : c1586b4c  r8 : 00000000
> [    6.168173] r7 : 00000001  r6 : c156fef4  r5 : ee31c700  r4 : c15cec98
> [    6.174682] r3 : c1592dc0  r2 : 010f9e38  r1 : 6e0c8059  r0 : 00000000
> [    6.181193] Flags: nZcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment none
> [    6.188483] Control: 10c53c7d  Table: 6e0c8059  DAC: 00000051
> [    6.194212] Process swapper (pid: 0, stack limit = 0xc1400218)
> [    6.200028] Stack: (0xc1401f48 to 0xc1402000)
> [    6.204370] 1f40:                   ed4e4e00 c03530f4 00000000 c12b3a28 c1401fa4 c030d5d0
> [    6.212529] 1f60: 00000000 00000000 00000002 00000000 c15d9510 c0c9ee9c c14030c4 00000000
> [    6.220688] 1f80: c156f3c0 c1400000 c1592c80 c1403040 ffffffff c1592c80 efffcac0 c12b3a28
> [    6.228848] 1fa0: c1401fb4 c0c9ee9c c1592ccc c1592c80 00000000 c0362150 c1592ccc c1200c54
> [    6.237007] 1fc0: ffffffff ffffffff 00000000 c1200680 00000000 c12b3a28 c1592e14 c1403058
> [    6.245166] 1fe0: c12b3a24 c14085fc 40204059 410fc0f4 00000000 40208078 00000000 00000000
> [    6.253332] [<c030a970>] (cpu_init) from [<c03530f4>] (atomic_notifier_call_chain+0x18/0x20)
> [    6.261748] [<c03530f4>] (atomic_notifier_call_chain) from [<c030d5d0>] (__switch_to+0x34/0x48)
> [    6.270425] Code: bad PC value
> [    6.273464] ---[ end trace d30a42bcfb82d5c1 ]---
> [    6.278062] Kernel panic - not syncing: Attempted to kill the idle task!
> [    6.284748] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
>
> [PYBOOT] [arndale    01:13]: got exception: panic
> ~$off
