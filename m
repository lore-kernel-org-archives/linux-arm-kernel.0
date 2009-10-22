From: schwarzb@ipms.fraunhofer.de (Markus Schwarzenberg)
Date: Thu, 22 Oct 2009 17:27:16 +0200
Subject: S3C6400 SMDK6400 HSMMC problem
Message-ID: <20091022172716.2c20c1a8@linpcd55>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

First: i'm new to this list. The new listinfo page tells nothing
about attachments (are they allowed, size?) or where to put them 
now - so for now i don't attach two files i actually wanted to 
provide (my adaptions for u-boot-hsmmc, kernel .config).

Now the problem: 

i'm trying to get linux-2.6.32-rc5 working on a Samsung/Meritech 
SMDK6400, (Processor S3C6400.) 

The kernel is load sucessfully using u-boot-2009.08-rc3 from the 
DOS-Partition of a SD Card via the S3C6400 HSMMC 0. 
  Note1: to get this working I adapted src/cpu/s3c6410/hs_mmc.c 
         from OpenMoko / qi for u-boot. 

However the kernel's sdhci driver has problems (I/O errors) using the same
S3C6400 HSMMC 0 (see below) when trying to mount the root partition from
the SD Card.

Besides some additional printk statements in the kernel source, the
only relevant modification (to use HSMMC0 instead of 1) was using
s3c_device_hsmmc0 instead of s3c_device_hsmmc1 in 
static struct platform_device *smdk6400_devices[] __initdata
file: arch/arm/mach-s3c6400/mach-smdk6400.c

Any hints where to look next are highly appreciated. 

Best Regards,

Markus Schwarzenberg

----- BEGIN MESSAGES ----

U-Boot 2009.08-rc3 (Oct 07 2009 - 11:38:42) for SMDK6400


CPU:     S3C6400 at 667MHz
         Fclk = 667MHz, Hclk = 133MHz, Pclk = 66MHz (ASYNC Mode) 
Board:   SMDK6400
DRAM:  128 MB
Flash:  0 kB
64 MiB
In:    serial
Out:   serial
Err:   serial
SMDK6400 # mmc init
CID information: SD 2.0
Manufacturer ID:       02
OEM/Application ID:    544D
Product name:          G20AS
Product Revision:      0.3
Product Serial Number: 2627147596
Manufacturing Date:    2009/03
CSD data: 32004f00 57c5a5b5 fffffeb3 000a41fc
CSD structure version:   1.0
MMC System Spec version: 0
Card command classes:    5b5
Read block length:       1024
Supports partial reads
Write block length:      1024
Does not support partial writes
Does not support group WP
Card capacity: 1973420032 bytes
File format:            0/0
Write protection:        

csd_structure:2:       0x0
spec_vers:4:           0x0
rsvd1:2:               0x0
taac:                  0x4f
nsac:                  0x0
tran_speed:            0x32
ccc:12:                0x5b5
read_bl_len:4:         0xa
read_bl_partial:1:     0x1
write_blk_misalign:1:  0x0
read_blk_misalign:1:   0x1
dsr_imp:1:             0x0
rsvd2:2:               0x0
c_size:12:             0xeb3
vdd_r_curr_min:3:      0x7
vdd_r_curr_max:3:      0x7
vdd_w_curr_min:3:      0x7
vdd_w_curr_max:3:      0x7
c_size_mult:3:         0x7
erase_grp_size:5:      0x1c
wp_grp_size:5:         0xf
wp_grp_enable:1:       0x0
default_ecc:2:         0x0
r2w_factor:3:          0x2
write_bl_len:4:        0xa
write_bl_partial:1:    0x0
rsvd3:5:               0x0
file_format_grp:1:     0x0
copy:1:                0x0
perm_write_protect:1:  0x0
tmp_write_protect:1:   0x0
file_format:2:         0x0
ecc:2:                 0x0
mmc_legacy_init: OK, 3854336 blocks a 512 bytes
mmc1 is available

SMDK6400 # fatload mmc 0 50000000 uImage
reading uImage
SMDK6400 # setenv bootargs 'console=ttySAC0,115200n8 root=/dev/mmcblk0p2 rootdelay=10 rootfstype=ext2' 
SMDK6400 # bootm 50000000 
## Booting kernel from Legacy Image at 50000000 ...
   Image Name:   Linux-2.6.32-rc5
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1656520 Bytes =  1.6 MB
   Load Address: 50008000
   Entry Point:  50008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux........................................................................................................... done, booting the kernel.
Linux version 2.6.32-rc5 (schwarzb at linpcd55) (gcc version 4.3.2 (Sourcery G++ Lite 2008q3-41) ) #32 Wed Oct 21 16:20:26 CEST 2009
CPU: ARMv6-compatible processor [410fb761] revision 1 (ARMv7), cr=00c5387f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: SMDK6400
Memory policy: ECC disabled, Data cache writeback
CPU S3C6400 (id 0x36400202)
S3C24XX Clocks, (c) 2004 Simtec Electronics
S3C64XX: PLL settings, A=667000000, M=533000000, E=24000000
S3C64XX: HCLK2=266500000, HCLK=133250000, PCLK=66625000
mout_apll: source is fout_apll (1), rate is 667000000
mout_epll: source is fout_epll (1), rate is 24000000
mout_mpll: source is mpll (1), rate is 533000000
mmc_bus: source is mout_epll (0), rate is 24000000
mmc_bus: source is mout_epll (0), rate is 24000000
mmc_bus: source is mout_epll (0), rate is 24000000
usb-bus-host: source is clk_48m (0), rate is 48000000
uclk1: source is mout_epll (0), rate is 24000000
spi-bus: source is mout_epll (0), rate is 24000000
spi-bus: source is mout_epll (0), rate is 24000000
audio-bus: source is mout_epll (0), rate is 24000000
audio-bus: source is mout_epll (0), rate is 24000000
irda-bus: source is mout_epll (0), rate is 24000000
camera: source is hclk2 (0), rate is 266500000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttySAC0,115200n8 root=/dev/mmcblk0p2 rootdelay=10 rootfstype=ext2
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB = 128MB total
Memory: 126208KB available (3052K code, 361K data, 120K init, 0K highmem)
Hierarchical RCU implementation.
NR_IRQS:246
VIC @f4000000: id 0x00041192, vendor 0x41
VIC @f4010000: id 0x00041192, vendor 0x41
Console: colour dummy device 80x30
console [ttySAC0] enabled
Calibrating delay loop... 665.19 BogoMIPS (lpj=3325952)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
s3c64xx_dma_init: Registering DMA channels
s3c64xx_dma_init1: registering DMA 0 (c8808100)
s3c64xx_dma_init1: registering DMA 1 (c8808120)
s3c64xx_dma_init1: registering DMA 2 (c8808140)
s3c64xx_dma_init1: registering DMA 3 (c8808160)
s3c64xx_dma_init1: registering DMA 4 (c8808180)
s3c64xx_dma_init1: registering DMA 5 (c88081a0)
s3c64xx_dma_init1: registering DMA 6 (c88081c0)
s3c64xx_dma_init1: registering DMA 7 (c88081e0)
PL080: IRQ 73, at c8808000
s3c64xx_dma_init1: registering DMA 8 (c880c100)
s3c64xx_dma_init1: registering DMA 9 (c880c120)
s3c64xx_dma_init1: registering DMA 10 (c880c140)
s3c64xx_dma_init1: registering DMA 11 (c880c160)
s3c64xx_dma_init1: registering DMA 12 (c880c180)
s3c64xx_dma_init1: registering DMA 13 (c880c1a0)
s3c64xx_dma_init1: registering DMA 14 (c880c1c0)
s3c64xx_dma_init1: registering DMA 15 (c880c1e0)
PL080: IRQ 74, at c880c000
S3C6400: Initialising architecture
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (extended precision)
JFFS2 version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
ROMFS MTD (C) 2007 Red Hat, Inc.
msgmni has been set to 246
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
s3c6400-uart.0: s3c2410_serial0 at MMIO 0x7f005000 (irq = 16) is a S3C6400/10
s3c6400-uart.1: s3c2410_serial1 at MMIO 0x7f005400 (irq = 20) is a S3C6400/10
brd: module loaded
loop: module loaded
S3C24XX NAND Driver, (c) 2004 Simtec Electronics
dummy_hcd dummy_hcd: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd: Dummy host controller
dummy_hcd dummy_hcd: new USB bus registered, assigned bus number 1
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Dummy host controller
usb usb1: Manufacturer: Linux 2.6.32-rc5 dummy_hcd
usb usb1: SerialNumber: dummy_hcd
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
s3c-sdhci s3c-sdhci.0: clock source 0: hsmmc (133250000 Hz)
s3c-sdhci s3c-sdhci.0: clock source 1: hsmmc (133250000 Hz)
s3c-sdhci s3c-sdhci.0: clock source 2: mmc_bus (24000000 Hz)
mmc0: SDHCI controller on samsung-hsmmc [s3c-sdhci.0] using PIO
s3c-sdhci s3c-sdhci.0: sdhci_add_host OK
TCP cubic registered
NET: Registered protocol family 17
Waiting 10sec before mounting root device...
mmc0: Minimum clock frequency too high for identification mode
s3c6400_setup_sdhci_cfg_card: CTRL 2=c0004100, 3=80808080
mmc0: Got data interrupt 0x00000002 even though no data operation was in progress.
s3c6400_setup_sdhci_cfg_card: CTRL 2=c0004100, 3=00008080
mmc0: new high speed SD card at address 1234
blk_queue_max_sectors: set to minimum 8
mmcblk0: mmc0:1234 SA02G 1.83 GiB 
 mmcblk0:
mmcblk0: error -84 transferring data, sector 0, nr 8, card status 0x900
end_request: I/O error, dev mmcblk0, sector 0
mmcblk0: error -84 transferring data, sector 6, nr 2, card status 0x900
end_request: I/O error, dev mmcblk0, sector 6
Buffer I/O error on device mmcblk0, logical block 0
mmcblk0: error -84 transferring data, sector 0, nr 8, card status 0x900
end_request: I/O error, dev mmcblk0, sector 0
mmcblk0: error -84 transferring data, sector 4, nr 4, card status 0x900
end_request: I/O error, dev mmcblk0, sector 4
Buffer I/O error on device mmcblk0, logical block 0
 unable to read partition table
VFS: Cannot open root device "mmcblk0p2" or unknown-block(179,2)
Please append a correct "root=" boot option; here are the available
partitions:
b300         1927168 mmcblk0 driver: mmcblk
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(179,2)
Backtrace: 
[<c002a9c8>] (dump_backtrace+0x0/0x114) from [<c0274114>] (dump_stack+0x18/0x1c)
 r7:c7826000 r6:00000000 r5:c001e808 r4:c0341f5c
[<c02740fc>] (dump_stack+0x0/0x1c) from [<c0274164>] (panic+0x4c/0x11c)
[<c0274118>] (panic+0x0/0x11c) from [<c000907c>] (mount_block_root+0x264/0x2b4)
 r3:00000000 r2:00000000 r1:c781ff68 r0:c02da3a6
[<c0008e18>] (mount_block_root+0x0/0x2b4) from [<c0009120>] (mount_root+0x54/0x6c)
[<c00090cc>] (mount_root+0x0/0x6c) from [<c000929c>] (prepare_namespace+0x164/0x1b8)
 r5:c001e808 r4:c03414d4
[<c0009138>] (prepare_namespace+0x0/0x1b8) from [<c0008634>] (kernel_init+0xe0/0x114)
 r5:00000000 r4:c03412a0
[<c0008554>] (kernel_init+0x0/0x114) from [<c0048898>] (do_exit+0x0/0x5b4)
 r4:00000000

----- END MESSAGES ----
