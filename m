From: slash.tmp@free.fr (Mason)
Date: Wed, 14 Dec 2016 17:01:40 +0100
Subject: Linux crashes when trying to online secondary core
Message-ID: <ef972981-3fb6-74a4-cd83-a6629d2dab2a@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm seeing Linux v4.9 crash (dereferencing NULL) when I try to online
the secondary core, after putting it offline.

Perhaps commit 00c1d17aab513d3b8117fb84644eba39434b33e4 is relevant?

You will find below:

1) the full boot log
2) the defconfig I used

Note #1: I added the following patch for debugging purpose:

diff --git a/arch/arm/mach-tango/platsmp.c b/arch/arm/mach-tango/platsmp.c
index 98c62a4a8623..c6865935f21b 100644
--- a/arch/arm/mach-tango/platsmp.c
+++ b/arch/arm/mach-tango/platsmp.c
@@ -5,8 +5,14 @@
 
 static int tango_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
+       int ret;
+       printk("%s from %pf\n", __func__, __builtin_return_address(0));
+       ret =
        tango_set_aux_boot_addr(virt_to_phys(secondary_startup));
+       printk("tango_set_aux_boot_addr=%d\n", ret);
+       ret =
        tango_start_aux_core(cpu);
+       printk("tango_start_aux_core=%d\n", ret);
        return 0;
 }


Note #2: Linux runs as untrusted OS (trustzone thing). Trusted OS
is called armor. Sometimes armor and Linux print to the console
at the same time, which explains some hard-to-read output.


## Booting kernel from Legacy Image at 84001000 ...
   Image Name:   Linux-4.9.0
   Created:      2016-12-14  14:31:44 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    6903791 Bytes = 6.6 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

SMC called with a0=0x00000000 a1=0x00000000 a2=0x00000000 a3=0x20100000 0x00000102
SMC called with a0=0x00000000 a1=0x00000000 a2=0x00000000 a3=0x00000064 0x00000102
SMC called with a0=0x00000001 a1=0x00000102 a2=0xd0804730 a3=0xc0119380 0x00000102
SMC called with a0=0x80101500 a1=0x00000105 a2=0x00000000 a3=0x00000000 0x00000105
SMC called with a0=0x00000001 a1=0x00000104 a2=0x00000000 a3=0x00000000 0x00000104
[0][flow/smc_handler.c:127] waking up CPU1
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.0 (me at misti.france.sdesigns.com) (gcc version 5.3.1 20160113 (Linaro GCC 5.3-2016.02) ) #143 SMP PREEMPT Wed Dec 14 15:31:39 CET 2016
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt:Machine model: Sigma Designs SMP8758 Vantage-1172 Rev E1
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 65536
[    0.000000] free_area_init_node: node 0, pgdat c0b20f00, node_mem_map cfdf9000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65536 pages, LIFO batch:15
[    0.000000] percpu: Embedded 14 pages/cpu @cfdd6000 s25728 r8192 d23424 u57344
[    0.000000] pcpu-alloc: s25728 r8192 d23424 u57344 alloc=14*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
[    0.000000] Kernel command line: console=ttyS0,115200 mem=256M debug no_console_suspend
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 249108K/262144K available (4096K kernel code, 134K rwdata, 872K rodata, 5120K init, 231K bss, 13036K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff800000   ( 752 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0500000   (5088 kB)
[    0.000000]       .init : 0xc0600000 - 0xc0b00000   (5120 kB)
[    0.000000]       .data : 0xc0b00000 - 0xc0b21800   ( 134 kB)
[    0.000000]        .bss : 0xc0b21800 - 0xc0b5b680   ( 232 kB)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 4 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 8 ways, 512 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x72860401
[    0.000000] clocksource: tango-xtal: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 70787423951 ns
[    0.000004] sched_clock: 32 bits at 27MHz, resolution 37ns, wraps every 79536431085ns
[    0.000012] Switching to timer-based delay loop, resolution 37ns
[    0.000256] Console: colour dummy device 80x30
[    0.000278] Calibrating delay loop (skipped), value calculated using timer frequency.. 54.25 BogoMIPS (lpj=90000)
[    0.000289] pid_max: default: 32768 minimum: 301
[    0.000393] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000400] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000896] CPU: Testing write buffer coherency: ok
[    0.001133] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.001178] Setting up static identity map for 0x80100000 - 0x80100058
[    0.056732] tango_boot_secondary from __cpu_up
[    0.063938] tango_set_aux_boot_addr=0
[    0.075101] tango_start_aux_core=0
[    0.075229] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.075319] Brought up 2 CPUs
[    0.075330] SMP: Total of 2 processors activated (108.50 BogoMIPS).
[    0.075337] CPU: All CPU(s) started in SVC mode.
[    0.075951] devtmpfs: initialized
[    0.077370] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.077819] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.078226] NET: Registered protocol family 16
[    0.078999] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.080104] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.080116] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.094156] SCSI subsystem initialized
[    0.094678] usbcore: registered new interface driver usbfs
[    0.094788] usbcore: registered new interface driver hub
[    0.094887] usbcore: registered new device driver usb
[    0.096948] clocksource: Switched to clocksource tango-xtal
[    0.110399] NET: Registered protocol family 2
[    0.110923] TCP established hash table entries: 2048 (order: 1, 8192 bytes)
[    0.110949] TCP bind hash table entries: 2048 (order: 2, 16384 bytes)
[    0.110977] TCP: Hash tables configured (established 2048 bind 2048)
[    0.111051] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.111082] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.111239] NET: Registered protocol family 1
[    0.111623] RPC: Registered named UNIX socket transport module.
[    0.111631] RPC: Registered udp transport module.
[    0.111636] RPC: Registered tcp transport module.
[    0.111641] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.310427] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
[    0.311930] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.312759] workingset: timestamp_bits=30 max_order=16 bucket_order=0
[    0.313862] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.313883] io scheduler noop registered
[    0.313891] io scheduler deadline registered
[    0.313920] io scheduler cfq registered (default)
[    0.315331] tangox-dma 290a0.dma: SMP86xx DMA with 2 channels, 1 slaves
[    0.397789] Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
[    0.399218] console [ttyS0] disabled
[    0.399291] 10700.serial: ttyS0 at MMIO 0x10700 (irq = 20, base_baud = 460800) is a Palmchip BK-3103
[    0.961466] console [ttyS0] enabled
[    0.972296] loop: module loaded
[    0.976476] libphy: Fixed MDIO Bus: probed
[    0.990487] libphy: nb8800-mii: probed
[    0.999534] nb8800 26000.ethernet eth0: MAC address 00:16:e8:43:2f:80
[    1.006218] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.012991] usbcore: registered new interface driver usb-storage
[    1.072811] ci_hdrc ci_hdrc.0: doesn't support gadget
[    1.077917] ci_hdrc ci_hdrc.0: EHCI Host Controller
[    1.082851] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
[    1.100296] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
[    1.106586] hub 1-0:1.0: USB hub found
[    1.110424] hub 1-0:1.0: 1 port detected
[    1.169474] ci_hdrc ci_hdrc.1: doesn't support gadget
[    1.174577] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    1.179510] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 2
[    1.196962] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    1.203147] hub 2-0:1.0: USB hub found
[    1.206980] hub 2-0:1.0: 1 port detected
[    1.212967] tangox-wdt 1fd00.watchdog: SMP86xx/SMP87xx watchdog registered
[    1.221059] sdhci: Secure Digital Host Controller Interface driver
[    1.227316] sdhci: Copyright(c) Pierre Ossman
[    1.231703] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.237845] usbcore: registered new interface driver usbhid
[    1.243463] usbhid: USB HID core driver
[    1.247645] NET: Registered protocol family 17
[    1.252201] Registering SWP/SWPB emulation handler
[    1.266305] Freeing unused kernel memory: 5120K (c0600000 - c0b00000)
Starting logging: OK
Initializing random number generator... [    1.359367] random: dd: uninitialized urandom read (512 bytes read)
done.
Starting network: OK
Starting telnetd: OK

Welcome to Buildroot
buildroot login: root
# 
# echo 0 > /sys/devices/system/cpu/cpu1/online
SMC called with a0=[0x00000001 a1=0x00000 121 a2=0x000 00005 a3 =0xc01193b4 70x000000121
[1][flow/suspend.c:39]. CPU 1 die:3 jumping to post-boot WFE4
4187] CPU1: shutdown
SMC called with a0=0x00000001 a1=0x00000122 a2=0x00000000 a3=0x00000000 0x00000122
[0][flow/suspend.c:82] Killing core1
armor+++ armor: core 1 booted, entering wfe...
# 
# echo 1 > /sys/devices/system/cpu/cpu1/online
[   86.924294] tango_boot_secondary from __cpu_up
SMC called with a0=0x80101500 a1=0x00000105 a2=0x00000000 a3=0x00000000 0x00000105
[   86.936275] tango_set_aux_boot_addr=0
SMC called with a0=0x00000001 a1=0x00000104 a2=0x00000000 a3=0x00000000 0x00000104
[0][flow/smc_handler.c:127] waking up CPU1
[   86.9[   8516.92512662]2] U Unnaabbllee  tto ho ahnandledle  kerkernenell NULL pointer dereference at virtual address 00000000
[   86.951266] pgd = c0004000
[   86.951271] [00000000] *pgd=00000000
[   86.951280] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[   86.951285] Modules linked in:
[   86.951292] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.9.0 #143
[   86.951294] Hardware name: Sigma Tango DT
[   86.951297] task: cf85b140 task.stack: cf85e000
[   86.951312] PC is at tick_broadcast_setup_oneshot+0x18/0x134
[   86.951319] LR is at debug_smp_processor_id+0x20/0x24
[   86.951324] pc : [<c0187394>]    lr : [<c030f0a4>]    psr: 200001d3
[   86.951324] sp : cf85fe90  ip : cf85fe80  fp : cf85fecc
[   86.951326] r10: 00000000  r9 : c05016d4  r8 : 400001d3
[   86.951329] r7 : 00000000  r6 : cfde8f80  r5 : 00000000  r4 : 00000001
[   86.951331] r3 : cf85e000  r2 : 00000002  r1 : c057d620  r0 : 00000001
[   86.951335] Flags: nzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment none
[   86.951338] Control: 10c5387d  Table: 8000404a  DAC: 00000051
[   86.951340] Process swapper/1 (pid: 0, stack limit = 0xcf85e210)
[   86.951344] Stack: (0xcf85fe90 to 0xcf860000)
[   86.951348] fe80:                                     cf85fedc cf85fea0 c0b482dc 400001d3
[   86.951354] fea0: cfde8f80 00000001 00000001 cfde8f80 00000000 400001d3 c05016d4 00000000
[   86.951359] fec0: cf85fef4 cf85fed0 c01875f4 c0187388 cfde8f80 cfde78f0 00000001 00000000
[   86.951364] fee0: 00000001 c05016d4 cf85ff2c cf85fef8 c0186318 c01874bc cf85ff14 cf85ff08
[   86.951369] ff00: c0b0c150 cfde78f0 cfde8f80 00000001 00000000 a00001d3 00000001 00000000
[   86.951374] ff20: cf85ff4c cf85ff30 c0186544 c01862bc c0b0c150 c0b0c150 c0b0c168 cfde8f80
[   86.951379] ff40: cf85ff74 cf85ff50 c01852ec c018648c cfde4244 00000060 c0b07cf8 00000001
[   86.951385] ff60: 0f3a5000 00000001 cf85ff84 cf85ff78 c03fcf10 c0185294 cf85ffb4 cf85ff88
[   86.951390] ff80: c011c588 c03fceb4 00000000 cfde4244 00000060 00000001 c0a3f244 0f3a5000
[   86.951395] ffa0: 413fc090 00000000 cf85ffdc cf85ffb8 c011e10c c011c53c c0b0d198 00000001
[   86.951400] ffc0: 10c0387d c0b21ae8 8000406a 413fc090 cf85fff4 cf85ffe0 c010dd6c c011e0bc
[   86.951405] ffe0: 8f84006a 00000051 00000000 cf85fff8 8010158c c010dc88 8f34eea9 0607fa8b
[   86.951408] Backtrace: 
[   86.951417] [<c018737c>] (tick_broadcast_setup_oneshot) from [<c01875f4>] (tick_device_uses_broadcast+0x144/0x1a8)
[   86.951423]  r10:00000000 r9:c05016d4 r8:400001d3 r7:00000000 r6:cfde8f80 r5:00000001
[   86.951425]  r4:00000001
[   86.951431] [<c01874b0>] (tick_device_uses_broadcast) from [<c0186318>] (tick_setup_device+0x68/0x110)
[   86.951437]  r9:c05016d4 r8:00000001 r7:00000000 r6:00000001 r5:cfde78f0 r4:cfde8f80
[   86.951443] [<c01862b0>] (tick_setup_device) from [<c0186544>] (tick_check_new_device+0xc4/0xe8)
[   86.951448]  r10:00000000 r9:00000001 r8:a00001d3 r7:00000000 r6:00000001 r5:cfde8f80
[   86.951450]  r4:cfde78f0
[   86.951457] [<c0186480>] (tick_check_new_device) from [<c01852ec>] (clockevents_register_device+0x64/0x11c)
[   86.951461]  r7:cfde8f80 r6:c0b0c168 r5:c0b0c150 r4:c0b0c150
[   86.951472] [<c0185288>] (clockevents_register_device) from [<c03fcf10>] (dummy_timer_starting_cpu+0x68/0x70)
[   86.951478]  r9:00000001 r8:0f3a5000 r7:00000001 r6:c0b07cf8 r5:00000060 r4:cfde4244
[   86.951490] [<c03fcea8>] (dummy_timer_starting_cpu) from [<c011c588>] (cpuhp_invoke_callback+0x58/0x120)
[   86.951497] [<c011c530>] (cpuhp_invoke_callback) from [<c011e10c>] (notify_cpu_starting+0x5c/0x6c)
[   86.951503]  r10:00000000 r9:413fc090 r8:0f3a5000 r7:c0a3f244 r6:00000001 r5:00000060
[   86.951505]  r4:cfde4244 r3:00000000
[   86.951511] [<c011e0b0>] (notify_cpu_starting) from [<c010dd6c>] (secondary_start_kernel+0xf0/0x164)
[   86.951516]  r9:413fc090 r8:8000406a r7:c0b21ae8 r6:10c0387d r5:00000001 r4:c0b0d198
[   86.951524] [<c010dc7c>] (secondary_start_kernel) from [<8010158c>] (0x8010158c)
[   86.951526]  r5:00000051 r4:8f84006a
[   86.951532] Code: e24cb004 e24dd014 e1a05000 eb061f3b (e5952000) 
[   86.951537] ---[ end trace b9e15a7104bf60a3 ]---
[   86.951543] Kernel panic - not syncing: Attempted to kill the idle task!
[   86.962632] CPU0: stopping
[   86.962638] CPU: 0 PID: 928 Comm: sh Tainted: G      D         4.9.0 #143
[   86.962640] Hardware name: Sigma Tango DT
[   86.962643] Backtrace: 
[   86.962659] [<c010b9c4>] (dump_backtrace) from [<c010bc80>] (show_stack+0x18/0x1c)
[   86.962664]  r7:60000193 r6:c0b10914 r5:00000000 r4:c0b10914
[   86.962674] [<c010bc68>] (show_stack) from [<c02f574c>] (dump_stack+0x80/0x94)
[   86.962680] [<c02f56cc>] (dump_stack) from [<c010e1f4>] (handle_IPI+0x1a0/0x1b4)
[   86.962685]  r7:00000000 r6:00000004 r5:00000000 r4:c0a42ec4
[   86.962690] [<c010e054>] (handle_IPI) from [<c01014ec>] (gic_handle_irq+0x90/0x94)
[   86.962695]  r9:d0803100 r8:d0802100 r7:cfbb7bb8 r6:d080210c r5:c0b03348 r4:c0b10b70
[   86.962700] [<c010145c>] (gic_handle_irq) from [<c010c7cc>] (__irq_svc+0x6c/0xa8)
[   86.962703] Exception stack(0xcfbb7bb8 to 0xcfbb7c00)
[   86.962706] 7ba0:                                                       00000000 60000093
[   86.962711] 7bc0: 00000000 60000013 c0b26880 c0b43ca0 00000000 00000026 00000000 00000073
[   86.962717] 7be0: 00002248 cfbb7c74 cfbb7b40 cfbb7c08 c04dc3d0 c0163780 60000013 ffffffff
[   86.962722]  r9:cfbb6000 r8:00000000 r7:cfbb7bec r6:ffffffff r5:60000013 r4:c0163780
[   86.962732] [<c0163490>] (console_unlock) from [<c0163d40>] (vprintk_emit+0x2ac/0x4a8)
[   86.962738]  r10:00000000 r9:c0b23d20 r8:c0b0b03c r7:00000004 r6:00000002 r5:00000000
[   86.962740]  r4:00000016
[   86.962746] [<c0163a94>] (vprintk_emit) from [<c01640dc>] (vprintk_default+0x28/0x30)
[   86.962751]  r10:00000000 r9:00000001 r8:c0b21ae8 r7:cf85b140 r6:c05a7a54 r5:c01640b4
[   86.962753]  r4:cfbb7d14
[   86.962764] [<c01640b4>] (vprintk_default) from [<c01a7df8>] (printk+0x74/0x7c)
[   86.962772] [<c01a7d88>] (printk) from [<c011949c>] (tango_boot_secondary+0x68/0x70)
[   86.962776]  r3:60000500 r2:00000003 r1:00000000 r0:c057376c
[   86.962779]  r5:00000001 r4:00000001
[   86.962784] [<c0119434>] (tango_boot_secondary) from [<c010d9bc>] (__cpu_up+0xb0/0x144)
[   86.962787]  r5:00000001 r4:c0b21af8
[   86.962792] [<c010d90c>] (__cpu_up) from [<c011d128>] (bringup_cpu+0x28/0xa8)
[   86.962797]  r9:00000001 r8:00000030 r7:00000001 r6:c0b086a8 r5:00000001 r4:cf85b140
[   86.962804] [<c011d100>] (bringup_cpu) from [<c011c588>] (cpuhp_invoke_callback+0x58/0x120)
[   86.962806]  r5:00000001 r4:cfde4244
[   86.962813] [<c011c530>] (cpuhp_invoke_callback) from [<c011c784>] (cpuhp_up_callbacks+0x2c/0xdc)
[   86.962819]  r10:00000000 r9:cfde4244 r8:00000030 r7:00000000 r6:00000000 r5:00000001
[   86.962821]  r4:cfde4244 r3:00000000
[   86.962827] [<c011c758>] (cpuhp_up_callbacks) from [<c011dd38>] (_cpu_up+0xb0/0x10c)
[   86.962832]  r9:cfde4244 r8:0f3a5000 r7:00000097 r6:00000000 r5:00000001 r4:c0a3f244
[   86.962837] [<c011dc88>] (_cpu_up) from [<c011de0c>] (do_cpu_up+0x78/0xa0)
[   86.962842]  r9:00000000 r8:00000000 r7:cec32540 r6:cfde4044 r5:00000097 r4:00000001
[   86.962847] [<c011dd94>] (do_cpu_up) from [<c011de48>] (cpu_up+0x14/0x18)
[   86.962849]  r5:cfde4010 r4:c036154c
[   86.962862] [<c011de34>] (cpu_up) from [<c0361560>] (cpu_subsys_online+0x14/0x18)
[   86.962869] [<c036154c>] (cpu_subsys_online) from [<c035cb14>] (device_online+0x6c/0x90)
[   86.962874] [<c035caa8>] (device_online) from [<c035cba8>] (online_store+0x70/0x7c)
[   86.962878]  r7:cec32540 r6:cfbb7f80 r5:00000002 r4:cfde4010
[   86.962883] [<c035cb38>] (online_store) from [<c035a3d4>] (dev_attr_store+0x20/0x2c)
[   86.962886]  r5:00000002 r4:c035cb38
[   86.962894] [<c035a3b4>] (dev_attr_store) from [<c024ac2c>] (sysfs_kf_write+0x48/0x4c)
[   86.962897]  r5:00000002 r4:c035a3b4
[   86.962903] [<c024abe4>] (sysfs_kf_write) from [<c024a3e8>] (kernfs_fop_write+0xf8/0x1f8)
[   86.962905]  r5:00000002 r4:cf9d2b80
[   86.962916] [<c024a2f0>] (kernfs_fop_write) from [<c01e3bd4>] (__vfs_write+0x34/0x120)
[   86.962922]  r10:00000000 r9:cfbb6000 r8:c0107d64 r7:00000002 r6:cfbb7f80 r5:c024a2f0
[   86.962924]  r4:cf9cd780
[   86.962930] [<c01e3ba0>] (__vfs_write) from [<c01e4a68>] (vfs_write+0xac/0x170)
[   86.962936]  r9:cfbb6000 r8:c0107d64 r7:cfbb7f80 r6:00e0a408 r5:cf9cd780 r4:00000002
[   86.962942] [<c01e49bc>] (vfs_write) from [<c01e5868>] (SyS_write+0x4c/0xa8)
[   86.962947]  r9:cfbb6000 r8:c0107d64 r7:00000002 r6:00e0a408 r5:cf9cd780 r4:cf9cd780
[   86.962955] [<c01e581c>] (SyS_write) from [<c0107ba0>] (ret_fast_syscall+0x0/0x3c)
[   86.962959]  r7:00000004 r6:b6effd60 r5:00e0a408 r4:00000002
[   87.718648] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!




CONFIG_CROSS_COMPILE="arm-linux-gnueabihf-"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_NO_HZ_IDLE=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_EMBEDDED=y
CONFIG_PERF_EVENTS=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODVERSIONS=y
CONFIG_ARCH_TANGO=y
# CONFIG_ARM_ERRATA_643719 is not set
CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_HZ_300=y
CONFIG_AEABI=y
CONFIG_HIGHMEM=y
# CONFIG_COMPACTION is not set
# CONFIG_ATAGS is not set
CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
CONFIG_CMDLINE="console=ttyS0,115200 mem=256M"
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPUFREQ_DT=y
CONFIG_VFP=y
CONFIG_NEON=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_IPV6 is not set
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
CONFIG_MTD=y
CONFIG_MTD_TESTS=m
CONFIG_MTD_NAND=y
CONFIG_MTD_NAND_TANGO=m
CONFIG_MTD_UBI=m
CONFIG_BLK_DEV_LOOP=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_NETDEVICES=y
CONFIG_NET_VENDOR_AURORA=y
CONFIG_AURORA_NB8800=y
CONFIG_AT803X_PHY=y
# CONFIG_USB_NET_DRIVERS is not set
# CONFIG_WLAN is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_SERIO is not set
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=1
CONFIG_SERIAL_8250_RUNTIME_UARTS=1
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_OF_PLATFORM=y
# CONFIG_HW_RANDOM is not set
CONFIG_I2C=y
CONFIG_I2C_XLR=y
CONFIG_GPIOLIB=y
CONFIG_THERMAL=y
CONFIG_CPU_THERMAL=y
CONFIG_TANGO_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_TANGOX_WATCHDOG=y
CONFIG_FB=y
CONFIG_USB=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_STORAGE=y
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_HOST=y
CONFIG_MMC=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_OF_ARASAN=y
CONFIG_DMADEVICES=y
CONFIG_TANGO_DMA=y
CONFIG_PHY_TANGO_USB=y
CONFIG_EXT4_FS=y
CONFIG_FUSE_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_UBIFS_FS=m
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_ROOT_NFS=y
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_UTF8=m
CONFIG_PRINTK_TIME=y
# CONFIG_FTRACE is not set
# CONFIG_ARM_UNWIND is not set
# CONFIG_CRYPTO_ECHAINIV is not set


Regards.
