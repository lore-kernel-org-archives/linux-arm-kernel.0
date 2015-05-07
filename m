From: horms@verge.net.au (Simon Horman)
Date: Thu, 7 May 2015 20:17:17 +0900
Subject: Possible regression due to "hrtimer: Get rid of hrtimer softirq"
Message-ID: <20150507111711.GA17448@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have observed what appears to be a regression while testing next-20150507
which seems to be caused by c6eb3f70d4482 ("hrtimer: Get rid of hrtimer
softirq").

The problem manifests on the Koelsch board which is based on the
Renesas ARM r8a7791 SoC as per the boot log below which was obtained
after enabling DEBUG_LL and related options to enable early printk.

Without those options enabled the console produced no output whatsoever.

The problem manifests when booting using the shmobile_defconfig,
which uses multiplatform and enables all devices using DT.

I see the same problem - no console  output - on all Renesas ARM
boards which I have access to and for which multiplatform is supported.
It does not seem to manifest when booting non-multiplatform configurations.

In particular the following boards seem to be effected when using
shmobile_defconfig:

* emev2/kzm9d
* r8a73a4/ape6evm
* r8a7740/armadillo
* r8a7790/lager
* r8a7791/koelsch (as noted above)
* r8a7794/alt

The one board that supports multiplatform that does not appear to
be affected is the r7s7210/genmai. I suspect this is because booting it
does not currently enable many devices.



Booting Linux on physical CPU 0x0
Linux version 4.0.0-09020-gc6eb3f70d448-dirty (horms at ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #160 SMP Thu May 7 20:15:46 JST 2015
CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), cr=10c5307d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine model: Koelsch
Ignoring memory block 0x200000000 - 0x240000000
bootconsole [earlycon0] enabled
debug: ignoring loglevel setting.
Memory policy: Data cache writealloc
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c0658200, node_mem_map eeff8000
  Normal zone: 1520 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 194560 pages, LIFO batch:31
  HighMem zone: 67584 pages, LIFO batch:15
PERCPU: Embedded 9 pages/cpu @eefc7000 s15808 r0 d21056 u36864
pcpu-alloc: s15808 r0 d21056 u36864 alloc=9*4096
pcpu-alloc: [0] 0 [0] 1 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624
Kernel command line: earlyprintk console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1032656K/1048576K available (4740K kernel code, 230K rwdata, 1216K rodata, 276K init, 192K bss, 15920K reserved, 0K cma-reserved, 270336K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc05da044   (5961 kB)
      .init : 0xc05db000 - 0xc0620000   ( 276 kB)
      .data : 0xc0620000 - 0xc0659b00   ( 231 kB)
       .bss : 0xc065c000 - 0xc068c30c   ( 193 kB)
Hierarchical RCU implementation.
        Additional per-CPU info printed with stalls.
        RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS:16 nr_irqs:16 16
Architected cp15 timer(s) running at 10.00MHz (virt).
clocksource arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every 4398046511100ns
Switching to timer-based delay loop, resolution 100ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj=100000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: update cpu_capacity 1024
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x40009000 - 0x40009058
Unable to boot CPU1 when MD21 is set
CPU1: failed to boot: -524
Brought up 1 CPUs
SMP: Total of 1 processors activated (20.00 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
renesas_irqc e61c0000.interrupt-controller: unable to get clock
renesas_irqc e61c0000.interrupt-controller: driving 10 irqs
sh-pfc e6060000.pfc: r8a77910_pfc support registered
No ATAGs?
hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 8 bytes.
gpio-regulator regulator at 1: Could not obtain regulator setting GPIOs: -517
gpio-regulator regulator at 3: Could not obtain regulator setting GPIOs: -517
gpio-regulator regulator at 5: Could not obtain regulator setting GPIOs: -517
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c-sh_mobile e60b0000.i2c: I2C adapter 6, bus speed 100000 Hz
media: Linux media interface: v0.10
Linux video capture interface: v2.00
sh_cmt ffca0000.timer: ch0: used for clock events
sh_cmt ffca0000.timer: ch1: used as clock source
clocksource ffca0000.timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000000 ns
Advanced Linux Sound Architecture Driver Initialized.
Switched to clocksource arch_sys_counter
------------[ cut here ]------------
kernel BUG at kernel/irq_work.c:135!
Internal error: Oops - BUG: 0 [#1] SMP ARM
CPU: 0 PID: 17 Comm: kworker/u4:1 Not tainted 4.0.0-09020-gc6eb3f70d448-dirty #160
Hardware name: Generic R8A7791 (Flattened Device Tree)
Workqueue: khelper __call_usermodehelper
task: ee877180 ti: ee89c000 task.ti: ee89c000
PC is at irq_work_run_list+0x18/0xd0
LR is at irq_work_tick+0x48/0x58
pc : [<c0081160>]    lr : [<c00814dc>]    psr: 60000153
sp : ee89dc90  ip : ee89dcb0  fp : ee89dcac
r10: 00000000  r9 : 00000000  r8 : 0ee6b280
r7 : ee819c80  r6 : 00000012  r5 : 00000000  r4 : ee877180
r3 : 60000153  r2 : 2e9ac000  r1 : 00000202  r0 : eefc86c8
Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5307d  Table: 4000406a  DAC: 00000015
Process kworker/u4:1 (pid: 17, stack limit = 0xee89c210)
Stack: (0xee89dc90 to 0xee89e000)
dc80:                                     c061c6c8 ee877180 00000000 00000012
dca0: ee89dcbc ee89dcb0 c00814dc c0081154 ee89dcd4 ee89dcc0 c006b314 c00814a0
dcc0: c0622140 00000000 ee89dcec ee89dcd8 c0076f1c c006b2cc ee89c000 eefcafc0
dce0: ee89dd1c ee89dcf0 c0076f64 c0076e84 00000000 c0658c80 ee803dc0 c0636280
dd00: 00000012 ee819c80 eefcafc0 00000000 ee89dd2c ee89dd20 c036886c c0076f40
dd20: ee89dd54 ee89dd30 c0062038 c0368848 c0061fc8 00000012 00000000 ee805000
dd40: 00000001 00800111 ee89dd6c ee89dd58 c005e6a8 c0061fd4 0000007d 00000000
dd60: ee89dd8c ee89dd70 c005e744 c005e68c f0002000 ee89ddb0 c0622788 ee89dde4
dd80: ee89ddac ee89dd90 c000a3a8 c005e6c4 c0025590 c00f1ef8 40000153 ffffffff
dda0: ee89de7c ee89ddb0 c0013740 c000a374 c0631f68 ee89ddf8 00000020 ee877180
ddc0: ee1cf180 c0631f68 ee1fa000 ee877180 00800111 00000000 00000000 ee89de7c
dde0: ee01344c ee89ddf8 c0025590 c00f1ef8 40000153 ffffffff ee89de2c ee877b48
de00: ee877b50 eefca4c0 ee01a3c0 c00378a8 00000000 c01b0a4c eefca480 0000b416
de20: ee89dea4 ee89de30 eefca480 00000000 ee1cf3a0 00000001 ee89de6c ee89de48
de40: 0ee696c4 00000000 00000021 00000000 00000001 00000000 00800111 ee837e00
de60: 00000000 ee01a3c0 00000088 00000000 ee89debc ee89de80 c0026500 c0025120
de80: 00000000 00000000 ee89debc ee89de98 c003fe64 c000b418 ee01a3c0 ee82e400
dea0: ee837e00 00000000 ee01a3c0 00000000 ee89ded4 ee89dec0 c0026790 c0026490
dec0: 00000000 2e9ac000 ee89deec ee89ded8 c0037888 c0026768 c0037854 ee87d400
dee0: ee89df2c ee89def0 c0039cf4 c0037860 00000000 ee87d400 ee82e400 00000000
df00: ee82e414 ee87d400 ee82e400 ee87d418 ee82e414 ee82e400 00000088 00000000
df20: ee89df5c ee89df30 c003a188 c0039b14 ee877180 ee87ec80 00000000 ee87d400
df40: c0039e60 00000000 00000000 00000000 ee89dfac ee89df60 c003ef30 c0039e6c
df60: 7da43d78 00000000 ffffffff ee87d400 00000000 00000000 ee89df78 ee89df78
df80: 00000000 00000000 ee89df88 ee89df88 ee87ec80 c003ee40 00000000 00000000
dfa0: 00000000 ee89dfb0 c000fd20 c003ee4c 00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 9d585d40 bead4278
Backtrace: 
[<c0081148>] (irq_work_run_list) from [<c00814dc>] (irq_work_tick+0x48/0x58)
 r6:00000012 r5:00000000 r4:ee877180 r3:c061c6c8
[<c0081494>] (irq_work_tick) from [<c006b314>] (update_process_times+0x54/0x64)
[<c006b2c0>] (update_process_times) from [<c0076f1c>] (tick_periodic+0xa4/0xbc)
 r5:00000000 r4:c0622140
[<c0076e78>] (tick_periodic) from [<c0076f64>] (tick_handle_periodic+0x30/0xa4)
 r4:eefcafc0 r3:ee89c000
[<c0076f34>] (tick_handle_periodic) from [<c036886c>] (arch_timer_handler_virt+0x30/0x38)
 r9:00000000 r8:eefcafc0 r7:ee819c80 r6:00000012 r5:c0636280 r4:ee803dc0
[<c036883c>] (arch_timer_handler_virt) from [<c0062038>] (handle_percpu_devid_irq+0x70/0x8c)
[<c0061fc8>] (handle_percpu_devid_irq) from [<c005e6a8>] (generic_handle_irq+0x28/0x38)
 r8:00800111 r7:00000001 r6:ee805000 r5:00000000 r4:00000012 r3:c0061fc8
[<c005e680>] (generic_handle_irq) from [<c005e744>] (__handle_domain_irq+0x8c/0xb4)
 r4:00000000 r3:0000007d
[<c005e6b8>] (__handle_domain_irq) from [<c000a3a8>] (gic_handle_irq+0x40/0x64)
 r7:ee89dde4 r6:c0622788 r5:ee89ddb0 r4:f0002000
[<c000a368>] (gic_handle_irq) from [<c0013740>] (__irq_svc+0x40/0x54)
Exception stack(0xee89ddb0 to 0xee89ddf8)
dda0:                                     c0631f68 ee89ddf8 00000020 ee877180
ddc0: ee1cf180 c0631f68 ee1fa000 ee877180 00800111 00000000 00000000 ee89de7c
dde0: ee01344c ee89ddf8 c0025590 c00f1ef8 40000153 ffffffff
 r6:ffffffff r5:40000153 r4:c00f1ef8 r3:c0025590
[<c0025114>] (copy_process) from [<c0026500>] (do_fork+0x7c/0x2d8)
 r10:00000000 r9:00000088 r8:ee01a3c0 r7:00000000 r6:ee837e00 r5:00800111
 r4:00000000
[<c0026484>] (do_fork) from [<c0026790>] (kernel_thread+0x34/0x3c)
 r10:00000000 r8:ee01a3c0 r7:00000000 r6:ee837e00 r5:ee82e400 r4:ee01a3c0
[<c002675c>] (kernel_thread) from [<c0037888>] (__call_usermodehelper+0x34/0x54)
[<c0037854>] (__call_usermodehelper) from [<c0039cf4>] (process_one_work+0x1ec/0x324)
 r4:ee87d400 r3:c0037854
[<c0039b08>] (process_one_work) from [<c003a188>] (worker_thread+0x328/0x444)
 r10:00000000 r9:00000088 r8:ee82e400 r7:ee82e414 r6:ee87d418 r5:ee82e400
 r4:ee87d400
[<c0039e60>] (worker_thread) from [<c003ef30>] (kthread+0xf0/0x104)
 r10:00000000 r9:00000000 r8:00000000 r7:c0039e60 r6:ee87d400 r5:00000000
 r4:ee87ec80 r3:ee877180
[<c003ee40>] (kthread) from [<c000fd20>] (ret_from_fork+0x14/0x34)
 r7:00000000 r6:00000000 r5:c003ee40 r4:ee87ec80
Code: e24cb004 e10f3000 e3130080 1a000000 (e7f001f2) 
---[ end trace c5cac49db7d153b1 ]---
Kernel panic - not syncing: Fatal exception in interrupt
---[ end Kernel panic - not syncing: Fatal exception in interrupt
