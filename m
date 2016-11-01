From: nasix.embedded@gmail.com (Nasser)
Date: Tue, 1 Nov 2016 09:04:24 +0330
Subject: S5PV210 boot problem
Message-ID: <20161101053424.GA5845@smart-All-Series>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear friends, I have problem booting my custom HW (around s5pv210 SoC) 
using the latest stable kernel release (v4.8.5). Of course this is the first DT
based kernel I'm trying to boot with in this HW. I chose s5pv210_defconfig and 
by checking CONFIG_ARM_APPENDED_DTB, appended the DTB (s5pv210-smdkv210.dtb) at the end of zImage.

The boot loader is based on the old u-boot v1.3.4.
Due to some problems with kernel decompression, I revert 
1fdc08abfa26f30fcef0ce1333e9ac6f80350f30 ARM: decompressor: avoid speculative prefetch from non-RAM areas 
for a successful boot on every new kernel and it worked till now (for non-DT
kernels)

Boot log messages is attached. There are some problems with clock
settings and obviously "Division by zero in kernel".
Can anybody shed some light on the possible issue(s)?

## Transferring control to Linux (at address 20008000) ...

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 4.8.5-00001-gbbbb0ab (smart at smart-ThinkPad-T410) (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1) ) #5 PREEMPT Mon Oct 36
CPU: ARMv7 Processor [412fc082] revision 2 (ARMv7), cr=10c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
OF: fdt:Machine model: YIC System SMDKV210 based on S5PV210
debug: ignoring loglevel setting.
bootconsole [earlycon0] enabled
Memory policy: Data cache writeback
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat 80517730, node_mem_map bf7f8000
  Normal zone: 2048 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 262144 pages, LIFO batch:31
CPU: All CPU(s) started in SVC mode.
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
Kernel command line: console=ttySAC0,115200n8 root=/dev/mmcblk0p1 rw rootwait ignore_loglevel earlyprintk
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034972K/1048576K available (2048K kernel code, 95K rwdata, 700K rodata, 1024K init, 208K bss, 13604K reserved, 0K cma-reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xc0800000 - 0xff800000   (1008 MB)
    lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
    modules : 0x7f000000 - 0x80000000   (  16 MB)
      .text : 0x80008000 - 0x80300000   (3040 kB)
      .init : 0x80400000 - 0x80500000   (1024 kB)
      .data : 0x80500000 - 0x80517e40   (  96 kB)
       .bss : 0x80517e40 - 0x8054bfec   ( 209 kB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Preemptible hierarchical RCU implementation.
        Build-time adjustment of leaf fanout to 32.
NR_IRQS:16 nr_irqs:16 16
VIC @c0800000: id 0x00041192, vendor 0x41
VIC @c0802000: id 0x00041192, vendor 0x41
VIC @c0804000: id 0x00041192, vendor 0x41
VIC @c0806000: id 0x00041192, vendor 0x41
S5PV210 clocks: mout_apll = 0, mout_mpll = 0
        mout_epll = 0, mout_vpll = 0
Division by zero in kernel.
CPU: 0 PID: 0 Comm: swapper Not tainted 4.8.5-00001-gbbbb0ab #5
Hardware name: Samsung S5PC110/S5PV210-based board
[<8010c1ac>] (unwind_backtrace) from [<8010a084>] (show_stack+0x10/0x14)
[<8010a084>] (show_stack) from [<8024a07c>] (Ldiv0+0x8/0x14)
[<8024a07c>] (Ldiv0) from [<8015c6f0>] (clockevents_config+0x24/0x7c)
[<8015c6f0>] (clockevents_config) from [<8015c75c>] (clockevents_config_and_register+0x14/0x20)
[<8015c75c>] (clockevents_config_and_register) from [<80416d6c>] (_samsung_pwm_clocksource_init+0x124/0x264)
[<80416d6c>] (_samsung_pwm_clocksource_init) from [<80416fc4>] (samsung_pwm_alloc+0x118/0x13c)
[<80416fc4>] (samsung_pwm_alloc) from [<80416be0>] (clocksource_probe+0x44/0xac)
[<80416be0>] (clocksource_probe) from [<80400af0>] (start_kernel+0x224/0x388)
[<80400af0>] (start_kernel) from [<20008078>] (0x20008078)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/time/clockevents.c:44 cev_delta2ns+0x130/0x14c
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.8.5-00001-gbbbb0ab #5
Hardware name: Samsung S5PC110/S5PV210-based board
[<8010c1ac>] (unwind_backtrace) from [<8010a084>] (show_stack+0x10/0x14)
[<8010a084>] (show_stack) from [<801158f4>] (__warn+0xd4/0xfc)
[<801158f4>] (__warn) from [<8011593c>] (warn_slowpath_null+0x20/0x28)
[<8011593c>] (warn_slowpath_null) from [<8015bfec>] (cev_delta2ns+0x130/0x14c)
[<8015bfec>] (cev_delta2ns) from [<8015c728>] (clockevents_config+0x5c/0x7c)
[<8015c728>] (clockevents_config) from [<8015c75c>] (clockevents_config_and_register+0x14/0x20)
[<8015c75c>] (clockevents_config_and_register) from [<80416d6c>] (_samsung_pwm_clocksource_init+0x124/0x264)
[<80416d6c>] (_samsung_pwm_clocksource_init) from [<80416fc4>] (samsung_pwm_alloc+0x118/0x13c)
[<80416fc4>] (samsung_pwm_alloc) from [<80416be0>] (clocksource_probe+0x44/0xac)
[<80416be0>] (clocksource_probe) from [<80400af0>] (start_kernel+0x224/0x388)
[<80400af0>] (start_kernel) from [<20008078>] (0x20008078)
---[ end trace 0000000000000000 ]---
Division by zero in kernel.
CPU: 0 PID: 0 Comm: swapper Tainted: G        W       4.8.5-00001-gbbbb0ab #5
Hardware name: Samsung S5PC110/S5PV210-based board
[<8010c1ac>] (unwind_backtrace) from [<8010a084>] (show_stack+0x10/0x14)
[<8010a084>] (show_stack) from [<80249588>] (Ldiv0_64+0x8/0x18)
[<80249588>] (Ldiv0_64) from [<80159bac>] (clocks_calc_mult_shift+0x11c/0x124)
[<80159bac>] (clocks_calc_mult_shift) from [<8040abe8>] (sched_clock_register+0x5c/0x1fc)
[<8040abe8>] (sched_clock_register) from [<80416e40>] (_samsung_pwm_clocksource_init+0x1f8/0x264)
[<80416e40>] (_samsung_pwm_clocksource_init) from [<80416fc4>] (samsung_pwm_alloc+0x118/0x13c)
[<80416fc4>] (samsung_pwm_alloc) from [<80416be0>] (clocksource_probe+0x44/0xac)
[<80416be0>] (clocksource_probe) from [<80400af0>] (start_kernel+0x224/0x388)
[<80400af0>] (start_kernel) from [<20008078>] (0x20008078)
Division by zero in kernel.
CPU: 0 PID: 0 Comm: swapper Tainted: G        W       4.8.5-00001-gbbbb0ab #5
Hardware name: Samsung S5PC110/S5PV210-based board
[<8010c1ac>] (unwind_backtrace) from [<8010a084>] (show_stack+0x10/0x14)
[<8010a084>] (show_stack) from [<80249588>] (Ldiv0_64+0x8/0x18)
[<80249588>] (Ldiv0_64) from [<80159c68>] (clocks_calc_max_nsecs+0x24/0x78)
[<80159c68>] (clocks_calc_max_nsecs) from [<8040ac44>] (sched_clock_register+0xb8/0x1fc)
[<8040ac44>] (sched_clock_register) from [<80416e40>] (_samsung_pwm_clocksource_init+0x1f8/0x264)
[<80416e40>] (_samsung_pwm_clocksource_init) from [<80416fc4>] (samsung_pwm_alloc+0x118/0x13c)
[<80416fc4>] (samsung_pwm_alloc) from [<80416be0>] (clocksource_probe+0x44/0xac)
[<80416be0>] (clocksource_probe) from [<80400af0>] (start_kernel+0x224/0x388)
[<80400af0>] (start_kernel) from [<20008078>] (0x20008078)
sched_clock: 32 bits at 0 Hz, resolution 0ns, wraps every 0ns
Division by zero in kernel.
CPU: 0 PID: 0 Comm: swapper Tainted: G        W       4.8.5-00001-gbbbb0ab #5
Hardware name: Samsung S5PC110/S5PV210-based board
[<8010c1ac>] (unwind_backtrace) from [<8010a084>] (show_stack+0x10/0x14)
[<8010a084>] (show_stack) from [<80249588>] (Ldiv0_64+0x8/0x18)
[<80249588>] (Ldiv0_64) from [<80159c68>] (clocks_calc_max_nsecs+0x24/0x78)
[<80159c68>] (clocks_calc_max_nsecs) from [<80159e58>] (__clocksource_update_freq_scale+0x19c/0x2b8)
[<80159e58>] (__clocksource_update_freq_scale) from [<80159f80>] (__clocksource_register_scale+0xc/0x48)
[<80159f80>] (__clocksource_register_scale) from [<80416fc4>] (samsung_pwm_alloc+0x118/0x13c)
[<80416fc4>] (samsung_pwm_alloc) from [<80416be0>] (clocksource_probe+0x44/0xac)
[<80416be0>] (clocksource_probe) from [<80400af0>] (start_kernel+0x224/0x388)
[<80400af0>] (start_kernel) from [<20008078>] (0x20008078)
clocksource: samsung_clocksource_timer: mask: 0xffffffff max_cycles: 0x0, max_idle_ns: 0 ns
Console: colour dummy device 80x30
Calibrating delay loop...

----- End forwarded message -----
