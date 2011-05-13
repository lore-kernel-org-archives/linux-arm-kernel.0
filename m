From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 13 May 2011 22:36:04 +0530
Subject: [RFC PATCH v2 00/12] Consolidating GIC per-cpu interrupts
In-Reply-To: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>
References: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <4DCD64FC.4090703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On 5/6/2011 4:03 PM, Marc Zyngier wrote:
> The current GIC per-cpu interrupt (aka PPIs) suffers from a number of
> problems:
>
> - It uses a completely separate scheme to handle the interrupts,
>    mostly because the PPI concept doesn't really match the kernel view
>    of an interrupt.
> - Some low-level code gets duplicated, as usual...
> - At least one platform (msm) has started implementing its own
>    alternative scheme.
>
> The proposed solution is to let the GIC code expose the PPIs as
> something that the kernel can manage. Instead of having a single
> interrupt number shared on all cores, make the interrupt number be
> different on each CPU.
>
> This enables the use of the normal kernel API (request_irq() and
> friends) and the elimination of some low level code.
>
> This patch set is based on 2.6.39-rc6, and depends on Will Deacon's
> GIC fasteoi patches. Tested on VExpress, PB-11MP, Pandaboard and
> SMDK-S5PV310.
>

Looks like, this series breaks system wide supsend. Please
check.

Regards
Santosh

-------
# echo mem > /sys/power/state
[   37.503112] PM: Syncing filesystems ... done.
[   37.552032] Freezing user space processes ... (elapsed 0.01 seconds) 
done.
[   37.577545] Freezing remaining freezable tasks ... (elapsed 0.02 
seconds) done.
[   37.616210] PM: suspend of devices complete after 5.187 msecs
[   37.623657] PM: late suspend of devices complete after 1.403 msecs
[   37.630187] Disabling non-boot CPUs ...
[   37.731964] CPU1: shutdown
[   38.285888] Enabling non-boot CPUs ...
[   38.291137] CPU1: Booted secondary processor
[   38.291168] CPU1: Unknown IPI message 0x1
[   38.291168] local_timer: can't register interrupt 413 on cpu 1 (-16)
[   38.365112] Unable to handle kernel NULL pointer dereference at 
virtual address 0000004c
[   38.388946] pgd = c0004000
[   38.391784] [0000004c] *pgd=00000000
[   38.395538] Internal error: Oops: 805 [#1] SMP
[   38.400207] last sysfs file: /sys/devices/virtual/vc/vcsa63/dev
[   38.406433] Modules linked in:
[   38.409637] CPU: 1    Not tainted  (2.6.39-rc5-00099-g9e06a0a #6)
[   38.416046] PC is at clockevents_program_event+0x60/0xd4
[   38.421630] LR is at tick_dev_program_event+0x38/0x140
[   38.427032] pc : [<c00bc270>]    lr : [<c00bd730>]    psr: 60000193
[   38.427032] sp : ef885f78  ip : 00000008  fp : 00000000
[   38.439086] r10: 00000000  r9 : 00000008  r8 : cebb6148
[   38.444580] r7 : 00000000  r6 : 0076bbcd  r5 : 00000000  r4 : 00000000
[   38.451446] r3 : 00000008  r2 : cebb6148  r1 : 00000000  r0 : cebb6148
[   38.458282] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM 
Segment kernel
[   38.466064] Control: 10c53c7d  Table: 8000404a  DAC: 00000017
[   38.472076] Process swapper (pid: 0, stack limit = 0xef8842f8)
[   38.478210] Stack: (0xef885f78 to 0xef886000)
[   38.482788] 5f60: 
    00000000 00000000
[   38.491394] 5f80: 00000001 c00bd730 ce44a57b 00000008 ce44a57b 
00000008 cebb6148 00000008
[   38.499969] 5fa0: ce442e45 00000000 411fc092 c00bd8ac 00000000 
00000008 00000000 c1164ef0
[   38.508575] 5fc0: 00000008 c00be464 00773594 00000000 ce442e45 
00000008 ef884000 0000001f
[   38.517150] 5fe0: 10c03c7d c05f8630 00000000 c005b9a4 00000001 
c006bd8c 5e3adbb2 b8403c00
[   38.525756] [<c00bc270>] (clockevents_program_event+0x60/0xd4) from 
[<c00bd730>] (tick_dev_program_event+0x38/0x140)
[   38.536804] [<c00bd730>] (tick_dev_program_event+0x38/0x140) from 
[<c00bd8ac>] (tick_program_event+0x3c/0x48)
[   38.547241] [<c00bd8ac>] (tick_program_event+0x3c/0x48) from 
[<c00be464>] (tick_nohz_restart_sched_tick+0x170/0x1b8)
[   38.558319] [<c00be464>] (tick_nohz_restart_sched_tick+0x170/0x1b8) 
from [<c005b9a4>] (cpu_idle+0xdc/0xf8)
[   38.568481] [<c005b9a4>] (cpu_idle+0xdc/0xf8) from [<c006bd8c>] 
(platform_cpu_die+0x3c/0x50)
[   38.577331] Code: e0c17007 e3560001 e2d71000 ba000018 (e584304c)
[   38.583740] ---[ end trace fd37aa01e7ce7dcd ]---
[   38.588592] Kernel panic - not syncing: Attempted to kill the idle task!
[   38.595642] CPU0: stopping
[   38.598510] [<c0060cdc>] (unwind_backtrace+0x0/0xe4) from 
[<c00502a4>] (do_IPI+0xb4/0x12c)
[   38.607208] [<c00502a4>] (do_IPI+0xb4/0x12c) from [<c03f6c9c>] 
(__irq_svc+0x3c/0x100)
[   38.615447] Exception stack(0xc058bf88 to 0xc058bfd0)
[   38.620727] bf80:                   c005b948 00000000 c058bfc0 
00000000 c058a000 c0034c0c
[   38.629333] bfa0: c0034c08 c0590ddc 80000000 411fc092 00000000 
00000000 00000000 c058bfd0
[   38.637908] bfc0: c005b948 c005b94c 60000013 ffffffff
[   38.643218] [<c03f6c9c>] (__irq_svc+0x3c/0x100) from [<c005b94c>] 
(cpu_idle+0x84/0xf8)
[   38.651550] [<c005b94c>] (cpu_idle+0x84/0xf8) from [<c000893c>] 
(start_kernel+0x298/0x2f0)
[   38.660247] [<c000893c>] (start_kernel+0x298/0x2f0) from [<8000803c>] 
(0x8000803c)

Regards
Santosh
