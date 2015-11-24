From: markku.ahvenjarvi@nomovok.com (=?UTF-8?Q?Markku_Ahvenj=c3=a4rvi?=)
Date: Tue, 24 Nov 2015 15:57:01 +0200
Subject: am35xx memory management issues
In-Reply-To: <5645E026.9010002@nomovok.com>
References: <5644AD53.3020303@nomovok.com> <20151112170659.GL3218@atomide.com>
 <5645E026.9010002@nomovok.com>
Message-ID: <56546CAD.4060007@nomovok.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 13.11.2015 15:05, Markku Ahvenj?rvi wrote:
> Hi,
> 
> On 12.11.2015 19:06, Tony Lindgren wrote:
>> Hi,
>>
>> * Markku Ahvenj?rvi <markku.ahvenjarvi@nomovok.com> [151112 07:26]:
>>> Hello everyone,
>>>
>>> We have am3517 based board and are experiencing sporadic corruption of mm structures. We've had this problem for months now and haven't really got bottom of it.
>>>
>>> Our board is currently using 3.18.20, but with am3517-evm we've tried pretty much everything between v3.14 and v4.2. So far we've been able to reproduce it on am3517-evm, craneboard and beagleboard (rev. C3 and C4). We have also tested am/dm37x-evm, am335x-evm and beagle bone black, no problems seen.
>>>
>>> Usually kernel it panics in 'kernel BUG at mm/rmap.c:406!', but occasionally there's 'BUG: Bad rss-counter state' prints followed by NULL pointer deref or another BUG statement in mm/slab.c. Sometimes spinlock lockup or already unlocked reported, so it is quite random.
>>>
>>> Reproducing can take from half hour up to few days. We are using stress-ng with options:
>>> stress-ng --cpu 1 --vm 3 --vm-bytes 64M --fork 4
>>>
>>> In our tests we have noticed that kernel configuration affect frequency of the problem. So far we haven't seen any with omap2plus_defconfig, but with slimmer defconfig like the one we are using for our board we can get it in few hours. We bisected our defconfig and omap2plus_defconfig, but couldn't pinpoint any specific config that would cause these problems: it just got less frequent until stopped occurring. To rule out any bad behaving drivers, we basically disabled everything but serial and it just kept crashing.
>>
>> Adding also LAKML to Cc. Can you check if it starts happening if you
>> leave out other omaps from .config other than CONFIG_ARCH_OMAP3?
>> That's to compile code only for ARMv7 and leave out ARMv6.
>>
>> Also please check if leaving out CONFIG_SMP_ON_UP affects things.
> 
> Alright, will do.

We've been testing omap2plus defconfig without other omaps and without CONFIG_SMP_ON_UP. So far we haven't seen any panics, but I've had only a few units testing it.

Meanwhile we've been testing our custom board with a configuration that is quite close to omap2plus, including other omaps and CONFIG_SMP_ON_UP. We've had couple of panics, so it seems that these doesn't affect the problem. We had 15 units running stress-ng and it took ~8 days until we saw first panic, so if omap2plus is affected it is quite rare.

Any other suggestions?

Regards,

Markku

> 
>>> Someone was having quite similar problems back in 2012, but other than that we've found nothing:
>>> http://thread.gmane.org/gmane.linux.ports.arm.omap/78039/
>>>
>>> Anyone seen this kind of issues before? Any ideas what might cause this?
>>
>> If it starts happening after after leaving out ARMv6 or SMP_ON_UP,
>> it could be a cache bug or missing errata that's needed.
> 
> Right.
> 
> Regards,
> 
> Markku
> 
>>
>> Regards,
>>
>> Tony
>>
>>
>>> [    0.000000] Booting Linux on physical CPU 0x0
>>> [    0.000000] Linux version 3.18.24 (markku at thinkpad) (gcc version 4.9.3 20141031 (prerelease) (Linaro GCC 2014.11) ) #2 PREEMPT Wed Nov 4 09:51:36 EET 2015
>>> [    0.000000] CPU: ARMv7 Processor [411fc087] revision 7 (ARMv7), cr=10c5387d
>>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
>>> [    0.000000] Machine model: TI AM3517 EVM (AM3517/05 TMDSEVM3517)
>>> [    0.000000] cma: Reserved 8 MiB at 0x8f400000
>>> [    0.000000] Memory policy: Data cache writeback
>>> [    0.000000] On node 0 totalpages: 65280
>>> [    0.000000] free_area_init_node: node 0, pgdat c09be980, node_mem_map cfce7000
>>> [    0.000000]   Normal zone: 512 pages used for memmap
>>> [    0.000000]   Normal zone: 0 pages reserved
>>> [    0.000000]   Normal zone: 65280 pages, LIFO batch:15
>>> [    0.000000]   HighMem zone: 1048574 pages exceeds freesize 0
>>> [    0.000000] CPU: All CPU(s) started in SVC mode.
>>> [    0.000000] AM3517 ES1.1 (l2cache sgx neon )
>>> [    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
>>> [    0.000000] pcpu-alloc: [0] 0
>>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64768
>>> [    0.000000] Kernel command line: console=ttyO2,115200
>>> [    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
>>> [    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
>>> [    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
>>> [    0.000000] Memory: 239940K/261120K available (4809K kernel code, 341K rwdata, 1816K rodata, 2996K init, 353K bss, 21180K reserved, 0K highmem)
>>> [    0.000000] Virtual kernel memory layout:
>>> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>>> [    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
>>> [    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
>>> [    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
>>> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
>>> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
>>> [    0.000000]       .text : 0xc0008000 - 0xc0680984   (6627 kB)
>>> [    0.000000]       .init : 0xc0681000 - 0xc096e000   (2996 kB)
>>> [    0.000000]       .data : 0xc096e000 - 0xc09c354c   ( 342 kB)
>>> [    0.000000]        .bss : 0xc09c354c - 0xc0a1b97c   ( 354 kB)
>>> [    0.000000] Preemptible hierarchical RCU implementation.
>>> [    0.000000] NR_IRQS:16 nr_irqs:16 16
>>> [    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
>>> [    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/600 MHz
>>> [    0.000000] OMAP clockevent source: timer2 at 13000000 Hz
>>> [    0.000023] sched_clock: 32 bits at 13MHz, resolution 76ns, wraps every 330382100403ns
>>> [    0.000058] OMAP clocksource: timer1 at 13000000 Hz
>>> [    0.000598] Console: colour dummy device 80x30
>>> [    0.000635] Calibrating delay loop... 589.82 BogoMIPS (lpj=294912)
>>> [    0.008980] pid_max: default: 32768 minimum: 301
>>> [    0.009168] Security Framework initialized
>>> [    0.009264] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
>>> [    0.009282] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
>>> [    0.010313] CPU: Testing write buffer coherency: ok
>>> [    0.010936] Setting up static identity map for 0x80496c78 - 0x80496cd0
>>> [    0.013878] devtmpfs: initialized
>>> [    0.016530] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
>>> [    0.038120] omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
>>> [    0.038751] omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
>>> [    0.082753] omap_hwmod: mcbsp2: cannot be enabled for reset (3)
>>> [    0.099153] pinctrl core: initialized pinctrl subsystem
>>> [    0.100179] regulator-dummy: no parameters
>>> [    0.134359] NET: Registered protocol family 16
>>> [    0.137058] DMA: preallocated 256 KiB pool for atomic coherent allocations
>>> [    0.146611] Reprogramming SDRC clock to 332000000 Hz
>>> [    0.149695] platform 480c5000.aes: Cannot lookup hwmod 'aes'
>>> [    0.156050] OMAP GPIO hardware version 2.5
>>> [    0.173473] platform 480c3000.sham: Cannot lookup hwmod 'sham'
>>> [    0.174042] platform 480cb000.smartreflex: Cannot lookup hwmod 'smartreflex_core'
>>> [    0.181773] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
>>> [    0.182409] platform 480ab000.usb_otg_hs: Cannot lookup hwmod 'usb_otg_hs'
>>> [    0.185485] No ATAGs?
>>> [    0.185526] hw-breakpoint: debug architecture 0x4 unsupported.
>>> [    0.187801] OMAP DMA hardware revision 4.0
>>> [    0.248481] omap-dma-engine 48056000.dma-controller: OMAP DMA engine driver
>>> [    0.249924] vmmc_fixed: 3300 mV
>>> [    0.251923] SCSI subsystem initialized
>>> [    0.252848] usbcore: registered new interface driver usbfs
>>> [    0.253127] usbcore: registered new interface driver hub
>>> [    0.253330] usbcore: registered new device driver usb
>>> [    0.255867] omap_i2c 48070000.i2c: bus 0 rev3.3 at 400 kHz
>>> [    0.257215] omap_i2c 48072000.i2c: bus 1 rev3.3 at 400 kHz
>>> [    0.258330] omap_i2c 48060000.i2c: bus 2 rev3.3 at 400 kHz
>>> [    0.260815] Switched to clocksource timer1
>>> [    0.340661] NET: Registered protocol family 2
>>> [    0.342429] TCP established hash table entries: 2048 (order: 1, 8192 bytes)
>>> [    0.342506] TCP bind hash table entries: 2048 (order: 3, 40960 bytes)
>>> [    0.342604] TCP: Hash tables configured (established 2048 bind 2048)
>>> [    0.342743] TCP: reno registered
>>> [    0.342768] UDP hash table entries: 256 (order: 1, 12288 bytes)
>>> [    0.342879] UDP-Lite hash table entries: 256 (order: 1, 12288 bytes)
>>> [    0.343204] NET: Registered protocol family 1
>>> [    0.861358] hw perfevents: enabled with armv7_cortex_a8 PMU driver, 5 counters available
>>> [    0.867219] futex hash table entries: 256 (order: 0, 7168 bytes)
>>> [    0.870487] VFS: Disk quotas dquot_6.5.2
>>> [    0.870589] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
>>> [    0.871381] msgmni has been set to 484
>>> [    0.874913] io scheduler noop registered
>>> [    0.874948] io scheduler deadline registered
>>> [    0.875029] io scheduler cfq registered (default)
>>> [    0.877145] pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 size 568
>>> [    0.877537] pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size 92
>>> [    0.880571] omap_uart 4806a000.serial: no wakeirq for uart0
>>> [    0.881110] 4806a000.serial: ttyO0 at MMIO 0x4806a000 (irq = 88, base_baud = 3000000) is a OMAP UART0
>>> [    0.882028] omap_uart 4806c000.serial: no wakeirq for uart0
>>> [    0.882573] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq = 89, base_baud = 3000000) is a OMAP UART1
>>> [    0.883521] omap_uart 49020000.serial: no wakeirq for uart0
>>> [    0.883691] 49020000.serial: ttyO2 at MMIO 0x49020000 (irq = 90, base_baud = 3000000) is a OMAP UART2
>>> [    1.469044] console [ttyO2] enabled
>>> [    1.492339] brd: module loaded
>>> [    1.498629] mtdoops: mtd device (mtddev=name/number) must be supplied
>>> [    1.508182] usbcore: registered new interface driver asix
>>> [    1.514672] usbcore: registered new interface driver ax88179_178a
>>> [    1.522285] usbcore: registered new interface driver cdc_ether
>>> [    1.529444] usbcore: registered new interface driver smsc95xx
>>> [    1.536463] usbcore: registered new interface driver net1080
>>> [    1.543372] usbcore: registered new interface driver cdc_subset
>>> [    1.550618] usbcore: registered new interface driver cdc_ncm
>>> [    1.561182] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
>>> [    1.595009] usbcore: registered new interface driver usbhid
>>> [    1.601583] usbhid: USB HID core driver
>>> [    1.607206] oprofile: using arm/armv7
>>> [    1.611987] nf_conntrack version 0.5.0 (3877 buckets, 15508 max)
>>> [    1.619512] TCP: cubic registered
>>> [    1.623127] Initializing XFRM netlink socket
>>> [    1.627898] NET: Registered protocol family 17
>>> [    1.632751] NET: Registered protocol family 15
>>> [    1.637616] Key type dns_resolver registered
>>> [    1.642382] omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu_iva
>>> [    1.650025] omap2_set_init_voltage: unable to set vdd_mpu_iva
>>> [    1.656119] omap2_set_init_voltage: unable to find boot up OPP for vdd_core
>>> [    1.663479] omap2_set_init_voltage: unable to set vdd_core
>>> [    1.670110] PM: no software I/O chain control; some wakeups may be lost
>>> [    1.677499] pm: Failed to request pm_wkup irq
>>> [    1.682230] ThumbEE CPU extension supported.
>>> [    1.686920] Registering SWP/SWPB emulation handler
>>> [    1.697176] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
>>> [    1.705634] mmc0: host does not support reading read-only switch, assuming write-enable
>>> [    1.721911] mmc0: new high speed SDHC card at address 0002
>>> [    1.737955] mmcblk0: mmc0:0002       3.81 GiB
>>> [    1.748383]  mmcblk0: p1 p2 p3
>>> [    1.756622] Warning: unable to open an initial console.
>>> [    1.772351] Freeing unused kernel memory: 2996K (c0681000 - c096e000)
>>> [    2.651221] udevd[643]: starting version 182
>>> [    4.101678] random: dd urandom read with 51 bits of entropy available
>>> [   15.397932] random: nonblocking pool is initialized
>>> [  382.789857] perf interrupt took too long (2535 > 2500), lowering kernel.perf_event_max_sample_rate to 50000
>>> [  755.387860] perf interrupt took too long (5004 > 5000), lowering kernel.perf_event_max_sample_rate to 25000
>>> [ 4675.751682] ------------[ cut here ]------------
>>> [ 4675.814115] WARNING: CPU: 0 PID: 27573 at mm/rmap.c:226 unlink_anon_vmas+0x20c/0x21c()
>>> [ 4675.895950] Modules linked in:
>>> [ 4675.927371] CPU: 0 PID: 27573 Comm: stress-ng-fork Not tainted 3.18.24 #2
>>> [ 4676.007080] [<c00145b4>] (unwind_backtrace) from [<c0011e68>] (show_stack+0x10/0x14)
>>> [ 4676.089059] [<c0011e68>] (show_stack) from [<c0035824>] (warn_slowpath_common+0x70/0x88)
>>> [ 4676.172027] [<c0035824>] (warn_slowpath_common) from [<c00358d8>] (warn_slowpath_null+0x1c/0x24)
>>> [ 4676.266028] [<c00358d8>] (warn_slowpath_null) from [<c00ef6b8>] (unlink_anon_vmas+0x20c/0x21c)
>>> [ 4676.358081] [<c00ef6b8>] (unlink_anon_vmas) from [<c00e4658>] (free_pgtables+0x78/0xcc)
>>> [ 4676.441074] [<c00e4658>] (free_pgtables) from [<c00ec624>] (exit_mmap+0xf0/0x230)
>>> [ 4676.521016] [<c00ec624>] (exit_mmap) from [<c003313c>] (mmput+0x50/0xec)
>>> [ 4676.593103] [<c003313c>] (mmput) from [<c0036434>] (do_exit+0x25c/0x9d0)
>>> [ 4676.665045] [<c0036434>] (do_exit) from [<c00379e8>] (do_group_exit+0x3c/0xb0)
>>> [ 4676.741161] [<c00379e8>] (do_group_exit) from [<c0037a6c>] (__wake_up_parent+0x0/0x18)
>>> [ 4676.824005] ---[ end trace 216df8b29a401aa4 ]---
>>> [ 4676.875157] ------------[ cut here ]------------
>>> [ 4676.880036] kernel BUG at mm/rmap.c:406!
>>> [ 4676.884144] Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
>>> [ 4676.889889] Modules linked in:
>>> [ 4676.893107] CPU: 0 PID: 27573 Comm: stress-ng-fork Tainted: G        W      3.18.24 #2
>>> [ 4676.901400] task: cf220c80 ti: ce072000 task.ti: ce072000
>>> [ 4676.907077] PC is at unlink_anon_vmas+0x1dc/0x21c
>>> [ 4676.912007] LR is at unlink_anon_vmas+0x104/0x21c
>>> [ 4676.916935] pc : [<c00ef688>]    lr : [<c00ef5b0>]    psr: 200c0013
>>> [ 4676.916935] sp : ce073e80  ip : 00000000  fp : c09c13c6
>>> [ 4676.928949] r10: ce19c8c8  r9 : ce19c8fc  r8 : ce19c904
>>> [ 4676.934419] r7 : ce0780e8  r6 : ce1ceaa0  r5 : c09fc620  r4 : ce1ceaa0
>>> [ 4676.941251] r3 : 00000004  r2 : ffff0001  r1 : 00000000  r0 : ce0eb568
>>> [ 4676.948086] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>>> [ 4676.955556] Control: 10c5387d  Table: 8e100019  DAC: 00000015
>>> [ 4676.961571] Process stress-ng-fork (pid: 27573, stack limit = 0xce072238)
>>> [ 4676.968677] Stack: (0xce073e80 to 0xce074000)
>>> [ 4676.973246] 3e80: 00000000 ce0eb568 cf2b893c ce19c8c8 ce1c7768 4a5c8000 ce073ed8 00002000
>>> [ 4676.981811] 3ea0: 00000000 ce068040 ce068084 c00e4658 4a5c8000 c00e6538 00000000 ce183c90
>>> [ 4676.990376] 3ec0: ce073f00 ce068040 000000f8 c000e8a4 00000001 c00ec624 ce068040 00000001
>>> [ 4676.998940] 3ee0: 00000000 00000000 ffffffff b6f5a070 ffffffec 000000c1 00000400 ce175000
>>> [ 4677.007505] 3f00: c0994c78 cf220c80 cf220c80 ce072008 000000f8 ce068040 00000000 ce072008
>>> [ 4677.016069] 3f20: 000000f8 ce068040 00000000 ce072008 000000f8 c003313c cf221104 cf220c80
>>> [ 4677.024634] 3f40: ce072008 c0036434 be9d6ea4 c0068a90 cf006940 cf00699c ce072030 00000036
>>> [ 4677.033198] 3f60: c09a2d94 00000000 ce072000 ce1d2800 000000f8 c000e8a4 ce072000 00000000
>>> [ 4677.041762] 3f80: 0005bb68 c00379e8 00000000 00000000 0005bb58 000000f8 c000e8a4 c0037a6c
>>> [ 4677.050326] 3fa0: 00000000 c000e720 00000000 00000000 00000000 00000000 00000000 4a72c468
>>> [ 4677.058890] 3fc0: 00000000 00000000 0005bb58 000000f8 00000001 00000000 be9d6ed0 0005bb68
>>> [ 4677.067455] 3fe0: 4a695e80 be9d6ea4 0001b21c 4a695e90 60060010 00000000 00000000 00000000
>>> [ 4677.076039] [<c00ef688>] (unlink_anon_vmas) from [<c00e4658>] (free_pgtables+0x78/0xcc)
>>> [ 4677.084430] [<c00e4658>] (free_pgtables) from [<c00ec624>] (exit_mmap+0xf0/0x230)
>>> [ 4677.092275] [<c00ec624>] (exit_mmap) from [<c003313c>] (mmput+0x50/0xec)
>>> [ 4677.099302] [<c003313c>] (mmput) from [<c0036434>] (do_exit+0x25c/0x9d0)
>>> [ 4677.106326] [<c0036434>] (do_exit) from [<c00379e8>] (do_group_exit+0x3c/0xb0)
>>> [ 4677.113895] [<c00379e8>] (do_group_exit) from [<c0037a6c>] (__wake_up_parent+0x0/0x18)
>>> [ 4677.122189] Code: 0a000009 e2820004 ebfdc186 eaffffb2 (e7f001f2)
>>> [ 4677.128597] ---[ end trace 216df8b29a401aa5 ]---
>>> [ 4677.133435] Kernel panic - not syncing: Fatal exception
>>> [ 4677.138911] ---[ end Kernel panic - not syncing: Fatal exception
>>> --
