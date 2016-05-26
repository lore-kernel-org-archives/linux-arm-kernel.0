From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Thu, 26 May 2016 09:13:35 +0530
Subject: ARM: dts: exynos: Add MFC memory banks for Peach boards
In-Reply-To: <d045b880-4a44-acd8-f7f6-e521caf374aa@osg.samsung.com>
References: <1461871311-18344-1-git-send-email-javier@osg.samsung.com>
 <57456344.7020708@samsung.com>
 <d045b880-4a44-acd8-f7f6-e521caf374aa@osg.samsung.com>
Message-ID: <574670E7.3060508@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Wednesday 25 May 2016 08:32 PM, Javier Martinez Canillas wrote:
> Hello Pankaj,
> 
> On 05/25/2016 04:33 AM, pankaj.dubey wrote:
>> Hi Javier,
>>
>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> Just noticed that, current krzk/for-next failed to boot on Exynos5880
>> based Chromebook device. Git bisect is showing culprit as this patch.
> 
> Strange, krzk/for-next boots correctly on my Exynos5800 Peach Pi:
> 
> $ git log --pretty=oneline --abbrev-commit HEAD
> 35e691cf5165 Merge branch 'fixes-v4.7' into for-next
> 

This is same as mine.

My other build parameters are:
defconfig: exynos_defconfig
CROSS_COMPILE: gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux
rootfs: small cramfs

> $ uname -r
> 4.6.0-00073-g35e691cf5165
> 
>> When I reverted this patch, its able to boot normally.
>> Is there any missing patches that we need to take on krzk/for-next to
>> boot on Chromebook.
>>
> 

Further I checked that, either I revert this patch OR do not reserve
memory for MFC in exynos_reserve using following changes, both cases I
am able to boot kernel on Chromebook (Exynos5800).

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index f977eea..e615e24 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -268,7 +268,7 @@ static char const *const exynos_dt_compat[]
__initconst = {

 static void __init exynos_reserve(void)
 {
-#ifdef CONFIG_S5P_DEV_MFC
+#ifndef CONFIG_S5P_DEV_MFC
        int i;
        char *mfc_mem[] = {
                "samsung,mfc-v5",
@@ -280,6 +280,8 @@ static void __init exynos_reserve(void)
        for (i = 0; i < ARRAY_SIZE(mfc_mem); i++)
                if (of_scan_flat_dt(s5p_fdt_alloc_mfc_mem, mfc_mem[i]))
                        break;
+#else
+       pr_err("*****exynos_reserve Bypassing Memory Reservation for MFC
********\n");
 #endif
 }


> No that I'm aware of. I wonder why it boots for me but fails for
> you. Can you please share your complete boot log to see if there
> are any hints there?
>  

Following is failed boot log:
U-Boot 2013.04-g8e3e5ef (May 26 2015 - 16:11:36) for Peach

CPU:    Exynos5422 at 900MHz

Board: Google Peach Pi, rev 11.6
I2C:   ready
DRAM:  3.5 GiB
Relocation Offset dbd54000, base at ffb54000
SPL stack at 2072c00, used 3f0, free 10
PMIC max77802-pmic initialized
CPU:    Exynos5422 at 1800MHz
TPS65090 PMIC EC init
MMC:   EXYNOS DWMMC: 0, EXYNOS DWMMC: 1
SF: Detected W25Q32DW with page size 4 KiB, total 32 MiB
In:    cros-ec-keyb
Out:   lcd
Err:   lcd
SF: Detected W25Q32DW with page size 4 KiB, total 32 MiB
ELOG: Event(17) added with size 13
Net:   No ethernet found.
Hit any key to stop autoboot:  0
mmc1 is current device
4586144 bytes read in 242 ms (18.1 MiB/s)
26583040 bytes read in 1166 ms (21.7 MiB/s)
## Loading kernel from FIT Image at 20008000 ...
   Using 'conf at 2' configuration
   Trying 'kernel at 1' kernel subimage
     Description:  unavailable
     Type:         Kernel Image (no loading done)
     Compression:  uncompressed
     Data Start:   0x200080c8
     Data Size:    4459024 Bytes = 4.3 MiB
   Verifying Hash Integrity ... OK
## Loading fdt from FIT Image at 20008000 ...
   Using 'conf at 2' configuration
   Trying 'fdt at 2' fdt subimage
     Description:  exynos5800-peach-pi.dtb
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x20458148
     Data Size:    63002 Bytes = 61.5 KiB
     Architecture: ARM
     Hash algo:    sha1
     Hash value:   cd1c1703f744b44b1833ca61ec36b625665548de
   Verifying Hash Integrity ... sha1+ OK
   Booting using the fdt blob at 0x20458148
   XIP Kernel Image (no loading done) ... OK
   Loading Device Tree to 3ffe1000, end 3ffffb49 ... OK
boot_kernel.c: ft_board_setup: warning: Must pass exactly one of vboot
or cdata

Starting kernel ...

Timer summary in microseconds:
       Mark    Elapsed  Stage
          0          0  reset
    122,793    122,793  board_init_f
    143,214     20,421  board_init_r
    238,069     94,855  id=64
    240,278      2,209  main_loop
  4,841,682  4,601,404  bootm_start
  4,841,683          1  id=1
  4,846,604      4,921  id=100
  4,846,607          3  id=101
  4,846,607          0  id=102
  4,850,208      3,601  id=110
  4,877,729     27,521  id=105
  4,877,731          2  id=106
  4,877,734          3  id=107
  4,877,735          1  id=108
  4,877,736          1  id=109
  4,882,406      4,670  id=90
  4,882,408          2  id=92
  4,882,408          0  id=91
  4,927,272     44,864  id=95
  4,927,274          2  id=96
  4,927,276          2  id=97
  4,927,277          1  id=98
  4,927,279          2  id=99
  4,937,617     10,338  id=7
  4,951,899     14,282  id=15
  4,955,112      3,213  start_kernel

Accumulated time:
                 6,948  SPI read
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.6.0-00073-g35e691c
(pankaj at chromebld-server) (gcc version 4.9.2 20140904 (prerelease)
(crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro GCC
4.9-2014.09) ) #59 SMP PREEMPT Thu May 26 08:21:07 IST 2016
[    0.000000] CPU: ARMv7 Processor [412fc0f3] revision 3 (ARMv7),
cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction
cache
[    0.000000] Machine model: Google Peach Pi Rev 10+
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] cma: Reserved 64 MiB at 0xfbc00000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Samsung CPU ID: 0xe5422001
[    0.000000] On node 0 totalpages: 913407
[    0.000000] free_area_init_node: node 0, pgdat c0b42cc0, node_mem_map
ee3f7000
[    0.000000]   Normal zone: 1536 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 194560 pages, LIFO batch:31
[    0.000000]   HighMem zone: 718847 pages, LIFO batch:31
[    0.000000] percpu: Embedded 12 pages/cpu @ee341000 s19392 r8192
d21568 u49152
[    0.000000] pcpu-alloc: s19392 r8192 d21568 u49152 alloc=12*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 911871
[    0.000000] Kernel command line: cros_legacy console=ttySAC3,115200
debug earlyprintk cros_debug no_console_suspend root=/dev/ram0 rw
ramdisk=32768 initrd=0x42000000,3
2M
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288
bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes)
[    0.000000] Memory: 3522460K/3653628K available (6317K kernel code,
271K rwdata, 2204K rodata, 1024K init, 313K bss, 65632K reserved, 65536K
cma-reserved, 2809852K hig
hmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc09524b8   (9514 kB)
[    0.000000]       .init : 0xc0a00000 - 0xc0b00000   (1024 kB)
[    0.000000]       .data : 0xc0b00000 - 0xc0b43ca0   ( 272 kB)
[    0.000000]        .bss : 0xc0b45000 - 0xc0b937e8   ( 314 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] GIC physical location is 0x10481000
[    0.000000] Switching to timer-based delay loop, resolution 41ns
[    0.000000] clocksource: mct-frc: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 79635851949 ns
[    0.000003] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps
every 89478484971ns
[    0.008334] Console: colour dummy device 80x30
[    0.012699] Calibrating delay loop (skipped), value calculated using
timer frequency.. 48.00 BogoMIPS (lpj=120000)
[    0.023090] pid_max: default: 32768 minimum: 301
[    0.027864] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.034465] Mountpoint-cache hash table entries: 2048 (order: 1, 8192
bytes)
[    0.041947] CPU: Testing write buffer coherency: ok
[    0.047033] CPU0: update cpu_capacity 1535
[    0.051046] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.056840] Setting up static identity map for 0x20100000 - 0x20100058
[    0.063593] ARM CCI driver probed
[    0.067193] Exynos MCPM support installed
[    0.124848] CPU1: update cpu_capacity 1535
[    0.124852] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.144835] CPU2: update cpu_capacity 1535
[    0.144839] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.164835] CPU3: update cpu_capacity 1535
[    0.164838] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.184910] CPU4: update cpu_capacity 448
[    0.184923] CPU4: thread -1, cpu 0, socket 1, mpidr 80000100
[    0.204875] CPU5: update cpu_capacity 448
[    0.204885] CPU5: thread -1, cpu 1, socket 1, mpidr 80000101
[    0.224875] CPU6: update cpu_capacity 448
[    0.224885] CPU6: thread -1, cpu 2, socket 1, mpidr 80000102
[    0.244876] CPU7: update cpu_capacity 448
[    0.244886] CPU7: thread -1, cpu 3, socket 1, mpidr 80000103
[    0.245053] Brought up 8 CPUs
[    0.316818] SMP: Total of 8 processors activated (384.00 BogoMIPS).
[    0.323151] CPU: All CPU(s) started in SVC mode.
[    0.328619] devtmpfs: initialized
[    0.354746] VFP support v0.3: implementor 41 architecture 4 part 30
variant f rev 0
[    0.362960] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 9556302231375000 ns
[    0.374103] pinctrl core: initialized pinctrl subsystem
[    0.379947] NET: Registered protocol family 16
[    0.385336] DMA: preallocated 256 KiB pool for atomic coherent
allocations
[    0.404756] cpuidle: using governor menu
[    0.412891] exynos-audss-clk 3810000.audss-clock-controller: setup
completed
[    0.422092] gpio gpiochip0: (gpy7): added GPIO chardev (254:0)
[    0.427978] gpiochip_setup_dev: registered GPIOs 0 to 7 on device:
gpiochip0 (gpy7)
[    0.435577] gpio gpiochip1: (gpx0): added GPIO chardev (254:1)
[    0.441581] gpiochip_setup_dev: registered GPIOs 8 to 15 on device:
gpiochip1 (gpx0)
[    0.449281] gpio gpiochip2: (gpx1): added GPIO chardev (254:2)
[    0.455286] gpiochip_setup_dev: registered GPIOs 16 to 23 on device:
gpiochip2 (gpx1)
[    0.463074] gpio gpiochip3: (gpx2): added GPIO chardev (254:3)
[    0.469081] gpiochip_setup_dev: registered GPIOs 24 to 31 on device:
gpiochip3 (gpx2)
[    0.476867] gpio gpiochip4: (gpx3): added GPIO chardev (254:4)
[    0.482872] gpiochip_setup_dev: registered GPIOs 32 to 39 on device:
gpiochip4 (gpx3)
[    0.491481] gpio gpiochip5: (gpc0): added GPIO chardev (254:5)
[    0.497348] gpiochip_setup_dev: registered GPIOs 40 to 47 on device:
gpiochip5 (gpc0)
[    0.505131] gpio gpiochip6: (gpc1): added GPIO chardev (254:6)
[    0.511139] gpiochip_setup_dev: registered GPIOs 48 to 55 on device:
gpiochip6 (gpc1)
[    0.518924] gpio gpiochip7: (gpc2): added GPIO chardev (254:7)
[    0.524931] gpiochip_setup_dev: registered GPIOs 56 to 62 on device:
gpiochip7 (gpc2)
[    0.532716] gpio gpiochip8: (gpc3): added GPIO chardev (254:8)
[    0.538722] gpiochip_setup_dev: registered GPIOs 63 to 66 on device:
gpiochip8 (gpc3)
[    0.546510] gpio gpiochip9: (gpc4): added GPIO chardev (254:9)
[    0.552515] gpiochip_setup_dev: registered GPIOs 67 to 68 on device:
gpiochip9 (gpc4)
[    0.560303] gpio gpiochip10: (gpd1): added GPIO chardev (254:10)
[    0.566485] gpiochip_setup_dev: registered GPIOs 69 to 76 on device:
gpiochip10 (gpd1)
[    0.574357] gpio gpiochip11: (gpy0): added GPIO chardev (254:11)
[    0.580535] gpiochip_setup_dev: registered GPIOs 77 to 82 on device:
gpiochip11 (gpy0)
[    0.588410] gpio gpiochip12: (gpy1): added GPIO chardev (254:12)
[    0.594589] gpiochip_setup_dev: registered GPIOs 83 to 86 on device:
gpiochip12 (gpy1)
[    0.602463] gpio gpiochip13: (gpy2): added GPIO chardev (254:13)
[    0.608642] gpiochip_setup_dev: registered GPIOs 87 to 92 on device:
gpiochip13 (gpy2)
[    0.616518] gpio gpiochip14: (gpy3): added GPIO chardev (254:14)
[    0.622701] gpiochip_setup_dev: registered GPIOs 93 to 100 on device:
gpiochip14 (gpy3)
[    0.630657] gpio gpiochip15: (gpy4): added GPIO chardev (254:15)
[    0.636835] gpiochip_setup_dev: registered GPIOs 101 to 108 on
device: gpiochip15 (gpy4)
[    0.644888] gpio gpiochip16: (gpy5): added GPIO chardev (254:16)
[    0.651063] gpiochip_setup_dev: registered GPIOs 109 to 116 on
device: gpiochip16 (gpy5)
[    0.659111] gpio gpiochip17: (gpy6): added GPIO chardev (254:17)
[    0.665289] gpiochip_setup_dev: registered GPIOs 117 to 124 on
device: gpiochip17 (gpy6)
[    0.673856] gpio gpiochip18: (gpe0): added GPIO chardev (254:18)
[    0.679908] gpiochip_setup_dev: registered GPIOs 125 to 132 on
device: gpiochip18 (gpe0)
[    0.687948] gpio gpiochip19: (gpe1): added GPIO chardev (254:19)
[    0.694126] gpiochip_setup_dev: registered GPIOs 133 to 134 on
device: gpiochip19 (gpe1)
[    0.702174] gpio gpiochip20: (gpf0): added GPIO chardev (254:20)
[    0.708356] gpiochip_setup_dev: registered GPIOs 135 to 140 on
device: gpiochip20 (gpf0)
[    0.716401] gpio gpiochip21: (gpf1): added GPIO chardev (254:21)
[    0.722579] gpiochip_setup_dev: registered GPIOs 141 to 148 on
device: gpiochip21 (gpf1)
[    0.730628] gpio gpiochip22: (gpg0): added GPIO chardev (254:22)
[    0.736806] gpiochip_setup_dev: registered GPIOs 149 to 156 on
device: gpiochip22 (gpg0)
[    0.744857] gpio gpiochip23: (gpg1): added GPIO chardev (254:23)
[    0.751033] gpiochip_setup_dev: registered GPIOs 157 to 164 on
device: gpiochip23 (gpg1)
[    0.759081] gpio gpiochip24: (gpg2): added GPIO chardev (254:24)
[    0.765264] gpiochip_setup_dev: registered GPIOs 165 to 166 on
device: gpiochip24 (gpg2)
[    0.773309] gpio gpiochip25: (gpj4): added GPIO chardev (254:25)
[    0.779493] gpiochip_setup_dev: registered GPIOs 167 to 170 on
device: gpiochip25 (gpj4)
[    0.788029] gpio gpiochip26: (gpa0): added GPIO chardev (254:26)
[    0.794075] gpiochip_setup_dev: registered GPIOs 171 to 178 on
device: gpiochip26 (gpa0)
[    0.802119] gpio gpiochip27: (gpa1): added GPIO chardev (254:27)
[    0.808301] gpiochip_setup_dev: registered GPIOs 179 to 184 on
device: gpiochip27 (gpa1)
[    0.816346] gpio gpiochip28: (gpa2): added GPIO chardev (254:28)
[    0.822525] gpiochip_setup_dev: registered GPIOs 185 to 192 on
device: gpiochip28 (gpa2)
[    0.830573] gpio gpiochip29: (gpb0): added GPIO chardev (254:29)
[    0.836751] gpiochip_setup_dev: registered GPIOs 193 to 197 on
device: gpiochip29 (gpb0)
[    0.844800] gpio gpiochip30: (gpb1): added GPIO chardev (254:30)
[    0.850979] gpiochip_setup_dev: registered GPIOs 198 to 202 on
device: gpiochip30 (gpb1)
[    0.859026] gpio gpiochip31: (gpb2): added GPIO chardev (254:31)
[    0.865208] gpiochip_setup_dev: registered GPIOs 203 to 206 on
device: gpiochip31 (gpb2)
[    0.873254] gpio gpiochip32: (gpb3): added GPIO chardev (254:32)
[    0.879433] gpiochip_setup_dev: registered GPIOs 207 to 214 on
device: gpiochip32 (gpb3)
[    0.887480] gpio gpiochip33: (gpb4): added GPIO chardev (254:33)
[    0.893662] gpiochip_setup_dev: registered GPIOs 215 to 216 on
device: gpiochip33 (gpb4)
[    0.901708] gpio gpiochip34: (gph0): added GPIO chardev (254:34)
[    0.907897] gpiochip_setup_dev: registered GPIOs 217 to 224 on
device: gpiochip34 (gph0)
[    0.916503] gpio gpiochip35: (gpz): added GPIO chardev (254:35)
[    0.922456] gpiochip_setup_dev: registered GPIOs 225 to 231 on
device: gpiochip35 (gpz)
[    0.934388] EXYNOS5420 PMU initialized
[    0.966020] of_get_named_gpiod_flags: parsed 'gpio' property of node
'/regulator-usb300[0]' - status (0)
[    0.975689] of_get_named_gpiod_flags: parsed 'gpio' property of node
'/regulator-usb301[0]' - status (0)
[    0.985303] of_get_named_gpiod_flags: can't parse 'gpio' property of
node '/fixed-regulator[0]'
[    0.995569] SCSI subsystem initialized
[    0.999446] usbcore: registered new interface driver usbfs
[    1.004908] usbcore: registered new interface driver hub
[    1.010346] usbcore: registered new device driver usb
[    1.015851] s3c-i2c 12c80000.i2c: slave address 0x50
[    1.020732] s3c-i2c 12c80000.i2c: bus frequency set to 65 KHz
[    1.026817] s3c-i2c 12c80000.i2c: i2c-2: S3C I2C adapter
[    1.032853] Advanced Linux Sound Architecture Driver Initialized.
[    1.039949] clocksource: Switched to clocksource mct-frc
[    1.057595] NET: Registered protocol family 2
[    1.062235] TCP established hash table entries: 8192 (order: 3, 32768
bytes)
[    1.069247] TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
[    1.075883] TCP: Hash tables configured (established 8192 bind 8192)
[    1.082251] UDP hash table entries: 512 (order: 2, 24576 bytes)
[    1.088220] UDP-Lite hash table entries: 512 (order: 2, 24576 bytes)
[    1.094763] NET: Registered protocol family 1
[    1.099356] RPC: Registered named UNIX socket transport module.
[    1.105209] RPC: Registered udp transport module.
[    1.109974] RPC: Registered tcp transport module.
[    1.114725] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.121421] Trying to unpack rootfs image as initramfs...
[    1.126940] rootfs image is not initramfs (junk in compressed
archive); looks like an initrd
[    1.160139] Unable to handle kernel paging request at virtual address
e3000000
[    1.167270] pgd = c0004000
[    1.170046] [e3000000] *pgd=00000000
[    1.173693] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[    1.179068] Modules linked in:
[    1.182194] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.6.0-00073-g35e691c #59
[    1.189477] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    1.195638] task: edc88000 ti: edc76000 task.ti: edc76000
[    1.201111] PC is at memcpy+0x48/0x330
[    1.204923] LR is at iov_iter_copy_from_user_atomic+0x184/0x24c
[    1.210906] pc : [<c0320388>]    lr : [<c0331688>]    psr: 20000013
[    1.210906] sp : edc77cd4  ip : 00000000  fp : c070b640
[    1.222530] r10: 00000000  r9 : 00000000  r8 : ffefe000
[    1.227822] r7 : 00000000  r6 : ffeff000  r5 : 00001000  r4 : edc77dec
[    1.234415] r3 : 01000000  r2 : 00000f80  r1 : e3000000  r0 : ffefe000
[    1.241009] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment none
[    1.248208] Control: 10c5387d  Table: 2000406a  DAC: 00000051
[    1.254020] Process swapper/0 (pid: 1, stack limit = 0xedc76210)
[    1.260093] Stack: (0xedc77cd4 to 0xedc78000)
[    1.264518] 7cc0:
00001000 ffeff000 00000000
[    1.272760] 7ce0: ffefe000 ffefe000 edc77dec c0331688 00001000
00001000 edc77df4 ed85508c
[    1.281001] 7d00: 00001000 01000000 00000000 00000000 c070b640
c01966d8 00001000 00000001
[    1.289242] 7d20: edc77d40 edc77d44 00000000 edf0e600 01000000
00000000 edc76000 00000001
[    1.297483] 7d40: eff519e0 c01f6100 00000000 00000000 edc77e08
00000000 edc77df4 edc77df4
[    1.305725] 7d60: edf0e600 ed85508c c0b45050 c0197f88 c0b45050
c06c9d3c c0b67b58 c0b67b58
[    1.313966] 7d80: 000000a8 00000003 ed855018 edc77e08 ed855018
edf0e600 edc77df4 02000000
[    1.322207] 7da0: 00000000 c0b4504c c0b45050 c0198118 eded6860
c0b4504c c0b45050 c01ec01c
[    1.330448] 7dc0: edf0e600 02000000 00000000 00000000 edc77e60
eded6860 c0b4504c c01dd0b8
[    1.338690] 7de0: 02000000 00000301 00000002 e2000000 02000000
00000003 01000000 01000000
[    1.346931] 7e00: edc77dec 00000001 edf0e600 00000000 00000000
00000000 00000000 00000000
[    1.355172] 7e20: 00000000 00000000 edf0e600 02000000 e2000000
edc77e60 00000000 c01dddac
[    1.363414] 7e40: ed854fa0 edf0e608 edf0e600 edf0e600 e2000000
02000000 00000000 c01dead8
[    1.371655] 7e60: 00000000 00000000 c08781c0 02000000 e2000000
00000000 00000000 c0a027a8
[    1.379896] 7e80: 00000000 00000000 eded6800 c0b43a4c 00000000
c0a02eb4 c0871494 eded685b
[    1.388137] 7ea0: 00000001 00000068 000241ed 00000000 00000000
00000000 00001000 00000000
[    1.396378] 7ec0: 57465fab 00000000 57465fab 00000000 00000000
376eac80 00000000 00000000
[    1.404619] 7ee0: 00000000 c0b05a50 c0b05a50 c0a02d70 00000000
edf24ac0 000000d4 c0a34848
[    1.412861] 7f00: 00000000 c0101814 c0b0a98c edc77f18 c0b47668
c06c98b0 60000000 c0b0933c
[    1.421102] 7f20: 00000000 c0b0933c c0926578 c0716b3c 000000d4
c0135ef0 0000cccd 00000000
[    1.429343] 7f40: c08dd0e0 00000000 00000005 00000005 c0b09318
efffc8c0 c0a5ba5c 00000005
[    1.437585] 7f60: c0a3483c c0b45000 c0b45000 000000d4 c0a34848
c0a00db8 00000005 00000005
[    1.445826] 7f80: 00000000 c0a005a0 00000000 c06c6254 00000000
00000000 00000000 00000000
[    1.454067] 7fa0: 00000000 c06c625c 00000000 c0107a38 00000000
00000000 00000000 00000000
[    1.462308] 7fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    1.470549] 7fe0: 00000000 00000000 00000000 00000000 00000013
00000000 f7ffffff a7ffefff
[    1.478797] [<c0320388>] (memcpy) from [<c0331688>]
(iov_iter_copy_from_user_atomic+0x184/0x24c)
[    1.487646] [<c0331688>] (iov_iter_copy_from_user_atomic) from
[<c01966d8>] (generic_perform_write+0xf8/0x1c8)
[    1.497706] [<c01966d8>] (generic_perform_write) from [<c0197f88>]
(__generic_file_write_iter+0x198/0x1f4)
[    1.507420] [<c0197f88>] (__generic_file_write_iter) from
[<c0198118>] (generic_file_write_iter+0x134/0x260)
[    1.517311] [<c0198118>] (generic_file_write_iter) from [<c01dd0b8>]
(__vfs_write+0xa8/0xd8)
[    1.525811] [<c01dd0b8>] (__vfs_write) from [<c01dddac>]
(vfs_write+0x90/0x164)
[    1.533184] [<c01dddac>] (vfs_write) from [<c01dead8>]
(SyS_write+0x44/0x9c)
[    1.540301] [<c01dead8>] (SyS_write) from [<c0a027a8>] (xwrite+0x2c/0x68)
[    1.547152] [<c0a027a8>] (xwrite) from [<c0a02eb4>]
(populate_rootfs+0x144/0x268)
[    1.554700] [<c0a02eb4>] (populate_rootfs) from [<c0101814>]
(do_one_initcall+0x90/0x1d8)
[    1.562939] [<c0101814>] (do_one_initcall) from [<c0a00db8>]
(kernel_init_freeable+0x15c/0x1fc)
[    1.571706] [<c0a00db8>] (kernel_init_freeable) from [<c06c625c>]
(kernel_init+0x8/0x114)
[    1.579945] [<c06c625c>] (kernel_init) from [<c0107a38>]
(ret_from_fork+0x14/0x3c)
[    1.587576] Code: ba000002 f5d1f03c f5d1f05c f5d1f07c (e8b151f8)
[    1.593751] ---[ end trace 065c5ae2b4577941 ]---
[    1.598420] note: swapper/0[1] exited with preempt_count 1
[    1.604062] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    1.604062]
[    1.613263] CPU5: stopping
[    1.616048] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G      D
4.6.0-00073-g35e691c #59
[    1.624540] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    1.630729] [<c010e26c>] (unwind_backtrace) from [<c010afdc>]
(show_stack+0x10/0x14)
[    1.638525] [<c010afdc>] (show_stack) from [<c03217f4>]
(dump_stack+0x88/0x9c)
[    1.645808] [<c03217f4>] (dump_stack) from [<c010d508>]
(handle_IPI+0x190/0x1a4)
[    1.653264] [<c010d508>] (handle_IPI) from [<c01014d8>]
(gic_handle_irq+0x90/0x94)
[    1.660899] [<c01014d8>] (gic_handle_irq) from [<c010ba94>]
(__irq_svc+0x54/0x90)
[    1.668438] Exception stack(0xedcc7f88 to 0xedcc7fd0)
[    1.673562] 7f80:                   00000001 00000000 00000000
c0114120 edcc6000 c0b02454
[    1.681803] 7fa0: 00000000 c0a5f3f8 c0b024bc edcc7fe0 c0b024b4
00000000 f0806000 edcc7fd8
[    1.690040] 7fc0: c0108478 c010847c 60000013 ffffffff
[    1.695166] [<c010ba94>] (__irq_svc) from [<c010847c>]
(arch_cpu_idle+0x38/0x3c)
[    1.702630] [<c010847c>] (arch_cpu_idle) from [<c0152788>]
(cpu_startup_entry+0x1bc/0x240)
[    1.710955] [<c0152788>] (cpu_startup_entry) from [<2010156c>]
(0x2010156c)
[    1.717972] CPU1: stopping
[    1.720764] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D
4.6.0-00073-g35e691c #59
[    1.729261] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    1.735434] [<c010e26c>] (unwind_backtrace) from [<c010afdc>]
(show_stack+0x10/0x14)
[    1.743233] [<c010afdc>] (show_stack) from [<c03217f4>]
(dump_stack+0x88/0x9c)
[    1.750516] [<c03217f4>] (dump_stack) from [<c010d508>]
(handle_IPI+0x190/0x1a4)
[    1.757977] [<c010d508>] (handle_IPI) from [<c01014d8>]
(gic_handle_irq+0x90/0x94)
[    1.765609] [<c01014d8>] (gic_handle_irq) from [<c010ba94>]
(__irq_svc+0x54/0x90)
[    1.773156] Exception stack(0xedcbff88 to 0xedcbffd0)
[    1.778275] ff80:                   00000001 00000000 00000000
c0114120 edcbe000 c0b02454
[    1.786517] ffa0: 00000000 c0a5f3f8 c0b024bc edcbffe0 c0b024b4
00000000 00000000 edcbffd8
[    1.794755] ffc0: c0108478 c010847c 60000013 ffffffff
[    1.799879] [<c010ba94>] (__irq_svc) from [<c010847c>]
(arch_cpu_idle+0x38/0x3c)
[    1.807353] [<c010847c>] (arch_cpu_idle) from [<c0152788>]
(cpu_startup_entry+0x1bc/0x240)
[    1.815664] [<c0152788>] (cpu_startup_entry) from [<2010156c>]
(0x2010156c)
[    1.822697] CPU7: stopping
[    1.825456] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G      D
4.6.0-00073-g35e691c #59
[    1.833952] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    1.840127] [<c010e26c>] (unwind_backtrace) from [<c010afdc>]
(show_stack+0x10/0x14)
[    1.847931] [<c010afdc>] (show_stack) from [<c03217f4>]
(dump_stack+0x88/0x9c)
[    1.855218] [<c03217f4>] (dump_stack) from [<c010d508>]
(handle_IPI+0x190/0x1a4)
[    1.862675] [<c010d508>] (handle_IPI) from [<c01014d8>]
(gic_handle_irq+0x90/0x94)
[    1.870309] [<c01014d8>] (gic_handle_irq) from [<c010ba94>]
(__irq_svc+0x54/0x90)
[    1.877847] Exception stack(0xedccbf88 to 0xedccbfd0)
[    1.882972] bf80:                   00000001 00000000 00000000
c0114120 edcca000 c0b02454
[    1.891215] bfa0: 00000000 c0a5f3f8 c0b024bc edccbfe0 c0b024b4
00000000 f0806000 edccbfd8
[    1.899452] bfc0: c0108478 c010847c 60000013 ffffffff
[    1.904577] [<c010ba94>] (__irq_svc) from [<c010847c>]
(arch_cpu_idle+0x38/0x3c)
[    1.912040] [<c010847c>] (arch_cpu_idle) from [<c0152788>]
(cpu_startup_entry+0x1bc/0x240)
[    1.920364] [<c0152788>] (cpu_startup_entry) from [<2010156c>]
(0x2010156c)
[    1.927381] CPU2: stopping
[    1.930164] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D
4.6.0-00073-g35e691c #59
[    1.938663] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    1.944826] [<c010e26c>] (unwind_backtrace) from [<c010afdc>]
(show_stack+0x10/0x14)
[    1.952634] [<c010afdc>] (show_stack) from [<c03217f4>]
(dump_stack+0x88/0x9c)
[    1.959918] [<c03217f4>] (dump_stack) from [<c010d508>]
(handle_IPI+0x190/0x1a4)
[    1.967379] [<c010d508>] (handle_IPI) from [<c01014d8>]
(gic_handle_irq+0x90/0x94)
[    1.975012] [<c01014d8>] (gic_handle_irq) from [<c010ba94>]
(__irq_svc+0x54/0x90)
[    1.982558] Exception stack(0xedcc1f88 to 0xedcc1fd0)
[    1.987675] 1f80:                   00000001 00000000 00000000
c0114120 edcc0000 c0b02454
[    1.995919] 1fa0: 00000000 c0a5f3f8 c0b024bc edcc1fe0 c0b024b4
00000000 f0806000 edcc1fd8
[    2.004162] 1fc0: c0108478 c010847c 60000013 ffffffff
[    2.009280] [<c010ba94>] (__irq_svc) from [<c010847c>]
(arch_cpu_idle+0x38/0x3c)
[    2.016742] [<c010847c>] (arch_cpu_idle) from [<c0152788>]
(cpu_startup_entry+0x1bc/0x240)
[    2.025067] [<c0152788>] (cpu_startup_entry) from [<2010156c>]
(0x2010156c)
[    2.032097] CPU4: stopping
[    2.034866] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G      D
4.6.0-00073-g35e691c #59
[    2.043361] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    2.049538] [<c010e26c>] (unwind_backtrace) from [<c010afdc>]
(show_stack+0x10/0x14)
[    2.057343] [<c010afdc>] (show_stack) from [<c03217f4>]
(dump_stack+0x88/0x9c)
[    2.064628] [<c03217f4>] (dump_stack) from [<c010d508>]
(handle_IPI+0x190/0x1a4)
[    2.072086] [<c010d508>] (handle_IPI) from [<c01014d8>]
(gic_handle_irq+0x90/0x94)
[    2.079719] [<c01014d8>] (gic_handle_irq) from [<c010ba94>]
(__irq_svc+0x54/0x90)
[    2.087259] Exception stack(0xedcc5f88 to 0xedcc5fd0)
[    2.092382] 5f80:                   00000001 00000000 00000000
c0114120 edcc4000 c0b02454
[    2.100626] 5fa0: 00000000 c0a5f3f8 c0b024bc edcc5fe0 c0b024b4
00000000 f0806000 edcc5fd8
[    2.108862] 5fc0: c0108478 c010847c 60000013 ffffffff
[    2.113988] [<c010ba94>] (__irq_svc) from [<c010847c>]
(arch_cpu_idle+0x38/0x3c)
[    2.121451] [<c010847c>] (arch_cpu_idle) from [<c0152788>]
(cpu_startup_entry+0x1bc/0x240)
[    2.129775] [<c0152788>] (cpu_startup_entry) from [<2010156c>]
(0x2010156c)
[    2.136795] CPU6: stopping
[    2.139573] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G      D
4.6.0-00073-g35e691c #59
[    2.148068] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    2.154244] [<c010e26c>] (unwind_backtrace) from [<c010afdc>]
(show_stack+0x10/0x14)
[    2.162050] [<c010afdc>] (show_stack) from [<c03217f4>]
(dump_stack+0x88/0x9c)
[    2.169335] [<c03217f4>] (dump_stack) from [<c010d508>]
(handle_IPI+0x190/0x1a4)
[    2.176793] [<c010d508>] (handle_IPI) from [<c01014d8>]
(gic_handle_irq+0x90/0x94)
[    2.184426] [<c01014d8>] (gic_handle_irq) from [<c010ba94>]
(__irq_svc+0x54/0x90)
[    2.191966] Exception stack(0xedcc9f88 to 0xedcc9fd0)
[    2.197090] 9f80:                   00000001 00000000 00000000
c0114120 edcc8000 c0b02454
[    2.205333] 9fa0: 00000000 c0a5f3f8 c0b024bc edcc9fe0 c0b024b4
00000000 f0806000 edcc9fd8
[    2.213569] 9fc0: c0108478 c010847c 60000013 ffffffff
[    2.218695] [<c010ba94>] (__irq_svc) from [<c010847c>]
(arch_cpu_idle+0x38/0x3c)
[    2.226157] [<c010847c>] (arch_cpu_idle) from [<c0152788>]
(cpu_startup_entry+0x1bc/0x240)
[    2.234482] [<c0152788>] (cpu_startup_entry) from [<2010156c>]
(0x2010156c)
[    2.241498] CPU3: stopping
[    2.244279] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D
4.6.0-00073-g35e691c #59
[    2.252779] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    2.258944] [<c010e26c>] (unwind_backtrace) from [<c010afdc>]
(show_stack+0x10/0x14)
[    2.266750] [<c010afdc>] (show_stack) from [<c03217f4>]
(dump_stack+0x88/0x9c)
[    2.274036] [<c03217f4>] (dump_stack) from [<c010d508>]
(handle_IPI+0x190/0x1a4)
[    2.281495] [<c010d508>] (handle_IPI) from [<c01014d8>]
(gic_handle_irq+0x90/0x94)
[    2.289129] [<c01014d8>] (gic_handle_irq) from [<c010ba94>]
(__irq_svc+0x54/0x90)
[    2.296675] Exception stack(0xedcc3f88 to 0xedcc3fd0)
[    2.301795] 3f80:                   00000001 00000000 00000000
c0114120 edcc2000 c0b02454
[    2.310036] 3fa0: 00000000 c0a5f3f8 c0b024bc edcc3fe0 c0b024b4
00000000 f0806000 edcc3fd8
[    2.318276] 3fc0: c0108478 c010847c 60000013 ffffffff
[    2.323396] [<c010ba94>] (__irq_svc) from [<c010847c>]
(arch_cpu_idle+0x38/0x3c)
[    2.330858] [<c010847c>] (arch_cpu_idle) from [<c0152788>]
(cpu_startup_entry+0x1bc/0x240)
[    2.339184] [<c0152788>] (cpu_startup_entry) from [<2010156c>]
(0x2010156c)
[    2.346219] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b
[    2.346219]
[   38.194984] random: nonblocking pool is initialized


Thanks,
Pankaj Dubey
