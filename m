From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Nov 2013 14:00:53 +0100
Subject: [PATCH 0/9] ARM: sa1100: Rework IRQ handling
In-Reply-To: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CACRpkdZU3_EqhBjV68+okJwh7QONuxWVjKkrUO4PkwJhKrP+mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 9:47 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> This is a considerable rework of my previous attempt to update sa1100 irq
> handling. IRQ code is updated to support MULTI_IRQ_HANDLER and is mostly
> prepared to be converted to irqchip driver (if the need arises in future).
> I have integrated idea of Linus Waleij to use irq domains. GPIO irq handling
> is split to gpio driver, which also undergo an update/rewrite.

Overall this is looking very nice. However when I apply this on top
of (a working and booting) mainline HEAD, I get this:

sa11x0-uart.3: ttySA0 at MMIO 0x80050000 (irq = 17, base_baud =
230400) is a SA1100
Unable to handle kernel NULL pointer dereference at virtual address 0000004c
pgd = c0004000
[0000004c] *pgd=00000000
Internal error: Oops: 40cd7017 [#1] PREEMPT ARM
Modules linked in:
task: c1832000 ti: c1834000 task.ti: c1834000
PC is at gpiod_set_raw_value+0x14/0x4c
LR is at uart_add_one_port+0x2c4/0x3e8
pc : [<c017b7ec>]    lr : [<c01ac7d8>]    psr: a0000093
sp : c1835db8  ip : 00000001  fp : c0359df8
r10: c1862e20  r9 : a0000013  r8 : c1834008
r7 : c1926078  r6 : c0659f2c  r5 : 00000001  r4 : c0656438
r3 : 00000000  r2 : 80050000  r1 : 00000001  r0 : c0656438
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: c0cd717f  Table: c0cd717f  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc18341c0)
Stack: (0xc1835db8 to 0xc1836000)
5da0:                                                       80050000
c1926000
5dc0: c06415fc c01ac7d8 00000000 c1835df0 00000011 00038400 c0351738
c0cf35e0
5de0: 00038400 00000011 00000000 c0352e2c 4f494d4d 38783020 30353030
00303030
5e00: c0cf3540 c0c0c400 c0c0c400 c0c0c540 c1863cc0 c00f973c 00000000
c0c0c540
5e20: c1863cc0 c00fa14c c0c5dea0 c00f989c ff0a0004 c0659f2c c0635d20
c0635d54
5e40: c06415b8 c03af454 c03b5280 00000000 c1834030 c01ae8d8 c01b68b4
c0635d20
5e60: c06415b8 c01b68cc c01b68b4 c0635d20 c065a550 c01b4fcc 00000007
c0635d20
5e80: c06415b8 c0635d54 00000000 c01b524c 00000000 c01b51b4 c06415b8
c01b36cc
5ea0: c1807f4c c1874a50 c06415b8 c0c5dea0 c0641c90 c01b4884 c033c704
c06415b8
5ec0: 00000006 c06415b8 00000006 c064a320 c064a320 c01b58bc 00000000
00000000
5ee0: 00000006 c03af48c c03ba968 c0008738 c033eb60 c1805f80 c0652094
c18584e0
5f00: c02c1000 0000001f 00000000 00000000 00000000 c00efdd8 c1835f40
c1858480
5f20: c0002178 c02cd440 00000072 c003420c c0383568 00000006 c0002184
00000006
5f40: 00000000 c03ba968 00000006 c064a320 c064a320 c039c47c c03b5280
00000072
5f60: c03b5274 c039cbc8 00000006 00000006 c039c47c e64cf708 e9a321ec
c15a1bcf
5f80: 63932b15 00000000 c02b759c 00000000 00000000 00000000 00000000
00000000
5fa0: 00000000 c02b75a4 00000000 c000e9f0 00000000 00000000 00000000
00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 7fc33b8e
cc8612cc
[<c017b7ec>] (gpiod_set_raw_value+0x14/0x4c) from [<c01ac7d8>]
(uart_add_one_port+0x2c4/0x3e8)
[<c01ac7d8>] (uart_add_one_port+0x2c4/0x3e8) from [<c01ae8d8>]
(sa1100_serial_probe+0x98/0xc4)
[<c01ae8d8>] (sa1100_serial_probe+0x98/0xc4) from [<c01b68cc>]
(platform_drv_probe+0x18/0x4c)
[<c01b68cc>] (platform_drv_probe+0x18/0x4c) from [<c01b4fcc>]
(really_probe+0x6c/0x1f8)
[<c01b4fcc>] (really_probe+0x6c/0x1f8) from [<c01b524c>]
(__driver_attach+0x98/0x9c)
[<c01b524c>] (__driver_attach+0x98/0x9c) from [<c01b36cc>]
(bus_for_each_dev+0x68/0x98)
[<c01b36cc>] (bus_for_each_dev+0x68/0x98) from [<c01b4884>]
(bus_add_driver+0x13c/0x1e8)
[<c01b4884>] (bus_add_driver+0x13c/0x1e8) from [<c01b58bc>]
(driver_register+0x78/0xf8)
[<c01b58bc>] (driver_register+0x78/0xf8) from [<c03af48c>]
(sa1100_serial_init+0x38/0x58)
[<c03af48c>] (sa1100_serial_init+0x38/0x58) from [<c0008738>]
(do_one_initcall+0x104/0x16c)
[<c0008738>] (do_one_initcall+0x104/0x16c) from [<c039cbc8>]
(kernel_init_freeable+0xf4/0x1b0)
[<c039cbc8>] (kernel_init_freeable+0xf4/0x1b0) from [<c02b75a4>]
(kernel_init+0x8/0x118)
[<c02b75a4>] (kernel_init+0x8/0x118) from [<c000e9f0>]
(ret_from_fork+0x14/0x24)
Code: e2504000 0a000008 e5943000 e1a05001 (e5d3304c)
---[ end trace 42b376e5a40c702b ]---
note: swapper[1] exited with preempt_count 1
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

This is caused by the patch:
"ARM: sa1100: convert gpio driver to be a proper platform driver"

The reason: UARTs are initialized *very* early and the UART quirk used on the
h3600 is using GPIOs through the .set_mctrl hooks back into
arch/arm/mach-sa1100/h3xxx.c functions
h3xxx_uart_set_mctrl()
h3xxx_uart_get_mctrl()

And that happens before the GPIO driver gets registered -> crash.

This is why the device is registered from the machine in the first place
I think.

I don't know what the proper solution is, but I think you can keep most
of the platform device conversion if you also keep the special initialization
call.

Yours,
Linus Walleij
