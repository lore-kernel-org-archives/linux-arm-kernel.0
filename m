From: thiago.bauermann@gmail.com (Thiago Jung Bauermann)
Date: Wed, 30 May 2012 15:06:23 -0300
Subject: Kernel 3.4 error on Dreamplug: [vectors]: mlock failed: Cannot
 allocate memory
Message-ID: <1338401183.22894.11.camel@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have just upgraded my Dreamplug to the 3.4 kernel, and when creating
an LVM snapshot volume, I see errors for which I didn't find any report
yet:

# lvcreate -s -L 80M -n root-fsck-snapshot marv2-vg/root
  ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
  ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
  ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: munlock failed: Cannot allocate memory
  ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
  ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
  ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: munlock failed: Cannot allocate memory
  Logical volume "root-fsck-snapshot" created

# lvremove -f marv2-vg/root-fsck-snapshot
  ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
  ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
  ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: munlock failed: Cannot allocate memory
  ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
  ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
  ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: munlock failed: Cannot allocate memory
  Logical volume "root-fsck-snapshot" successfully removed

This is on the following kernel:

Linux marv 3.4.0-1bauer2-kirkwood #1 Wed May 30 01:31:47 BRT 2012 armv5tel GNU/Linux

Ironically, the main reason I upgraded the kernel from 3.0.0 was to get
rid of another message that happened on the same situation (I don't
think it's related though):


# lvcreate -s -L 80M -n root-fsck-snapshot marv2-vg/root
  The link /dev/marv2-vg/root-fsck-snapshot should had been created by udev but it was not found. Falling back to direct link creation.
  semid 131072: semop failed for cookie 0xd4d54fe: incorrect semaphore state
  Failed to set a proper state for notification semaphore identified by cookie value 223171838 (0xd4d54fe) to initialize waiting for incoming notifications.
  Logical volume "root-fsck-snapshot" created

# lvremove -f marv2-vg/root-fsck-snapshot
  Node /dev/mapper/marv2--vg-root--fsck--snapshot was not removed by udev. Falling back to direct node removal.
  Node /dev/mapper/marv2--vg-root--fsck--snapshot-cow was not removed by udev. Falling back to direct node removal.
  The link /dev/marv2-vg/root-fsck-snapshot should have been removed by udev but it is still present. Falling back to direct link removal.
  Node /dev/mapper/marv2--vg-root-real was not removed by udev. Falling back to direct node removal.
  Logical volume "root-fsck-snapshot" successfully removed

This was on:

Linux marv 3.0.0-1bauer4-kirkwood #1 PREEMPT Tue Nov 1 16:23:31 BRST 2011 armv5tel GNU/Linux

I'm attaching my dmesg, but there are no errors there. And the snapshot
worked fine. Any ideas about what is going on?

Ps: Please keep me in the Cc: when replying since I'm not subscribed to
this list.

-- 
[]'s
Thiago Jung Bauermann

-------------- next part --------------
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.4.0-1bauer2-kirkwood (root at marv) (gcc version 4.4.5 (Debian 4.4.5-8) ) #1 Wed May 30 01:31:47 BRT 2012
[    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Marvell DreamPlug Reference Board
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 131072
[    0.000000] free_area_init_node: node 0, pgdat c052f950, node_mem_map c05ec000
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 130048 pages, LIFO batch:31
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
[    0.000000] Kernel command line: console=ttyS0,115200 root=/dev/mapper/marv2--vg-root rootdelay=10
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] allocated 1048576 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] Memory: 512MB = 512MB total
[    0.000000] Memory: 506116k/506116k available, 18172k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc04c6748   (4858 kB)
[    0.000000]       .init : 0xc04c7000 - 0xc04ef000   ( 160 kB)
[    0.000000]       .data : 0xc04f0000 - 0xc0532a68   ( 267 kB)
[    0.000000]        .bss : 0xc0532a8c - 0xc05eb0e8   ( 738 kB)
[    0.000000] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:114
[    0.000000] gpiochip_add: registered GPIOs 0 to 31 on device: orion_gpio0
[    0.000000] gpiochip_add: registered GPIOs 32 to 49 on device: orion_gpio1
[    0.000000] sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 21474ms
[    0.000000] Console: colour dummy device 80x30
[    3.818248] Calibrating delay loop... 1191.11 BogoMIPS (lpj=5955584)
[    3.908183] pid_max: default: 32768 minimum: 301
[    3.908279] Security Framework initialized
[    3.908298] SELinux:  Disabled at boot.
[    3.908348] Mount-cache hash table entries: 512
[    3.908800] Initializing cgroup subsys cpuacct
[    3.908812] Initializing cgroup subsys memory
[    3.908839] Initializing cgroup subsys devices
[    3.908848] Initializing cgroup subsys freezer
[    3.908857] Initializing cgroup subsys net_cls
[    3.908865] Initializing cgroup subsys blkio
[    3.908935] CPU: Testing write buffer coherency: ok
[    3.909139] Setting up static identity map for 0x3872a0 - 0x3872dc
[    3.911459] dummy: 
[    3.911750] NET: Registered protocol family 16
[    3.913863] Kirkwood: MV88F6281-A1, TCLK=200000000.
[    3.913878] Feroceon L2: Cache support initialised.
[    3.915420] initial MPP regs: 01112222 11113311 33331111 33333333 00003333 00000222 00000000
[    3.915445]   final MPP regs: 01112222 11113311 33331111 33333333 00003333 00000222 00000000
[    3.926842] bio: create slab <bio-0> at 0
[    3.927889] SCSI subsystem initialized
[    3.928374] libata version 3.00 loaded.
[    3.930037] Switching to clocksource orion_clocksource
[    3.955117] NET: Registered protocol family 2
[    3.955298] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[    3.955642] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    3.955998] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[    3.956178] TCP: Hash tables configured (established 16384 bind 16384)
[    3.956188] TCP: reno registered
[    3.956198] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    3.956220] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    3.956411] NET: Registered protocol family 1
[    3.956443] PCI: CLS 0 bytes, default 32
[    3.956590] Trying to unpack rootfs image as initramfs...
[    4.433399] Freeing initrd memory: 6544K
[    4.433447] NetWinder Floating Point Emulator V0.97 (double precision)
[    4.434904] audit: initializing netlink socket (disabled)
[    4.434944] type=2000 audit(0.610:1): initialized
[    4.448249] VFS: Disk quotas dquot_6.5.2
[    4.448573] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    4.452246] jffs2: version 2.2. (NAND) (SUMMARY)  ?? 2001-2006 Red Hat, Inc.
[    4.452985] msgmni has been set to 1001
[    4.454645] alg: No test for stdrng (krng)
[    4.455113] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    4.455128] io scheduler noop registered
[    4.455136] io scheduler deadline registered
[    4.455170] io scheduler cfq registered (default)
[    4.455236] mv_xor_shared mv_xor_shared.0: Marvell shared XOR driver
[    4.455269] mv_xor_shared mv_xor_shared.1: Marvell shared XOR driver
[    4.490110] mv_xor mv_xor.0: Marvell XOR: ( xor cpy )
[    4.530115] mv_xor mv_xor.1: Marvell XOR: ( xor fill cpy )
[    4.570107] mv_xor mv_xor.2: Marvell XOR: ( xor cpy )
[    4.610106] mv_xor mv_xor.3: Marvell XOR: ( xor fill cpy )
[    4.610687] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    4.631568] serial8250.0: ttyS0 at MMIO 0xf1012000 (irq = 33) is a 16550A
[    5.092192] console [ttyS0] enabled
[    5.105322] brd: module loaded
[    5.108621] sata_mv sata_mv.0: version 1.28
[    5.108707] sata_mv sata_mv.0: slots 32 ports 1
[    5.114556] scsi0 : sata_mv
[    5.117842] ata1: SATA max UDMA/133 irq 21
[    5.124326] orion_spi orion_spi.0: master is unqueued, this is deprecated
[    5.131442] m25p80 spi0.0: mx25l1606e (2048 Kbytes)
[    5.141127] Creating 2 MTD partitions on "spi_flash":
[    5.146208] 0x000000000000-0x000000080000 : "u-boot"
[    5.152542] 0x000000100000-0x000000110000 : "u-boot env"
[    5.159202] mv643xx_eth: MV-643xx 10/100/1000 ethernet driver version 1.4
[    5.166262] mv643xx_eth smi: probed
[    5.175703] mv643xx_eth_port mv643xx_eth_port.0: eth0: port 0 with MAC address f0:ad:4e:00:ae:80
[    5.190325] mv643xx_eth_port mv643xx_eth_port.1: eth1: port 0 with MAC address f0:ad:4e:00:ae:81
[    5.199643] rtc-mv rtc-mv: rtc core: registered rtc-mv as rtc0
[    5.206065] cpuidle: using governor ladder
[    5.210305] cpuidle: using governor menu
[    5.214468] Registered led device: dreamplug:blue:bluetooth
[    5.214688] Registered led device: dreamplug:green:wifi
[    5.214898] Registered led device: dreamplug:green:wifi_ap
[    5.215383] TCP: cubic registered
[    5.218719] NET: Registered protocol family 17
[    5.223255] Registering the dns_resolver key type
[    5.228030] Gating clock of unused units
[    5.228039] before: 0x00dfc3fd
[    5.228047]  after: 0x00cf41d9
[    5.228679] registered taskstats version 1
[    5.233588] rtc-mv rtc-mv: setting system clock to 2012-05-30 14:47:11 UTC (1338389231)
[    5.470087] ata1: SATA link down (SStatus 0 SControl F300)
[    5.476094] Freeing init memory: 160K
[    5.658427] mmc0: mvsdio driver initialized, lacking card detect (fall back to polling)
[    5.726254] mmc0: new high speed SDIO card at address 0001
[    5.835130] usbcore: registered new interface driver usbfs
[    5.894107] usbcore: registered new interface driver hub
[    5.940859] usbcore: registered new device driver usb
[    5.962078] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.968693] orion-ehci orion-ehci.0: Marvell Orion EHCI
[    5.992035] orion-ehci orion-ehci.0: new USB bus registered, assigned bus number 1
[    6.030106] orion-ehci orion-ehci.0: irq 19, io mem 0xf1050000
[    6.050080] orion-ehci orion-ehci.0: USB 2.0 started, EHCI 1.00
[    6.056571] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    6.063410] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.070672] usb usb1: Product: Marvell Orion EHCI
[    6.075396] usb usb1: Manufacturer: Linux 3.4.0-1bauer2-kirkwood ehci_hcd
[    6.082226] usb usb1: SerialNumber: orion-ehci.0
[    6.087675] hub 1-0:1.0: USB hub found
[    6.091477] hub 1-0:1.0: 1 port detected
[    6.410088] usb 1-1: new high-speed USB device number 2 using orion-ehci
[    6.560710] usb 1-1: New USB device found, idVendor=1a40, idProduct=0101
[    6.567442] usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    6.574622] usb 1-1: Product: USB 2.0 Hub
[    6.583512] hub 1-1:1.0: USB hub found
[    6.595078] hub 1-1:1.0: 4 ports detected
[    6.880234] usb 1-1.1: new high-speed USB device number 3 using orion-ehci
[    6.991960] usb 1-1.1: New USB device found, idVendor=05e3, idProduct=0726
[    6.998872] usb 1-1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=2
[    7.006226] usb 1-1.1: Product: USB Storage
[    7.010452] usb 1-1.1: SerialNumber: 000000009910
[    7.029903] usbcore: registered new interface driver uas
[    7.039192] Initializing USB Mass Storage driver...
[    7.044516] scsi1 : usb-storage 1-1.1:1.0
[    7.049823] usbcore: registered new interface driver usb-storage
[    7.055878] USB Mass Storage support registered.
[    7.100242] usb 1-1.2: new high-speed USB device number 4 using orion-ehci
[    7.212210] usb 1-1.2: New USB device found, idVendor=0930, idProduct=6545
[    7.219122] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    7.226477] usb 1-1.2: Product: DataTraveler 2.0
[    7.231138] usb 1-1.2: Manufacturer: Kingston
[    7.235514] usb 1-1.2: SerialNumber: 001D92AD6B72B92143340599
[    7.254540] scsi2 : usb-storage 1-1.2:1.0
[    7.330221] usb 1-1.3: new high-speed USB device number 5 using orion-ehci
[    7.456834] usb 1-1.3: New USB device found, idVendor=07d1, idProduct=3c16
[    7.463766] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    7.471131] usb 1-1.3: Product: 11n Adapter
[    7.475331] usb 1-1.3: Manufacturer: Ralink
[    7.479534] usb 1-1.3: SerialNumber: 1.0
[    7.560239] usb 1-1.4: new full-speed USB device number 6 using orion-ehci
[    7.671209] usb 1-1.4: New USB device found, idVendor=0d8c, idProduct=000c
[    7.678117] usb 1-1.4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    7.685472] usb 1-1.4: Product: C-Media USB Headphone Set  
[    7.731295] input: C-Media USB Headphone Set   as /devices/platform/orion-ehci.0/usb1/1-1/1-1.4/1-1.4:1.3/input/input0
[    7.742405] generic-usb 0003:0D8C:000C.0001: input,hidraw0: USB HID v1.00 Device [C-Media USB Headphone Set  ] on usb-orion-ehci.0-1.4/input3
[    7.755939] usbcore: registered new interface driver usbhid
[    7.761560] usbhid: USB HID core driver
[    8.061301] scsi 1:0:0:0: Direct-Access     Generic  STORAGE DEVICE   9910 PQ: 0 ANSI: 0
[    8.070016] scsi 1:0:0:1: Direct-Access     Generic  STORAGE DEVICE   9910 PQ: 0 ANSI: 0
[    8.092892] sd 1:0:0:0: [sda] 3842048 512-byte logical blocks: (1.96 GB/1.83 GiB)
[    8.100880] sd 1:0:0:1: [sdb] 3948544 512-byte logical blocks: (2.02 GB/1.88 GiB)
[    8.113492] sd 1:0:0:1: [sdb] Write Protect is off
[    8.118330] sd 1:0:0:1: [sdb] Mode Sense: 0b 00 00 08
[    8.118502] sd 1:0:0:0: [sda] Write Protect is off
[    8.123344] sd 1:0:0:0: [sda] Mode Sense: 0b 00 00 08
[    8.127638] sd 1:0:0:0: [sda] No Caching mode page present
[    8.133196] sd 1:0:0:0: [sda] Assuming drive cache: write through
[    8.141124] sd 1:0:0:1: [sdb] No Caching mode page present
[    8.146642] sd 1:0:0:1: [sdb] Assuming drive cache: write through
[    8.158233] sd 1:0:0:0: [sda] No Caching mode page present
[    8.163776] sd 1:0:0:0: [sda] Assuming drive cache: write through
[    8.172371] sd 1:0:0:1: [sdb] No Caching mode page present
[    8.177899] sd 1:0:0:1: [sdb] Assuming drive cache: write through
[    8.184490]  sda: sda1 sda2 < sda5 >
[    8.191125]  sdb: sdb1 < sdb5 >
[    8.202755] sd 1:0:0:0: [sda] No Caching mode page present
[    8.208275] sd 1:0:0:0: [sda] Assuming drive cache: write through
[    8.214430] sd 1:0:0:0: [sda] Attached SCSI removable disk
[    8.222385] sd 1:0:0:1: [sdb] No Caching mode page present
[    8.227903] sd 1:0:0:1: [sdb] Assuming drive cache: write through
[    8.234056] sd 1:0:0:1: [sdb] Attached SCSI removable disk
[    8.255182] scsi 2:0:0:0: Direct-Access     Kingston DataTraveler 2.0 PMAP PQ: 0 ANSI: 0 CCS
[    8.275275] sd 2:0:0:0: [sdc] 7827456 512-byte logical blocks: (4.00 GB/3.73 GiB)
[    8.288501] sd 2:0:0:0: [sdc] Write Protect is off
[    8.293376] sd 2:0:0:0: [sdc] Mode Sense: 23 00 00 00
[    8.299744] sd 2:0:0:0: [sdc] No Caching mode page present
[    8.305309] sd 2:0:0:0: [sdc] Assuming drive cache: write through
[    8.321997] sd 2:0:0:0: [sdc] No Caching mode page present
[    8.327512] sd 2:0:0:0: [sdc] Assuming drive cache: write through
[    8.345347]  sdc: sdc1
[    8.353762] sd 2:0:0:0: [sdc] No Caching mode page present
[    8.359279] sd 2:0:0:0: [sdc] Assuming drive cache: write through
[    8.365435] sd 2:0:0:0: [sdc] Attached SCSI removable disk
[   16.208229] device-mapper: uevent: version 1.0.3
[   16.214952] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) initialised: dm-devel at redhat.com
[   16.543427] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
[   17.301473] udev[607]: starting version 164
[   17.988109] cfg80211: Calling CRDA to update world regulatory domain
[   18.430222] usb 1-1.3: reset high-speed USB device number 5 using orion-ehci
[   18.580823] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   18.582501] Registered led device: rt2800usb-phy0::radio
[   18.582743] Registered led device: rt2800usb-phy0::assoc
[   18.582988] Registered led device: rt2800usb-phy0::quality
[   18.583857] usbcore: registered new interface driver rt2800usb
[   19.292330] Adding 204796k swap on /dev/mapper/marv2--vg-swap.  Priority:-1 extents:1 across:204796k 
[   19.329917] EXT4-fs (dm-0): re-mounted. Opts: (null)
[   19.705413] EXT4-fs (dm-0): re-mounted. Opts: errors=remount-ro,barrier=1,acl,user_xattr
[   20.475024] FAT-fs (sda1): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
[   21.028385] NET: Registered protocol family 10
[   21.045744] Bridge firewalling registered
[   21.602264] ip_tables: (C) 2000-2006 Netfilter Core Team
[   23.741269] Netfilter messages via NETLINK v0.30.
[   23.775961] nf_conntrack version 0.5.0 (8012 buckets, 32048 max)
[   24.073410] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   24.081470] NF_TPROXY: Transparent proxy support initialized, version 4.1.0
[   24.088466] NF_TPROXY: Copyright (c) 2006-2007 BalaBit IT Ltd.
[   25.933254] xt_time: kernel timezone is -0000
[   27.270003] u32 classifier
[   27.272759]     Performance counters on
[   27.276610]     Actions configured
[   29.946935] device vethRM61Tm entered promiscuous mode
[   29.967503] ADDRCONF(NETDEV_UP): vethRM61Tm: link is not ready
[   29.987790] ADDRCONF(NETDEV_CHANGE): vethRM61Tm: link becomes ready
[   29.994197] br0: port 1(vethRM61Tm) entered forwarding state
[   29.999890] br0: port 1(vethRM61Tm) entered forwarding state
[   30.023094] device veth0Lmaat entered promiscuous mode
[   30.048885] ADDRCONF(NETDEV_UP): veth0Lmaat: link is not ready
[   30.082819] ADDRCONF(NETDEV_CHANGE): veth0Lmaat: link becomes ready
[   30.089251] br0: port 2(veth0Lmaat) entered forwarding state
[   30.094976] br0: port 2(veth0Lmaat) entered forwarding state
[   31.460084] br0: no IPv6 routers present
[   40.220065] eth0: no IPv6 routers present
[   40.500070] vethRM61Tm: no IPv6 routers present
[   40.880065] veth0Lmaat: no IPv6 routers present
[   40.930064] eth0: no IPv6 routers present
[   43.951399] EXT4-fs (dm-0): re-mounted. Opts: (null)
[   43.957458] EXT4-fs (dm-0): re-mounted. Opts: (null)
[   45.020100] br0: port 1(vethRM61Tm) entered forwarding state
[   45.100094] br0: port 2(veth0Lmaat) entered forwarding state
[   45.305751] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   45.335058] ADDRCONF(NETDEV_UP): eth1: link is not ready
[   46.647476] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   46.763116] sshd (2225): /proc/2225/oom_adj is deprecated, please use /proc/2225/oom_score_adj instead.
[   50.944916] wlan0: authenticate with 00:18:39:c8:aa:73
[   51.015105] wlan0: send auth to 00:18:39:c8:aa:73 (try 1/3)
[   51.017291] wlan0: authenticated
[   51.089893] wlan0: associate with 00:18:39:c8:aa:73 (try 1/3)
[   51.091993] wlan0: RX AssocResp from 00:18:39:c8:aa:73 (capab=0x431 status=0 aid=2)
[   51.092007] wlan0: associated
[   51.100289] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   61.499544] wlan0: no IPv6 routers present
[ 1003.437336] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: (null)
[ 1952.188562] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: (null)
[ 2002.466683] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: (null)
[ 2124.276943] lvcreate: sending ioctl 1261 to a partition!
[ 2124.282320] lvcreate: sending ioctl 1261 to a partition!
[ 2124.287685] lvcreate: sending ioctl 1261 to a partition!
