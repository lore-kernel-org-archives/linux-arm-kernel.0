From: peda@lysator.liu.se (Peter Rosin)
Date: Tue, 01 Dec 2015 18:17:16 +0100
Subject: Regression, was [PATCH 4/4] USB: host: ohci-at91: merge loops in
 ohci_hcd_at91_drv_probe
In-Reply-To: 1439216592-11381-5-git-send-email-alexandre.belloni@free-electrons.com
Message-ID: <565DD61C.5010904@lysator.liu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Alexandre Belloni wrote:
> ohci_hcd_at91_drv_probe() has four at91_for_each_port. They can be merged
> into two loops without changing the driver behaviour.

Not so much, I bisected the following panic to the commit matching this patch
(e4df92279fd9e01532f65e5ba397877799ed6252).

Reverting that commit on top of 4.3 fixes things for me.

Cheers,
Peter

...
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-atmel: OHCI Atmel driver
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
pgd = c0004000
[0000000c] *pgd=00000000
Internal error: Oops: 5 [#1] ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.2.0-rc6+ #5
Hardware name: Atmel SAMA5
task: c3825ac0 ti: c3826000 task.ti: c3826000
PC is at ohci_hcd_at91_overcurrent_irq+0x18/0xe8
LR is at handle_irq_event_percpu+0x78/0x140
pc : [<c02f5084>]    lr : [<c00433b0>]    psr: 40000193
sp : c3827d08  ip : c3000e34  fp : c3a016dc
r10: c06e8bbd  r9 : c3941880  r8 : 0000007f
r7 : c392be00  r6 : 00000000  r5 : 00000008  r4 : 00000000
r3 : c02f506c  r2 : c3941880  r1 : c392be00  r0 : 0000007f
Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 20004059  DAC: 00000015
Process swapper (pid: 1, stack limit = 0xc3826208)
Stack: (0xc3827d08 to 0xc3828000)
7d00:                   c3a01600 c383fb10 00000000 00000000 0000007f c00433b0
7d20: 00000000 ffffffff c3941880 c383fb10 c4856648 c383fb10 c485664c c3802460
7d40: c38a6044 c00434a4 c3941880 c00458b8 0000007f c0042bc4 0000000f c01fe4ac
7d60: ff0a0110 00008000 00000028 00000000 00000000 00000001 c3802200 00000000
7d80: 0000007f c0042bc4 c06c91d4 c0042dec c004451c 60000113 ffffffff c3827ddc
7da0: 60000113 c0013500 c3941880 c3a01600 00000000 00000000 c3941880 0000007f
7dc0: c3a01600 00000000 60000113 00000000 0000007f c3a016dc 00000000 c3827df0
7de0: c00446b4 c004451c 60000113 ffffffff c383fb10 c00914d0 c3a01600 00000080
7e00: c3941880 c02f506c c392be00 c0044954 c392be00 00000000 c392be10 c3f77690
7e20: c3a016d0 c060d1e4 00000000 c02f5a0c c060d1e4 c392be00 0000004f 00000000
7e40: 00000001 00000001 c3927178 c070a458 c392be10 c06d7bfc fffffdfb c06d7bfc
7e60: 00000000 c06b0f68 00000000 c02670ec c02670a8 c070a458 c392be10 00000000
7e80: c06ecd78 c02655b4 c02657f4 00000000 c06ce538 c392be10 c06d7bfc c392be44
7ea0: 00000000 c06ce538 00000096 c0265880 00000000 c06d7bfc c02657f4 c0263880
7ec0: c383ea4c c39168b0 c06d7bfc c39df280 c06ecca0 c0264b80 c060d318 c3a017c0
7ee0: c06d7bfc c06be860 c3a017c0 c06a1468 00000000 c0266078 c0267050 c06be860
7f00: c06be860 c00096c8 c3807280 c06fc48c c3839100 c04d9470 00000000 00000000
7f20: 00004140 c00dff9c 00000000 00000096 c3ffca15 c0031e54 00000000 c06b0f44
7f40: c0612f0c c3ffcab1 00000006 00000006 00000000 00000000 c06b84b4 00000006
7f60: c06b0f60 c06f4140 c06f4140 c06b0f68 00000000 c068bda4 00000006 00000006
7f80: 00000000 c068b5b0 00000000 c04d06ec 00000000 00000000 00000000 00000000
7fa0: 00000000 c04d06f4 00000000 c000ff68 00000000 00000000 00000000 00000000
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 8aaaaaaa aaaaaaaa
[<c02f5084>] (ohci_hcd_at91_overcurrent_irq) from [<c00433b0>] (handle_irq_event_percpu+0x78/0x140)
[<c00433b0>] (handle_irq_event_percpu) from [<c00434a4>] (handle_irq_event+0x2c/0x40)
[<c00434a4>] (handle_irq_event) from [<c00458b8>] (handle_simple_irq+0x6c/0x80)
[<c00458b8>] (handle_simple_irq) from [<c0042bc4>] (generic_handle_irq+0x2c/0x3c)
[<c0042bc4>] (generic_handle_irq) from [<c01fe4ac>] (gpio_irq_handler+0xa4/0x12c)
[<c01fe4ac>] (gpio_irq_handler) from [<c0042bc4>] (generic_handle_irq+0x2c/0x3c)
[<c0042bc4>] (generic_handle_irq) from [<c0042dec>] (__handle_domain_irq+0x54/0xa8)
[<c0042dec>] (__handle_domain_irq) from [<c0013500>] (__irq_svc+0x40/0x54)
[<c0013500>] (__irq_svc) from [<c004451c>] (__setup_irq+0x248/0x530)
[<c004451c>] (__setup_irq) from [<c0044954>] (request_threaded_irq+0xc4/0x144)
[<c0044954>] (request_threaded_irq) from [<c02f5a0c>] (ohci_hcd_at91_drv_probe+0x460/0x518)
[<c02f5a0c>] (ohci_hcd_at91_drv_probe) from [<c02670ec>] (platform_drv_probe+0x44/0xa4)
[<c02670ec>] (platform_drv_probe) from [<c02655b4>] (driver_probe_device+0x1fc/0x43c)
[<c02655b4>] (driver_probe_device) from [<c0265880>] (__driver_attach+0x8c/0x90)
[<c0265880>] (__driver_attach) from [<c0263880>] (bus_for_each_dev+0x6c/0xa0)
[<c0263880>] (bus_for_each_dev) from [<c0264b80>] (bus_add_driver+0x1d0/0x268)
[<c0264b80>] (bus_add_driver) from [<c0266078>] (driver_register+0x78/0xf8)
[<c0266078>] (driver_register) from [<c00096c8>] (do_one_initcall+0xb8/0x1f0)
[<c00096c8>] (do_one_initcall) from [<c068bda4>] (kernel_init_freeable+0x138/0x1d8)
[<c068bda4>] (kernel_init_freeable) from [<c04d06f4>] (kernel_init+0x8/0xe8)
[<c04d06f4>] (kernel_init) from [<c000ff68>] (ret_from_fork+0x14/0x2c)
Code: e5916058 e1a08000 e3a04000 e2865008 (e5b50004)
---[ end trace e66fbc480972ac43 ]---
Kernel panic - not syncing: Fatal exception in interrupt
---[ end Kernel panic - not syncing: Fatal exception in interrupt
