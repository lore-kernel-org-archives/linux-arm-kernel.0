From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 21 Feb 2016 22:14:05 +0100
Subject: LPC18xx doesn't boot on linux-next
In-Reply-To: <CAAEAJfB4_JbRMC5Y5siqPR__Tr8V6x15DSuvEdANxVNjiB-v3w@mail.gmail.com>
References: <CAAEAJfB4_JbRMC5Y5siqPR__Tr8V6x15DSuvEdANxVNjiB-v3w@mail.gmail.com>
Message-ID: <CAGhQ9VyyhCKy4qCFAe-WQ45OjLCSa8AmExL8YkWnSdYNE2v_2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On 21 February 2016 at 21:17, Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
> Hey Joachim,
>
> I've noticed that my Hitex LPC4350 doesn't boot with latest next.
> Here's the bootlog,
> with lpc18xx_defconfig.

Thanks for reporting.

The 'would create circular parent' message doesn't seem to exist in
v4.5rc and seem to have been added by 858d58815 'clk: avoid circular
clock topology'.

Does it help to revert that commit? if not could you bisected it?


regards,
Joachim Eastwood


> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version
> 4.5.0-rc4-next-20160219-00003-ge153f1589736 (zeta at laptop) (gcc version
> 4.8.2 (OSELAS.Toolchain-2013.12.2) ) #208 PREEMPT Sun Feb 21 17:05:51
> ART 2016
> [    0.000000] CPU: ARMv7-M [410fc241] revision 1 (ARMv7M), cr=00000000
> [    0.000000] CPU: unknown data cache, unknown instruction cache
> [    0.000000] Machine model: Hitex LPC4350 Evaluation Board
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping off.
> Total pages: 2032
> [    0.000000] Kernel command line: console=ttyS0,115200 earlyprintk
> ethaddr=C0:B1:3C:88:88:90
> [    0.000000] PID hash table entries: 32 (order: -5, 128 bytes)
> [    0.000000] Dentry cache hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.000000] Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.000000] Memory: 5080K/8192K available (1883K kernel code, 119K
> rwdata, 652K rodata, 84K init, 185K bss, 3112K reserved, 0K
> cma-reserved)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0x00000000 - 0x00001000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0x00000000 - 0xffffffff   (4095 MB)
> [    0.000000]     lowmem  : 0x28000000 - 0x28800000   (   8 MB)
> [    0.000000]       .text : 0x28008000 - 0x2828205c   (2537 kB)
> [    0.000000]       .init : 0x28283000 - 0x28298000   (  84 kB)
> [    0.000000]       .data : 0x28298000 - 0x282b5fe0   ( 120 kB)
> [    0.000000]        .bss : 0x282b5fe0 - 0x282e47ac   ( 186 kB)
> [    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] Preemptible hierarchical RCU implementation.
> [    0.000000] Build-time adjustment of leaf fanout to 32.
> [    0.000000] NR_IRQS:16 nr_irqs:16 16
> [    0.000000] __clk_core_init: pll1 would create circular parent
> [    0.000000] lpc18xx_cgu_register_source_clks: failed to register pll (2)
> [    0.000000] __clk_core_init: idiva would create circular parent
> [    0.000000] lpc18xx_cgu_register_source_clks: failed to register div 0
> [    0.000000] __clk_core_init: idivb would create circular parent
> [    0.000000] lpc18xx_cgu_register_source_clks: failed to register div 1
> [    0.000000] __clk_core_init: idivc would create circular parent
> [    0.000000] lpc18xx_cgu_register_source_clks: failed to register div 2
> [    0.000000] __clk_core_init: idivd would create circular parent
> [    0.000000] lpc18xx_cgu_register_source_clks: failed to register div 3
> [    0.000000] __clk_core_init: idive would create circular parent
> [    0.000000] lpc18xx_cgu_register_source_clks: failed to register div 4
> [    0.000000] Division by zero in kernel.
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 4.5.0-rc4-next-20160219-00003-ge153f1589736 #208
> [    0.000000] Hardware name: NXP LPC18xx/43xx (Device Tree)
> [    0.000000] [<2800be59>] (unwind_backtrace) from [<2800b20b>]
> (show_stack+0xb/0xc)
> [    0.000000] [<2800b20b>] (show_stack) from [<280ac3cf>] (Ldiv0_64+0x9/0x1a)
> [    0.000000] [<280ac3cf>] (Ldiv0_64) from [<28036787>]
> (clocks_calc_max_nsecs+0x19/0x4e)
> [    0.000000] [<28036787>] (clocks_calc_max_nsecs) from [<280368b3>]
> (__clocksource_update_freq_scale+0xf7/0x12c)
> [    0.000000] [<280368b3>] (__clocksource_update_freq_scale) from
> [<280368f1>] (__clocksource_register_scale+0x9/0x34)
> [    0.000000] [<280368f1>] (__clocksource_register_scale) from
> [<2828dea9>] (lpc32xx_timer_init+0x125/0x228)
> [    0.000000] [<2828dea9>] (lpc32xx_timer_init) from [<2828dcd5>]
> (clocksource_probe+0x25/0x50)
> [    0.000000] [<2828dcd5>] (clocksource_probe) from [<28283579>]
> (start_kernel+0x19d/0x2b4)
> [    0.000000] [<28283579>] (start_kernel) from [<28008025>] (0x28008025)
> [    0.000000] clocksource: lpc3220 timer: mask: 0xffffffff
> max_cycles: 0x0, max_idle_ns: 0 ns
> [    0.000000] Division by zero in kernel.
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 4.5.0-rc4-next-20160219-00003-ge153f1589736 #208
> [    0.000000] Hardware name: NXP LPC18xx/43xx (Device Tree)
> [    0.000000] [<2800be59>] (unwind_backtrace) from [<2800b20b>]
> (show_stack+0xb/0xc)
> [    0.000000] [<2800b20b>] (show_stack) from [<280ac3cf>] (Ldiv0_64+0x9/0x1a)
> [    0.000000] [<280ac3cf>] (Ldiv0_64) from [<280366f7>]
> (clocks_calc_mult_shift+0x77/0x9c)
> [    0.000000] [<280366f7>] (clocks_calc_mult_shift) from [<2828aaf9>]
> (register_current_timer_delay+0x19/0xbc)
> [    0.000000] [<2828aaf9>] (register_current_timer_delay) from
> [<2828dddb>] (lpc32xx_timer_init+0x57/0x228)
> [    0.000000] [<2828dddb>] (lpc32xx_timer_init) from [<2828dcd5>]
> (clocksource_probe+0x25/0x50)
> [    0.000000] [<2828dcd5>] (clocksource_probe) from [<28283579>]
> (start_kernel+0x19d/0x2b4)
> [    0.000000] [<28283579>] (start_kernel) from [<28008025>] (0x28008025)
> [    0.000000] Switching to timer-based delay loop, resolution 0ns
> [    0.000000] Division by zero in kernel.
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 4.5.0-rc4-next-20160219-00003-ge153f1589736 #208
> [    0.000000] Hardware name: NXP LPC18xx/43xx (Device Tree)
> [    0.000000] [<2800be59>] (unwind_backtrace) from [<2800b20b>]
> (show_stack+0xb/0xc)
> [    0.000000] [<2800b20b>] (show_stack) from [<280ac3cf>] (Ldiv0_64+0x9/0x1a)
> [    0.000000] [<280ac3cf>] (Ldiv0_64) from [<280366f7>]
> (clocks_calc_mult_shift+0x77/0x9c)
> [    0.000000] [<280366f7>] (clocks_calc_mult_shift) from [<28287bfb>]
> (sched_clock_register+0x3b/0x164)
> [    0.000000] [<28287bfb>] (sched_clock_register) from [<2828dde5>]
> (lpc32xx_timer_init+0x61/0x228)
> [    0.000000] [<2828dde5>] (lpc32xx_timer_init) from [<2828dcd5>]
> (clocksource_probe+0x25/0x50)
> [    0.000000] [<2828dcd5>] (clocksource_probe) from [<28283579>]
> (start_kernel+0x19d/0x2b4)
> [    0.000000] [<28283579>] (start_kernel) from [<28008025>] (0x28008025)
> [    0.000000] Division by zero in kernel.
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 4.5.0-rc4-next-20160219-00003-ge153f1589736 #208
> [    0.000000] Hardware name: NXP LPC18xx/43xx (Device Tree)
> [    0.000000] [<2800be59>] (unwind_backtrace) from [<2800b20b>]
> (show_stack+0xb/0xc)
> [    0.000000] [<2800b20b>] (show_stack) from [<280ac3cf>] (Ldiv0_64+0x9/0x1a)
> [    0.000000] [<280ac3cf>] (Ldiv0_64) from [<28036787>]
> (clocks_calc_max_nsecs+0x19/0x4e)
> [    0.000000] [<28036787>] (clocks_calc_max_nsecs) from [<28287c31>]
> (sched_clock_register+0x71/0x164)
> [    0.000000] [<28287c31>] (sched_clock_register) from [<2828dde5>]
> (lpc32xx_timer_init+0x61/0x228)
> [    0.000000] [<2828dde5>] (lpc32xx_timer_init) from [<2828dcd5>]
> (clocksource_probe+0x25/0x50)
> [    0.000000] [<2828dcd5>] (clocksource_probe) from [<28283579>]
> (start_kernel+0x19d/0x2b4)
> [    0.000000] [<28283579>] (start_kernel) from [<28008025>] (0x28008025)
> [    0.000000] sched_clock: 32 bits at 0 Hz, resolution 0ns, wraps every 0ns
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at
> /home/zeta/fast/linux/ezequielg/kernel/time/clockevents.c:44
> cev_delta2ns+0x2d/0xc8()
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 4.5.0-rc4-next-20160219-00003-ge153f1589736 #208
> [    0.000000] Hardware name: NXP LPC18xx/43xx (Device Tree)
> [    0.000000] [<2800be59>] (unwind_backtrace) from [<2800b20b>]
> (show_stack+0xb/0xc)
> [    0.000000] [<2800b20b>] (show_stack) from [<2800e42d>]
> (warn_slowpath_common+0x51/0x74)
> [    0.000000] [<2800e42d>] (warn_slowpath_common) from [<2800e4c7>]
> (warn_slowpath_null+0xf/0x14)
> [    0.000000] [<2800e4c7>] (warn_slowpath_null) from [<2803847d>]
> (cev_delta2ns+0x2d/0xc8)
> [    0.000000] [<2803847d>] (cev_delta2ns) from [<28038a0d>]
> (clockevents_config+0x35/0x50)
> [    0.000000] [<28038a0d>] (clockevents_config) from [<28038a35>]
> (clockevents_config_and_register+0xd/0x16)
> [    0.000000] [<28038a35>] (clockevents_config_and_register) from
> [<2828df31>] (lpc32xx_timer_init+0x1ad/0x228)
> [    0.000000] [<2828df31>] (lpc32xx_timer_init) from [<2828dcd5>]
> (clocksource_probe+0x25/0x50)
> [    0.000000] [<2828dcd5>] (clocksource_probe) from [<28283579>]
> (start_kernel+0x19d/0x2b4)
> [    0.000000] [<28283579>] (start_kernel) from [<28008025>] (0x28008025)
> [    0.000000] ---[ end trace cb88537fdc8fa200 ]---
>
>
> --
> Ezequiel Garc?a, VanguardiaSur
> www.vanguardiasur.com.ar
