From: alandpearson@gmail.com (Alan Pearson)
Date: Tue, 9 Nov 2010 13:59:21 +0000
Subject: w1-gpio oops
Message-ID: <E0675DE1-DC0C-40AE-947B-D4BD96C18993@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

First post to list, so be kind :)

I'm trying to get w1 (one wire) working over GPIO and despite my best efforts this results in a nasty oops.
Firstly, I'd like to say I'm no kernel hacker and my knowledge of Ooops and kernel debugging is limited, but I'm willing to learn:)

I'm using Kernel.org kernel 2.6.36 (also tried 2.6.37-rc1) on a Marvell based 'GuruPlug server' device.
I'm using the GPIO pins that are on the U-SNAP interface, namely MPP38.

Having compiled and deployed the kernel to the device and verifying that I can control the GPIO pins OK from userspace using /sys, I then proceed to try and get w1 working on GPIO (after first unexporting the pin I want).

There's sparse info on this, and most wisdom tells me to use the w1-gpio-custom module for openWRT to set the pin number before loading the module, which I've done.

sheevaplug-debian:~# modprobe wire
sheevaplug-debian:~# modprobe w1_gpio_custom bus0=0,38,0
sheevaplug-debian:~# modprobe w1_gpio
Internal error: Oops - undefined instruction: 0 [#1] PREEMPT
last sysfs file: /sys/devices/virtual/mtd/mtd2/mtdblock2/range
Modules linked in: w1_gpio(+) w1_gpio_custom wire xt_tcpudp iptable_filter ip_tables x_tables ipv6 libertas_sdio libertas sata_mv mv_c]
CPU: 0    Not tainted  (2.6.37-rc1 #3)
PC is at 0xbf0d40d8
LR is at w1_gpio_probe+0x14c/0x194 [w1_gpio]
pc : [<bf0d40d8>]    lr : [<bf0da160>]    psr: a0000013
sp : deb6be98  ip : 00000000  fp : beca8984
r10: 00000040  r9 : deb6a000  r8 : bf0da040
r7 : deb27f00  r6 : 00000000  r5 : df2fd420  r4 : deb36b80
r3 : bf0d40d4  r2 : 00000000  r1 : deb6be64  r0 : 00000001
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005397f  Table: 1eb44000  DAC: 00000015
Process modprobe (pid: 2813, stack limit = 0xdeb6a270)
Stack: (0xdeb6be98 to 0xdeb6c000)
be80:                                                       deb27f00 000022cc
bea0: deb6be90 deb27f08 deb27f08 bf0d7190 bf0d7190 c02895dc 00000060 c028b630
bec0: c028b61c c028a5ec 00000000 deb27f08 deb27f3c bf0d7190 00000000 c028a704
bee0: bf0d7190 c028a6a4 00000000 c0289d94 df8240b8 deb18570 bf0d7190 deb18780
bf00: c058d5f0 c02896f0 bf0d714f bf0d714f deb6bf10 bf0d7190 00000001 00024418
bf20: 00000000 c002fbe4 00000000 c028a9d8 bf0d717c 00000001 00024418 00000000
bf40: c002fbe4 c028ba1c bf0d71c8 bf0da000 00024418 c002f42c 00000000 00000001
bf60: bf0d71c8 00000000 00024418 bf0d71c8 00000000 00024418 000014ed c002fbe4
bf80: 00000000 c0077ba0 400c3000 000014ed 00024418 00009064 00000000 00008edc
bfa0: 00000080 c002fa60 00009064 00000000 400c3000 000014ed 00024418 000014ed
bfc0: 00009064 00000000 00008edc 00000080 00000000 00000000 40102000 beca8984
bfe0: 00000000 beca88fc 0000b6b0 402af0c4 60000010 400c3000 ffffefff fffffcff
[<bf0da160>] (w1_gpio_probe+0x14c/0x194 [w1_gpio]) from [<c028b630>] (platform_drv_probe+0x14/0x18)
[<c028b630>] (platform_drv_probe+0x14/0x18) from [<c028a5ec>] (driver_probe_device+0xb0/0x168)
[<c028a5ec>] (driver_probe_device+0xb0/0x168) from [<c028a704>] (__driver_attach+0x60/0x84)
[<c028a704>] (__driver_attach+0x60/0x84) from [<c0289d94>] (bus_for_each_dev+0x48/0x74)
[<c0289d94>] (bus_for_each_dev+0x48/0x74) from [<c02896f0>] (bus_add_driver+0x144/0x2c0)
[<c02896f0>] (bus_add_driver+0x144/0x2c0) from [<c028a9d8>] (driver_register+0xa8/0x138)
[<c028a9d8>] (driver_register+0xa8/0x138) from [<c028ba1c>] (platform_driver_probe+0x18/0x98)
[<c028ba1c>] (platform_driver_probe+0x18/0x98) from [<c002f42c>] (do_one_initcall+0xcc/0x1a8)
[<c002f42c>] (do_one_initcall+0xcc/0x1a8) from [<c0077ba0>] (sys_init_module+0x90/0x1a4)
[<c0077ba0>] (sys_init_module+0x90/0x1a4) from [<c002fa60>] (ret_fast_syscall+0x0/0x2c)
Code: debcffc0 debcd0f0 deb4e120 00000000 (deb92ca0) 


As I said, this doesn't mean a lot to me, and I'm not sure it's an ARM problem, but I don't have other hardware to test on.


Any help greatly appreciated.
