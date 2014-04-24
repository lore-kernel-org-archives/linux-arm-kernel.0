From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 24 Apr 2014 10:14:14 -0700
Subject: L2C boot crash on BCM Capri (was: next boot: 47 pass,
 2 fail (next-20140424))
Message-ID: <CAGa+x84pQLkD5_-xZKaEq67ETAtAaCB4Ryt_F-ocwX_wmh=tTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 8:02 AM, Kevin's boot bot <khilman@linaro.org> wrote:
>
> Tree/Branch: next
> Git describe: next-20140424
> Failed boot tests (console logs at the end)
> ===========================================
>                   omap5-uevm:     FAIL:    arm-omap2plus_defconfig
>                  bcm28155-ap:     FAIL:    arm-multi_v7_defconfig

For this BCM Capri failure, I enabled DEBUG_LL and got the crash dump
below, which suggests something in the recent L2C cleanup needs
investigating.

Kevin

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version
3.15.0-rc2-linus-next-20140424-02851-gd397246adc00 (khilman at paris)
(gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-1ubuntu1) ) #7 SMP Thu Apr 24
09:53:52 PDT 2014
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine model: BCM28155 AP board
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] cma: CMA: reserved 64 MiB at bb800000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 196608
[    0.000000] free_area_init_node: node 0, pgdat c0ba8240,
node_mem_map eb1d8000
[    0.000000]   DMA zone: 1520 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 194560 pages, LIFO batch:31
[    0.000000]   HighMem zone: 16 pages used for memmap
[    0.000000]   HighMem zone: 2048 pages, LIFO batch:0
[    0.000000] PERCPU: Embedded 8 pages/cpu @eb1c4000 s8256 r8192 d16320 u32768
[    0.000000] pcpu-alloc: s8256 r8192 d16320 u32768 alloc=8*4096
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 195088
[    0.000000] Kernel command line: console=ttyS0,115200n8
root=/dev/mmcblk0p8 rootwait rootfstype=ext4 debug earlyprintk=ttyS0
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 703544K/786432K available (6067K kernel code,
799K rwdata, 2432K rodata, 552K init, 289K bss, 82888K reserved, 8192K
highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0208000 - 0xc0a55170   (8501 kB)
[    0.000000]       .init : 0xc0a56000 - 0xc0ae0040   ( 553 kB)
[    0.000000]       .data : 0xc0ae2000 - 0xc0ba9ee0   ( 800 kB)
[    0.000000]        .bss : 0xc0ba9ee8 - 0xc0bf25a0   ( 290 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] __peri_clk_init: error initializing gate for bsc3
[    0.000000] Broadcom slave_ccu initialization had errors
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns,
wraps every 21474836480000000ns
[    0.010000] Console: colour dummy device 80x30
[    0.010000] Calibrating delay loop... 2387.14 BogoMIPS (lpj=11935744)
[    0.070000] pid_max: default: 32768 minimum: 301
[    0.070000] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.080000] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.080000] CPU: Testing write buffer coherency: ok
[    0.090000] missing device node for CPU 0
[    0.090000] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.100000] Setting up static identity map for 0x907bbe50 - 0x907bbee8
[    0.100000] L2C-310 enabling early BRESP for Cortex-A9
[    0.110000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.110000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.120000] Unhandled fault: imprecise external abort (0xc06) at 0x44a42d67
[    0.120000] Internal error: : c06 [#1] SMP ARM
[    0.120000] Modules linked in:
[    0.120000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
3.15.0-rc2-linus-next-20140424-02851-gd397246adc00 #7
[    0.120000] task: ea852000 ti: ea860000 task.ti: ea860000
[    0.120000] PC is at l2c_enable+0x48/0x114
[    0.120000] LR is at l2c310_enable+0x180/0x1f4
[    0.120000] pc : [<c021b078>]    lr : [<c0a5d654>]    psr: 80000013
[    0.120000] sp : ea861e58  ip : 00000000  fp : 00000000
[    0.120000] r10: 0000ffff  r9 : c0baa3c8  r8 : 00000000
[    0.120000] r7 : 00000008  r6 : 000000c0  r5 : 00000008  r4 : f0014000
[    0.120000] r3 : f0014908  r2 : f0014940  r1 : 00000000  r0 : f0014000
[    0.120000] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[    0.120000] Control: 10c5387d  Table: 9020404a  DAC: 00000015
[    0.120000] Process swapper/0 (pid: 1, stack limit = 0xea860250)
[    0.120000] Stack: (0xea861e58 to 0xea862000)
[    0.120000] 1e40:
    000000fb f0014000
[    0.120000] 1e60: 4e051001 c0a5d654 c0acf8f8 0e051000 410000c8
00000010 00000000 c0a5d210
[    0.120000] 1e80: c021c024 c021bedc c021be1c c021c084 c021b4a8
c021b36c c021b3c0 00000000
[    0.120000] 1ea0: 00000000 c0acf8f8 eb1cf8a0 c0baa3c8 00000000
c0a77390 00000000 ea860000
[    0.120000] 1ec0: 00000000 c0a5d8d4 ffffffff 00000000 c0be9b28
3ff20000 3ff20fff eb1cf8f8
[    0.120000] 1ee0: 00000200 00000000 00000000 00000000 c0aeced8
c0aeced8 ea831480 c0208d04
[    0.120000] 1f00: c0baa2b8 c07b445c c0938980 ea861f24 00000000
ea861f24 00000000 c0215ee0
[    0.120000] 1f20: c0938980 00000000 ffffffff 00000000 00000000
80000000 c0baa274 c0baa278
[    0.120000] 1f40: ea861f74 00000001 c0aea458 00000001 00000000
c0adcd88 c0adcdb4 00000000
[    0.120000] 1f60: 00000000 00000000 00000000 00000000 00000000
c0a56bdc c000c0c0 c0c0c0c0
[    0.120000] 1f80: c0c0c0c0 c0c0c0c0 00000000 c07b0bd8 00000000
00000000 00000000 00000000
[    0.120000] 1fa0: 00000000 c07b0be0 00000000 c020e978 00000000
00000000 00000000 00000000
[    0.120000] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    0.120000] 1fe0: 00000000 00000000 00000000 00000000 00000013
00000000 c0c0c0c0 c0c0c0c0
[    0.120000] [<c021b078>] (l2c_enable) from [<c0a5d654>]
(l2c310_enable+0x180/0x1f4)
[    0.120000] [<c0a5d654>] (l2c310_enable) from [<c0a5d210>]
(__l2c_init+0x154/0x1dc)
[    0.120000] [<c0a5d210>] (__l2c_init) from [<c0a5d8d4>]
(l2x0_of_init+0x140/0x168)
[    0.120000] [<c0a5d8d4>] (l2x0_of_init) from [<c0208d04>]
(do_one_initcall+0x80/0x1b8)
[    0.120000] [<c0208d04>] (do_one_initcall) from [<c0a56bdc>]
(kernel_init_freeable+0x64/0x1cc)
[    0.120000] [<c0a56bdc>] (kernel_init_freeable) from [<c07b0be0>]
(kernel_init+0x8/0xec)
[    0.120000] [<c07b0be0>] (kernel_init) from [<c020e978>]
(ret_from_fork+0x14/0x3c)
[    0.120000] Code: 12843c09 13a01000 10832185 0a000004 (e5831000)
[    0.120000] ---[ end trace 3406ff24bd97382e ]---
[    0.130000] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    0.130000]
[    0.130000] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b
[    0.130000]
~$off
# PYBOOT: Exception: kernel: ERROR: failed to boot: Unhandled fault
# PYBOOT: Time: 22.95 seconds.
# PYBOOT: Result: FAIL
