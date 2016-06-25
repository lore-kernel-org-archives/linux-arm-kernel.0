From: tbm@cyrius.com (Martin Michlmayr)
Date: Sat, 25 Jun 2016 12:46:25 -0700
Subject: orion5x: initrd fails to load due to reserved memory
In-Reply-To: <20160625171615.GC1041@n2100.armlinux.org.uk>
References: <20160625162040.GA15367@jirafa.cyrius.com>
 <20160625171615.GC1041@n2100.armlinux.org.uk>
Message-ID: <20160625194625.GA16705@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [2016-06-25 18:16]:
> > The boot loader loads the kernel to 0x400000 and the ramdisk 0x200000
> > after that location, i.e. at 0x600000:
> 
> So you're giving the kernel zImage just 2MB here.  How large is the
> 4.6 zImage?  Does the zImage have a dtb appended?

This device uses a board file so there's no DTB (but DTB is enabled in
the kernel because of other devices).

We have 64 bytes for the u-boot header, 8 bytes to set the correct
machine ID and then the zImage.  We ensure everything is < 2 MB.
The zImage itself is around 2022912 bytes.

Anyway, I don't think the problem is that the kernel is too large.
This u-boot always loads the ramdisk 2 MB after the kernel, and
setting 0x0500000 as loadAddr (therefore 0x0700000 for the initrd)
works fine.

> > Booting the image (@ 0x400000) with RamDisk (@ 0x600000)...
> > 
> > Unfortunately, with 4.x, this leads to:
> > 
> > INITRD: 0x00600040+0x00727f12 overlaps in-use memory region - disabling initrd
> 
> Right, so the kernel worked out that something else overwrote the
> initramfs.  If you boot with memblock=debug, and memblock should
> dump out the memory and reserved regions.

Thanks.  I've attached logs with loadAddr=0x0400000 (the default,
which fails) and loadAddr=0x0500000 (which boots fine).

I don't know how to interpret the log but it seems with 0x0500000 it
reserves the right memory for the ramdisk whereas with 0x0400000 it
complains about the initrd space being reserved.

In case it's relevant, a few words about the boot process on this
device.  There are 2 ways to boot:

1) You can send an image to the device via the network.  This image is
taken by the boot loader and split after 2 MB.  The first 2 MB have to
consist of the kernel (with u-boot header).  The second part is the
ramdisk (with u-boot header).  This is not a u-boot multi image.
These are two images concatenated into one file.  In Debian, we
prepend the zImage with the magic to set the machine ID, create the
u-boot image and then pad the image so it's exactly 2 MB.  We then add
a u-boot header to the ramdisk and append it to the 2MB kernel file to
create one boot image.

2) When the device boots from disk, it loads a u-boot multi image.  In
that case, we don't pad the kernel.  We get:
   Contents:
   Image 0:  2023264 Bytes =  1.9 MB
   Image 1:  3921850 Bytes =  3.7 MB
Unfortunately, that also doesn't boot:
INITRD: 0x005edfac+0x003bd7ba overlaps in-use memory region - disabling initrd

Again, changing the load address for ext2load works.

-- 
Martin Michlmayr
http://www.cyrius.com/
-------------- next part --------------
Recovery Image received (9601362 bytes).
Booting the image (@ 0x400000) with RamDisk (@ 0x600000)...
## Booting image at 00400000 ...
   Image Name:   Debian kernel
   Created:      2016-06-25  19:21:58 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2097088 Bytes =  2 MB
   Load Address: 01000040
   Entry Point:  01000040
   Verifying Checksum ... OK
OK
## Loading Ramdisk Image at 00600000 ...
   Image Name:   Debian installer
   Created:      2016-06-25   1:11:48 UTC
   Image Type:   ARM Linux RAMDisk Image (uncompressed)
   Data Size:    7503634 Bytes =  7.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.6.0-1-marvell (debian-kernel at lists.debian.org) (gcc version 5.4.0 20160609 (Debian 5.4.0-4) ) #1 Debian 4.6.2-1 (2016-06-15)
[    0.000000] CPU: Feroceon [41069260] revision 0 (ARMv5TEJ), cr=a005317f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: HP Media Vault mv2120
[    0.000000] Clearing invalid memory bank 0KB at 0xffffffff
[    0.000000] Clearing invalid memory bank 0KB at 0xffffffff
[    0.000000] Clearing invalid memory bank 0KB at 0xffffffff
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x41000403
[    0.000000] memblock_reserve: [0x00000000008200-0x0000000060646f] flags 0x0 arm_memblock_init+0x20/0x17c
[    0.000000] INITRD: 0x00600040+0x00727f12 overlaps in-use memory region - disabling initrd
[    0.000000] memblock_reserve: [0x00000000004000-0x00000000007fff] flags 0x0 arm_memblock_init+0x110/0x17c
[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0x8000000 reserved size = 0x602270
[    0.000000]  memory.cnt  = 0x1
[    0.000000]  memory[0x0]	[0x00000000000000-0x00000007ffffff], 0x8000000 bytes flags: 0x0
[    0.000000]  reserved.cnt  = 0x2
[    0.000000]  reserved[0x0]	[0x00000000004000-0x00000000007fff], 0x4000 bytes flags: 0x0
[    0.000000]  reserved[0x1]	[0x00000000008200-0x0000000060646f], 0x5fe270 bytes flags: 0x0
[    0.000000] Memory policy: Data cache writeback
[    0.000000] memblock_reserve: [0x00000007ffe000-0x00000007ffffff] flags 0x0 memblock_alloc_range_nid+0x3c/0x50
[    0.000000] memblock_reserve: [0x00000007ffd000-0x00000007ffdfff] flags 0x0 memblock_alloc_range_nid+0x3c/0x50
[    0.000000] memblock_reserve: [0x00000007ffcfb0-0x00000007ffcfff] flags 0x0 memblock_alloc_range_nid+0x3c/0x50
[    0.000000] memblock_reserve: [0x00000007ffcf88-0x00000007ffcfaf] flags 0x0 memblock_alloc_range_nid+0x3c/0x50
[    0.000000] memblock_reserve: [0x00000007ffcf60-0x00000007ffcf87] flags 0x0 memblock_alloc_range_nid+0x3c/0x50
[    0.000000] memblock_reserve: [0x00000007ffb000-0x00000007ffbfff] flags 0x0 memblock_alloc_range_nid+0x3c/0x50
[    0.000000] memblock_reserve: [0x00000007ffa000-0x00000007ffafff] flags 0x0 memblock_alloc_range_nid+0x3c/0x50
[    0.000000] memblock_reserve: [0x00000007ff9000-0x00000007ff9fff] flags 0x0 memblock_alloc_range_nid+0x3c/0x50
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 1048576 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 alloc_node_mem_map.constprop.6+0x68/0xac
[    0.000000] memblock_reserve: [0x00000007ef9000-0x00000007ff8fff] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 16 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 free_area_init_node+0x2cc/0x384
[    0.000000] memblock_reserve: [0x00000007ffcf40-0x00000007ffcf4f] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 1024 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 zone_wait_table_init+0x78/0xdc
[    0.000000] memblock_reserve: [0x00000007ffcb40-0x00000007ffcf3f] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 32 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 setup_arch+0x4b8/0x7c0
[    0.000000] memblock_reserve: [0x00000007ffcb20-0x00000007ffcb3f] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 36 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0xbc/0x3dc
[    0.000000] memblock_reserve: [0x00000007ffcae0-0x00000007ffcb03] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 36 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0xe4/0x3dc
[    0.000000] memblock_reserve: [0x00000007ffcaa0-0x00000007ffcac3] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 36 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0x108/0x3dc
[    0.000000] memblock_reserve: [0x00000007ffca60-0x00000007ffca83] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_alloc_info+0x48/0x84
[    0.000000] memblock_reserve: [0x00000007ef8000-0x00000007ef8fff] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 32768 bytes align=0x1000 nid=-1 from=0x3fffffff max_addr=0x0 setup_per_cpu_areas+0x30/0x98
[    0.000000] memblock_reserve: [0x00000007ef0000-0x00000007ef7fff] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x22c/0x788
[    0.000000] memblock_reserve: [0x00000007ffca40-0x00000007ffca43] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x24c/0x788
[    0.000000] memblock_reserve: [0x00000007ffca20-0x00000007ffca23] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x268/0x788
[    0.000000] memblock_reserve: [0x00000007ffca00-0x00000007ffca03] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x284/0x788
[    0.000000] memblock_reserve: [0x00000007ffc9e0-0x00000007ffc9e3] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 120 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x4b4/0x788
[    0.000000] memblock_reserve: [0x00000007ffc960-0x00000007ffc9d7] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 68 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x4f4/0x788
[    0.000000] memblock_reserve: [0x00000007ffc900-0x00000007ffc943] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: console=ttyS0,115200 memblock=debug
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 2048 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x15c/0x23c
[    0.000000] memblock_reserve: [0x00000007ffc100-0x00000007ffc8ff] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 65536 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x15c/0x23c
[    0.000000] memblock_reserve: [0x00000007ee0000-0x00000007eeffff] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 32768 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x15c/0x23c
[    0.000000] memblock_reserve: [0x00000007ed8000-0x00000007edffff] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 123732K/131072K available (3773K kernel code, 367K rwdata, 1416K rodata, 288K init, 289K bss, 7340K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff800000   ( 880 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc051993c   (5191 kB)
[    0.000000]       .init : 0xc051a000 - 0xc0562000   ( 288 kB)
[    0.000000]       .data : 0xc0562000 - 0xc05bdcb0   ( 368 kB)
[    0.000000]        .bss : 0xc05bdcb0 - 0xc0606470   ( 290 kB)
[    0.000000] NR_IRQS:16 nr_irqs:65 65
[    0.000000] Switching to timer-based delay loop, resolution 6ns
[    0.000018] sched_clock: 32 bits at 166MHz, resolution 6ns, wraps every 12884901885ns
[   20.540490] clocksource: orion_clocksource: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 11467562657 ns
[   20.541178] Console: colour dummy device 80x30
[   20.541227] Calibrating delay loop (skipped), value calculated using timer frequency.. 333.33 BogoMIPS (lpj=666666)
[   20.541263] pid_max: default: 32768 minimum: 301
[   20.541466] Security Framework initialized
[   20.541492] Yama: disabled by default; enable with sysctl kernel.yama.*
[   20.541662] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[   20.541694] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[   20.543656] CPU: Testing write buffer coherency: ok
[   20.543936] ftrace: allocating 16337 entries in 32 pages
[   20.605349] Setting up static identity map for 0x8200 - 0x823c
[   20.610989] devtmpfs: initialized
[   20.613843] VFP support v0.3: not present
[   20.614291] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[   20.614923] pinctrl core: initialized pinctrl subsystem
[   20.618015] NET: Registered protocol family 16
[   20.619119] DMA: preallocated 256 KiB pool for atomic coherent allocations
[   20.621134] cpuidle: using governor ladder
[   20.621176] cpuidle: using governor menu
[   20.621301] Orion ID: MV88F5182-A2. TCLK=166666667.
[   20.638236] clocksource: Switched to clocksource orion_clocksource
[   20.680833] VFS: Disk quotas dquot_6.6.0
[   20.680996] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   20.705261] NET: Registered protocol family 2
[   20.707269] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[   20.707338] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[   20.707392] TCP: Hash tables configured (established 1024 bind 1024)
[   20.707562] UDP hash table entries: 256 (order: 0, 4096 bytes)
[   20.707628] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[   20.708180] NET: Registered protocol family 1
[   20.710895] futex hash table entries: 256 (order: -1, 3072 bytes)
[   20.711116] audit: initializing netlink subsys (disabled)
[   20.711272] audit: type=2000 audit(0.148:1): initialized
[   20.712421] workingset: timestamp_bits=28 max_order=15 bucket_order=0
[   20.712799] zbud: loaded
[   20.718786] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[   20.719282] io scheduler noop registered
[   20.719416] io scheduler cfq registered (default)
[   20.720902] mv_xor mv_xor.0: Marvell shared XOR driver
[   20.758312] mv_xor mv_xor.0: Marvell XOR (Registers Mode): ( xor cpy )
[   20.759197] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[   20.761010] console [ttyS0] disabled
[   20.781269] serial8250.0: ttyS0 at MMIO 0xf1012000 (irq = 4, base_baud = 10416666) is a 16550A
[   21.767567] console [ttyS0] enabled
[   21.773125] physmap platform flash device: 00080000 at f4000000
[   21.779339] physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank. Manufacturer ID 0x0000c2 Chip ID 0x0000b9
[   21.789587] Amd/Fujitsu Extended Query Table at 0x0040
[   21.794775]   Amd/Fujitsu Extended Query version 1.0.
[   21.799860] physmap-flash.0: JEDEC Device ID is 0xB9. Assuming broken CFI table.
[   21.807282] physmap-flash.0: Swapping erase regions for top-boot CFI table.
[   21.814272] number of CFI chips: 1
[   21.818989] Creating 1 MTD partitions on "physmap-flash.0":
[   21.824680] 0x000000000000-0x000000080000 : "firmware"
[   21.834549] mousedev: PS/2 mouse device common for all mice
[   21.841085] i2c /dev entries driver
[   21.845821] rtc-pcf8563 0-0051: chip found, driver version 0.4.4
[   21.857713] rtc-pcf8563 0-0051: rtc core: registered rtc-pcf8563 as rtc0
[   21.868148] ledtrig-cpu: registered to indicate activity on CPUs
[   21.875382] NET: Registered protocol family 17
[   21.881696] registered taskstats version 1
[   21.886179] zswap: loaded using pool lzo/zbud
[   21.892808] rtc-pcf8563 0-0051: setting system clock to 2016-06-25 19:25:17 UTC (1466882717)
[   21.903038] List of all partitions:
[   21.906628] 1f00             512 mtdblock0  (driver?)
[   21.911726] No filesystem could mount root, tried: 
[   21.916664] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[   21.924913] CPU: 0 PID: 1 Comm: swapper Not tainted 4.6.0-1-marvell #1 Debian 4.6.2-1
[   21.932711] Hardware name: HP Media Vault mv2120
[   21.937383] [<c0015fec>] (unwind_backtrace) from [<c0013024>] (show_stack+0x18/0x1c)
[   21.945141] [<c0013024>] (show_stack) from [<c00c8048>] (panic+0xb4/0x244)
[   21.952027] [<c00c8048>] (panic) from [<c051b298>] (mount_block_root+0x254/0x2dc)
[   21.959512] [<c051b298>] (mount_block_root) from [<c051b4bc>] (prepare_namespace+0x124/0x184)
[   21.968031] [<c051b4bc>] (prepare_namespace) from [<c051ae68>] (kernel_init_freeable+0x1c4/0x214)
[   21.976910] [<c051ae68>] (kernel_init_freeable) from [<c03937ec>] (kernel_init+0x10/0xf8)
[   21.985099] [<c03937ec>] (kernel_init) from [<c000f770>] (ret_from_fork+0x14/0x24)
[   21.992655] ---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[   53.834304] random: nonblocking pool is initialized
-------------- next part --------------
Recovery Image received (9601362 bytes).
Booting the image (@ 0x500000) with RamDisk (@ 0x700000)...
## Booting image at 00500000 ...
   Image Name:   Debian kernel
   Created:      2016-06-25  19:21:58 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2097088 Bytes =  2 MB
   Load Address: 01000040
   Entry Point:  01000040
   Verifying Checksum ... OK
OK
## Loading Ramdisk Image at 00700000 ...
   Image Name:   Debian installer
   Created:      2016-06-25   1:11:48 UTC
   Image Type:   ARM Linux RAMDisk Image (uncompressed)
   Data Size:    7503634 Bytes =  7.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.6.0-1-marvell (debian-kernel at lists.debian.org) (gcc version 5.4.0 20160609 (Debian 5.4.0-4) ) #1 Debian 4.6.2-1 (2016-06-15)
[    0.000000] CPU: Feroceon [41069260] revision 0 (ARMv5TEJ), cr=a005317f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: HP Media Vault mv2120
[    0.000000] Clearing invalid memory bank 0KB at 0xffffffff
[    0.000000] Clearing invalid memory bank 0KB at 0xffffffff
[    0.000000] Clearing invalid memory bank 0KB at 0xffffffff
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x00000000
[    0.000000] Ignoring unrecognised tag 0x41000403
[    0.000000] memblock_reserve: [0x00000000008200-0x0000000060646f] flags 0x0 arm_memblock_init+0x20/0x17c
[    0.000000] memblock_reserve: [0x00000000700040-0x00000000e27f51] flags 0x0 arm_memblock_init+0xf4/0x17c
[    0.000000] memblock_reserve: [0x00000000004000-0x00000000007fff] flags 0x0 arm_memblock_init+0x110/0x17c
[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0x8000000 reserved size = 0xd2a182
[    0.000000]  memory.cnt  = 0x1
[    0.000000]  memory[0x0]	[0x00000000000000-0x00000007ffffff], 0x8000000 bytes flags: 0x0
[    0.000000]  reserved.cnt  = 0x3
[    0.000000]  reserved[0x0]	[0x00000000004000-0x00000000007fff], 0x4000 bytes flags: 0x0
[    0.000000]  reserved[0x1]	[0x00000000008200-0x0000000060646f], 0x5fe270 bytes flags: 0x0
[    0.000000]  reserved[0x2]	[0x00000000700040-0x00000000e27f51], 0x727f12 bytes flags: 0x0
[    0.000000] Memory policy: Data cache writeback
[    0.000000] memblock_reserve: [0x00000007ffe000-0x00000007ffffff] flags 0x0 memblock_alloc_range_nid+0x3c/0x50
[    0.000000] memblock_reserve: [0x00000007ffd000-0x00000007ffdfff] flags 0x0 memblock_alloc_range_nid+0x3c/0x50
[    0.000000] memblock_reserve: [0x00000007ffcfb0-0x00000007ffcfff] flags 0x0 memblock_alloc_range_nid+0x3c/0x50
[    0.000000] memblock_reserve: [0x00000007ffcf88-0x00000007ffcfaf] flags 0x0 memblock_alloc_range_nid+0x3c/0x50
[    0.000000] memblock_reserve: [0x00000007ffcf60-0x00000007ffcf87] flags 0x0 memblock_alloc_range_nid+0x3c/0x50
[    0.000000] memblock_reserve: [0x00000007ffb000-0x00000007ffbfff] flags 0x0 memblock_alloc_range_nid+0x3c/0x50
[    0.000000] memblock_reserve: [0x00000007ffa000-0x00000007ffafff] flags 0x0 memblock_alloc_range_nid+0x3c/0x50
[    0.000000] memblock_reserve: [0x00000007ff9000-0x00000007ff9fff] flags 0x0 memblock_alloc_range_nid+0x3c/0x50
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 1048576 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 alloc_node_mem_map.constprop.6+0x68/0xac
[    0.000000] memblock_reserve: [0x00000007ef9000-0x00000007ff8fff] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 16 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 free_area_init_node+0x2cc/0x384
[    0.000000] memblock_reserve: [0x00000007ffcf40-0x00000007ffcf4f] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 1024 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 zone_wait_table_init+0x78/0xdc
[    0.000000] memblock_reserve: [0x00000007ffcb40-0x00000007ffcf3f] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 32 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 setup_arch+0x4b8/0x7c0
[    0.000000] memblock_reserve: [0x00000007ffcb20-0x00000007ffcb3f] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 36 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0xbc/0x3dc
[    0.000000] memblock_reserve: [0x00000007ffcae0-0x00000007ffcb03] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 36 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0xe4/0x3dc
[    0.000000] memblock_reserve: [0x00000007ffcaa0-0x00000007ffcac3] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 36 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0x108/0x3dc
[    0.000000] memblock_reserve: [0x00000007ffca60-0x00000007ffca83] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_alloc_info+0x48/0x84
[    0.000000] memblock_reserve: [0x00000007ef8000-0x00000007ef8fff] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 32768 bytes align=0x1000 nid=-1 from=0x3fffffff max_addr=0x0 setup_per_cpu_areas+0x30/0x98
[    0.000000] memblock_reserve: [0x00000007ef0000-0x00000007ef7fff] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x22c/0x788
[    0.000000] memblock_reserve: [0x00000007ffca40-0x00000007ffca43] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x24c/0x788
[    0.000000] memblock_reserve: [0x00000007ffca20-0x00000007ffca23] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x268/0x788
[    0.000000] memblock_reserve: [0x00000007ffca00-0x00000007ffca03] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x284/0x788
[    0.000000] memblock_reserve: [0x00000007ffc9e0-0x00000007ffc9e3] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 120 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x4b4/0x788
[    0.000000] memblock_reserve: [0x00000007ffc960-0x00000007ffc9d7] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] memblock_virt_alloc_try_nid: 68 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x4f4/0x788
[    0.000000] memblock_reserve: [0x00000007ffc900-0x00000007ffc943] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: console=ttyS0,115200 memblock=debug
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 2048 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x15c/0x23c
[    0.000000] memblock_reserve: [0x00000007ffc100-0x00000007ffc8ff] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 65536 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x15c/0x23c
[    0.000000] memblock_reserve: [0x00000007ee0000-0x00000007eeffff] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] memblock_virt_alloc_try_nid_nopanic: 32768 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x15c/0x23c
[    0.000000] memblock_reserve: [0x00000007ed8000-0x00000007edffff] flags 0x0 memblock_virt_alloc_internal+0x130/0x184
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 116404K/131072K available (3773K kernel code, 367K rwdata, 1416K rodata, 288K init, 289K bss, 14668K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff800000   ( 880 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc051993c   (5191 kB)
[    0.000000]       .init : 0xc051a000 - 0xc0562000   ( 288 kB)
[    0.000000]       .data : 0xc0562000 - 0xc05bdcb0   ( 368 kB)
[    0.000000]        .bss : 0xc05bdcb0 - 0xc0606470   ( 290 kB)
[    0.000000] NR_IRQS:16 nr_irqs:65 65
[    0.000000] Switching to timer-based delay loop, resolution 6ns
[    0.000018] sched_clock: 32 bits at 166MHz, resolution 6ns, wraps every 12884901885ns
[   19.620994] clocksource: orion_clocksource: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 11467562657 ns
[   19.621682] Console: colour dummy device 80x30
[   19.621732] Calibrating delay loop (skipped), value calculated using timer frequency.. 333.33 BogoMIPS (lpj=666666)
[   19.621767] pid_max: default: 32768 minimum: 301
[   19.621970] Security Framework initialized
[   19.621996] Yama: disabled by default; enable with sysctl kernel.yama.*
[   19.622166] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[   19.622198] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[   19.624158] CPU: Testing write buffer coherency: ok
[   19.624437] ftrace: allocating 16337 entries in 32 pages
[   19.685850] Setting up static identity map for 0x8200 - 0x823c
[   19.691490] devtmpfs: initialized
[   19.694343] VFP support v0.3: not present
[   19.694791] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[   19.695423] pinctrl core: initialized pinctrl subsystem
[   19.698518] NET: Registered protocol family 16
[   19.699622] DMA: preallocated 256 KiB pool for atomic coherent allocations
[   19.701638] cpuidle: using governor ladder
[   19.701681] cpuidle: using governor menu
[   19.701806] Orion ID: MV88F5182-A2. TCLK=166666667.
[   19.718741] clocksource: Switched to clocksource orion_clocksource
[   19.761338] VFS: Disk quotas dquot_6.6.0
[   19.761501] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   19.785765] NET: Registered protocol family 2
[   19.787773] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[   19.787842] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[   19.787897] TCP: Hash tables configured (established 1024 bind 1024)
[   19.788067] UDP hash table entries: 256 (order: 0, 4096 bytes)
[   19.788133] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[   19.788684] NET: Registered protocol family 1
[   19.789435] Unpacking initramfs...
[   21.586346] Freeing initrd memory: 7328K (c0700000 - c0e28000)
[   21.588175] futex hash table entries: 256 (order: -1, 3072 bytes)
[   21.588392] audit: initializing netlink subsys (disabled)
[   21.588548] audit: type=2000 audit(1.944:1): initialized
[   21.589702] workingset: timestamp_bits=28 max_order=15 bucket_order=0
[   21.590091] zbud: loaded
[   21.596150] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[   21.596641] io scheduler noop registered
[   21.596774] io scheduler cfq registered (default)
[   21.598258] mv_xor mv_xor.0: Marvell shared XOR driver
[   21.634123] mv_xor mv_xor.0: Marvell XOR (Registers Mode): ( xor cpy )
[   21.635113] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[   21.636907] console [ttyS0] disabled
[   21.657164] serial8250.0: ttyS0 at MMIO 0xf1012000 (irq = 4, base_baud = 10416666) is a 16550A
[   22.662397] console [ttyS0] enabled
[   22.668030] physmap platform flash device: 00080000 at f4000000
[   22.674218] physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank. Manufacturer ID 0x0000c2 Chip ID 0x0000b9
[   22.684470] Amd/Fujitsu Extended Query Table at 0x0040
[   22.689656]   Amd/Fujitsu Extended Query version 1.0.
[   22.694762] physmap-flash.0: JEDEC Device ID is 0xB9. Assuming broken CFI table.
[   22.702179] physmap-flash.0: Swapping erase regions for top-boot CFI table.
[   22.709170] number of CFI chips: 1
[   22.738967] Creating 1 MTD partitions on "physmap-flash.0":
[   22.744650] 0x000000000000-0x000000080000 : "firmware"
[   22.754470] mousedev: PS/2 mouse device common for all mice
[   22.761033] i2c /dev entries driver
[   22.765766] rtc-pcf8563 0-0051: chip found, driver version 0.4.4
[   22.777681] rtc-pcf8563 0-0051: rtc core: registered rtc-pcf8563 as rtc0
[   22.788071] ledtrig-cpu: registered to indicate activity on CPUs
[   22.795347] NET: Registered protocol family 17
[   22.801611] registered taskstats version 1
[   22.806096] zswap: loaded using pool lzo/zbud
[   22.812819] rtc-pcf8563 0-0051: setting system clock to 2016-06-25 19:22:31 UTC (1466882551)
[   22.825293] Freeing unused kernel memory: 288K (c051a000 - c0562000)
[   22.831701] This architecture does not have kernel memory protection.
[   22.968162] random: systemd-udevd urandom read with 12 bits of entropy available
[   23.281430] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[   23.373343] mv643xx_eth: MV-643xx 10/100/1000 ethernet driver version 1.4
[   23.412395] libphy: PHY orion-mdio-mii:08 not found
[   23.566567] libphy: orion_mdio_bus: probed
[   23.645585] mv643xx_eth_port mv643xx_eth_port.0 eth0: port 0 with MAC address 00:0a:e4:87:40:ac
Starting system log daemon: syslogd, klogd.
...
