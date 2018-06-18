From: stefan@agner.ch (Stefan Agner)
Date: Mon, 18 Jun 2018 23:09:04 +0200
Subject: Dynamic ftrace self test broken on ARM
Message-ID: <65fb14b356bc0a414f1fe5cf5c6eb395@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On a ARM (i.MX 7) I noticed today that the kernel crashes after dynamic
ftrace self test. I tried v4.18-rc1 first, but it seems that at least
also v4.17 is affected.

Booting Linux on physical CPU 0x0
Linux version 4.17.0 (ags at trochilidae) (gcc version 7.2.1 20171011
(Linaro GCC 7.2-2017.11)) #564 SMP Mon Jun 18 23:00:48 CEST 2018
CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
CPU: div instructions available: patching division code
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
OF: fdt: Machine model: Toradex Colibri iMX7D 1GB (eMMC) on Colibri
Evaluation Board V3
bootconsole [earlycon0] enabled
Memory policy: Data cache writealloc
Ignoring RAM at 0xb0000000-0xc0000000
Consider using a HIGHMEM enabled kernel.
cma: Reserved 256 MiB at 0xa0000000
psci: probing for conduit method from DT.
psci: Using PSCI v0.1 Function IDs from DT
percpu: Embedded 17 pages/cpu @(ptrval) s39308 r8192 d22132 u69632
Built 1 zonelists, mobility grouping on.  Total pages: 195072
Kernel command line: earlyprintk root=/dev/mmcblk0p2 rootfstype=ext4
rootwait ip=off console=tty1 console=ttymxc0,115200n8 ${extraargs}
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 501152K/786432K available (9216K kernel code, 682K rwdata, 3016K
rodata, 1024K init, 397K bss, 23136K reserved, 262144K cma-reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0x(ptrval) - 0x(ptrval)   (10208 kB)
      .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
      .data : 0x(ptrval) - 0x(ptrval)   ( 683 kB)
       .bss : 0x(ptrval) - 0x(ptrval)   ( 398 kB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
ftrace: allocating 32657 entries in 96 pages
Hierarchical RCU implementation.
 RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
GIC: Using split EOI/Deactivate mode
arch_timer: cp15 timer(s) running at 8.00MHz (phys).
clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles:
0x1d854df40, max_idle_ns: 440795202120 ns
sched_clock: 56 bits at 8MHz, resolution 125ns, wraps every
2199023255500ns
Switching to timer-based delay loop, resolution 125ns
Switching to timer-based delay loop, resolution 41ns
sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every
89478484971ns
clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 79635851949 ns
Console: colour dummy device 80x30
console [tty1] enabled
Calibrating delay loop (skipped), value calculated using timer
frequency.. 48.00 BogoMIPS (lpj=240000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: update cpu_capacity 1024
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x80100000 - 0x80100060
Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
CPU1: update cpu_capacity 1024
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
smp: Brought up 1 node, 2 CPUs
SMP: Total of 2 processors activated (96.00 BogoMIPS).
CPU: All CPU(s) started in HYP mode.
CPU: Virtualization extensions available.
devtmpfs: initialized
random: get_random_u32 called from bucket_table_alloc+0x84/0x19c with
crng_init=0
VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 5
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 19112604462750000 ns
futex hash table entries: 512 (order: 3, 32768 bytes)
Running postponed tracer tests:
Testing tracer function: PASSED
Testing dynamic ftrace: PASSED
Testing dynamic ftrace ops #1:
(1 0 1 0 0)
(1 1 2 0 0)
(2 1 3 0 93620)
(2 2 4 0 93807) PASSED
Testing dynamic ftrace ops #2:
(1 0 1 96630 0)
(1 1 2 96804 0)
(2 1 3 1 342)
(2 2 4 121 462) PASSED
Testing ftrace recursion: PASSED
Testing ftrace recursion safe: PASSED
Testing ftrace regs: PASSED
Testing tracer nop: PASSED
Testing tracer function_graph: PASSED
pinctrl core: initialized pinctrl subsystem
Unable to handle kernel paging request at virtual address c0ca14e4
pgd = (ptrval)
[c0ca14e4] *pgd=80c1940e(bad)
Internal error: Oops: 80d [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.17.0 #564
Hardware name: Freescale i.MX7 Dual (Device Tree)
PC is at skb_init+0x50/0x7c
LR is at kmem_cache_create_usercopy+0x10c/0x320
pc : [<c0e63b80>]    lr : [<c023bd5c>]    psr: 60000013
sp : dc11be98  ip : dc11be58  fp : dc11bebc
r10: c0e006f0  r9 : c0e82820  r8 : c0faa8c0
r7 : c0e63a10  r6 : 00000000  r5 : 00000000  r4 : c0ca14e4
r3 : c0eb72c8  r2 : 00000000  r1 : 1ea8b000  r0 : dc0eef00
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 8000406a  DAC: 00000051
Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
Stack: (0xdc11be98 to 0xdc11c000)
be80:                                                       00000018
00000030
bea0: 00000000 c07fda4c 00000000 ffffe000 dc11bedc dc11bec0 c0e63a38
c0e63b3c
bec0: c0e5d488 c0170c64 c0fa7140 c0fa7140 dc11bf44 dc11bee0 c0103080
c0e63a1c
bee0: c0145d74 c0e006fc c0bf3c00 c0bf3ca4 c0bf3cf0 c0c03b98 00000000
c0bf3c7c
bf00: 00000001 00000001 c0bf6c04 c0cf0b68 dffffc66 00000000 00000000
c0fa7140
bf20: c0e82844 00000002 c0fa7140 c0eb6264 00000002 c0faa8c0 dc11bf94
dc11bf48
bf40: c0e011d8 c0103038 00000001 00000001 00000000 c0e006f0 00000000
c0f09fc0
bf60: c0cf0b68 000000dc c0989c58 00000000 c0989c58 00000000 00000000
00000000
bf80: 00000000 00000000 dc11bfac dc11bf98 c0989c70 c0e00f74 00000000
c0989c58
bfa0: 00000000 dc11bfb0 c01010e8 c0989c64 00000000 00000000 00000000
00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000
00000000
[<c0e63b80>] (skb_init) from [<c0e63a38>] (sock_init+0x28/0xc8)
[<c0e63a38>] (sock_init) from [<c0103080>] (do_one_initcall+0x54/0x1e8)
[<c0103080>] (do_one_initcall) from [<c0e011d8>]
(kernel_init_freeable+0x270/0x308)
[<c0e011d8>] (kernel_init_freeable) from [<c0989c70>]
(kernel_init+0x18/0x124)
[<c0989c70>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
Exception stack(0xdc11bfb0 to 0xdc11bff8)
bfa0:                                     00000000 00000000 00000000
00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
Code: e58d3000 e3a010b8 e3a03a42 ebcf6033 (e5840000)
---[ end trace fff84001ba23c9c9 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    2.292924]
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D           4.17.0 #564
Hardware name: Freescale i.MX7 Dual (Device Tree)
[<c01128a4>] (unwind_backtrace) from [<c010d868>] (show_stack+0x20/0x24)
[<c010d868>] (show_stack) from [<c0975590>] (dump_stack+0x90/0xa4)
[<c0975590>] (dump_stack) from [<c0110608>] (handle_IPI+0x2dc/0x2fc)
[<c0110608>] (handle_IPI) from [<c010233c>] (gic_handle_irq+0x9c/0xa0)
[<c010233c>] (gic_handle_irq) from [<c0101a0c>] (__irq_svc+0x6c/0x90)
Exception stack(0xdc14df18 to 0xdc14df60)
df00:                                                       00000000
00000324
df20: df957420 c011c4c0 ffffe000 c0f05d28 c0f05d6c 00000002 00000000
c0f05d80
df40: 00000000 dc14df74 dc14df78 dc14df68 c0109938 c010993c 60000013
ffffffff
[<c0101a0c>] (__irq_svc) from [<c010993c>] (arch_cpu_idle+0x48/0x4c)
[<c010993c>] (arch_cpu_idle) from [<c098f81c>]
(default_idle_call+0x30/0x3c)
[<c098f81c>] (default_idle_call) from [<c01566a4>] (do_idle+0x1bc/0x284)
[<c01566a4>] (do_idle) from [<c0156a18>] (cpu_startup_entry+0x28/0x30)
[<c0156a18>] (cpu_startup_entry) from [<c01100b0>]
(secondary_start_kernel+0x158/0x164)
[<c01100b0>] (secondary_start_kernel) from [<8010274c>] (0x8010274c)
---[ end Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
 ]---

I tested with imx_v6_v7_defconfig and enabled the following options:

CONFIG_DYNAMIC_FTRACE=y                                                 
                                                                   
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y                                       
                                                                   
CONFIG_FTRACE_MCOUNT_RECORD=y                                           
                                                                   
CONFIG_FTRACE_SELFTEST=y                                                
                                                                   
CONFIG_FTRACE_STARTUP_TEST=y

I guess startup test should leave the kernel unencumbered?

--
Stefan
