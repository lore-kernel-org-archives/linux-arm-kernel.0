From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Fri, 8 Apr 2016 08:45:15 +0200
Subject: 4.4 BCM5301X ARM regression "External imprecise Data abort"
In-Reply-To: <5702DB4D.5070203@hauke-m.de>
References: <CACna6rz=KE_FtNtrSKmcYE514s4-dgrnx=iGbN7JDXkQPd6bTw@mail.gmail.com>
 <5702D7DD.2080205@broadcom.com> <5702DB4D.5070203@hauke-m.de>
Message-ID: <CACna6rwVR3mBqHbxq-J3wPqOiajsxatAQfzH0hb1SYjc-cmx8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2016 at 23:23, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 04/04/2016 11:08 PM, Scott Branden wrote:
>> On 16-04-03 11:13 PM, Rafa? Mi?ecki wrote:
>>> I got regression reports from Netgear R8000 (BCM4709A0) users and did
>>> some testing & regression tracking with Aditya.
>>>
>>> It happens that Linux 4.4 doesn't boot due to the following commits:
>>> bbeb920 ("ARM: 8422/1: enable imprecise aborts during early kernel
>>> startup")
>>> 9254970 ("ARM: 8447/1: catch pending imprecise abort on unmask")
>>> 937b123 ("ARM: BCM5301X: remove workaround imprecise abort fault
>>> handler")
>>>
>>> In kernel 4.3 we got that abort workaround which was resulting in:
>>> [    5.007128] Freeing unused kernel memory: 212K (c0435000 - c046a000)
>>> [    5.694632] init: Console is alive
>>> [    5.698169] init: - watchdog -
>>> [    5.701470] External imprecise Data abort at addr=0x0, fsr=0x1406
>>> ignored.
>>> As you can see, this abort was happening soon after freeing unused
>>> memory and ignoring it *once* did the trick. It was never appearing
>>> again.
>
> I assume it only can throw one of these and if it is deactivated it will
> ignore the next one or overwrite it. So it could be that more than one
> is thrown here.
>
>>> With 4.4 similar (or the same?) abort happens earlier (during PCI host
>>> driver init) and doesn't get ignored:
>>> [    2.478461] pci 0000:00:00.0: PCI bridge to [bus 01]
>>> [    2.483451] pci 0000:00:00.0:   bridge window [mem
>>> 0x08000000-0x085fffff]
>>> [    2.599449] pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
>>> [    2.605744] pci_bus 0001:00: root bus resource [mem
>>> 0x40000000-0x47ffffff]
>>> [    2.612657] pcie_iproc_bcma bcma0:8: link: UP
>>> [    2.617241] PCI: bus0: Fast back to back transfers disabled
>>> [    2.622845] pci 0001:00:00.0: bridge configuration invalid ([bus
>>> 00-00]), reconfiguring
>>> [    2.631297] PCI: bus1: Fast back to back transfers disabled
>>> [    2.636887] pci 0001:01:00.0: bridge configuration invalid ([bus
>>> 00-00]), reconfiguring
>>> [    2.645035] Unhandled fault: imprecise external abort (0x1406) at
>>> 0x00000000
>>> (see 4.4.txt for the backtrace)
>>>
>>> At first I was hoping that we simply need to re-add the removed
>>> workaround. I tried it but it appeared that one abort is immediately
>>> followed by another:
>>> [    2.936895] pci 0001:01:00.0: bridge configuration invalid ([bus
>>> 00-00]), reconfiguring
>>> [    2.945053] External imprecise Data abort at addr=0x0, fsr=0x1406
>>> ignored.
>>> [    2.951966] Unhandled fault: imprecise external abort (0x1406) at
>>> 0x00000000
>>>
>>> So it seems that commits bbeb920 and 9254970 broke something in PCI
>>> host initialization (or maybe just exposed another bug?). Instead of
>>> getting an abort once and late we are getting now many of them and a
>>> bit earlier.
>
> These commits mad the kernel earlier "listen" to such errors, so that
> they will be shown at the time they occur and not sometime later.

So AFAIU with kernel 4.3:
1) Aborts were masked (silent) until "Freeing unused kernel memory"
2) There was one (silent) abort caused by a bootloader
3) There were likely multiple aborts (silent) during early PCI init
4) After unmasking we got only a single abort reported and we were ignoring it

With kernel 4.4:
1) All aborts are reported immediately
2) Abort caused by a bootloader gets ignored by ARM code:
"Hit pending asynchronous external abort (FSR=0x00001c06) during first unmask"
thanks to 9254970 ("ARM: 8447/1: catch pending imprecise abort on unmask")
3) There are still multiple aborts during PCI init (reported immediately now)
4) To work as before (in 4.3) we should ignore all aborts, not only the 1st one

Of course proposed solution is an ugly workaround, we should have no
aborts reported in the first place.


>> We do not observe such issues in Cygnus and other SoCs that use this
>> PCIe driver (we do not use bcma either - I do not know if that is related).
>>>
>>> Reverting all three commits from the top of 4.4.6 gives me back a
>>> working & booting kernel.
>>>
>>> Do you have any idea how to fix this regression (and hopefully
>>> original problem as well)?
>> I think the proper fix is to correct the issues in the bootloader.  It
>> was my understanding from Jon Mason that this is the root of the
>> original problem.
>>>
>
> I think this is a new problem.
>
> In the Broadcom SDK was a comment saying that probably the bootloader is
> broken and that causes this fault which was worked around in the
> mainline kernel with the fault handler in the brcm code.

There is some issue with bootloader indeed, but with kernel 4.4 we
seem to have it handled by ARM arch code. There is now this nice
workaround I see when booting 4.4:
[    0.000000] Hit pending asynchronous external abort
(FSR=0x00001c06) during first unmask, this is most likely caused by a
firmware/bootloader bug.

It seems we were lucky so far (in 4.3 and older) thanks for all aborts
being squashed into a single one. We meant to ignore bootloader caused
abort but we were also ignoring many more aborts triggered by iproc.


> When I added the code Arnd asked me if this SoC has a PCIe controller
> because he saw such a problem on an other SoC with a PCIe controller.
> https://www.spinics.net/lists/arm-kernel/msg298112.html
>
> As this is now happening in the PCIe code I assume that this has
> something to do with PCIe. ;-)
>
> Have you tried to deactivate PCIe support in Device tree and see what
> happens? Have you tried to load the PCIe controller as a module later on
> so if that makes a difference?

So this definitely looks like something PCIe related. I modified
OpenWrt config to build iproc as module and load it late.

As said earlier I got this early on-unmask abort handled nicely by ARM
arch code:
[    0.000000] Hit pending asynchronous external abort
(FSR=0x00001c06) during first unmask, this is most likely caused by a
firmware/bootloader bug.

Then many modules load nicely, I'm seeing:
[    2.959868] Freeing unused kernel memory: 212K (c0443000 - c0478000)
without any abort at this point.

And it goes cleanly farther until loading pcie-iproc-bcma.ko. At some
point PCIe initialization starts triggering aborts:
[   10.547032] pci 0001:01:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[   10.555199] External imprecise Data abort at addr=0x1c6e00f,
fsr=0x1406 ignored.
[   10.562635] Unhandled fault: imprecise external abort (0x1406) at 0x01c6e00f
(backtrace here, see 4.4-iproc-module.txt)

With kernel 4.3 the same place of PCIe init looked like this:
[    2.926866] pci 0001:01:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    2.935051] pci 0001:02:00.0: unknown header type 12, ignoring device
[    2.942154] pci 0001:02:03.0: [Firmware Bug]: reg 0x10: invalid BAR
(can't size)
[    2.949595] pci 0001:02:03.0: [Firmware Bug]: reg 0x14: invalid BAR
(can't size)
[    2.957014] pci 0001:02:03.0: [Firmware Bug]: reg 0x18: invalid BAR
(can't size)
(...)


Arnd: did you find any solution for that aborts triggered during PCIe init?

-- 
Rafa?
-------------- next part --------------
CFE for Foxconn Router R8000 version: v1.0.8
Build Date: Fri May 30 15:03:06 CST 2014 
Init Arena
Init Devs.
Boot up from NAND flash...
Bootcode Boot partition size = 524288(0x80000)
DDR Clock: 800 MHz
Info: DDR frequency set from clkfreq=1000,*800*
et2: Broadcom BCM47XX 10/100/1000 Mbps Ethernet Controller 7.14.43.2 (r474543)
CPU type 0x0: 1000MHz
Tot mem: 262144 KBytes

Device eth0:  hwaddr E8-FC-AF-FD-EE-2E, ipaddr 192.168.1.1, mask 255.255.255.0
        gateway not set, nameserver not set
Checking crc...Loader:raw Filesys:raw Dev:nflash0.os File: Options:(null)
Loading: .. 1513840 bytes read
Entry at 0x00008000
Closing network.
Starting program at 0x00008000
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.4.6 (zajec at linux-samsung.lan) (gcc version 5.3.0 (OpenWrt GCC 5.3.0 r48934) ) #9 SMP Thu Apr 7 21:02:01 UTC 2016
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: Netgear R8000 (BCM4709)
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Hit pending asynchronous external abort (FSR=0x00001c06) during first unmask, this is most likely caused by a firmware/bootloader bug.
[    0.000000] PERCPU: Embedded 11 pages/cpu @c6dcf000 s12928 r8192 d23936 u45056
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65280
[    0.000000] Kernel command line: console=ttyS0,115200 earlyprintk
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 254856K/262144K available (3150K kernel code, 101K rwdata, 1180K rodata, 212K init, 280K bss, 7288K reserved, 0K cma-reserved, 131072K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff800000   ( 880 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0442e54   (4332 kB)
[    0.000000]       .init : 0xc0443000 - 0xc0478000   ( 212 kB)
[    0.000000]       .data : 0xc0478000 - 0xc049142c   ( 102 kB)
[    0.000000]        .bss : 0xc049142c - 0xc04d75ec   ( 281 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C: DT/platform modifies aux control register: 0x0a130000 -> 0x0a530000
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 1 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 256 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x7e530001
[    0.000011] sched_clock: 64 bits at 500MHz, resolution 2ns, wraps every 4398046511103ns
[    0.008132] clocksource: arm_global_timer: mask: 0xffffffffffffffff max_cycles: 0xe6a171a037, max_idle_ns: 881590485102 ns
[    0.019400] Calibrating delay loop... 1987.37 BogoMIPS (lpj=9936896)
[    0.082231] pid_max: default: 32768 minimum: 301
[    0.087003] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.093731] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.101266] CPU: Testing write buffer coherency: ok
[    0.106451] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.112288] Setting up static identity map for 0x82a0 - 0x82d4
[    0.179380] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.179446] Brought up 2 CPUs
[    0.188264] SMP: Total of 2 processors activated (3981.31 BogoMIPS).
[    0.194726] CPU: WARNING: CPU(s) started in wrong/inconsistent modes (primary CPU mode 0x13)
[    0.203273] CPU: This may indicate a broken bootloader or firmware.
[    0.211132] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.221160] pinctrl core: initialized pinctrl subsystem
[    0.226827] NET: Registered protocol family 16
[    0.231960] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.271185] clocksource: Switched to clocksource arm_global_timer
[    0.278220] NET: Registered protocol family 2
[    0.283143] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.290287] TCP bind hash table entries: 1024 (order: 1, 8192 bytes)
[    0.296754] TCP: Hash tables configured (established 1024 bind 1024)
[    0.303282] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.309231] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.315792] NET: Registered protocol family 1
[    0.321086] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.331696] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.337641] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME) (CMODE_PRIORITY) (c) 2001-2006 Red Hat, Inc.
[    0.348827] bounce: pool size: 64 pages
[    0.352801] io scheduler noop registered
[    0.356820] io scheduler deadline registered (default)
[    0.362405] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    0.369450] console [ttyS0] disabled
[    0.373155] 18000300.serial: ttyS0 at MMIO 0x18000300 (irq = 18, base_baud = 7812500) is a 16550
[    0.382083] console [ttyS0] enabled
[    0.382083] console [ttyS0] enabled
[    0.389159] bootconsole [earlycon0] disabled
[    0.389159] bootconsole [earlycon0] disabled
[    0.398924] nand: Could not find valid ONFI parameter page; aborting
[    0.405389] nand: device found, Manufacturer ID: 0x01, Chip ID: 0xf1
[    0.411781] nand: AMD/Spansion NAND 128MiB 3,3V 8-bit
[    0.416850] nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    0.424476] iproc_nand 18028000.nand: detected 128MiB total, 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-8
[    0.434435] Scanning device for bad blocks
[    1.065063] random: nonblocking pool is initialized
[    1.664239] mtd_read error while parsing (offset: 0x7580000): -74
[    1.670727] mtd_read error while parsing (offset: 0x75A0000): -74
[    1.677200] mtd_read error while parsing (offset: 0x75C0000): -74
[    1.683685] mtd_read error while parsing (offset: 0x75E0000): -74
[    1.690169] mtd_read error while parsing (offset: 0x7600000): -74
[    1.696644] mtd_read error while parsing (offset: 0x7620000): -74
[    1.703131] mtd_read error while parsing (offset: 0x7640000): -74
[    1.709614] mtd_read error while parsing (offset: 0x7660000): -74
[    1.716089] mtd_read error while parsing (offset: 0x7680000): -74
[    1.722574] mtd_read error while parsing (offset: 0x76A0000): -74
[    1.729050] mtd_read error while parsing (offset: 0x76C0000): -74
[    1.735534] mtd_read error while parsing (offset: 0x76E0000): -74
[    1.742020] mtd_read error while parsing (offset: 0x7700000): -74
[    1.748495] mtd_read error while parsing (offset: 0x7720000): -74
[    1.754980] mtd_read error while parsing (offset: 0x7740000): -74
[    1.761464] mtd_read error while parsing (offset: 0x7760000): -74
[    1.767938] mtd_read error while parsing (offset: 0x7780000): -74
[    1.774424] mtd_read error while parsing (offset: 0x77A0000): -74
[    1.780907] mtd_read error while parsing (offset: 0x77C0000): -74
[    1.787383] mtd_read error while parsing (offset: 0x77E0000): -74
[    1.793875] mtd_read error while parsing (offset: 0x7800000): -74
[    1.800361] mtd_read error while parsing (offset: 0x7820000): -74
[    1.806836] mtd_read error while parsing (offset: 0x7840000): -74
[    1.813323] mtd_read error while parsing (offset: 0x7860000): -74
[    1.819805] mtd_read error while parsing (offset: 0x7880000): -74
[    1.826281] mtd_read error while parsing (offset: 0x78A0000): -74
[    1.832767] mtd_read error while parsing (offset: 0x78C0000): -74
[    1.839241] mtd_read error while parsing (offset: 0x78E0000): -74
[    1.845728] mtd_read error while parsing (offset: 0x7900000): -74
[    1.852212] mtd_read error while parsing (offset: 0x7920000): -74
[    1.858686] mtd_read error while parsing (offset: 0x7940000): -74
[    1.865173] mtd_read error while parsing (offset: 0x7960000): -74
[    1.871656] mtd_read error while parsing (offset: 0x7980000): -74
[    1.878131] mtd_read error while parsing (offset: 0x79A0000): -74
[    1.884616] mtd_read error while parsing (offset: 0x79C0000): -74
[    1.891100] mtd_read error while parsing (offset: 0x79E0000): -74
[    1.897579] mtd_read error while parsing (offset: 0x7A00000): -74
[    1.904062] mtd_read error while parsing (offset: 0x7A20000): -74
[    1.910545] mtd_read error while parsing (offset: 0x7A40000): -74
[    1.917021] mtd_read error while parsing (offset: 0x7A60000): -74
[    1.923509] mtd_read error while parsing (offset: 0x7A80000): -74
[    1.929989] mtd_read error while parsing (offset: 0x7AA0000): -74
[    1.936465] mtd_read error while parsing (offset: 0x7AC0000): -74
[    1.942952] mtd_read error while parsing (offset: 0x7AE0000): -74
[    1.949434] mtd_read error while parsing (offset: 0x7B00000): -74
[    1.955910] mtd_read error while parsing (offset: 0x7B20000): -74
[    1.962396] mtd_read error while parsing (offset: 0x7B40000): -74
[    1.968870] mtd_read error while parsing (offset: 0x7B60000): -74
[    1.975356] mtd_read error while parsing (offset: 0x7B80000): -74
[    1.981841] mtd_read error while parsing (offset: 0x7BA0000): -74
[    1.988314] mtd_read error while parsing (offset: 0x7BC0000): -74
[    1.994802] mtd_read error while parsing (offset: 0x7BE0000): -74
[    2.001286] mtd_read error while parsing (offset: 0x7C00000): -74
[    2.007760] mtd_read error while parsing (offset: 0x7C20000): -74
[    2.014246] mtd_read error while parsing (offset: 0x7C40000): -74
[    2.020728] mtd_read error while parsing (offset: 0x7C60000): -74
[    2.027204] mtd_read error while parsing (offset: 0x7C80000): -74
[    2.033690] mtd_read error while parsing (offset: 0x7CA0000): -74
[    2.040173] mtd_read error while parsing (offset: 0x7CC0000): -74
[    2.046649] mtd_read error while parsing (offset: 0x7CE0000): -74
[    2.053138] mtd_read error while parsing (offset: 0x7D00000): -74
[    2.059670] mtd_read error while parsing (offset: 0x7D20000): -74
[    2.066150] mtd_read error while parsing (offset: 0x7D40000): -74
[    2.072640] mtd_read error while parsing (offset: 0x7D60000): -74
[    2.079116] mtd_read error while parsing (offset: 0x7D80000): -74
[    2.085603] mtd_read error while parsing (offset: 0x7DA0000): -74
[    2.092085] mtd_read error while parsing (offset: 0x7DC0000): -74
[    2.098559] mtd_read error while parsing (offset: 0x7DE0000): -74
[    2.105049] mtd_read error while parsing (offset: 0x7E00000): -74
[    2.111540] mtd_read error while parsing (offset: 0x7E20000): -74
[    2.118013] mtd_read error while parsing (offset: 0x7E40000): -74
[    2.124500] mtd_read error while parsing (offset: 0x7E60000): -74
[    2.130983] mtd_read error while parsing (offset: 0x7E80000): -74
[    2.137458] mtd_read error while parsing (offset: 0x7EA0000): -74
[    2.143944] mtd_read error while parsing (offset: 0x7EC0000): -74
[    2.150427] mtd_read error while parsing (offset: 0x7EE0000): -74
[    2.156903] mtd_read error while parsing (offset: 0x7F00000): -74
[    2.163389] mtd_read error while parsing (offset: 0x7F20000): -74
[    2.169872] mtd_read error while parsing (offset: 0x7F40000): -74
[    2.176347] mtd_read error while parsing (offset: 0x7F60000): -74
[    2.182835] mtd_read error while parsing (offset: 0x7F80000): -74
[    2.189308] mtd_read error while parsing (offset: 0x7FA0000): -74
[    2.196464] mtd_read error while parsing (offset: 0x7FE0000): -74
[    2.203578] 17 bcm47xxpart partitions found on MTD device brcmnand.0
[    2.209951] Creating 17 MTD partitions on "brcmnand.0":
[    2.215195] 0x000000000000-0x000000080000 : "boot"
[    2.220727] 0x000000080000-0x000000200000 : "nvram"
[    2.226227] 0x000000200000-0x000002600000 : "firmware"
[    2.232436] 0x00000020001c-0x000000600000 : "linux"
[    2.238005] 0x000000600000-0x000002600000 : "ubi"
[    2.243480] 0x000002600000-0x000002680000 : "board_data"
[    2.249500] 0x000002680000-0x0000026a0000 : "POT"
[    2.254929] 0x0000026a0000-0x000002780000 : "POT"
[    2.260380] 0x000002780000-0x0000027a0000 : "POT"
[    2.265783] 0x0000027a0000-0x000002e00000 : "POT"
[    2.271276] 0x000002e00000-0x000002e80000 : "ML"
[    2.276610] 0x000002e80000-0x000002f00000 : "ML"
[    2.281948] 0x000002f00000-0x000002f80000 : "ML"
[    2.287255] 0x000002f80000-0x000003000000 : "ML"
[    2.292664] 0x000003000000-0x000003080000 : "ML"
[    2.297986] 0x000003080000-0x000003100000 : "ML"
[    2.303374] 0x000003100000-0x000008000000 : "ML"
[    2.309317] libphy: Fixed MDIO Bus: probed
[    2.313534] bgmac: Broadcom 47xx GBit MAC driver loaded
[    2.318932] bcma: bus0: Found chip with id 53010, rev 0x00 and package 0x00
[    2.325997] bcma: bus0: Core 0 found: ChipCommon (manuf 0x4BF, id 0x800, rev 0x2A, class 0x0)
[    2.334647] bcma: bus0: Core 1 found: Chipcommon B (manuf 0x4BF, id 0x50B, rev 0x01, class 0x0)
[    2.343458] bcma: bus0: Core 2 found: DMA (manuf 0x4BF, id 0x502, rev 0x01, class 0x0)
[    2.351483] bcma: bus0: Core 3 found: GBit MAC (manuf 0x4BF, id 0x82D, rev 0x05, class 0x0)
[    2.359929] bcma: bus0: Core 4 found: GBit MAC (manuf 0x4BF, id 0x82D, rev 0x05, class 0x0)
[    2.368385] bcma: bus0: Core 5 found: GBit MAC (manuf 0x4BF, id 0x82D, rev 0x05, class 0x0)
[    2.376845] bcma: bus0: Core 6 found: GBit MAC (manuf 0x4BF, id 0x82D, rev 0x05, class 0x0)
[    2.385268] bcma: bus0: Core 7 found: PCIe Gen 2 (manuf 0x4BF, id 0x501, rev 0x01, class 0x0)
[    2.393875] bcma: bus0: Core 8 found: PCIe Gen 2 (manuf 0x4BF, id 0x501, rev 0x01, class 0x0)
[    2.402493] bcma: bus0: Core 9 found: PCIe Gen 2 (manuf 0x4BF, id 0x501, rev 0x01, class 0x0)
[    2.411136] bcma: bus0: Core 10 found: ARM Cortex A9 core (ihost) (manuf 0x4BF, id 0x510, rev 0x01, class 0x0)
[    2.421236] bcma: bus0: Core 11 found: USB 2.0 (manuf 0x4BF, id 0x504, rev 0x01, class 0x0)
[    2.429678] bcma: bus0: Core 12 found: USB 3.0 (manuf 0x4BF, id 0x505, rev 0x01, class 0x0)
[    2.438129] bcma: bus0: Core 13 found: SDIO3 (manuf 0x4BF, id 0x503, rev 0x01, class 0x0)
[    2.446417] bcma: bus0: Core 14 found: I2S (manuf 0x4BF, id 0x834, rev 0x03, class 0x0)
[    2.454532] bcma: bus0: Core 15 found: ARM Cortex A9 JTAG (manuf 0x4BF, id 0x506, rev 0x01, class 0x0)
[    2.463947] bcma: bus0: Core 16 found: Denali DDR2/DDR3 memory controller (manuf 0x4BF, id 0x507, rev 0x01, class 0x0)
[    2.474754] bcma: bus0: Core 17 found: ROM (manuf 0x4BF, id 0x508, rev 0x01, class 0x0)
[    2.482873] bcma: bus0: Core 18 found: NAND flash controller (manuf 0x4BF, id 0x509, rev 0x01, class 0x0)
[    2.492557] bcma: bus0: Core 19 found: SPI flash controller (manuf 0x4BF, id 0x50A, rev 0x01, class 0x0)
[    2.502079] bcma: bus0: Flash type not supported
[    2.507684] bcm53xxspiflash spi32766.0: unrecognized JEDEC id bytes: ff, ff, ff
[    2.515076] bcm53xxspiflash: probe of spi32766.0 failed with error -2
[    2.554534] bgmac bcma0:3: Invalid MAC addr: 00:00:00:00:00:00
[    2.560427] bgmac bcma0:3: Using random MAC: 56:5f:15:35:98:84
[    2.566307] bgmac bcma0:3: Found PHY addr: 30 (NOREGS)
[    2.572276] bgmac bcma0:3: Support for Roboswitch not implemented
[    2.579882] b53_common: found switch: BCM53012, rev 5
[    2.585569] bgmac bcma0:4: Invalid MAC addr: 00:00:00:00:00:00
[    2.591479] bgmac bcma0:4: Using random MAC: 2e:a0:27:b8:34:fa
[    2.597366] bgmac bcma0:4: Found PHY addr: 30 (NOREGS)
[    2.603350] bgmac bcma0:4: Support for Roboswitch not implemented
[    2.610391] bgmac bcma0:5: Found PHY addr: 30 (NOREGS)
[    2.616347] bgmac bcma0:5: Support for Roboswitch not implemented
[    2.623328] bgmac: Unsupported core_unit 3
[    2.627447] bgmac: probe of bcma0:6 failed with error -524
[    2.634133] bcm47xx-wdt bcm47xx-wdt.0: BCM47xx Watchdog Timer enabled (30 seconds, Software Timer)
[    2.643157] bcma: bus0: Bus registered
[    2.647823] NET: Registered protocol family 10
[    2.653299] NET: Registered protocol family 17
[    2.657796] bridge: automatic filtering via arp/ip/ip6tables has been deprecated. Update your scripts to load br_netfilter if you need this.
[    2.670482] 8021q: 802.1Q VLAN Support v1.8
[    2.674744] Registering SWP/SWPB emulation handler
[    2.681161] UBI: auto-attach mtd4
[    2.684314] ubi0: attaching mtd4
[    2.858227] ubi0: scanning is finished
[    2.870655] ubi0: attached mtd4 (name "ubi", size 32 MiB)
[    2.876078] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976 bytes
[    2.882996] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 2048
[    2.889810] ubi0: VID header offset: 2048 (aligned 2048), data offset: 4096
[    2.896791] ubi0: good PEBs: 256, bad PEBs: 0, corrupted PEBs: 0
[    2.902814] ubi0: user volume: 2, internal volumes: 1, max. volumes count: 128
[    2.910055] ubi0: max/mean erase counter: 3/1, WL threshold: 4096, image sequence number: 928618645
[    2.919117] ubi0: available PEBs: 0, total reserved PEBs: 256, PEBs reserved for bad PEB handling: 20
[    2.928395] ubi0: background thread "ubi_bgt0d" started, PID 359
[    2.935386] block ubiblock0_0: created from ubi0:0(rootfs)
[    2.940918] ubiblock: device ubiblock0_0 (rootfs) set to be root filesystem
[    2.952471] VFS: Mounted root (squashfs filesystem) readonly on device 254:0.
[    2.959868] Freeing unused kernel memory: 212K (c0443000 - c0478000)
[    3.355081] init: Console is alive
[    3.358619] init: - watchdog -
[    3.737253] usbcore: registered new interface driver usbfs
[    3.742874] usbcore: registered new interface driver hub
[    3.748280] usbcore: registered new device driver usb
[    3.759522] init: - preinit -
Press the [f] key and hit [enter] to enter failsafe mode
Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level
[    5.579380] eth0: Link is Up - 1Gbps/Full - flow control off
[    7.046438] UBIFS (ubi0:1): default file-system created
[    7.052537] UBIFS (ubi0:1): background thread "ubifs_bgt0_1" started, PID 442
[    7.124608] UBIFS (ubi0:1): UBIFS: mounted UBI device 0, volume 1, name "rootfs_data"
[    7.132487] UBIFS (ubi0:1): LEB size: 126976 bytes (124 KiB), min./max. I/O unit sizes: 2048 bytes/2048 bytes
[    7.142431] UBIFS (ubi0:1): FS size: 25014272 bytes (23 MiB, 197 LEBs), journal size 1269760 bytes (1 MiB, 10 LEBs)
[    7.152897] UBIFS (ubi0:1): reserved for root: 1181485 bytes (1153 KiB)
[    7.159534] UBIFS (ubi0:1): media format: w4/r0 (latest is w4/r0), UUID 1B97EDBB-591B-4F6A-A9C1-7BEF2BCD134D, small LPT model
[    7.172716] mount_root: overlay filesystem has not been fully initialized yet
[    7.180316] mount_root: switching to jffs2 overlay
[    7.200924] procd: - early -
[    7.203870] procd: - watchdog -
[    7.849698] procd: - ubus -
[    7.910713] procd: - init -
Please press Enter to activate this console.
[   10.218496] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   10.329492] pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
[   10.335796] pci_bus 0000:00: root bus resource [mem 0x08000000-0x0fffffff]
[   10.342728] pcie_iproc_bcma bcma0:7: link: UP
[   10.347346] PCI: bus0: Fast back to back transfers disabled
[   10.352966] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   10.361482] PCI: bus1: Fast back to back transfers disabled
[   10.367126] pci 0000:00:00.0: BAR 8: assigned [mem 0x08000000-0x085fffff]
[   10.373960] pci 0000:01:00.0: BAR 2: assigned [mem 0x08000000-0x083fffff 64bit]
[   10.381308] pci 0000:01:00.0: BAR 0: assigned [mem 0x08400000-0x08407fff 64bit]
[   10.388640] pci 0000:00:00.0: PCI bridge to [bus 01]
[   10.393630] pci 0000:00:00.0:   bridge window [mem 0x08000000-0x085fffff]
[   10.509470] pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
[   10.515767] pci_bus 0001:00: root bus resource [mem 0x40000000-0x47ffffff]
[   10.522683] pcie_iproc_bcma bcma0:8: link: UP
[   10.527301] PCI: bus0: Fast back to back transfers disabled
[   10.532915] pci 0001:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   10.541435] PCI: bus1: Fast back to back transfers disabled
[   10.547032] pci 0001:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   10.555199] External imprecise Data abort at addr=0x1c6e00f, fsr=0x1406 ignored.
[   10.562635] Unhandled fault: imprecise external abort (0x1406) at 0x01c6e00f
[   10.569699] pgd = c71e4000
[   10.572405] [01c6e00f] *pgd=0732b831, *pte=06d1f75f, *ppte=06d1fc7f
[   10.578711] Internal error: : 1406 [#1] SMP ARM
[   10.583249] Modules linked in: pcie_iproc_bcma(+) pcie_iproc ip6t_REJECT nf_reject_ipv6 nf_log_ipv6 nf_log_common ip6table_raw ip6table_mangle ip6table_filter ip6_tables x_tables leds_gpio gpio_button_hotplug usbcore nls_base usb_common
[   10.604388] CPU: 0 PID: 648 Comm: kmodloader Not tainted 4.4.6 #9
[   10.610493] Hardware name: BCM5301X
[   10.613985] task: c7a5a400 ti: c7346000 task.ti: c7346000
[   10.619404] PC is at pci_generic_config_read32+0x48/0x74
[   10.624733] LR is at arm_heavy_mb+0x20/0x40
[   10.628923] pc : [<c01ad4d8>]    lr : [<c001b2ac>]    psr: a0000093
[   10.628923] sp : c7347a00  ip : c73479c8  fp : c7347a1c
[   10.640427] r10: 0000000e  r9 : 00000000  r8 : c7347a72
[   10.645659] r7 : 60000013  r6 : 00000001  r5 : c7347a2c  r4 : 0000000e
[   10.652195] r3 : c88c4000  r2 : c88c41f8  r1 : 00120000  r0 : c88c41fc
[   10.658733] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   10.665974] Control: 10c5387d  Table: 071e404a  DAC: 00000051
[   10.671728] Process kmodloader (pid: 648, stack limit = 0xc7346190)
[   10.678011] Stack: (0xc7347a00 to 0xc7348000)
[   10.682377] 7a00: c01ad490 c04bebec c716f600 60000013 c7347a5c c7347a20 c01ad26c c01ad49c
[   10.690576] 7a20: c7347a2c ffffffff 00000051 00000000 c7347a74 c70f5000 c716f600 00000000
[   10.698775] 7a40: 00000000 00000000 c716fe00 00000000 c7347aa4 c7347a60 c01afad8 c01ad21c
[   10.706974] 7a60: c01d9750 c017d4c8 c7347a8c c7347a78 c01ae8e0 c01d9740 c70f5000 c716f600
[   10.715173] 7a80: c7347aa4 c70f5000 c716f600 00000000 00000000 00000000 c7347acc c7347aa8
[   10.723373] 7aa0: c01b0174 c01afabc c7347ac4 00120000 c716f600 c716f600 00000001 00000000
[   10.731570] 7ac0: c7347aec c7347ad0 c01b0210 c01b0100 c716f600 00000008 00000001 00000002
[   10.739770] 7ae0: c7347b14 c7347af0 c01b0fb0 c01b01b8 c70f5800 c716f600 00000001 00000002
[   10.747969] 7b00: 00000000 c716fe00 c7347b74 c7347b18 c01b0db8 c01b0f94 c0053284 c0055958
[   10.756168] 7b20: c70f5800 c7347b3c c7347b74 00000000 00000000 00000000 00000000 00000001
[   10.764368] 7b40: 00000001 00ff0201 c7347b74 c716fe00 c70f5800 00000001 00000001 c716fe14
[   10.772568] 7b60: c716f800 00000000 c7347b9c c7347b78 c01b1010 c01b0aa8 c70f6000 c716fe00
[   10.780766] 7b80: 00000000 00000001 00000000 c716f800 c7347bfc c7347ba0 c01b0db8 c01b0f94
[   10.788965] 7ba0: c0053284 c0055958 c70f6000 c7347bc4 c7347bfc 00000000 00000000 00000000
[   10.797164] 7bc0: 00000000 00000001 00010001 00ff0100 c7347bfc c716f800 c70f6000 00000001
[   10.805363] 7be0: 00000000 c716f814 bf0641d0 c0075878 c7347c24 c7347c00 c01b1010 c01b0aa8
[   10.813563] 7c00: c7209a90 c716f800 00000000 00000330 00000004 bf0641d0 c7347c8c c7347c28
[   10.821762] 7c20: bf0606ac c01b0f94 c7347c94 c7a35e10 00000004 bf0641d0 c7347c5c c7347c94
[   10.829961] 7c40: c0024e78 901201f0 c7347c94 c7347c9c c7347c7c c7347c60 01060400 c0024e68
[   10.838161] 7c60: c7209a90 c7209a90 c7347c94 c7a35e00 c7a35e10 00000004 bf0641d0 c0075878
[   10.846360] 7c80: c7347cd4 c7347c90 bf0640f4 bf060130 c7a35e10 c7347c94 c7347c94 40000000
[   10.854559] 7ca0: 47ffffff bf064154 00000200 c7347cb8 c0104c60 c0104b78 c7a35e10 c04bf95c
[   10.862758] 7cc0: 00000000 c04bf958 c7347ce4 c7347cd8 c0230240 bf064068 c7347d0c c7347ce8
[   10.870957] 7ce0: c01dd3d4 c0230224 c7a35e10 c7a35e44 bf0641d0 c048bf34 c047a3c8 00000000
[   10.879156] 7d00: c7347d2c c7347d10 c01dd5a8 c01dd2e0 00000000 bf0641d0 c01dd538 c048bf34
[   10.887356] 7d20: c7347d54 c7347d30 c01dbbd0 c01dd544 c788975c c7adf834 c7889770 bf0641d0
[   10.895555] 7d40: 00000000 c725ba00 c7347d64 c7347d58 c01dcf70 c01dbb68 c7347d8c c7347d68
[   10.903754] 7d60: c01dcb7c c01dcf5c bf064181 c7347d78 bf0641d0 bf066000 c047d9c8 c047d9c8
[   10.911952] 7d80: c7347da4 c7347d90 c01ddc34 c01dcab4 c73d6700 bf066000 c7347db4 c7347da8
[   10.920152] 7da0: c02304fc c01ddb9c c7347dc4 c7347db8 bf066018 c02304e0 c7347e44 c7347dc8
[   10.928351] 7dc0: c001393c bf06600c c047ccc4 c6df8000 c7ff1420 40000000 00000000 00000000
[   10.936550] 7de0: 00000015 c0075878 c7347e1c c7347df8 c00875c8 c00871d4 00000000 c73d6640
[   10.944749] 7e00: c8b3a000 00000001 00000000 00000001 c73d6640 c8b3a000 00000001 dc8ba606
[   10.952948] 7e20: bf064240 c716ea00 c73d6640 c716eb80 00000000 00000015 c7347e6c c7347e48
[   10.961147] 7e40: c0076c04 c001379c c7347e6c c7347e58 c00a99ac c7347f34 c716ea00 bf064240
[   10.969347] 7e60: c7347f2c c7347e70 c0078270 c0076bb0 bf06424c 00007fff bf064240 c0075d28
[   10.977546] 7e80: 00012377 bf0643a0 c8b3abb8 c03d97d4 0000001c c8b3a3c8 0000001c bf064288
[   10.985745] 7ea0: c73d6640 024002c2 00000000 00000000 00000000 00000000 00000000 00000000
[   10.993945] 7ec0: 65696370 7270695f 0000636f 00000000 00000000 00000000 00000000 00000000
[   11.002143] 7ee0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 dc8ba606
[   11.010344] 7f00: c0078734 00000c08 01c6bc18 00000000 c8b3ac08 00012377 c7346000 00000051
[   11.018542] 7f20: c7347fa4 c7347f30 c00787f0 c0076dd8 c7455cb8 c8b3a000 00000c08 c8b3a8c0
[   11.026741] 7f40: c8b3a46f c8b3a6e4 000003c0 00000420 00000000 00000000 00000000 00000308
[   11.034939] 7f60: 00000013 00000014 0000000e 00000000 00000008 00000000 c00b64a4 00000000
[   11.043139] 7f80: 00000000 00000005 00000080 c00098c4 c7346000 00000000 00000000 c7347fa8
[   11.051338] 7fa0: c0009700 c00786e0 00000000 00000000 01c6b010 00000c08 00012377 0000fe00
[   11.059537] 7fc0: 00000000 00000000 00000005 00000080 00000c08 00000000 00000001 00000000
[   11.067738] 7fe0: bee00d34 bee00d18 00011abc b6f5537c 60000010 01c6b010 ffffffff ffffffff
[   11.075929] Backtrace: 
[   11.078396] [<c01ad490>] (pci_generic_config_read32) from [<c01ad26c>] (pci_bus_read_config_byte+0x5c/0x84)
[   11.088160]  r7:60000013 r6:c716f600 r5:c04bebec r4:c01ad490
[   11.093867] [<c01ad210>] (pci_bus_read_config_byte) from [<c01afad8>] (pci_setup_device+0x28/0x3f4)
[   11.102930]  r10:00000000 r9:c716fe00 r8:00000000 r7:00000000 r6:00000000 r5:c716f600
[   11.110816]  r4:c70f5000
[   11.113363] [<c01afab0>] (pci_setup_device) from [<c01b0174>] (pci_scan_single_device+0x80/0xb8)
[   11.122166]  r8:00000000 r7:00000000 r6:00000000 r5:c716f600 r4:c70f5000
[   11.128925] [<c01b00f4>] (pci_scan_single_device) from [<c01b0210>] (pci_scan_slot+0x64/0xe4)
[   11.137468]  r7:00000000 r6:00000001 r5:c716f600 r4:c716f600
[   11.143174] [<c01b01ac>] (pci_scan_slot) from [<c01b0fb0>] (pci_scan_child_bus+0x28/0xa8)
[   11.151368]  r7:00000002 r6:00000001 r5:00000008 r4:c716f600
[   11.157074] [<c01b0f88>] (pci_scan_child_bus) from [<c01b0db8>] (pci_scan_bridge+0x31c/0x4ec)
[   11.165616]  r9:c716fe00 r8:00000000 r7:00000002 r6:00000001 r5:c716f600 r4:c70f5800
[   11.173420] [<c01b0a9c>] (pci_scan_bridge) from [<c01b1010>] (pci_scan_child_bus+0x88/0xa8)
[   11.181789]  r10:00000000 r9:c716f800 r8:c716fe14 r7:00000001 r6:00000001 r5:c70f5800
[   11.189674]  r4:c716fe00
[   11.192221] [<c01b0f88>] (pci_scan_child_bus) from [<c01b0db8>] (pci_scan_bridge+0x31c/0x4ec)
[   11.200763]  r9:c716f800 r8:00000000 r7:00000001 r6:00000000 r5:c716fe00 r4:c70f6000
[   11.208566] [<c01b0a9c>] (pci_scan_bridge) from [<c01b1010>] (pci_scan_child_bus+0x88/0xa8)
[   11.216935]  r10:c0075878 r9:bf0641d0 r8:c716f814 r7:00000000 r6:00000001 r5:c70f6000
[   11.224821]  r4:c716f800
[   11.227371] [<c01b0f88>] (pci_scan_child_bus) from [<bf0606ac>] (iproc_pcie_setup+0x588/0x690 [pcie_iproc])
[   11.237129]  r9:bf0641d0 r8:00000004 r7:00000330 r6:00000000 r5:c716f800 r4:c7209a90
[   11.244937] [<bf060124>] (iproc_pcie_setup [pcie_iproc]) from [<bf0640f4>] (iproc_pcie_bcma_probe+0x98/0xd0 [pcie_iproc_bcma])
[   11.256347]  r10:c0075878 r9:bf0641d0 r8:00000004 r7:c7a35e10 r6:c7a35e00 r5:c7347c94
[   11.264233]  r4:c7209a90
[   11.266791] [<bf06405c>] (iproc_pcie_bcma_probe [pcie_iproc_bcma]) from [<c0230240>] (bcma_device_probe+0x28/0x34)
[   11.277158]  r7:c04bf958 r6:00000000 r5:c04bf95c r4:c7a35e10
[   11.282873] [<c0230218>] (bcma_device_probe) from [<c01dd3d4>] (driver_probe_device+0x100/0x264)
[   11.291683] [<c01dd2d4>] (driver_probe_device) from [<c01dd5a8>] (__driver_attach+0x70/0x94)
[   11.300136]  r9:00000000 r8:c047a3c8 r7:c048bf34 r6:bf0641d0 r5:c7a35e44 r4:c7a35e10
[   11.307942] [<c01dd538>] (__driver_attach) from [<c01dbbd0>] (bus_for_each_dev+0x74/0x98)
[   11.316134]  r7:c048bf34 r6:c01dd538 r5:bf0641d0 r4:00000000
[   11.321842] [<c01dbb5c>] (bus_for_each_dev) from [<c01dcf70>] (driver_attach+0x20/0x28)
[   11.329861]  r6:c725ba00 r5:00000000 r4:bf0641d0
[   11.334515] [<c01dcf50>] (driver_attach) from [<c01dcb7c>] (bus_add_driver+0xd4/0x1f0)
[   11.342453] [<c01dcaa8>] (bus_add_driver) from [<c01ddc34>] (driver_register+0xa4/0xe8)
[   11.350472]  r7:c047d9c8 r6:c047d9c8 r5:bf066000 r4:bf0641d0
[   11.356180] [<c01ddb90>] (driver_register) from [<c02304fc>] (__bcma_driver_register+0x28/0x30)
[   11.364894]  r5:bf066000 r4:c73d6700
[   11.368498] [<c02304d4>] (__bcma_driver_register) from [<bf066018>] (init_module+0x18/0x24 [pcie_iproc_bcma])
[   11.378448] [<bf066000>] (init_module [pcie_iproc_bcma]) from [<c001393c>] (do_one_initcall+0x1ac/0x1ec)
[   11.387951] [<c0013790>] (do_one_initcall) from [<c0076c04>] (do_init_module+0x60/0x1a4)
[   11.396055]  r9:00000015 r8:00000000 r7:c716eb80 r6:c73d6640 r5:c716ea00 r4:bf064240
[   11.403858] [<c0076ba4>] (do_init_module) from [<c0078270>] (load_module+0x14a4/0x1908)
[   11.411879]  r6:bf064240 r5:c716ea00 r4:c7347f34
[   11.416531] [<c0076dcc>] (load_module) from [<c00787f0>] (SyS_init_module+0x11c/0x13c)
[   11.424465]  r10:00000051 r9:c7346000 r8:00012377 r7:c8b3ac08 r6:00000000 r5:01c6bc18
[   11.432350]  r4:00000c08
[   11.434900] [<c00786d4>] (SyS_init_module) from [<c0009700>] (ret_fast_syscall+0x0/0x3c)
[   11.443003]  r10:00000000 r9:c7346000 r8:c00098c4 r7:00000080 r6:00000005 r5:00000000
[   11.450890]  r4:00000000
[   11.453437] Code: e5853000 e89da8f0 e5901000 f57ff04f (e3560002) 
[   11.459545] ---[ end trace 904ac2ae157d3f83 ]---
[   20.973607] device eth0.1 entered promiscuous mode
[   20.978422] device eth0 entered promiscuous mode
[   20.992239] br-lan: port 1(eth0.1) entered forwarding state
[   20.997869] br-lan: port 1(eth0.1) entered forwarding state
[   21.479404] eth0: Link is Up - 1Gbps/Full - flow control off
[   22.989360] br-lan: port 1(eth0.1) entered forwarding state
