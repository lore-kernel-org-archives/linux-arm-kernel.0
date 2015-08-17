From: m-karicheri2@ti.com (Murali Karicheri)
Date: Mon, 17 Aug 2015 18:12:52 -0400
Subject: [PATCH] ARM: keystone: add a work around to handle asynchronous
 external abort
In-Reply-To: <20150814215617.GA7557@n2100.arm.linux.org.uk>
References: <1439320409-20084-1-git-send-email-m-karicheri2@ti.com>
 <55CDF579.4050408@ti.com> <20150814140934.GX7557@n2100.arm.linux.org.uk>
 <55CE05EC.4040909@oracle.com> <55CE633C.10402@ti.com>
 <20150814215617.GA7557@n2100.arm.linux.org.uk>
Message-ID: <55D25C64.3090107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2015 05:56 PM, Russell King - ARM Linux wrote:
> On Fri, Aug 14, 2015 at 05:53:00PM -0400, Murali Karicheri wrote:
>> We have spend some time already to debug the root cause. Do you have idea on
>> how this was hunted down on OMAP that we can learn from? The bad address is
>> NULL and it seems to happen very rarely and is not easily reproducible.
>> Don't want to put this workaround, but we couldn't track it down either. So
>> any help to debug this will be appreciated.
>
> If you try applying Lucas' patch, you should receive the abort earlier
> in the kernel boot up, which may help narrow down what is provoking it.
>

Unfortunately, this patch causes boot to stop very early just after 
local_abt_enable() is called in early_trap_init(). Before and After 
applying the patch, here is what the boot log looks like. Do you see any 
issue with the patch diff shown below? Patch is applied on top of 
v4.2-rc7. I have some additional base port patches applied to boot 
kernel on my EVM based on a new SoC.

Thanks

Murali


== Patch Applied to Linux 4.2-rc7 =======

a0868495 at ula0868495 ~/Project/linux-keystone $ git show
commit 361c8f772b6666b806b470a25e55017f88950dcd
Author: Murali Karicheri <m-karicheri2@ti.com>
Date:   Mon Aug 17 16:22:25 2015 -0400

     abort enhancements

diff --git a/arch/arm/include/asm/irqflags.h 
b/arch/arm/include/asm/irqflags.h
index 4390814..ac1e7e9 100644
--- a/arch/arm/include/asm/irqflags.h
+++ b/arch/arm/include/asm/irqflags.h
@@ -54,6 +54,14 @@ static inline void arch_local_irq_disable(void)

  #define local_fiq_enable()  __asm__("cpsie f   @ __stf" : : : 
"memory", "cc")
  #define local_fiq_disable() __asm__("cpsid f   @ __clf" : : : 
"memory", "cc")
+
+#ifndef CONFIG_CPU_V7M
+#define local_abt_enable()  __asm__("cpsie a   @ __sta" : : : "memory", 
"cc")
+#define local_abt_disable() __asm__("cpsid a   @ __cla" : : : "memory", 
"cc")
+#else
+#define local_abt_enable()     do { } while (0)
+#define local_abt_disable()    do { } while (0)
+#endif
  #else

  /*
@@ -136,6 +144,8 @@ static inline void arch_local_irq_disable(void)
         : "memory", "cc");                                      \
         })

+#define local_abt_enable()     do { } while (0)
+#define local_abt_disable()    do { } while (0)
  #endif

  /*
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 3d6b782..27c944b 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -358,7 +358,7 @@ asmlinkage void secondary_start_kernel(void)

         cpu_init();

         pr_debug("CPU%u: Booted secondary processor\n", cpu);

         preempt_disable();
         trace_hardirqs_off();
@@ -385,6 +385,7 @@ asmlinkage void secondary_start_kernel(void)

         local_irq_enable();
         local_fiq_enable();
+       local_abt_enable();

         /*
          * OK, it's off to the idle thread for us
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index d358226..381c4e4 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -871,6 +871,11 @@ void __init early_trap_init(void *vectors_base)

         flush_icache_range(vectors, vectors + PAGE_SIZE * 2);
         modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
+
+       /* Enable imprecise aborts */
+       local_abt_enable();
+
  #else /* ifndef CONFIG_CPU_V7M */
         /*
          * on V7-M there is no need to copy the vector table to a dedicated


=========Log after applying the above patch ========================
Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.2.0-rc7-00009-g361c8f7-dirty 
(a0868495 at ula0868495) (gcc version 4.9.3 20150413 (prerelease) (Linaro 
GCC 4.9-2015.05) ) #4 SMP PREEMPT Mon Au5
[    0.000000] CPU: ARMv7 Processor [412fc0f4] revision 4 (ARMv7), 
cr=30c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction 
cache
[    0.000000] Machine model: Texas Instruments Keystone 2 Galileo EVM
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Switching physical address space to 0x800000000
[    0.000000] cma: Reserved 16 MiB at 0x000000085f000000
[    0.000000] Forcing write-allocate cache policy for SMP
[    0.000000] Memory policy: Data cache writealloc


==========Log before applying the patch ===============================
Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.2.0-rc7-00007-g1f593c2-dirty 
(a0868495 at ula0868495) (gcc version 4.9.3 20150413 (prerelease) (Linaro 
GCC 4.9-2015.05) ) #1 SMP PREEMPT Mon Au5
[    0.000000] CPU: ARMv7 Processor [412fc0f4] revision 4 (ARMv7), 
cr=30c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction 
cache
[    0.000000] Machine model: Texas Instruments Keystone 2 Galileo EVM
[    0.000000] Switching physical address space to 0x800000000
[    0.000000] cma: Reserved 16 MiB at 0x000000085f000000
[    0.000000] Forcing write-allocate cache policy for SMP
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 393216
[    0.000000] free_area_init_node: node 0, pgdat c07edc00, node_mem_map 
eebf9000
[    0.000000]   DMA zone: 1520 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 194560 pages, LIFO batch:31
[    0.000000]   HighMem zone: 198656 pages, LIFO batch:31
[    0.000000] PERCPU: Embedded 12 pages/cpu @eebdb000 s16832 r8192 
d24128 u49152
[    0.000000] pcpu-alloc: s16832 r8192 d24128 u49152 alloc=12*4096
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
Total pages: 391696
[    0.000000] Kernel command line: console=ttyS0,115200n8 rootwait=1 
clk_ignore_unused debug earlyprintk rdinit=/sbin/init rw root=/dev/ram0 
initrd=0x802000000,9M
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 
bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 
bytes)
[    0.000000] Memory: 1525700K/1572864K available (5489K kernel code, 
352K rwdata, 1936K rodata, 332K init, 189K bss, 30780K reserved, 16384K 
cma-reserved, 778240K highme)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0748894   (7427 kB)
[    0.000000]       .init : 0xc0749000 - 0xc079c000   ( 332 kB)
[    0.000000]       .data : 0xc079c000 - 0xc07f405c   ( 353 kB)
[    0.000000]        .bss : 0xc07f7000 - 0xc08265b0   ( 190 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Additional per-CPU info printed with stalls.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] Architected cp15 timer(s) running at 24.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff 
max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000006] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps 
every 4398046511097ns
[    0.000022] Switching to timer-based delay loop, resolution 41ns
[    0.000232] keystone timer clock @200000000 Hz
[    0.000365] Console: colour dummy device 80x30
[    0.000390] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.000409] pid_max: default: 4096 minimum: 301
[    0.000533] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000549] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 
bytes)
[    0.001210] CPU: Testing write buffer coherency: ok
[    0.001454] /cpus/cpu at 0 missing clock-frequency property
[    0.001474] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.001531] Setting up static identity map for 0x800082c0 - 0x800083cc
[    0.020357] Brought up 1 CPUs
[    0.020374] SMP: Total of 1 processors activated (48.00 BogoMIPS).
[    0.020386] CPU: All CPU(s) started in SVC mode.
[    0.020890] devtmpfs: initialized
[    0.026907] VFP support v0.3: implementor 41 architecture 4 part 30 
variant f rev 0
[    0.027592] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.028847] NET: Registered protocol family 16
[    0.030535] DMA: preallocated 256 KiB pool for atomic coherent 
allocations
[    0.040844] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 
watchpoint registers.
[    0.040861] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.067540] vgaarb: loaded
[    0.067950] SCSI subsystem initialized
[    0.068376] usbcore: registered new interface driver usbfs
[    0.068474] usbcore: registered new interface driver hub
[    0.068996] usbcore: registered new device driver usb
[    0.075144] clocksource: Switched to clocksource arch_sys_counter
[    0.136115] NET: Registered protocol family 2
[    0.136916] TCP established hash table entries: 8192 (order: 3, 32768 
bytes)
[    0.137020] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.137228] TCP: Hash tables configured (established 8192 bind 8192)
[    0.137306] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.137356] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.137624] NET: Registered protocol family 1
[    0.138537] RPC: Registered named UNIX socket transport module.
[    0.138552] RPC: Registered udp transport module.
[    0.138562] RPC: Registered tcp transport module.
[    0.138572] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.138603] PCI: CLS 0 bytes, default 64
[    0.138879] Unpacking initramfs...
[    1.021486] Initramfs unpacking failed: junk in compressed archive
[    1.030896] Freeing initrd memory: 9216K (c2000000 - c2900000)
[    1.031216] hw perfevents: Failed to parse /pmu/interrupt-affinity[0]
[    1.031268] hw perfevents: enabled with armv7_cortex_a15 PMU driver, 
7 counters available
[    1.032356] platform alarmtimer: set dma_pfn_offset00780000
[    1.033061] futex hash table entries: 16 (order: -2, 1024 bytes)
[    1.061488] Installing knfsd (copyright (C) 1996 okir at monad.swb.de).
[    1.061697] ntfs: driver 2.1.32 [Flags: R/O].
[    1.062370] jffs2: version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
[    1.069538] NET: Registered protocol family 38
[    1.069666] bounce: pool size: 64 pages
[    1.070002] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 253)
[    1.070025] io scheduler noop registered
[    1.070045] io scheduler deadline registered
[    1.070343] io scheduler cfq registered (default)
[    1.224619] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.224778] platform serial8250: set dma_pfn_offset00780000
[    1.228741] console [ttyS0] disabled
[    1.228827] 2530c00.serial: ttyS0 at MMIO 0x2530c00 (irq = 23, 
base_baud = 12000000) is a 16550A
[    1.851892] console [ttyS0] enabled
[    1.856840] 2531000.serial: ttyS1 at MMIO 0x2531000 (irq = 24, 
base_baud = 12000000) is a 16550A
[    1.867235] 2531400.serial: ttyS2 at MMIO 0x2531400 (irq = 25, 
base_baud = 12000000) is a 16550A
[    1.885650] loop: module loaded
[    1.891927] spi_davinci 21805400.spi: Controller at 0xf012e400
[    1.898849] spi_davinci 21805800.spi: Controller at 0xf0130800
[    1.905792] spi_davinci 21805c00.spi: Controller at 0xf0132c00
[    1.912320] spi_davinci 21806000.spi: Controller at 0xf0134000
[    1.921607] usbcore: registered new interface driver usb-storage
[    1.929871] mousedev: PS/2 mouse device common for all mice
[    1.936141] i2c /dev entries driver
[    1.941171] davinci-wdt 2260000.wdt: heartbeat 60 sec
[    1.947853] usbcore: registered new interface driver usbhid
[    1.953419] usbhid: USB HID core driver
[    1.958679] platform oprofile-perf.0: set dma_pfn_offset00780000
[    1.965446] oprofile: using timer interrupt.
[    1.969997] Netfilter messages via NETLINK v0.30. 

[    1.974938] nf_conntrack version 0.5.0 (16384 buckets, 65536 max) 

[    1.981990] ctnetlink v0.93: registering with nfnetlink. 

[    1.988320] ipip: IPv4 over IPv4 tunneling driver 

[    1.994258] gre: GRE over IPv4 demultiplexor driver 

[    1.999144] ip_gre: GRE over IPv4 tunneling driver
[    2.006310] ip_tables: (C) 2000-2006 Netfilter Core Team
[    2.011739] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
[    2.018699] arp_tables: (C) 2002 David S. Miller
[    2.023383] Initializing XFRM netlink socket
[    2.029369] NET: Registered protocol family 10
[    2.035534] NET: Registered protocol family 17
[    2.040009] NET: Registered protocol family 15
[    2.044606] 8021q: 802.1Q VLAN Support v1.8
[    2.051981] sctp: Hash tables configured (established 65536 bind 65536)
[    2.059618] Registering SWP/SWPB emulation handler
[    2.071022] clk: Not disabling unused clocks
[    2.076836] Freeing unused kernel memory: 332K (c0749000 - c079c000)
[    2.083750] Unhandled fault: asynchronous external abort (0x1211) at 
0x00000000
[    2.091051] pgd = edf42b40
[    2.093752] [00000000] *pgd=82e6c8003, *pmd=82e6c9003, *pte=00000000
[    2.100585] Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x00000007
[    2.100585]
[    2.109714] CPU: 0 PID: 1 Comm: init Not tainted 
4.2.0-rc7-00007-g1f593c2-dirty #1
[    2.117269] Hardware name: Keystone
[    2.120779] [<c001627c>] (unwind_backtrace) from [<c0012b70>] 
(show_stack+0x10/0x14)
[    2.128521] [<c0012b70>] (show_stack) from [<c0535a94>] 
(dump_stack+0x84/0xc4)
[    2.135737] [<c0535a94>] (dump_stack) from [<c0533a98>] 
(panic+0xa0/0x1f8)
[    2.142609] [<c0533a98>] (panic) from [<c00270f8>] 
(complete_and_exit+0x0/0x1c)
[    2.149910] [<c00270f8>] (complete_and_exit) from [<ee46bfb0>] 
(0xee46bfb0)
[    2.156867] ---[ end Kernel panic - not syncing: Attempted to kill 
init! exitcode=0x00000007
[    2.156867]


-- 
Murali Karicheri
Linux Kernel, Keystone
