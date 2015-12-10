From: horms@verge.net.au (Simon Horman)
Date: Thu, 10 Dec 2015 16:04:35 +0900
Subject: [PATCH 05/13] ARM: shmobile: genmai dts: Update console parameters
In-Reply-To: <1449597258-32623-6-git-send-email-geert+renesas@glider.be>
References: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
 <1449597258-32623-6-git-send-email-geert+renesas@glider.be>
Message-ID: <20151210070434.GB17682@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 06:54:10PM +0100, Geert Uytterhoeven wrote:
> Change the console alias to "serial0", for consistency with other
> boards (the first unlabeled serial port is always called "serial0").
> Add serial port config to chosen/stdout-path.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/boot/dts/r7s72100-genmai.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r7s72100-genmai.dts b/arch/arm/boot/dts/r7s72100-genmai.dts
> index a9da7a89fc4ba65a..47533c2c419e164d 100644
> --- a/arch/arm/boot/dts/r7s72100-genmai.dts
> +++ b/arch/arm/boot/dts/r7s72100-genmai.dts
> @@ -17,12 +17,12 @@
>  	compatible = "renesas,genmai", "renesas,r7s72100";
>  
>  	aliases {
> -		serial2 = &scif2;
> +		serial0 = &scif2;
>  	};
>  
>  	chosen {
>  		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
> -		stdout-path = &scif2;
> +		stdout-path = "serial0:115200n8";
>  	};
>  
>  	memory {

As noted elsewhere the serial2 -> serial0 portion of
this patch seems to result in no console.

I am wary about that change as it is user-space visible
but I didn't expect it to also have an impact on the kernel console.

In case it helps anyone now or in the future the output with earlyprintk
follows.

-- after with early printk --
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.4.0-rc4-00017-gb298a5a501ed-dirty (horms at ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #1213 SMP Thu Dec 10 15:05:11 JST 2015
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=18c5307d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: Genmai
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 32768
[    0.000000] free_area_init_node: node 0, pgdat c0829180, node_mem_map c7ef8000
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32768 pages, LIFO batch:7
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] PERCPU: Embedded 10 pages/cpu @c7ee0000 s17984 r0 d22976 u40960
[    0.000000] pcpu-alloc: s17984 r0 d22976 u40960 alloc=10*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: console=ttySC2,115200 root=/dev/nfs rw ip=dhcp ignore_loglevel earlyprintk=sh-sci.2,115200
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 121208K/131072K available (4976K kernel code, 242K rwdata, 1360K rodata, 1744K init, 268K bss, 9864K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff800000   ( 880 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]       .text : 0xc0008000 - 0xc063904c   (6341 kB)
[    0.000000]       .init : 0xc063a000 - 0xc07ee000   (1744 kB)
[    0.000000]       .data : 0xc07ee000 - 0xc082aa20   ( 243 kB)
[    0.000000]        .bss : 0xc082d000 - 0xc0870354   ( 269 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] clocksource_probe: no matching clocksources found
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836475000000ns
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Calibrating delay loop (skipped) preset value.. 266.66 BogoMIPS (lpj=1333333)
[    0.000000] pid_max: default: 32768 minimum: 301
[    0.000000] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] CPU: Testing write buffer coherency: ok
[    0.000000] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.000000] Setting up static identity map for 0x8009000 - 0x8009058
[    0.000000] Brought up 1 CPUs
[    0.000000] SMP: Total of 1 processors activated (266.66 BogoMIPS).
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] devtmpfs: initialized
[    0.000000] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.000000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.000000] pinctrl core: initialized pinctrl subsystem
[    0.000000] NET: Registered protocol family 16
[    0.000000] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.000000] No ATAGs?
[    0.000000] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.000000] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.000000] vgaarb: loaded
[    0.000000] SCSI subsystem initialized
[    0.000000] libata version 3.00 loaded.
[    0.000000] usbcore: registered new interface driver usbfs
[    0.000000] usbcore: registered new interface driver hub
[    0.000000] usbcore: registered new device driver usb
[    0.000000] media: Linux media interface: v0.10
[    0.000000] Linux video capture interface: v2.00
[    0.000000] sh_mtu2 fcff0000.timer: ch0: used for clock events
[    0.000000] sh_mtu2 fcff0000.timer: ch0: used for periodic clock events
[    0.000000] Advanced Linux Sound Architecture Driver Initialized.
[    0.410000] NET: Registered protocol family 2
[    0.420000] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.430000] TCP bind hash table entries: 1024 (order: 1, 8192 bytes)
[    0.440000] TCP: Hash tables configured (established 1024 bind 1024)
[    0.440000] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.450000] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.460000] NET: Registered protocol family 1
[    0.470000] RPC: Registered named UNIX socket transport module.
[    0.480000] RPC: Registered udp transport module.
[    0.480000] RPC: Registered tcp transport module.
[    0.490000] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.500000] PCI: CLS 0 bytes, default 64
[    1.310000] futex hash table entries: 256 (order: 2, 16384 bytes)
[    1.350000] NFS: Registering the id_resolver key type
[    1.360000] Key type id_resolver registered
[    1.360000] Key type id_legacy registered
[    1.370000] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.370000] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    1.410000] jitterentropy: Initialization failed with host not compliant with requirements: 2
[    1.420000] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    1.430000] io scheduler noop registered
[    1.430000] io scheduler deadline registered
[    1.440000] io scheduler cfq registered (default)
[    1.480000] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.520000] SuperH (H)SCI(F) driver initialized
[    1.520000] e8008000.serial: ttySC0 at MMIO 0xe8008000 (irq = 17, base_baud = 0) is a scif
[    1.550000] [drm] Initialized drm 1.1.0 20060810
[    1.570000] renesas_spi e800e800.spi: dma_request_slave_channel_compat failed
[    1.580000] renesas_spi e800e800.spi: DMA not available, using PIO
[    1.610000] renesas_spi e800e800.spi: probed
[    1.620000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.630000] ehci-pci: EHCI PCI platform driver
[    1.640000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.640000] ohci-pci: OHCI PCI platform driver
[    1.700000] mousedev: PS/2 mouse device common for all mice
[    1.710000] i2c /dev entries driver
[    1.740000] at24 2-0050: 16384 byte 24c128 EEPROM, writable, 64 bytes/write
[    1.740000] i2c-riic fcfee800.i2c: registered with 400000Hz bus speed
[    1.760000] usbcore: registered new interface driver usbhid
[    1.770000] usbhid: USB HID core driver
[    1.820000] NET: Registered protocol family 10
[    1.850000] sit: IPv6 over IPv4 tunneling driver
[    1.860000] NET: Registered protocol family 17
[    1.870000] Key type dns_resolver registered
[    1.880000] cpu cpu0: failed to get cpu0 clock: -2
[    1.880000] cpufreq-dt: probe of cpufreq-dt failed with error -2
[    1.890000] Registering SWP/SWPB emulation handler
[    1.920000] bootconsole [earlycon0] disabled
--
