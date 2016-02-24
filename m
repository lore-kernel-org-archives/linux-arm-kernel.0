From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 24 Feb 2016 12:24:16 +0000
Subject: [PATCH] ARM: realview: DT support for the PBA8
In-Reply-To: <1456303714-31039-1-git-send-email-linus.walleij@linaro.org>
References: <1456303714-31039-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <56CDA0F0.9050608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 24/02/16 08:48, Linus Walleij wrote:
> This adds a devicetree for the ARM RealView PBA8 platform,
> also known as HBI-0178, "RealView(R) Platform Baseboard for
> Cortex(TM)-A8".
>
> Tested in QEMU with -M realview-pb-a8 and works like a charm,
> however with these annoying boot messages:
>
> of_amba_device_create(): amba_device_add()
>      failed (-19) for /soc/sysctl at 10001000
> of_amba_device_create(): amba_device_add()
>      failed (-19) for /soc/ssp at 1000d000
> of_amba_device_create(): amba_device_add()
>      failed (-19) for /soc/timer at 10018000
> of_amba_device_create(): amba_device_add()
>      failed (-19) for /soc/timer at 10019000
> of_amba_device_create(): amba_device_add()
>      failed (-19) for /soc/sysctl at 1001a000
>
> I think this is because these PrimeCells do not exist in the
> QEMU machine model but would work fine on the real hardware.
> QEMU still works, because the SP810 clocks will anyway probe,
> as they are not amba_devices but use the special CLK_OF_DECLARE()
> probing macro.

And here I thought that big black box on the far corner of my desk was 
only good for taking up space. I have no idea of its provenance, but 
here's what it had to say (using appended dtb and a hack in the 
decompressor to set r1=-1, r2=0 because I can't be bothered faffing with 
a 2010-vintage u-boot):

RealView PBA8 #go 0x7fc0
## Starting application at 0x00007FC0 ...
Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 4.5.0-rc4-00004-ga81bbd8-dirty (robmur01 at e104324-lin) (gcc 
version 5.2.1 20151005 (Linaro GCC 5.2-2015.11-2) ) #16 SMP Wed Feb 24 
11:39:06 GMT 2016
CPU: ARMv7 Processor [411fc081] revision 1 (ARMv7), cr=10c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: ARM RealView PB-A8
bootconsole [earlycon0] enabled
Memory policy: Data cache writeback
CPU: All CPU(s) started in SVC mode.
PERCPU: Embedded 11 pages/cpu @c7ee4000 s13376 r8192 d23488 u45056
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: root=/dev/mmcblk0p1 rw rootwait console=ttyAMA0 
earlyprintk
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 124392K/131072K available (3863K kernel code, 128K rwdata, 1076K 
rodata, 212K init, 138K bss, 6680K reserved, 0K cma-reserved)
Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     DTCM    : 0xfffe8000 - 0xfffe8000   (   0 kB)
     ITCM    : 0xfffe0000 - 0xfffe0000   (   0 kB)
     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
     vmalloc : 0xc8800000 - 0xff800000   ( 880 MB)
     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
     modules : 0xbf000000 - 0xc0000000   (  16 MB)
       .text : 0xc0008000 - 0xc04dafec   (4940 kB)
       .init : 0xc04db000 - 0xc0510000   ( 212 kB)
       .data : 0xc0510000 - 0xc05303a0   ( 129 kB)
        .bss : 0xc0531000 - 0xc05538e0   ( 139 kB)
Hierarchical RCU implementation.
	Build-time adjustment of leaf fanout to 32.
	RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.
RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
NR_IRQS:16 nr_irqs:16 16
L2C: failed to init: -19
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at drivers/clk/versatile/clk-sp810.c:137 
clk_sp810_of_setup+0x124/0x168()
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.5.0-rc4-00004-ga81bbd8-dirty #16
Hardware name: ARM RealView Machine (Device Tree Support)
Backtrace:
[<c0013a98>] (dump_backtrace) from [<c0013c8c>] (show_stack+0x18/0x1c)
  r6:600000d3 r5:00000000 r4:c051f800
[<c0013c74>] (show_stack) from [<c01b26b0>] (dump_stack+0x94/0xb0)
[<c01b261c>] (dump_stack) from [<c0025884>] (warn_slowpath_common+0x7c/0xb8)
  r6:00000009 r5:00000089 r4:00000000
[<c0025808>] (warn_slowpath_common) from [<c0025964>] 
(warn_slowpath_null+0x24/0x28)
  r8:c7ef7570 r7:00000001 r6:c7ef7394 r5:c7807980 r4:c780798c
[<c0025940>] (warn_slowpath_null) from [<c04f4f34>] 
(clk_sp810_of_setup+0x124/0x168)
[<c04f4e10>] (clk_sp810_of_setup) from [<c04f4714>] 
(of_clk_init+0x13c/0x1e0)
  r10:00000003 r9:00000001 r8:00000000 r7:00000001 r6:c0511f6c r5:c78054c0
  r4:c0511f74
[<c04f45d8>] (of_clk_init) from [<c04ddac0>] (time_init+0x2c/0x38)
  r10:c05008c0 r9:c7ffc840 r8:c0531000 r7:c05127c0 r6:c0531000 r5:ffffffff
  r4:00000000
[<c04dda94>] (time_init) from [<c04dbbc4>] (start_kernel+0x248/0x364)
[<c04db97c>] (start_kernel) from [<0000807c>] (0x807c)
  r10:00000000 r9:411fc081 r8:00004059 r7:c0516910 r6:c05008bc r5:c051286c
  r4:c0531294
---[ end trace cb88537fdc8fa200 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at drivers/clk/versatile/clk-sp810.c:137 
clk_sp810_of_setup+0x124/0x168()
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W 
4.5.0-rc4-00004-ga81bbd8-dirty #16
Hardware name: ARM RealView Machine (Device Tree Support)
Backtrace:
[<c0013a98>] (dump_backtrace) from [<c0013c8c>] (show_stack+0x18/0x1c)
  r6:600000d3 r5:00000000 r4:c051f800
[<c0013c74>] (show_stack) from [<c01b26b0>] (dump_stack+0x94/0xb0)
[<c01b261c>] (dump_stack) from [<c0025884>] (warn_slowpath_common+0x7c/0xb8)
  r6:00000009 r5:00000089 r4:00000000
[<c0025808>] (warn_slowpath_common) from [<c0025964>] 
(warn_slowpath_null+0x24/0x28)
  r8:c7ef7570 r7:00000002 r6:c7ef7394 r5:c7807980 r4:c78079a4
[<c0025940>] (warn_slowpath_null) from [<c04f4f34>] 
(clk_sp810_of_setup+0x124/0x168)
[<c04f4e10>] (clk_sp810_of_setup) from [<c04f4714>] 
(of_clk_init+0x13c/0x1e0)
  r10:00000003 r9:00000001 r8:00000000 r7:00000001 r6:c0511f6c r5:c78054c0
  r4:c0511f74
[<c04f45d8>] (of_clk_init) from [<c04ddac0>] (time_init+0x2c/0x38)
  r10:c05008c0 r9:c7ffc840 r8:c0531000 r7:c05127c0 r6:c0531000 r5:ffffffff
  r4:00000000
[<c04dda94>] (time_init) from [<c04dbbc4>] (start_kernel+0x248/0x364)
[<c04db97c>] (start_kernel) from [<0000807c>] (0x807c)
  r10:00000000 r9:411fc081 r8:00004059 r7:c0516910 r6:c05008bc r5:c051286c
  r4:c0531294
---[ end trace cb88537fdc8fa201 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at drivers/clk/versatile/clk-sp810.c:137 
clk_sp810_of_setup+0x124/0x168()
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W 
4.5.0-rc4-00004-ga81bbd8-dirty #16
Hardware name: ARM RealView Machine (Device Tree Support)
Backtrace:
[<c0013a98>] (dump_backtrace) from [<c0013c8c>] (show_stack+0x18/0x1c)
  r6:600000d3 r5:00000000 r4:c051f800
[<c0013c74>] (show_stack) from [<c01b26b0>] (dump_stack+0x94/0xb0)
[<c01b261c>] (dump_stack) from [<c0025884>] (warn_slowpath_common+0x7c/0xb8)
  r6:00000009 r5:00000089 r4:00000000
[<c0025808>] (warn_slowpath_common) from [<c0025964>] 
(warn_slowpath_null+0x24/0x28)
  r8:c7ef7570 r7:00000003 r6:c7ef7394 r5:c7807980 r4:c78079bc
[<c0025940>] (warn_slowpath_null) from [<c04f4f34>] 
(clk_sp810_of_setup+0x124/0x168)
[<c04f4e10>] (clk_sp810_of_setup) from [<c04f4714>] 
(of_clk_init+0x13c/0x1e0)
  r10:00000003 r9:00000001 r8:00000000 r7:00000001 r6:c0511f6c r5:c78054c0
  r4:c0511f74
[<c04f45d8>] (of_clk_init) from [<c04ddac0>] (time_init+0x2c/0x38)
  r10:c05008c0 r9:c7ffc840 r8:c0531000 r7:c05127c0 r6:c0531000 r5:ffffffff
  r4:00000000
[<c04dda94>] (time_init) from [<c04dbbc4>] (start_kernel+0x248/0x364)
[<c04db97c>] (start_kernel) from [<0000807c>] (0x807c)
  r10:00000000 r9:411fc081 r8:00004059 r7:c0516910 r6:c05008bc r5:c051286c
  r4:c0531294
---[ end trace cb88537fdc8fa202 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at drivers/clk/versatile/clk-sp810.c:137 
clk_sp810_of_setup+0x124/0x168()
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W 
4.5.0-rc4-00004-ga81bbd8-dirty #16
Hardware name: ARM RealView Machine (Device Tree Support)
Backtrace:
[<c0013a98>] (dump_backtrace) from [<c0013c8c>] (show_stack+0x18/0x1c)
  r6:600000d3 r5:00000000 r4:c051f800
[<c0013c74>] (show_stack) from [<c01b26b0>] (dump_stack+0x94/0xb0)
[<c01b261c>] (dump_stack) from [<c0025884>] (warn_slowpath_common+0x7c/0xb8)
  r6:00000009 r5:00000089 r4:00000000
[<c0025808>] (warn_slowpath_common) from [<c0025964>] 
(warn_slowpath_null+0x24/0x28)
  r8:c7ef7570 r7:00000004 r6:c7ef7394 r5:c7807980 r4:c78079d4
[<c0025940>] (warn_slowpath_null) from [<c04f4f34>] 
(clk_sp810_of_setup+0x124/0x168)
[<c04f4e10>] (clk_sp810_of_setup) from [<c04f4714>] 
(of_clk_init+0x13c/0x1e0)
  r10:00000003 r9:00000001 r8:00000000 r7:00000001 r6:c0511f6c r5:c78054c0
  r4:c0511f74
[<c04f45d8>] (of_clk_init) from [<c04ddac0>] (time_init+0x2c/0x38)
  r10:c05008c0 r9:c7ffc840 r8:c0531000 r7:c05127c0 r6:c0531000 r5:ffffffff
  r4:00000000
[<c04dda94>] (time_init) from [<c04dbbc4>] (start_kernel+0x248/0x364)
[<c04db97c>] (start_kernel) from [<0000807c>] (0x807c)
  r10:00000000 r9:411fc081 r8:00004059 r7:c0516910 r6:c05008bc r5:c051286c
  r4:c0531294
---[ end trace cb88537fdc8fa203 ]---
clk: couldn't get parent clock 0 for /soc/sysctl at 1001a000
clk: couldn't get parent clock 0 for /soc/sysctl at 1001a000
clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, 
max_idle_ns: 1911260446275 ns
sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 
2147483647500ns
Console: colour dummy device 80x30
Calibrating delay loop... 743.83 BogoMIPS (lpj=3719168)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket -1, mpidr 0
Setting up static identity map for 0x82a0 - 0x8310
Brought up 1 CPUs
SMP: Total of 1 processors activated (743.83 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, 
max_idle_ns: 19112604462750000 ns
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
hw-breakpoint: debug architecture 0x4 unsupported.
Serial: AMBA PL011 UART driver
10009000.serial: ttyAMA0 at MMIO 0x10009000 (irq = 20, base_baud = 0) is 
a PL011 rev2
console [ttyAMA0] enabled
console [ttyAMA0] enabled
bootconsole [earlycon0] disabled
bootconsole [earlycon0] disabled
1000a000.serial: ttyAMA1 at MMIO 0x1000a000 (irq = 21, base_baud = 0) is 
a PL011 rev2
1000b000.serial: ttyAMA2 at MMIO 0x1000b000 (irq = 22, base_baud = 0) is 
a PL011 rev2
1000c000.serial: ttyAMA3 at MMIO 0x1000c000 (irq = 36, base_baud = 0) is 
a PL011 rev2
ssp-pl022 1000d000.ssp: ARM PL022 driver, device ID: 0x00041022
ssp-pl022 1000d000.ssp: mapped registers from 0x1000d000 to c8884000
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c i2c-0: Failed to register i2c client ds1338 at 0x68 (-16)
i2c i2c-0: Can't create device at 0x68
Advanced Linux Sound Architecture Driver Initialized.
clocksource: Switched to clocksource arm,sp804
NET: Registered protocol family 2
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 1024 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
UDP hash table entries: 256 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
hw perfevents: enabled with armv7_cortex_a8 PMU driver, 5 counters available
futex hash table entries: 256 (order: 2, 16384 bytes)
io scheduler noop registered
io scheduler deadline registered (default)
pl061_gpio 10013000.gpio: PL061 GPIO chip @0x10013000 registered
pl061_gpio 10014000.gpio: PL061 GPIO chip @0x10014000 registered
pl061_gpio 10015000.gpio: PL061 GPIO chip @0x10015000 registered
clcd-pl11x 10020000.clcd: PL111 rev0 at 0x10020000
clcd-pl11x 10020000.clcd: /issp/clcd at 10020000 hardware, 640x480 at 59 display
Console: switching to colour frame buffer device 80x30
realview-soc soc: RealView Syscon Core ID: 0x2178f505, HBI-178
libphy: smsc911x-mdio: probed
SMSC LAN911x Internal PHY 4e000000.etherne:01: attached PHY driver [SMSC 
LAN911x Internal PHY] (mii_bus:phy_addr=4e000000.etherne:01, irq=-1)
smsc911x 4e000000.ethernet eth0: MAC Address: 00:02:f7:00:0a:c2
isp1760 4f000000.usb: bus width: 32, oc: digital
isp1760 4f000000.usb: NXP ISP1760 USB Host Controller
isp1760 4f000000.usb: new USB bus registered, assigned bus number 1
isp1760 4f000000.usb: irq 19, io mem 0x4f000000
isp1760 4f000000.usb: USB ISP 1761 HW rev. 1 started
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ISP1760 USB device initialised
mousedev: PS/2 mouse device common for all mice
rtc-ds1307 0-0068: rtc core: registered ds1338 as rtc0
rtc-ds1307 0-0068: 56 bytes nvram
rtc-pl031 10017000.rtc: rtc core: registered pl031 as rtc1
versatile reboot driver registered
mmci-pl18x 10005000.mmcsd: Got CD GPIO
mmci-pl18x 10005000.mmcsd: Got WP GPIO
mmci-pl18x 10005000.mmcsd: mmc0: PL180 manf 41 rev0 at 0x10005000 irq 
32,33 (pio)
ledtrig-cpu: registered to indicate activity on CPUs
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
aaci-pl041 10004000.aaci: ARM AC'97 Interface PL041 rev0 at 0x10004000, 
irq 31
aaci-pl041 10004000.aaci: FIFO 512 entries
NET: Registered protocol family 17
Registering SWP/SWPB emulation handler
isp1760 4f000000.usb: port 1 high speed
rtc-ds1307 0-0068: setting system clock to 2000-01-01 00:17:12 UTC 
(946685832)
ALSA device list:
   #0: ARM AC'97 Interface PL041 rev0 at 0x10004000, irq 31
usb 1-1: new high-speed USB device number 2 using isp1760
isp1760 4f000000.usb: port 1 high speed
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 3 ports detected
atkbd serio0: keyboard reset failed on 10006000.kmi
atkbd serio1: keyboard reset failed on 10007000.kmi
atkbd serio0: keyboard reset failed on 10006000.kmi
atkbd serio1: keyboard reset failed on 10007000.kmi
Waiting for root device /dev/mmcblk0p1...


It then fails to notice my SD card, even if I eject and reinsert it :(

Robin.
