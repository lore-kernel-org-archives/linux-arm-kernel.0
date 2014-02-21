From: dashie@sigpipe.me (Dashie)
Date: Fri, 21 Feb 2014 20:21:11 +0100
Subject: Stuck getting DTS working for a new kirkwood board
In-Reply-To: <20140221151530.GZ7862@titan.lakedaemon.net>
References: <5306721B.7020403@sigpipe.me>
 <20140221013407.GX7862@titan.lakedaemon.net> <5307029C.20006@sigpipe.me>
 <20140221151530.GZ7862@titan.lakedaemon.net>
Message-ID: <5307A727.9080508@sigpipe.me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/21/2014 04:15 PM, Jason Cooper wrote:
> On Fri, Feb 21, 2014 at 08:39:08AM +0100, Dashie wrote:
>> On 02/21/2014 02:34 AM, Jason Cooper wrote:
>>> On Thu, Feb 20, 2014 at 10:22:35PM +0100, Dashie wrote:
>>>> I've done some tests using mainlineLinux and arcNumber and i remember to
>>>> got some things working (PCI-e, Intel eth) but only two drives and no
>>>> fan/sensor using arcNumber for "00000b1e    HP t5325 Thin Client       
>>>>                         2846".
>>>>
>>> Let's focus on converting this board file to devicetree.  which means
>>> you'll be setting mainlineLinux to true and arcNumber to 0xffffffff.
>>> (means booting via devicetree).
>>>
>> Actually i've unset mainlineLinux and arcNumber, so the DTB is used.
>> In fact the t5325 device is the only one which the pci-e works, but it
>> use old -setup.c files and then i'm lost with that.
>>
>>>> I've since started to use a DTS, copied the guruplug-server-plus (IIRC)
>>>> and done some changes, actually i can get working :
>>>>     - temp sensor
>>>>     - fan control (off, middle, full)
>>>>     - integrated marvell eth
>>>>     - the four disks are detected and seems working
>>> That's a good start.
>>>
>>>> But can't get the PCI-e working (and then the intel ethernet), also
>>>> sensor path seems to change every reboot (i need to do more tests).
>>>> Also i've SATA power reg enabled in the DTS but it doesn't seems to have
>>>> any (to be confirmed, the original firmware seems to have the ability to
>>>> shutdown unaccessed drives) and i will remove them, anyway i don't know
>>>> the GPIO, if any.
>>>>
>>>> I still miss some GPIOS for : Led (r/g) power, func led, the four sata
>>>> leds, maybe some triggers for hdds, and the power and func buttons.
>>>> (already tried gpio export and out direction and "1" in value, but
>>>> nothing blink)
>>>> Reset button sends things in /dev/input/input0 so it seems to works.
>>>>
>>>> The current DTS is joined to this mail, i've actually the NAS with me
>>>> and can test things. I can provide too : original dmesg (from original
>>>> firmware), current dmesg using DTS, lspci -vvv (from kernel with arcNumber).
>>>>
>>>> I'm currently using a stock 3.12.9 debian kernel and doesn't have
>>>> anymore access to the original firmware.
>>>>
>>> It would be helpful if you could build a kernel from the git repos.
>>> Have you done that before?
>>>
>> I've built a kernel from the 3.12.9 debian sources but can't get it to
>> boot, i got nothing after "Uncompressing Linux... done, booting the
>> kernel.".
> Check that you have 'earlyprintk' in your commandline, and that you set
>
> Kernel hacking
>   -> Kernel low-level debugging functions
>   -> Kernel low-level debugging port (Kernel low-level debugging via 8250 UART)
>   -> (0xf1012000) Physical base address of debug UART
>   -> (0xfde12000) Virtual base address of debug UART
>   -> (2) Register offset shift for the 8250 debug UART
>   -> Early printk
>
> Also make sure you have set 'console=ttyS0,115200n8' on the commandline
> as well.
All good, also checked for DTB append.
>> I've used the debian's kernel config file, but i can try the
>> kirkwood_defconfig make target and checking everything is activated (DTB
>> append, SATA PMP, etc.)
>> Which git repos i could try to build then ?
> We'll have you work with two repos.  Linus' mainline repo:
>
> $ cd
> $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> $ cd linux
> $ git config --add user.name "first and last"
> $ git config --add user.email "dashie at sigpipe.me"
>
> And we'll add our repo as another remote:
>
> $ git remote add mvebu git://git.infradead.org/linux-mvebu.git
> $ git remote update --prune mvebu
>
> First you should try v3.14-rc1
>
> $ git checkout -b t5325 v3.14-rc1
>
> Now, add your dts file and commit the result.  Build, boot, report back.
>
> I wold also do kirkwood_defconfig with the above that I mentioned.
Well, with kirkwood_defconfig it doesn't find the SATA PHY and panic.
So i've used my debian config, make oldconfig, built and ... the toy is
booting.

Since i've checkout the mvebu branch, i think it's better to start from
kirkwood_defconfig and activate things that starting from the debian
config, right ?

Anyway, going to play with an initrd to get rootfs on usb working.

I've attached the current dmesg to this mail.
>
> hth,
>
> Jason.
Thanks,
Dashie.
-------------- next part --------------
Bytes transferred = 8833880 (86cb58 hex)
## Booting image at 02000000 ...
   Image Name:   3.x-git-t5325__4
   Created:      2014-02-21  19:06:59 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1996116 Bytes =  1.9 MB
   Load Address: 00008000
   Entry Point:  00008000
   Verifying Checksum ... OK
OK
## Loading Ramdisk Image at 03000000 ...
   Image Name:   initramfs--3.12-1-kirkwood
   Created:      2014-02-08  17:55:26 UTC
   Image Type:   ARM Linux RAMDisk Image (gzip compressed)
   Data Size:    8833816 Bytes =  8.4 MB
   Load Address: 03000000
   Entry Point:  03000000
   Verifying Checksum ... OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.14.0-rc1+ (dashie at soarin) (gcc version 4.8.1 (Sourcery CodeBench Lite 2013.11-33) ) #2 Fri Feb 21 20:01:33 CET 2014
[    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine model: Verbatim PowerBay
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
[    0.000000] Kernel command line: mtdparts=orion_nand:0x000e0000 at 0x00000000(u-boot)ro,0x1d73c0 at 0x000e0000(uImage),0x86cb58 at 0x2b73c0(uInitrd),- at 0xb23f18(rootfs) console=ttyS0,115200n8 verbose mem=256M root=/dev/ram ip=off earlyprintk
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] allocated 524288 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] Memory: 244644K/262144K available (3774K kernel code, 319K rwdata, 1308K rodata, 194K init, 416K bss, 17500K reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc04feb4c   (5083 kB)
[    0.000000]       .init : 0xc04ff000 - 0xc052f884   ( 195 kB)
[    0.000000]       .data : 0xc0530000 - 0xc057fc40   ( 320 kB)
[    0.000000]        .bss : 0xc057fc40 - 0xc05e7e00   ( 417 kB)
[    0.000000] NR_IRQS:114
[    0.000032] sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 21474836475ns
[    0.000292] Console: colour dummy device 80x30
[    0.004856] Calibrating delay loop... 1191.93 BogoMIPS (lpj=2383872)
[    0.034901] pid_max: default: 32768 minimum: 301
[    0.039689] Security Framework initialized
[    0.043884] Yama: becoming mindful.
[    0.047521] Mount-cache hash table entries: 512
[    0.054163] Initializing cgroup subsys memory
[    0.058651] Initializing cgroup subsys devices
[    0.063187] Initializing cgroup subsys freezer
[    0.067718] Initializing cgroup subsys net_cls
[    0.072251] Initializing cgroup subsys blkio
[    0.076607] Initializing cgroup subsys perf_event
[    0.081460] CPU: Testing write buffer coherency: ok
[    0.086766] Setting up static identity map for 0x391050 - 0x39108c
[    0.094569] devtmpfs: initialized
[    0.099398] pinctrl core: initialized pinctrl subsystem
[    0.105136] regulator-dummy: no parameters
[    0.109624] NET: Registered protocol family 16
[    0.114550] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.122142] cpuidle: using governor ladder
[    0.126348] cpuidle: using governor menu
[    0.130423] Kirkwood: MV88F6281-A0.
[    0.134094] Feroceon L2: Enabling L2
[    0.137792] Feroceon L2: Cache support initialised.
[    0.143015] [Firmware Info]: /ocp at f1000000/ethernet-controller at 72000/ethernet0-port at 0: local-mac-address is not set
[    0.157058] No ATAGs?
[    0.161742] bio: create slab <bio-0> at 0
[    0.166615] vgaarb: loaded
[    0.170163] Switched to clocksource orion_clocksource
[    0.194396] NET: Registered protocol family 2
[    0.199456] TCP established hash table entries: 2048 (order: 1, 8192 bytes)
[    0.206530] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.212970] TCP: Hash tables configured (established 2048 bind 2048)
[    0.219480] TCP: reno registered
[    0.222797] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.228717] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.235236] NET: Registered protocol family 1
[    0.239904] Unpacking initramfs...
[    0.997881] Freeing initrd memory: 8620K (c3001000 - c386c000)
[    1.003873] NetWinder Floating Point Emulator V0.97 (double precision)
[    1.011337] futex hash table entries: 256 (order: -1, 2048 bytes)
[    1.017675] audit: initializing netlink subsys (disabled)
[    1.023212] audit: type=2000 audit(0.992:1): initialized
[    1.135788] VFS: Disk quotas dquot_6.5.2
[    1.139863] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.146526] jffs2: version 2.2. (NAND) (SUMMARY)  ? 2001-2006 Red Hat, Inc.
[    1.153837] msgmni has been set to 494
[    1.159497] alg: No test for stdrng (krng)
[    1.163758] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    1.171331] io scheduler noop registered
[    1.175337] io scheduler deadline registered
[    1.179712] io scheduler cfq registered (default)
[    1.185555] kirkwood-pinctrl f1010000.pinctrl: registered pinctrl driver
[    1.192627] mv_xor f1060800.xor: Marvell shared XOR driver
[    1.218225] mv_xor f1060800.xor: Marvell XOR: ( xor cpy )
[    1.242213] mv_xor f1060800.xor: Marvell XOR: ( xor cpy )
[    1.247834] mv_xor f1060900.xor: Marvell shared XOR driver
[    1.270214] mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
[    1.294213] mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
[    1.300053] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    1.307381] f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 33, base_baud = 12500000) is a 16550A
[    1.316425] console [ttyS0] enabled
[    1.316425] console [ttyS0] enabled
[    1.323522] bootconsole [earlycon0] disabled
[    1.323522] bootconsole [earlycon0] disabled
[    1.333526] mousedev: PS/2 mouse device common for all mice
[    2.342208] rtc-mv f1010300.rtc: internal RTC not ticking
[    2.347735] i2c /dev entries driver
[    2.357244] TCP: cubic registered
[    2.360651] NET: Registered protocol family 10
[    2.365781] mip6: Mobile IPv6
[    2.368793] NET: Registered protocol family 17
[    2.373281] mpls_gso: MPLS GSO support
[    2.377664] registered taskstats version 1
[    2.382654] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    2.390450] Freeing unused kernel memory: 192K (c04ff000 - c052f000)
Loading, please wait...
[    2.462758] systemd-udevd[49]: starting version 204
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
Begin: Waiting for root file system ... done.
Gave up waiting for root device.  Common problems:
 - Boot args (cat /proc/cmdline)
   - Check rootdelay= (did the system wait long enough?)
   - Check root= (did the system wait for the right device?)
 - Missing modules (cat /proc/modules; ls /dev)
ALERT!  /dev/disk/by-uuid/2922a347-7209-4983-8038-eae31b911dfa does not exist.  Dropping to a shell!
modprobe: can't change directory to '3.14.0-rc1+': No such file or directory
modprobe: can't change directory to '3.14.0-rc1+': No such file or directory
modprobe: can't change directory to '3.14.0-rc1+': No such file or directory
modprobe: can't change directory to '3.14.0-rc1+': No such file or directory
modprobe: can't change directory to '3.14.0-rc1+': No such file or directory
modprobe: can't change directory to '3.14.0-rc1+': No such file or directory
modprobe: can't change directory to '3.14.0-rc1+': No such file or directory
modprobe: can't change directory to '3.14.0-rc1+': No such file or directory


BusyBox v1.21.1 (Debian 1:1.21.0-1) built-in shell (ash)
Enter 'help' for a list of built-in commands.

/bin/sh: can't access tty; job control turned off
(initramfs) 
