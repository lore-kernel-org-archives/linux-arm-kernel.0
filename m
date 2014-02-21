From: dashie@sigpipe.me (Dashie)
Date: Fri, 21 Feb 2014 23:01:49 +0100
Subject: Stuck getting DTS working for a new kirkwood board
In-Reply-To: <20140221200855.GM7862@titan.lakedaemon.net>
References: <5306721B.7020403@sigpipe.me>
 <20140221013407.GX7862@titan.lakedaemon.net> <5307029C.20006@sigpipe.me>
 <20140221151530.GZ7862@titan.lakedaemon.net> <5307A727.9080508@sigpipe.me>
 <20140221200855.GM7862@titan.lakedaemon.net>
Message-ID: <5307CCCD.5010505@sigpipe.me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/21/2014 09:08 PM, Jason Cooper wrote:
> On Fri, Feb 21, 2014 at 08:21:11PM +0100, Dashie wrote:
>> On 02/21/2014 04:15 PM, Jason Cooper wrote:
>>> On Fri, Feb 21, 2014 at 08:39:08AM +0100, Dashie wrote:
>>>> On 02/21/2014 02:34 AM, Jason Cooper wrote:
>>>>> On Thu, Feb 20, 2014 at 10:22:35PM +0100, Dashie wrote:
>>>>>> I've done some tests using mainlineLinux and arcNumber and i remember to
>>>>>> got some things working (PCI-e, Intel eth) but only two drives and no
>>>>>> fan/sensor using arcNumber for "00000b1e    HP t5325 Thin Client       
>>>>>>                         2846".
>>>>>>
>>>>> Let's focus on converting this board file to devicetree.  which means
>>>>> you'll be setting mainlineLinux to true and arcNumber to 0xffffffff.
>>>>> (means booting via devicetree).
>>>>>
>>>> Actually i've unset mainlineLinux and arcNumber, so the DTB is used.
>>>> In fact the t5325 device is the only one which the pci-e works, but it
>>>> use old -setup.c files and then i'm lost with that.
>>>>
>>>>>> I've since started to use a DTS, copied the guruplug-server-plus (IIRC)
>>>>>> and done some changes, actually i can get working :
>>>>>>     - temp sensor
>>>>>>     - fan control (off, middle, full)
>>>>>>     - integrated marvell eth
>>>>>>     - the four disks are detected and seems working
>>>>> That's a good start.
>>>>>
>>>>>> But can't get the PCI-e working (and then the intel ethernet), also
>>>>>> sensor path seems to change every reboot (i need to do more tests).
>>>>>> Also i've SATA power reg enabled in the DTS but it doesn't seems to have
>>>>>> any (to be confirmed, the original firmware seems to have the ability to
>>>>>> shutdown unaccessed drives) and i will remove them, anyway i don't know
>>>>>> the GPIO, if any.
>>>>>>
>>>>>> I still miss some GPIOS for : Led (r/g) power, func led, the four sata
>>>>>> leds, maybe some triggers for hdds, and the power and func buttons.
>>>>>> (already tried gpio export and out direction and "1" in value, but
>>>>>> nothing blink)
>>>>>> Reset button sends things in /dev/input/input0 so it seems to works.
>>>>>>
>>>>>> The current DTS is joined to this mail, i've actually the NAS with me
>>>>>> and can test things. I can provide too : original dmesg (from original
>>>>>> firmware), current dmesg using DTS, lspci -vvv (from kernel with arcNumber).
>>>>>>
>>>>>> I'm currently using a stock 3.12.9 debian kernel and doesn't have
>>>>>> anymore access to the original firmware.
>>>>>>
>>>>> It would be helpful if you could build a kernel from the git repos.
>>>>> Have you done that before?
>>>>>
>>>> I've built a kernel from the 3.12.9 debian sources but can't get it to
>>>> boot, i got nothing after "Uncompressing Linux... done, booting the
>>>> kernel.".
>>> Check that you have 'earlyprintk' in your commandline, and that you set
>>>
>>> Kernel hacking
>>>   -> Kernel low-level debugging functions
>>>   -> Kernel low-level debugging port (Kernel low-level debugging via 8250 UART)
>>>   -> (0xf1012000) Physical base address of debug UART
>>>   -> (0xfde12000) Virtual base address of debug UART
>>>   -> (2) Register offset shift for the 8250 debug UART
>>>   -> Early printk
>>>
>>> Also make sure you have set 'console=ttyS0,115200n8' on the commandline
>>> as well.
>> All good, also checked for DTB append.
>>>> I've used the debian's kernel config file, but i can try the
>>>> kirkwood_defconfig make target and checking everything is activated (DTB
>>>> append, SATA PMP, etc.)
>>>> Which git repos i could try to build then ?
>>> We'll have you work with two repos.  Linus' mainline repo:
>>>
>>> $ cd
>>> $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>> $ cd linux
>>> $ git config --add user.name "first and last"
>>> $ git config --add user.email "dashie at sigpipe.me"
>>>
>>> And we'll add our repo as another remote:
>>>
>>> $ git remote add mvebu git://git.infradead.org/linux-mvebu.git
>>> $ git remote update --prune mvebu
>>>
>>> First you should try v3.14-rc1
>>>
>>> $ git checkout -b t5325 v3.14-rc1
>>>
>>> Now, add your dts file and commit the result.  Build, boot, report back.
>>>
>>> I wold also do kirkwood_defconfig with the above that I mentioned.
>>>
>> Well, with kirkwood_defconfig it doesn't find the SATA PHY and panic.
>> So i've used my debian config, make oldconfig, built and ... the toy is
>> booting.
> Yes, this is a known issue.  You worked around it by enabling generic
> phy support (it's most likely in the other configs).
>
>> Since i've checkout the mvebu branch,
> ?  I'm confused.  You should be on v3.14-rc1 with your dts file change
> on top.
Err yes exactly.
>> i think it's better to start from kirkwood_defconfig and activate
>> things that starting from the debian config, right ?
> Yes, we use kirkwood_defconfig for testing here so it should be a good,
> up-to-date minimal config for starting from (with the exception of the
> above bug).  Debian's config, by necessity is much bigger.
>
>> Anyway, going to play with an initrd to get rootfs on usb working.
> Looks like you just need to add some modules or compile them in.
>
> thx,
>
> Jason.
I restarted from the defconfig kirkwood, activated some builtin stuff
(USB / e1000) and it boots perfectly.
Sata and fan doesn't seems to be detected, but i got PCI-e with intel
eth detected this time.
'will see tomorrow about SATA part.

Thanks,
Dashie.

-------------- next part --------------
Bytes transferred = 3406619 (33fb1b hex)
## Booting image at 02000000 ...
   Image Name:   3.x-git-t5325__5
   Created:      2014-02-21  21:54:13 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3406555 Bytes =  3.2 MB
   Load Address: 00008000
   Entry Point:  00008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.14.0-rc1-dirty (dashie at soarin) (gcc version 4.8.1 (Sourcery CodeBench Lite 2013.11-33) ) #8 PREEMPT Fri Feb 21 22:49:34 CET 2014
CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
CPU: VIVT data cache, VIVT instruction cache
Machine model: Verbatim PowerBay
bootconsole [earlycon0] enabled
Memory policy: Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: mtdparts=orion_nand:0x000e0000 at 0x00000000(u-boot)ro,0x1d73c0 at 0x000e0000(uImage),0x86cb58 at 0x2b73c0(uInitrd),- at 0xb23f18(rootfs) console=ttyS0,115200n8 verbose mem=256M root=/dev/sda2 rootdelay=8 ip=off earlyprintk
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 252524K/262144K available (4903K kernel code, 253K rwdata, 1320K rodata, 153K init, 630K bss, 9620K reserved, 0K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .text : 0xc0008000 - 0xc061c1d8   (6225 kB)
      .init : 0xc061d000 - 0xc064377c   ( 154 kB)
      .data : 0xc0644000 - 0xc06835a0   ( 254 kB)
       .bss : 0xc06835ac - 0xc0721144   ( 631 kB)
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Preemptible hierarchical RCU implementation.
NR_IRQS:114
sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 21474836475ns
Console: colour dummy device 80x30
Calibrating delay loop... 1191.11 BogoMIPS (lpj=5955584)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x4ab1a0 - 0x4ab1f8
devtmpfs: initialized
pinctrl core: initialized pinctrl subsystem
regulator-dummy: no parameters
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
cpuidle: using governor ladder
cpuidle: using governor menu
Kirkwood: MV88F6281-A0.
Feroceon L2: Enabling L2
Feroceon L2: Cache support initialised.
[Firmware Info]: /ocp at f1000000/ethernet-controller at 72000/ethernet0-port at 0: local-mac-address is not set
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
cfg80211: Calling CRDA to update world regulatory domain
Switched to clocksource orion_clocksource
NET: Registered protocol family 2
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
futex hash table entries: 256 (order: -1, 2048 bytes)
jffs2: version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
msgmni has been set to 493
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
kirkwood-pinctrl f1010000.pinctrl: registered pinctrl driver
mvebu-pcie pcie-controller.1: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
pci_bus 0000:00: root bus resource [mem 0xe0000000-0xf0000000]
pci_bus 0000:00: root bus resource [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus1: Fast back to back transfers disabled
pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe00fffff]
pci 0000:00:01.0: BAR 7: assigned [io  0x10000-0x10fff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xe0000000-0xe001ffff]
pci 0000:01:00.0: BAR 3: assigned [mem 0xe0020000-0xe0023fff]
pci 0000:01:00.0: BAR 2: assigned [io  0x10000-0x1001f]
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:01.0:   bridge window [io  0x10000-0x10fff]
pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe00fffff]
mv_xor f1060800.xor: Marvell shared XOR driver
mv_xor f1060800.xor: Marvell XOR: ( xor cpy )
mv_xor f1060800.xor: Marvell XOR: ( xor cpy )
mv_xor f1060900.xor: Marvell shared XOR driver
mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 33, base_baud = 12500000) is a 16550A
console [ttyS0] enabled
console [ttyS0] enabled
bootconsole [earlycon0] disabled
bootconsole [earlycon0] disabled
loop: module loaded
e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
e1000e: Copyright(c) 1999 - 2013 Intel Corporation.
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
e1000e 0000:01:00.0 eth0: registered PHC clock
e1000e 0000:01:00.0 eth0: (PCI Express:2.5GT/s:Width x1) 00:a0:b0:a1:01:79
e1000e 0000:01:00.0 eth0: Intel(R) PRO/1000 Network Connection
e1000e 0000:01:00.0 eth0: MAC: 3, PHY: 8, PBA No: FFFFFF-0FF
libphy: orion_mdio_bus: probed
mv643xx_eth: MV-643xx 10/100/1000 ethernet driver version 1.4
mv643xx_eth_port mv643xx_eth_port.0 eth1: port 0 with MAC address 00:50:43:3c:3b:5d
libertas_sdio: Libertas SDIO driver
libertas_sdio: Copyright Pierre Ossman
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-orion: EHCI orion driver
orion-ehci f1050000.ehci: EHCI Host Controller
orion-ehci f1050000.ehci: new USB bus registered, assigned bus number 1
orion-ehci f1050000.ehci: irq 24, io mem 0xf1050000
orion-ehci f1050000.ehci: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usbcore: registered new interface driver usb-storage
usbcore: registered new interface driver ums-datafab
usbcore: registered new interface driver ums-freecom
usbcore: registered new interface driver ums-jumpshot
usbcore: registered new interface driver ums-sddr09
usbcore: registered new interface driver ums-sddr55
mousedev: PS/2 mouse device common for all mice
usb 1-1: new high-speed USB device number 2 using orion-ehci
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 2 ports detected
usb 1-1.2: new high-speed USB device number 3 using orion-ehci
usb-storage 1-1.2:1.0: USB Mass Storage device detected
scsi0 : usb-storage 1-1.2:1.0
rtc-mv f1010300.rtc: internal RTC not ticking
i2c /dev entries driver
lm75 0-0049: hwmon0: sensor 'lm75'
orion_wdt: Initial timeout 21 sec
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
oprofile: no performance counters
oprofile: using timer interrupt.
TCP: cubic registered
NET: Registered protocol family 17
lib80211: common routines for IEEE802.11 drivers
input: gpio_keys.3 as /devices/gpio_keys.3/input/input0
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Waiting 8 sec before mounting root device...
scsi 0:0:0:0: Direct-Access     SanDisk  Cruzer Orbit     1.27 PQ: 0 ANSI: 6
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] 15633408 512-byte logical blocks: (8.00 GB/7.45 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 < sda5 >
sd 0:0:0:0: [sda] Attached SCSI disk
EXT3-fs (sda2): error: couldn't mount because of unsupported optional features (240)
EXT2-fs (sda2): error: couldn't mount because of unsupported optional features (240)
EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
devtmpfs: mounted
Freeing unused kernel memory: 152K (c061d000 - c0643000)
Mount failed for selinuxfs on /sys/fs/selinux:  No such file or directory
INIT: version 2.88 booting
[info] Using makefile-style concurrent boot in runlevel S.
findfs: unable to resolve 'UUID=2922a347-7209-4983-8038-eae31b911dfa'
[....] Starting the hotplug events dispatcher: udevdsystemd-udevd[771]: starting version 204
. ok 
[....] Synthesizing the initial hotplug events...systemd-udevd[795]: renamed network interface eth1 to rename3
done.
[....] Waiting for /dev to be fully populated...systemd-udevd[792]: renamed network interface eth0 to eth2
systemd-udevd[795]: renamed network interface rename3 to eth0
done.
[....] Activating swap...Adding 383996k swap on /dev/sda5.  Priority:-1 extents:1 across:383996k 
done.
EXT4-fs (sda2): re-mounted. Opts: (null)
[....] Checking root file system...fsck from util-linux 2.20.1
/dev/sda2: clean, 108733/449680 files, 582150/1795328 blocks
done.
random: nonblocking pool is initialized
EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[ ok ] Cleaning up temporary files... /tmp.
[ ok ] Activating lvm and md swap...done.
[....] Checking file systems...fsck from util-linux 2.20.1
/dev/sda1: clean, 17/124496 files, 27791/248832 blocks
done.
[ ok ] Mounting local filesystems...done.
[ ok ] Activating swapfile swap...done.
[ ok ] Cleaning up temporary files....
[ ok ] Setting kernel variables ...done.
[ ok ] Configuring network interfaces...done.
[....] Starting rpcbind daemon...rpcbind: cannot create socket for udp6
rpcbind: cannot create socket for tcp6
. ok 
[ ok ] Starting NFS common utilities: statd idmapd.
[ ok ] Cleaning up temporary files....
[ ok ] Setting sensors limits.
[ ok ] Starting qcontrol daemon: qcontrol.
[ ok ] Setting up X socket directories... /tmp/.X11-unix /tmp/.ICE-unix.
INIT: Entering runlevel: 2
[info] Using makefile-style concurrent boot in runlevel 2.
[ ok ] Starting fan speed regulator: fancontrol.
[ ok ] Starting NFS common utilities: statd idmapd.
[warn] Not starting NFS kernel daemon: no exports. ... (warning).
mv643xx_eth_port mv643xx_eth_port.0 eth0: link up, 100 Mb/s, full duplex, flow control disabled
[ ok ] Starting NetBIOS name server: nmbd.
[ ok ] Starting enhanced syslogd: rsyslogd.
[ ok ] Starting deferred execution scheduler: atd.
[ ok ] Starting periodic command scheduler: cron.
[ ok ] Starting system message bus: dbus.
[ ok ] Starting MTA: exim4.
ALERT: exim paniclog /var/log/exim4/paniclog has non-zero size, mail system possibly broken
[ ok ] Starting sensor daemon: sensord.
[ ok ] Starting SMB/CIFS daemon: smbd.
[ ok ] Starting OpenBSD Secure Shell server: sshd.
[ ok ] Starting the Winbind daemon: winbind.
[info] System boot completed.
Error connecting to socket: No such file or directory

Debian GNU/Linux jessie/sid debian ttyS0

debian login: root
Password: 
Last login: Fri Feb 21 22:50:56 CET 2014 on ttyS0
Linux debian 3.14.0-rc1-dirty #8 PREEMPT Fri Feb 21 22:49:34 CET 2014 armv5tel

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
ifroot at debian:~# ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:50:43:3c:3b:5d  
          inet addr:192.168.1.137  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:73 errors:0 dropped:0 overruns:0 frame:0
          TX packets:93 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:7219 (7.0 KiB)  TX bytes:9313 (9.0 KiB)
          Interrupt:31 

eth2      Link encap:Ethernet  HWaddr 00:a0:b0:a1:01:79  
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
          Interrupt:25 Memory:e0000000-e0020000 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:2 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:100 (100.0 B)  TX bytes:100 (100.0 B)

root at debian:~#  lspci
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
