From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 9 Oct 2017 12:38:14 +0100
Subject: arm64: 4.14 of_match_node() issues
In-Reply-To: <20171009092409.GB5127@arm.com>
References: <5d2ff063-1f7e-0200-cc02-99804f7d9219@suse.de>
 <20171009092409.GB5127@arm.com>
Message-ID: <2376360f-6833-6a0c-c8bc-dfb6ae771068@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/10/17 10:24, Will Deacon wrote:
> Hi Andreas,
> 
> On Sat, Oct 07, 2017 at 02:42:13AM +0200, Andreas F?rber wrote:
>> Since 4.14-rc1 I am seeing frequent oopses during module loading (e.g.,
>> MMC, USB) from initrd on aarch64. Symptoms are similar to this in -rc3:
>>
>> [  OK  ] Started udev Coldplug all Devices.
>> [   10.117775] usbcore: registered new interface driver usbfs
>> [   10.118235] Unable to handle kernel paging request at virtual address
>> ffff000008e5abc0
>> [   10.118238] Mem abort info:
>> [   10.118245]   Exception class = DABT (current EL), IL = 32 bits
>> [   10.118249]   SET = 0, FnV = 0
>> [   10.118253]   EA = 0, S1PTW = 0
>> [   10.118256] Data abort info:
>> [   10.118261]   ISV = 0, ISS = 0x00000006
>> [   10.118264]   CM = 0, WnR = 0
>> [   10.118274] swapper pgtable: 4k pages, 48-bit VAs, pgd = ffff0000094a5000
>> [   10.118279] [ffff000008e5abc0] *pgd=00000000bfffe003,
>> *pud=00000000bfffd003, *pmd=0000000000000000
>> [   10.118299] Internal error: Oops: 96000006 [#1] SMP
>> [   10.118305] Modules linked in: fixed usbcore(+) sunxi_mmc mmc_core
>> phy_sun4i_usb sg
>> [   10.118341] CPU: 3 PID: 49 Comm: kworker/3:1 Not tainted
>> 4.14.0-rc3-2.gf27997b-default #1
>> [   10.118345] Hardware name: sunxi sunxi/sunxi, BIOS 2017.05-rc1 04/13/2017
>> [   10.118369] Workqueue: events deferred_probe_work_func
>> [   10.118378] task: ffff80007c8f4000 task.stack: ffff0000099d8000
>> [   10.118394] PC is at __of_match_node.part.1+0x48/0x88
>> [   10.118403] LR is at of_match_node+0x40/0x70
>> [   10.118411] pc : [<ffff00000879aed0>] lr : [<ffff00000879af50>]
> 
> [...]
> 
>> This has been observed on Pine64 (>60%; also by Stefan) and Odroid-C2;
>> my other arm64 boards such as Raspberry Pi 3 have not run into this so
>> far. No such problems on 32-bit boards.
>>
>> This is using the openSUSE config:
>> https://kernel.opensuse.org/cgit/kernel-source/plain/config/arm64/default
> 
> Hmm, hard to know what to suggest without a concrete reproducer.

I can reproduce it here: SoPine64, latest firmware, Linus' 4.14-rc4 with
Andreas' config. Attaching the log.

> Do you know
> which driver is being probed in the log above?

I see it when probing fixed.ko (fixed regulator), also phy-sun4i-usb.ko.
I have never seen it on the first modprobe, though (see the log).

> Also, does this still break
> if you pass "keepinitrd" on the cmdline?

Yes.

Cheers,
Andre.

-------------- next part --------------
U-Boot SPL 2017.09-00282-g34d179f35d-dirty (Oct 09 2017 - 10:30:43)
DRAM: 2048 MiB
Trying to boot from sunxi SPI
NOTICE:  BL3-1: Running on A64/H64 (1689) in SRAM A2 (@0x44000)
NOTICE:  Configuring SPC Controller
NOTICE:  BL3-1: v1.0(debug):d816dcdb
NOTICE:  BL3-1: Built : 10:25:46, Oct  9 2017
NOTICE:  PMIC: Probing for AXP803 on A64
NOTICE:  PMIC: AXP803 successfully setup
NOTICE:  Configuring thermal sensors
NOTICE:  SCPI: installed handler, implementation level: 112011
INFO:    BL3-1: Initializing runtime services
INFO:    BL3-1: Preparing for EL3 exit to normal world
INFO:    BL3-1: Next image address: 0x4a000000, SPSR: 0x3c9


U-Boot 2017.09-00282-g34d179f35d-dirty (Oct 09 2017 - 10:30:43 +0100) Allwinner Technology

CPU:   Allwinner A64 (SUN50I)
Model: Pine64+
DRAM:  2 GiB
MMC:   SUNXI SD/MMC: 0, SUNXI SD/MMC: 1
Card did not respond to voltage select!
mmc_init: -95, time 22
*** Warning - MMC init failed, using default environment

In:    serial
Out:   serial
Err:   serial
Net:   phy interface7
eth0: ethernet at 1c30000
starting USB...
USB0:   USB EHCI 0.00
USB1:   USB OHCI 0.0
USB2:   PA: set_value: error: gpio PA0 not reserved
USB EHCI 1.00
USB3:   USB OHCI 1.0
scanning bus 0 for devices... 1 USB Device(s) found
scanning bus 2 for devices... 1 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Hit any key to stop autoboot:  2  0 
=> dhcp
BOOTP broadcast 1
DHCP client bound to address 192.168.67.246 (10 ms)
*** Warning: no boot file name; using 'C0A843F6.img'
Using ethernet at 1c30000 device
TFTP from server 192.168.67.1; our IP address is 192.168.67.246
Filename 'C0A843F6.img'.
Load address: 0x42000000
Loading: *
TFTP error: 'file /root/C0A843F6.img not found' (1)
Not retrying...
=> setenv serverip 192.168.67.35
=> ftpboot $kernel_addr_r Image-4.14-rc4-suse
Using ethernet at 1c30000 device
TFTP from server 192.168.67.35; our IP address is 192.168.67.246
Filename 'Image-4.14-rc4-suse'.
Load address: 0x40080000
Loading: *#################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #######################################
	 11 MiB/s
done
Bytes transferred = 19649024 (12bd200 hex)
=> tftpboot $ramdisk_addr_r debian-testing-debug.initrd.img
Using ethernet at 1c30000 device
TFTP from server 192.168.67.35; our IP address is 192.168.67.246
Filename 'debian-testing-debug.initrd.img'.
Load address: 0x4fe00000
Loading: *#################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 ##############################
	 11 MiB/s
done
Bytes transferred = 25241598 (18127fe hex)
=> setenv bootargs "console=ttyS0,115200n8 earlycon=uart,mmio32,0x1c28000"
=> booti $kernel_addr_r $ramdisk_addr_r:$filesize $fdtcontroladdr
## Flattened Device Tree blob at b9f31458
   Booting using the fdt blob at 0xb9f31458
   Loading Ramdisk to 487ed000, end 49fff7fe ... OK
   Loading Device Tree to 00000000487e7000, end 00000000487ec99c ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.14.0-rc4-default (andprz01 at e104803-lin) (gcc version 5.3.0 (GCC)) #621 SMP Mon Oct 9 11:43:10 BST 2017
[    0.000000] Boot CPU: AArch64 Processor [410fd034]
[    0.000000] Machine model: Pine64+
[    0.000000] earlycon: uart0 at MMIO32 0x0000000001c28000 (options '')
[    0.000000] bootconsole [uart0] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x00000000bdffffff]
[    0.000000] NUMA: NODE_DATA [mem 0xbdfe2b00-0xbdfe45ff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x00000000bdffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x00000000bdffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x00000000bdffffff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv0.2 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] random: get_random_bytes called from start_kernel+0x9c/0x3e8 with crng_init=0
[    0.000000] percpu: Embedded 25 pages/cpu @ffff80007df7b000 s62360 r8192 d31848 u102400
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 845719
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 508032
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: console=ttyS0,115200n8 earlycon=uart,mmio32,0x1c28000
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 1986136K/2064384K available (8828K kernel code, 1588K rwdata, 3736K rodata, 4992K init, 1035K bss, 78248K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff000008920000   (  8832 KB)
[    0.000000]     .rodata : 0xffff000008920000 - 0xffff000008cd0000   (  3776 KB)
[    0.000000]       .init : 0xffff000008cd0000 - 0xffff0000091b0000   (  4992 KB)
[    0.000000]       .data : 0xffff0000091b0000 - 0xffff00000933d200   (  1589 KB)
[    0.000000]        .bss : 0xffff00000933d200 - 0xffff0000094401c8   (  1036 KB)
[    0.000000]     fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   (  4108 KB)
[    0.000000]     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
[    0.000000]               0xffff7e0000000000 - 0xffff7e0001f80000   (    31 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff80007e000000   (  2016 MB)
[    0.000000] ftrace: allocating 34088 entries in 134 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=4.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] arch_timer: Enabling global workaround for Freescale erratum a005858
[    0.000000] arch_timer: CPU0: Trapping CNTVCT access
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000005] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.008997] Console: colour dummy device 80x25
[    0.013715] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.024556] pid_max: default: 32768 minimum: 301
[    0.029542] Security Framework initialized
[    0.033891] AppArmor: AppArmor initialized
[    0.039696] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.047860] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.055297] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.062344] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.071262] ASID allocator initialised with 65536 entries
[    0.076978] Hierarchical SRCU implementation.
[    0.083390] EFI services will not be available.
[    0.088452] smp: Bringing up secondary CPUs ...
[    0.094602] Detected VIPT I-cache on CPU1
[    0.094666] arch_timer: CPU1: Trapping CNTVCT access
[    0.094675] CPU1: Booted secondary processor [410fd034]
[    0.095707] Detected VIPT I-cache on CPU2
[    0.095742] arch_timer: CPU2: Trapping CNTVCT access
[    0.095749] CPU2: Booted secondary processor [410fd034]
[    0.096698] Detected VIPT I-cache on CPU3
[    0.096727] arch_timer: CPU3: Trapping CNTVCT access
[    0.096734] CPU3: Booted secondary processor [410fd034]
[    0.096818] smp: Brought up 1 node, 4 CPUs
[    0.145580] SMP: Total of 4 processors activated.
[    0.150512] CPU features: detected feature: 32-bit EL0 Support
[    0.156773] CPU: All CPU(s) started at EL2
[    0.161075] alternatives: patching kernel code
[    0.167132] devtmpfs: initialized
[    0.173492] Registered cp15_barrier emulation handler
[    0.178810] Registered setend emulation handler
[    0.183834] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.194181] futex hash table entries: 1024 (order: 5, 131072 bytes)
[    0.201067] pinctrl core: initialized pinctrl subsystem
[    0.207396] DMI not present or invalid.
[    0.211745] NET: Registered protocol family 16
[    0.217635] cpuidle: using governor ladder
[    0.222020] cpuidle: using governor menu
[    0.226552] vdso: 2 pages (1 code @ ffff000008926000, 1 data @ ffff0000091b5000)
[    0.234301] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.241730] DMA: preallocated 256 KiB pool for atomic allocations
[    0.248511] Serial: AMBA PL011 UART driver
[    0.263362] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.271477] ACPI: Interpreter disabled.
[    0.275933] vgaarb: loaded
[    0.279121] SCSI subsystem initialized
[    0.283496] EDAC MC: Ver: 3.0.0
[    0.287011] dmi: Firmware registration failed.
[    0.292355] NetLabel: Initializing
[    0.295900] NetLabel:  domain hash size = 128
[    0.300429] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.306418] NetLabel:  unlabeled traffic allowed by default
[    0.312503] clocksource: Switched to clocksource arch_sys_counter
[    0.384645] VFS: Disk quotas dquot_6.6.0
[    0.388830] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.396637] AppArmor: AppArmor Filesystem Enabled
[    0.401613] pnp: PnP ACPI: disabled
[    0.413226] NET: Registered protocol family 2
[    0.418363] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.426174] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[    0.433510] TCP: Hash tables configured (established 16384 bind 16384)
[    0.440511] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.446863] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.453877] NET: Registered protocol family 1
[    0.458755] Unpacking initramfs...
[    2.050168] Freeing initrd memory: 24648K
[    2.055155] kvm [1]: 8-bit VMID
[    2.058453] kvm [1]: IDMAP page: 40913000
[    2.062654] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    2.069506] kvm [1]: Hyp mode initialized successfully
[    2.074951] kvm [1]: vgic-v2 at 1c84000
[    2.078808] kvm [1]: vgic interrupt IRQ1
[    2.082910] kvm [1]: virtual timer IRQ4
[    2.088371] audit: initializing netlink subsys (disabled)
[    2.094264] audit: type=2000 audit(2.040:1): state=initialized audit_enabled=0 res=1
[    2.094797] workingset: timestamp_bits=44 max_order=19 bucket_order=0
[    2.109150] zbud: loaded
[    2.113037] random: fast init done
[    2.120373] Key type asymmetric registered
[    2.124684] Asymmetric key parser 'x509' registered
[    2.129916] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    2.137775] io scheduler noop registered
[    2.141866] io scheduler deadline registered
[    2.146404] io scheduler cfq registered (default)
[    2.151308] io scheduler kyber registered
[    2.155526] io scheduler bfq registered
[    2.163990] sun50i-a64-r-pinctrl 1f02c00.pinctrl: initialized sunXi PIO driver
[    2.177230] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.185463] dw-apb-uart 1c28000.serial: could not find pctldev for node /soc/pinctrl at 1c20800/uart0 at 0, deferring probe
[    2.196830] Serial: AMBA driver
[    2.200401] msm_serial: driver initialized
[    2.205468] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    2.212431] libphy: Fixed MDIO Bus: probed
[    2.217106] mousedev: PS/2 mouse device common for all mice
[    2.223677] sun6i-rtc 1f00000.rtc: rtc core: registered rtc-sun6i as rtc0
[    2.230794] sun6i-rtc 1f00000.rtc: RTC enabled
[    2.236328] ledtrig-cpu: registered to indicate activity on CPUs
[    2.242812] hidraw: raw HID events driver (C) Jiri Kosina
[    2.249470] NET: Registered protocol family 10
[    2.266089] Segment Routing with IPv6
[    2.270767] registered taskstats version 1
[    2.275167] zswap: loaded using pool lzo/zbud
[    2.289959] Key type big_key registered
[    2.299075] Key type encrypted registered
[    2.303307] AppArmor: AppArmor sha1 policy hashing enabled
[    2.319077] sun50i-a64-pinctrl 1c20800.pinctrl: initialized sunXi PIO driver
[    2.327400] console [ttyS0] disabled
[    2.351275] 1c28000.serial: ttyS0 at MMIO 0x1c28000 (irq = 15, base_baud = 1500000) is a U6_16550A
[    2.360697] console [ttyS0] enabled
[    2.360697] console [ttyS0] enabled
[    2.367835] bootconsole [uart0] disabled
[    2.367835] bootconsole [uart0] disabled
[    2.376266] sun6i-rtc 1f00000.rtc: setting system clock to 1970-01-01 01:25:43 UTC (5143)
[    2.390252] Freeing unused kernel memory: 4992K
Starting system log daemon: syslogd, klogd.
BusyBox v1.22.1 (Debian 1:1.22.0-19+b3) built-in shell (ash)
Enter 'help' for a list of built-in commands.
~ # dmesg
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.14.0-rc4-default (andprz01 at e104803-lin) (gcc version 5.3.0 (GCC)) #621 SMP Mon Oct 9 11:43:10 BST 2017
[    0.000000] Boot CPU: AArch64 Processor [410fd034]
[    0.000000] Machine model: Pine64+
[    0.000000] earlycon: uart0 at MMIO32 0x0000000001c28000 (options '')
[    0.000000] bootconsole [uart0] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x00000000bdffffff]
[    0.000000] NUMA: NODE_DATA [mem 0xbdfe2b00-0xbdfe45ff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x00000000bdffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x00000000bdffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x00000000bdffffff]
[    0.000000] On node 0 totalpages: 516096
[    0.000000]   DMA zone: 8064 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 516096 pages, LIFO batch:31
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv0.2 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] random: get_random_bytes called from start_kernel+0x9c/0x3e8 with crng_init=0
[    0.000000] percpu: Embedded 25 pages/cpu @ffff80007df7b000 s62360 r8192 d318 48 u102400
[    0.000000] pcpu-alloc: s62360 r8192 d31848 u102400 alloc=25*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 845719
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 508032
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: console=ttyS0,115200n8 earlycon=uart,mmio32,0x1c28000
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 1986136K/2064384K available (8828K kernel code, 1588K rwdata, 3736K rodata, 4992K init, 1035K bss, 78248K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff000008920000   (  8832 KB)
[    0.000000]     .rodata : 0xffff000008920000 - 0xffff000008cd0000   (  3776 KB)
[    0.000000]       .init : 0xffff000008cd0000 - 0xffff0000091b0000   (  4992 KB)
[    0.000000]       .data : 0xffff0000091b0000 - 0xffff00000933d200   (  1589 KB)
[    0.000000]        .bss : 0xffff00000933d200 - 0xffff0000094401c8   (  1036 KB)
[    0.000000]     fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   (  4108 KB)
[    0.000000]     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB)
[    0.000000]               0xffff7e0000000000 - 0xffff7e0001f80000   (    31 MB)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff80007e000000   (  2016 MB)
[    0.000000] ftrace: allocating 34088 entries in 134 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=4.
[    0.000000]  Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] arch_timer: Enabling global workaround for Freescale erratum a005858
[    0.000000] arch_timer: CPU0: Trapping CNTVCT access
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000005] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.008997] Console: colour dummy device 80x25
[    0.013715] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.024556] pid_max: default: 32768 minimum: 301
[    0.029542] Security Framework initialized
[    0.033891] AppArmor: AppArmor initialized
[    0.039696] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.047860] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.055297] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.062344] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.071262] ASID allocator initialised with 65536 entries
[    0.076978] Hierarchical SRCU implementation.
[    0.083390] EFI services will not be available.
[    0.088452] smp: Bringing up secondary CPUs ...
[    0.094602] Detected VIPT I-cache on CPU1
[    0.094666] arch_timer: CPU1: Trapping CNTVCT access
[    0.094675] CPU1: Booted secondary processor [410fd034]
[    0.095707] Detected VIPT I-cache on CPU2
[    0.095742] arch_timer: CPU2: Trapping CNTVCT access
[    0.095749] CPU2: Booted secondary processor [410fd034]
[    0.096698] Detected VIPT I-cache on CPU3
[    0.096727] arch_timer: CPU3: Trapping CNTVCT access
[    0.096734] CPU3: Booted secondary processor [410fd034]
[    0.096818] smp: Brought up 1 node, 4 CPUs
[    0.145580] SMP: Total of 4 processors activated.
[    0.150512] CPU features: detected feature: 32-bit EL0 Support
[    0.156773] CPU: All CPU(s) started at EL2
[    0.161075] alternatives: patching kernel code
[    0.167132] devtmpfs: initialized
[    0.173492] Registered cp15_barrier emulation handler
[    0.178810] Registered setend emulation handler
[    0.183834] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.194181] futex hash table entries: 1024 (order: 5, 131072 bytes)
[    0.201067] pinctrl core: initialized pinctrl subsystem
[    0.207396] DMI not present or invalid.
[    0.211745] NET: Registered protocol family 16
[    0.217635] cpuidle: using governor ladder
[    0.222020] cpuidle: using governor menu
[    0.226552] vdso: 2 pages (1 code @ ffff000008926000, 1 data @ ffff0000091b5000)
[    0.234301] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.241730] DMA: preallocated 256 KiB pool for atomic allocations
[    0.248511] Serial: AMBA PL011 UART driver
[    0.263362] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.271477] ACPI: Interpreter disabled.
[    0.275933] vgaarb: loaded
[    0.279121] SCSI subsystem initialized
[    0.283208] libata version 3.00 loaded.
[    0.283496] EDAC MC: Ver: 3.0.0
[    0.286895] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    0.287011] dmi: Firmware registration failed.
[    0.292355] NetLabel: Initializing
[    0.295900] NetLabel:  domain hash size = 128
[    0.300429] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.306418] NetLabel:  unlabeled traffic allowed by default
[    0.312503] clocksource: Switched to clocksource arch_sys_counter
[    0.384645] VFS: Disk quotas dquot_6.6.0
[    0.388830] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.396637] AppArmor: AppArmor Filesystem Enabled
[    0.401613] pnp: PnP ACPI: disabled
[    0.413226] NET: Registered protocol family 2
[    0.418363] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.426174] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[    0.433510] TCP: Hash tables configured (established 16384 bind 16384)
[    0.440511] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.446863] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.453877] NET: Registered protocol family 1
[    0.458452] PCI: CLS 0 bytes, default 128
[    0.458755] Unpacking initramfs...
[    2.050168] Freeing initrd memory: 24648K
[    2.055155] kvm [1]: 8-bit VMID
[    2.058453] kvm [1]: IDMAP page: 40913000
[    2.062654] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    2.069506] kvm [1]: Hyp mode initialized successfully
[    2.074951] kvm [1]: vgic-v2 at 1c84000
[    2.078808] kvm [1]: vgic interrupt IRQ1
[    2.082910] kvm [1]: virtual timer IRQ4
[    2.088371] audit: initializing netlink subsys (disabled)
[    2.094264] audit: type=2000 audit(2.040:1): state=initialized audit_enabled=0 res=1
[    2.094797] workingset: timestamp_bits=44 max_order=19 bucket_order=0
[    2.109150] zbud: loaded
[    2.113037] random: fast init done
[    2.120373] Key type asymmetric registered
[    2.124684] Asymmetric key parser 'x509' registered
[    2.129916] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    2.137775] io scheduler noop registered
[    2.141866] io scheduler deadline registered
[    2.146404] io scheduler cfq registered (default)
[    2.151308] io scheduler kyber registered
[    2.155526] io scheduler bfq registered
[    2.163990] sun50i-a64-r-pinctrl 1f02c00.pinctrl: initialized sunXi PIO driver
[    2.177230] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.185463] dw-apb-uart 1c28000.serial: could not find pctldev for node /soc/pinctrl at 1c20800/uart0 at 0, deferring probe
[    2.196830] Serial: AMBA driver
[    2.200401] msm_serial: driver initialized
[    2.205468] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    2.212431] libphy: Fixed MDIO Bus: probed
[    2.217106] mousedev: PS/2 mouse device common for all mice
[    2.223677] sun6i-rtc 1f00000.rtc: rtc core: registered rtc-sun6i as rtc0
[    2.230794] sun6i-rtc 1f00000.rtc: RTC enabled
[    2.236328] ledtrig-cpu: registered to indicate activity on CPUs
[    2.242812] hidraw: raw HID events driver (C) Jiri Kosina
[    2.249470] NET: Registered protocol family 10
[    2.266089] Segment Routing with IPv6
[    2.270767] registered taskstats version 1
[    2.275167] zswap: loaded using pool lzo/zbud
[    2.289959] Key type big_key registered
[    2.299075] Key type encrypted registered
[    2.303307] AppArmor: AppArmor sha1 policy hashing enabled
[    2.319077] sun50i-a64-pinctrl 1c20800.pinctrl: initialized sunXi PIO driver
[    2.327400] console [ttyS0] disabled
[    2.351275] 1c28000.serial: ttyS0 at MMIO 0x1c28000 (irq = 15, base_baud = 1500000) is a U6_16550A
[    2.360697] console [ttyS0] enabled
[    2.367835] bootconsole [uart0] disabled
[    2.376266] sun6i-rtc 1f00000.rtc: setting system clock to 1970-01-01 01:25:43 UTC (5143)
[    2.390252] Freeing unused kernel memory: 4992K
~ # depmod -a
~ # modprobe phy-sun4i-usb
~ # modprobe sunxi-mmc
~ # modprobe fixed
[   43.622448] Unable to handle kernel paging request at virtual address ffff000008df9c88
[   43.630370] Mem abort info:
[   43.633164]   Exception class = DABT (current EL), IL = 32 bits
[   43.639074]   SET = 0, FnV = 0
[   43.642123]   EA = 0, S1PTW = 0
[   43.645258] Data abort info:
[   43.648134]   ISV = 0, ISS = 0x00000007
[   43.651962]   CM = 0, WnR = 0
[   43.654928] swapper pgtable: 4k pages, 48-bit VAs, pgd = ffff000009444000
[   43.661704] [ffff000008df9c88] *pgd=00000000bdffe003, *pud=00000000bdffd003, *pmd=00000000bdffa003, *pte=0000000000000000
[   43.672655] Internal error: Oops: 96000007 [#1] SMP
[   43.677527] Modules linked in: fixed(O) sunxi_mmc(O) mmc_core(O) phy_sun4i_usb(O)
[   43.685019] CPU: 1 PID: 34 Comm: kworker/1:1 Tainted: G           O    4.14.0-rc4-default #621
[   43.693615] Hardware name: Pine64+ (DT)
[   43.697461] Workqueue: events deferred_probe_work_func
[   43.702594] task: ffff80007b298080 task.stack: ffff000009848000
[   43.708511] PC is at __of_match_node+0x2c/0x90
[   43.712950] LR is at of_match_node+0x40/0x68
[   43.717214] pc : [<ffff00000877e59c>] lr : [<ffff00000877e640>] pstate: 600001c5
[   43.724596] sp : ffff00000984bba0
[   43.727905] x29: ffff00000984bba0 x28: ffff80007b298080 
[   43.733213] x27: ffff80007b1bbf00 x26: ffff80007b298080 
[   43.738520] x25: 0000000000000000 x24: ffff0000092c7000 
[   43.743826] x23: ffff000009323198 x22: 0000000000000000 
[   43.749133] x21: ffff80007dfe7758 x20: 0000000000000000 
[   43.754440] x19: ffff000008df9c88 x18: ffffffffffffffff 
[   43.759746] x17: 00000000004282b8 x16: ffff00000816d308 
[   43.765053] x15: ffff800009bba173 x14: 0000000000000040 
[   43.770360] x13: 0000000000000000 x12: 0000000000000020 
[   43.775666] x11: 0000000000000001 x10: 0101010101010101 
[   43.780973] x9 : 06fefeff01fefeff x8 : 7f7f7f7f7f7f7f7f 
[   43.786279] x7 : 2d2f2f2f652f6230 x6 : 4306574b54455d43 
[   43.791586] x5 : 435d45544b570643 x4 : 0000000000000000 
[   43.796891] x3 : 0000000000000000 x2 : 0000000000000000 
[   43.802197] x1 : ffff80007dfe7758 x0 : ffff00000877e640 
[   43.807505] Process kworker/1:1 (pid: 34, stack limit = 0xffff000009848000)
[   43.814454] Call trace:
[   43.816900] Exception stack(0xffff00000984ba60 to 0xffff00000984bba0)
[   43.823332] ba60: ffff00000877e640 ffff80007dfe7758 0000000000000000 0000000000000000
[   43.831151] ba80: 0000000000000000 435d45544b570643 4306574b54455d43 2d2f2f2f652f6230
[   43.838970] baa0: 7f7f7f7f7f7f7f7f 06fefeff01fefeff 0101010101010101 0000000000000001
[   43.846788] bac0: 0000000000000020 0000000000000000 0000000000000040 ffff800009bba173
[   43.854607] bae0: ffff00000816d308 00000000004282b8 ffffffffffffffff ffff000008df9c88
[   43.862425] bb00: 0000000000000000 ffff80007dfe7758 0000000000000000 ffff000009323198
[   43.870244] bb20: ffff0000092c7000 0000000000000000 ffff80007b298080 ffff80007b1bbf00
[   43.878064] bb40: ffff80007b298080 ffff00000984bba0 ffff00000877e640 ffff00000984bba0
[   43.885883] bb60: ffff00000877e59c 00000000600001c5 ffff80007dfe7758 0000000000000000
[   43.893702] bb80: ffffffffffffffff ffff0000092c7000 ffff00000984bba0 ffff00000877e59c
[   43.901522] [<ffff00000877e59c>] __of_match_node+0x2c/0x90
[   43.907001] [<ffff00000877e640>] of_match_node+0x40/0x68
[   43.912308] [<ffff000008780768>] of_match_device+0x30/0x48
[   43.917787] [<ffff0000086782b4>] platform_match+0x54/0xd8
[   43.923181] [<ffff0000086755bc>] __device_attach_driver+0x44/0x160
[   43.929355] [<ffff000008672dc0>] bus_for_each_drv+0x68/0xa8
[   43.934921] [<ffff000008674ddc>] __device_attach+0xcc/0x160
[   43.940487] [<ffff000008675754>] device_initial_probe+0x24/0x30
[   43.946400] [<ffff000008673fe0>] bus_probe_device+0xa0/0xa8
[   43.951967] [<ffff000008674600>] deferred_probe_work_func+0x60/0x180
[   43.958315] [<ffff0000080e9180>] process_one_work+0x150/0x430
[   43.964055] [<ffff0000080e94b8>] worker_thread+0x58/0x448
[   43.969449] [<ffff0000080f0210>] kthread+0x108/0x138
[   43.974410] [<ffff000008084ea0>] ret_from_fork+0x10/0x18
[   43.979717] Code: d503201f b4000333 52800014 d2800016 (39400264) 
[   43.985804] ---[ end trace 7532183b3e8658be ]---
~ # 
