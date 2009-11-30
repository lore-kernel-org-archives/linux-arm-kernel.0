From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Mon, 30 Nov 2009 13:07:04 -0200
Subject: USB support on i.MX27
In-Reply-To: <20091127101654.GP14091@buzzloop.caiaq.de>
References: <37367b3a0911240343u58e3b3d2le5d48e638348a3ad@mail.gmail.com>
	<eedb5540911242252w62f0a1cfo3a3f24dfa060957b@mail.gmail.com>
	<20091127101654.GP14091@buzzloop.caiaq.de>
Message-ID: <37367b3a0911300707l2abafe3buf99f624c3c90b99@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 11/27/09, Daniel Mack <daniel@caiaq.de> wrote:
>
> As I pointed out, the ISP1504 driver turned into a generic ULPI
> transceiver driver eventually. And the code got some cleanup, but apart
> from that, things are still like they used to be.
>

USB Host1 worked fine, but USB Host2 (connected to ISP1504) is crashing:

FEC Ethernet Driver
fec: PHY @ 0x3, ID 0x0007c0f1 -- LAN8710
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
mxc-ehci mxc-ehci.1: initializing i.MX USB Controller
mxc-ehci mxc-ehci.1: Freescale On-Chip EHCI Host Controller
mxc-ehci mxc-ehci.1: new USB bus registered, assigned bus number 1
mxc-ehci mxc-ehci.1: irq 54, io mem 0x10024200
mxc-ehci mxc-ehci.1: USB 2.0 started, EHCI 1.00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
mxc-ehci mxc-ehci.2: initializing i.MX USB Controller
timeout polling for ULPI device
timeout polling for ULPI device
timeout polling for ULPI device
timeout polling for ULPI device
ULPI transceiver vendor/product ID 0xffffff92/0xffffff92
ULPI ID does not match any known transceiver.
mxc-ehci mxc-ehci.2: unable to init transceiver
mxc-ehci mxc-ehci.2: Freescale On-Chip EHCI Host Controller
mxc-ehci mxc-ehci.2: new USB bus registered, assigned bus number 2
Unhandled fault: external abort on non-linefetch (0x808) at 0xc8896584
Internal error: : 808 [#1] PREEMPT
last sysfs file:
Modules linked in:
CPU: 0    Not tainted  (2.6.32-rc6-g415c7d2-dirty #3)
PC is at ehci_hub_control+0x87c/0x8b4
LR is at 0x4
pc : [<c020f49c>]    lr : [<00000004>]    psr: 00000093
sp : c781fe50  ip : 00000001  fp : 00000000
r10: c8896584  r9 : 00000000  r8 : 60000013
r7 : c78bc8c8  r6 : 00000001  r5 : 00000000  r4 : c781e000
r3 : 80000000  r2 : 00000007  r1 : 80000000  r0 : 00000044
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: a0004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc781e270)
Stack: (0xc781fe50 to 0xc7820000)
fe40:                                     00000000 c78bd400 c792f240 00000037
fe60: 00000000 c78bc8c8 c78bc800 c78bc8c8 00000000 00000000 00000000 c78bc800
fe80: c792f240 00000037 00000000 c0211ddc 00000000 00000000 00000002 00000000
fea0: c78bc800 000000a0 c78bd400 c01fefac c792f240 c038d8a0 00000000 c0047e48
fec0: c034a6a4 ffffffff 00000000 c038b2b0 c038b2a8 c78bc800 c038d8a0 c0212ce4
fee0: 00000000 00000000 00000000 00000037 c781ff1c c038b2b0 c03a25ac c03a25ac
ff00: c03dd978 c79339e0 00000000 c03a0260 00000000 c01d2020 c03a25ac c01d0dd4
ff20: c7827de8 c038b2b0 c03a25ac c038b2e4 c01d0ecc c01d0f50 00000000 c781ff48
ff40: c03a25ac c01d0078 c78034d8 c7867d10 c001ead0 c01d0800 c001ead0 c03a25ac
ff60: c0017f08 c01d0898 c0322a08 c02b7b78 c03de5ac c001ead0 c03a25ac c0017f08
ff80: 00000000 00000001 c03aaaec c01d12f0 c03de5ac c001ead0 c781e000 c0017f08
ffa0: 00000000 c0017f74 c001ea64 c002236c c0021950 3532e80c 00000035 00000000
ffc0: 00000000 00000110 c001ea64 c001ead0 c001e80c 00000000 00000000 00000000
ffe0: 00000000 c000875c 00000000 00000000 00000000 c0023a44 fffffeff ffffffff
[<c020f49c>] (ehci_hub_control+0x87c/0x8b4) from [<c0211ddc>] (ehci_mxc_setup+0)
[<c0211ddc>] (ehci_mxc_setup+0x308/0x36c) from [<c01fefac>] (usb_add_hcd+0x1c4/)
[<c01fefac>] (usb_add_hcd+0x1c4/0x5b0) from [<c0212ce4>] (ehci_mxc_drv_probe+0x)
[<c0212ce4>] (ehci_mxc_drv_probe+0x23c/0x418) from [<c01d2020>] (platform_drv_p)
[<c01d2020>] (platform_drv_probe+0x1c/0x24) from [<c01d0dd4>] (driver_probe_dev)
[<c01d0dd4>] (driver_probe_device+0x88/0x180) from [<c01d0f50>] (__driver_attac)
[<c01d0f50>] (__driver_attach+0x84/0x88) from [<c01d0078>] (bus_for_each_dev+0x)
[<c01d0078>] (bus_for_each_dev+0x54/0x80) from [<c01d0898>] (bus_add_driver+0xb)
[<c01d0898>] (bus_add_driver+0xb8/0x2dc) from [<c01d12f0>] (driver_register+0x5)
[<c01d12f0>] (driver_register+0x58/0x144) from [<c0017f74>] (ehci_hcd_init+0x6c)
[<c0017f74>] (ehci_hcd_init+0x6c/0xc4) from [<c002236c>] (do_one_initcall+0x2c/)
[<c002236c>] (do_one_initcall+0x2c/0x1a8) from [<c000875c>] (kernel_init+0x9c/0)
[<c000875c>] (kernel_init+0x9c/0x108) from [<c0023a44>] (kernel_thread_exit+0x0)
Code: e597300c e3130010 13c13a01 13c3302a (158a3000)
---[ end trace 76e229204033b0ca ]---
note: swapper[1] exited with preempt_count 2
Kernel panic - not syncing: Attempted to kill init!

Using Freescale kernel 2.6.22 is works fine.

Best Regards,

Alan
