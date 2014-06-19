From: loeliger@gmail.com (Jon Loeliger)
Date: Thu, 19 Jun 2014 11:17:16 -0500
Subject: A clockevent IRQ delivery question
Message-ID: <CAJgR-BjUpaR0cxew+-fz5YcDu0VKzim-rhLF4j1hEnR_4O+Jsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Folks,

So, I have an dual core A9-based system for which I am trying
to write clocksource and clockevent support.  I have a question
about how I should write the IRQ-delivery in the clockevent setup
code.

I can get this port to work if I use the ARM global timers with
"arm,cortex-a9-global-timer".  That sets up both the clocksource
and the clockevent on PPI 11 through the GIC.  Wonderful.

I'm converting to using our Vendor timers now.  I have two, and
one of them is working just fine as a monotonic up-counter for
clocksource.   I am having difficulty setting the other timer up
as the clockevent timer.

The interrupt for the clkevt timer will come  through the GIC on
a SPI.  At the time that the clock codes is being set up, only
the first boot CPU is running.  The other hasn't been started yet,
but it will come online just after setting up these timers.

The problem I see is that near what should be the login prompt,
the system hangs.

Some questions:

In my clockevent init() function, should I be setting the cpumask
to cpu_all_mask, cpu_possible_mask, cpumask_of(smp_processor_id())
or something else?  Empirically, cpu_possible_mask wasn't working
and cpumask_of(smp_processor_id()) allowed the boot to get past
the delay calibration.

Should I also use irq_set_affinity(smp_processor_id()) here?

I think what I am missing is an understanding of which CPUs will or
should get the IRQ delivered to it, and how do I arrange to make
that happen.

Boot log and DTS fragment below.

Thanks,
jdl



[    0.000000] Booting Linux on physical CPU 0x900
[    0.000000] Linux version 3.14.0-00011-g5d35c95-dirty
(jloelige at revenge.us.oracle.com) (gcc version 4.6.3 (Sourcery
CodeBench Lite 2012.03-57) ) #316 SMP Thu Jun 19 10:27:58 CDT 2014
[    0.000000] CPU: ARMv7 Processor [412fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine model: RAPID V1
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] psci: probing function IDs from device-tree
[    0.000000] PERCPU: Embedded 7 pages/cpu @eefde000 s7040 r8192 d13440 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 260624
[    0.000000] Kernel command line: console=ttyAMA0,115200
root=/dev/ram0 rw earlyprintk
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1032328K/1048576K available (2974K kernel code,
140K rwdata, 956K rodata, 150K init, 231K bss, 16248K reserved,
270336K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc03ded6c   (3932 kB)
[    0.000000]       .init : 0xc03df000 - 0xc0404b80   ( 151 kB)
[    0.000000]       .data : 0xc0406000 - 0xc0429060   ( 141 kB)
[    0.000000]        .bss : 0xc0429068 - 0xc0462d04   ( 232 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] RapidIRQ: Valid mask 0x3a4000, clear mask 0x3a4000
[    0.000000] rapid_irq_init: Map HWIRQ 14 as VIRQ 160
[    0.000000] rapid_irq_init: Map HWIRQ 17 as VIRQ 161
[    0.000000] rapid_irq_init: Map HWIRQ 19 as VIRQ 162
[    0.000000] rapid_irq_init: Map HWIRQ 20 as VIRQ 163
[    0.000000] rapid_irq_init: Map HWIRQ 21 as VIRQ 164
[    0.000000] RAPID SIC chip 0 "interrupt-controller" @ f0004000, 5
irqs, parent IRQ: 32
[    0.000000] L310 cache controller enabled
[    0.000000] l2x0: 8 ways, CACHE_ID 0x410000c5, AUX_CTRL 0x7e460000,
Cache size: 512 kB
[    0.000000] rapid_timer_init: start
[    0.000000] rapid_timer_init: CCU base at 0xf0008000 (0xca000000)
[    0.000000] rapid_timer_init: calling of_clk_init()
[    0.000000] of_fixed_clk_setup: pll16 at 1600000000 Hz
[    0.000000] of_fixed_clk_setup: a9pll at 400000000 Hz
[    0.000000] of_fixed_clk_setup: pclk at 25000000 Hz
[    0.000000] of_fixed_clk_setup: a9periphclk at 200000000 Hz
[    0.000000] rapid_timer_init: sees a child /soc/ccu at ca000000/pll16
[    0.000000] rapid_timer_init: sees a child /soc/ccu at ca000000/a9pll
[    0.000000] rapid_timer_init: sees a child /soc/ccu at ca000000/pclk
[    0.000000] rapid_timer_init: sees a child /soc/ccu at ca000000/a9periphclk
[    0.000000] rapid_timer_init: sees a child /soc/ccu at ca000000/timer0clk
[    0.000000] rapid_timer_init: sees a child /soc/ccu at ca000000/timer1clk
[    0.000000] rapid_timer_init: sees a child /soc/ccu at ca000000/timer at 0
[    0.000000] rapid_timer_init: sees a child /soc/ccu at ca000000/timer at 1
[    0.000000] ort_clocksource_init: ClockSource node is
/soc/ccu at ca000000/timer at 1
[    0.000000] ort_clocksource_init: clocksource on Timer 1
[    0.000000] ort_clocksource_init: clksrc rate 800000000
[    0.000000] ort_clocksource_init: calling ort_timer_reset()
[    0.000000] ort_clocksource_init: calling ort_timer_start()
[    0.000000] ort_clocksource_init: calling sched_clock_register()
[    0.000012] sched_clock: 64 bits at 800MHz, resolution 1ns, wraps
every 2748779069440ns
[    0.000028] ort_clocksource_init: calling clocksource_register_hz()
[    0.000057] ort_clockevent_init: Timer node is /soc/ccu at ca000000/timer at 0
[    0.000075] ort_clockevent_init: clockevents on Timer 0
[    0.000094] ort_clockevent_init: found clk
[    0.000116] ort_clockevent_init: clk rate 800000000, ticks_per_jiffy 8000000
[    0.000161] ort_clockevent_init: Looks like IRQ 164
[    0.000204] ort_clkevt_set_mode: set clkevt mode 1
[    0.000229] ort_clkevt_set_mode: set clkevt mode 2
[    0.000251] ort_clockevent_init: Looks like clockevent was setup
[    0.000332] Calibrating delay loop... 795.44 BogoMIPS (lpj=3977216)
[    0.090323] pid_max: default: 32768 minimum: 301
[    0.090664] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.090695] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.093505] CPU: Testing write buffer coherency: ok
[    0.093981] CPU0: thread -1, cpu 0, socket 9, mpidr 80000900
[    0.094054] Setting up static identity map for 0x2d0aa8 - 0x2d0adc
[    0.096920] CPU1: Booted secondary processor
[    0.130280] CPU1: thread -1, cpu 1, socket 9, mpidr 80000901
[    0.130545] Brought up 2 CPUs
[    0.130584] SMP: Total of 2 processors activated.
[    0.130602] CPU: All CPU(s) started in SVC mode.
[    0.131992] devtmpfs: initialized
[    0.139390] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 2
[    0.140567] NET: Registered protocol family 16
[    0.142194] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.149520] Serial: AMBA PL011 UART driver
[    0.149732] ca032000.serial: ttyAMA0 at MMIO 0xca032000 (irq = 163,
base_baud = 0) is a PL011 rev3
[    0.659476] console [ttyAMA0] enabled
[    0.683740] bio: create slab <bio-0> at 0
[    0.691556] SCSI subsystem initialized
[    0.695431] ssp-pl022 ce000000.spi: ARM PL022 driver, device ID: 0x00241022
[    0.702538] amba ce000000.spi: Driver ssp-pl022 requests probe deferral
[    0.711944] pps_core: LinuxPPS API ver. 1 registered
[    0.716927] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.726399] PTP clock support registered
[    0.732365] Switched to clocksource oracle_rapid_timer
[    0.740312] ort_clkevt_set_mode: set clkevt mode 3
[    0.748781] NET: Registered protocol family 2
[    0.754535] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.761855] TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
[    0.768857] TCP: Hash tables configured (established 8192 bind 8192)
[    0.775447] TCP: reno registered
[    0.778712] UDP hash table entries: 512 (order: 2, 24576 bytes)
[    0.784772] UDP-Lite hash table entries: 512 (order: 2, 24576 bytes)
[    0.791621] NET: Registered protocol family 1
[    0.796495] Trying to unpack rootfs image as initramfs...
[    0.803463] rootfs image is not initramfs (no cpio magic); looks
like an initrd
[    0.833339] Freeing initrd memory: 2652K (dfca1000 - dff38000)
[    0.842709] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.849969] bounce pool size: 64 pages
[    0.882765] jffs2: version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
[    0.890854] msgmni has been set to 1493
[    0.896809] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 252)
[    0.904297] io scheduler noop registered
[    0.908233] io scheduler deadline registered
[    0.913733] io scheduler cfq registered (default)
[    1.158866] of_dma_request_slave_channel: dma-names property of
node '/soc/serial at ca032000' missing or empty
[    1.168805] uart-pl011 ca032000.serial: no DMA platform data
[    1.197169] brd: module loaded
[    1.204911] mousedev: PS/2 mouse device common for all mice
[    1.210830] i2c /dev entries driver
[    1.215926] ipip: IPv4 over IPv4 tunneling driver
[    1.222557] TCP: cubic registered
[    1.225897] NET: Registered protocol family 17
[    1.230469] Registering SWP/SWPB emulation handler
[    1.238665] ssp-pl022 ce000000.spi: ARM PL022 driver, device ID: 0x00241022
[    1.245867] ssp-pl022 ce000000.spi: mapped registers from
0xce000000 to f00e0000
[    1.253417] of_dma_request_slave_channel: dma-names property of
node '/soc/spi at ce000000' missing or empty
[    1.263065] ssp-pl022 ce000000.spi: Failed to work in dma mode,
work without dma!
[    1.271909] ssp-pl022 ce000000.spi: Max speed that can be
programmed is 12500000 Hz, you requested 100000000
[    1.282386] m25p80 spi32766.0: n25q128a11 (16384 Kbytes)
[    1.287775] 5 ofpart partitions found on MTD device spi32766.0
[    1.293616] Creating 5 MTD partitions on "spi32766.0":
[    1.298770] 0x000000100000-0x000000140000 : "u-boot-env"
[    1.307030] 0x000000140000-0x000000180000 : "dtb"
[    1.314593] 0x000000180000-0x000000200000 : "u-boot"
[    1.322402] 0x000000200000-0x000000480000 : "linux"
[    1.330129] 0x000000480000-0x000001000000 : "rootfs"
[    1.340525] RAMDISK: gzip image found at block 0
[    1.823107] VFS: Mounted root (ext2 filesystem) on device 1:0.
[    1.829209] devtmpfs: mounted
[    1.832688] Freeing unused kernel memory: 148K (c03df000 - c0404000)
Starting logging: OK
Initializing random number generator... [    1.995481] random: dd
urandom read with 1 bits of entropy available
done.
Starting network...
Starting dropbear sshd: OK

And this fragment:

        ccu: ccu at ca000000 {
            compatible = "oracle,rapid-ccu";
            reg = <0xca000000 0x100>;
            #address-cells = <1>;
            #size-cells = <0>;

            pll16: pll16 {
                #clock-cells = <0>;
                compatible = "fixed-clock";
                clock-frequency = <1600000000>;    /* 1.6 GHz */
            };

            a9pll: a9pll {
                #clock-cells = <0>;
                compatible = "fixed-clock";
                clock-frequency = <400000000>;    /* 400 MHz */
            };

            pclk: pclk {
                #clock-cells = <0>;
                compatible = "fixed-clock";
                clock-frequency = <25000000>;    /* 25 MHz */
            };

            a9periphclk: a9periphclk {
                #clock-cells = <0>;
                compatible = "fixed-clock";
                clock-frequency = <200000000>;    /* 200 MHz */
            };

            timer0clk: timer0clk {
                compatible = "fixed-factor-clock";
                #clock-cells = <0>;
                clocks = <&pll16>;
                clock-div = <2>;
                clock-mult = <1>;
                clock-frequency = <800000000>;    /* 800 MHz */
            };

            timer1clk: timer1clk {
                compatible = "fixed-factor-clock";
                #clock-cells = <0>;
                clocks = <&pll16>;
                clock-div = <2>;
                clock-mult = <1>;
                clock-frequency = <800000000>;    /* 800 MHz */
            };

            timer at 0 {
                compatible = "oracle,rapid-timer";
                reg = <0>;
                clocks = <&timer0clk>;
                clock-names = "timer0clk";
                interrupt-parent = <&sic>;
                interrupts = <21 0x4>;
            };

            timer at 1 {
                compatible = "oracle,rapid-clksrc";
                reg = <1>;
                clocks = <&timer1clk>;
                clock-names = "timer1clk";
            };
        };
