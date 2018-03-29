From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 29 Mar 2018 14:34:46 +0200
Subject: ns16550 earlycon baud broken on BCM5301X since commit 31cb9a8575ca0
 ("earlycon: initialise baud field of earlycon device structure")
Message-ID: <CACna6rzki=sjXQS12eF3yPXH7XeFYTCXVOdj--F=P=jkJZX7fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I upgraded my BCM5301X device based on BCM4708 SoC from 4.13 to 4.14
and noticed earlycon output is corrupted (a wrong baud rate is used).


I bisected this problem down to the:

commit 31cb9a8575ca04f47ea113434d4782b695638b62
Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Date:   Mon Aug 21 19:22:13 2017 +0300

    earlycon: initialise baud field of earlycon device structure


My device uses arch/arm/boot/dts/bcm4708.dtsi:

uart0: serial at 0300 {
        compatible = "ns16550";
        reg = <0x0300 0x100>;
        interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
        clocks = <&iprocslow>;
        status = "okay";
};

aliases {
        serial0 = &uart0;
};

chosen {
        stdout-path = "serial0:115200n8";
};


A valid UART divisor for my device is 54. This is what bootloader sets
and what works with my serial console running 115200 8n1.


Before the commit 31cb9a8575ca0 early_serial8250_setup() never tried
setting baud because device->baud was 0. It left baud (divisor) to
whatever was configured by the bootloader. It has changed with above
commit though. So now the setup looks like that:
1) port->uartclk equals 1843200 as set in the of_setup_earlycon():
port->uartclk = BASE_BAUD * 16;
2) [NEW] device->baud equals 115200 as set in the of_setup_earlycon():
early_console_dev.baud = simple_strtoul(options, NULL, 0);
(a value of options is "115200n8")
3) [NEW] divisor is calculated to 1 in the init_port():
divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * device->baud);
4) [NEW] divisor is set using UART_DLL and UART_DLM in the init_port()

Obviously setting divisor 1 instead of 54 results in a wrong baud.


So right now my serial console output looks like that:
?6;'+{.??s?.???.".??4??.?????.??J|?.?.8??.?..??????g??~.????L>.??,?9z9?{?Z?.."???NC?<?9.?/???.?.?}??~.???"?.?|????;??.??yy?.[
   0.043623] console [ttyS0] enabled
[    0.043623] console [ttyS0] enabled
[    0.050842] bootconsole [ns16550] disabled
[    0.050842] bootconsole [ns16550] disabled
[    0.062939] libphy: Fixed MDIO Bus: probed
(...)

For a complete log (coming from dmesg command) see attachment.


Can you take a look at this problem, please? Is there something wrong
with my DT? Or is a problem in 8250 or earlycon?

-- 
Rafa?
-------------- next part --------------
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] random: get_random_bytes called from start_kernel+0x28/0x3a8 with crng_init=0
[    0.000000] Linux version 4.13.0-rc5+ (zajec at linux-samsung.lan) (gcc version 7.3.0 (OpenWrt GCC 7.3.0 r6427+1-ed3860c3e3)) #0 SMP Tue Mar 27 09:33:51 2018
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Luxul XAP-1510 V1
[    0.000000] earlycon: ns16550 at MMIO 0x18000300 (options '115200n8')
[    0.000000] bootconsole [ns16550] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Hit pending asynchronous external abort (FSR=0x00001c06) during first unmask, this is most likely caused by a firmware/bootloader bug.
[    0.000000] percpu: Embedded 14 pages/cpu @c7ed4000 s26572 r8192 d22580 u57344
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: console=ttyS0,115200 earlycon
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 123204K/131072K available (4096K kernel code, 110K rwdata, 816K rodata, 1024K init, 293K bss, 7868K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff800000   ( 880 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0500000   (5088 kB)
[    0.000000]       .init : 0xc0600000 - 0xc0700000   (1024 kB)
[    0.000000]       .data : 0xc0700000 - 0xc071ba40   ( 111 kB)
[    0.000000]        .bss : 0xc071ba40 - 0xc076514c   ( 294 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] L2C-310 cache controller enabled, 16 ways, 256 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x0a130000
[    0.000017] sched_clock: 64 bits at 400MHz, resolution 2ns, wraps every 4398046511103ns
[    0.008536] clocksource: arm_global_timer: mask: 0xffffffffffffffff max_cycles: 0x5c4093a7d1, max_idle_ns: 440795210635 ns
[    0.020288] Switching to timer-based delay loop, resolution 2ns
[    0.026902] Calibrating delay loop (skipped), value calculated using timer frequency.. 800.00 BogoMIPS (lpj=4000000)
[    0.038468] pid_max: default: 32768 minimum: 301
[    0.043609] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.050668] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.058963] CPU: Testing write buffer coherency: ok
[    0.064541] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.071125] Setting up static identity map for 0x100000 - 0x10003c
[    0.077950] Hierarchical SRCU implementation.
[    0.083177] smp: Bringing up secondary CPUs ...
[    0.088934] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.089061] smp: Brought up 1 node, 2 CPUs
[    0.099529] SMP: Total of 2 processors activated (1600.00 BogoMIPS).
[    0.106315] CPU: WARNING: CPU(s) started in wrong/inconsistent modes (primary CPU mode 0x13)
[    0.115346] CPU: This may indicate a broken bootloader or firmware.
[    0.124186] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.134761] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.141421] pinctrl core: initialized pinctrl subsystem
[    0.147498] NET: Registered protocol family 16
[    0.153026] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.162370] random: fast init done
[    0.175223] clocksource: Switched to clocksource arm_global_timer
[    0.182987] NET: Registered protocol family 2
[    0.188307] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.195823] TCP bind hash table entries: 1024 (order: 1, 8192 bytes)
[    0.202676] TCP: Hash tables configured (established 1024 bind 1024)
[    0.209613] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.215886] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.222894] NET: Registered protocol family 1
[    0.229199] workingset: timestamp_bits=30 max_order=15 bucket_order=0
[    0.241675] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.248020] jffs2: version 2.2. (NAND) (SUMMARY)  ?? 2001-2006 Red Hat, Inc.
[    0.259223] io scheduler noop registered
[    0.263418] io scheduler deadline registered (default)
[    0.268977] io scheduler mq-deadline registered
[    0.273817] io scheduler kyber registered
[    0.279206] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    0.287045] console [ttyS0] disabled
[    0.290933] 18000300.serial: ttyS0@MMIO 0x18000300 (irq = 18, base_baud = 6250000) is a 16550
[    0.300420] console [ttyS0] enabled
[    0.300420] console [ttyS0] enabled
[    0.307614] bootconsole [ns16550] disabled
[    0.307614] bootconsole [ns16550] disabled
[    0.319308] libphy: Fixed MDIO Bus: probed
(...)
