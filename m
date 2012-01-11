From: Jon.Povey@racelogic.co.uk (Jon Povey)
Date: Wed, 11 Jan 2012 11:47:34 +0000
Subject: DaVinci unbanked GPIO IRQs broken
Message-ID: <70E876B0EA86DD4BAF101844BC814DFE0BF3FFD2EF@Cloud.RL.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unbanked GPIO IRQs (I am on DM365) seem to have been broken
by commit aac4dd1dab8acfc244d697473d2a5f4424a5746c, conversion
to generic irq chip, leading to an oops from request_irq().

Please note I am on kernel 3.0.0-rc7 not the latest, although
I tried more recent gpio.c patches to no avail, I think this is
probably still broken in 3.2.

The problem seems to be with chip_data and chip getting overwritten
in davinci_gpio_irq_setup(), this was fixed for banked IRQs but not
unbanked. I had a go at fixing the overwrite of chip_data but it
still oopses in the same function, irq_gc_mask_set_bit().

Looking at the way gpio_irqchip_unbanked is copied from the irq and
modified looks pretty fishy but I am out of time to work on this
more (reverting the conversion to generic irq chip works for me).

Requesting an IRQ for example IRQ 44 for GPIO 0, I get a backtrace,
hopefuly my mail client won't mangle this too badly.

Unable to handle kernel paging request at virtual address febfffff
pgd = c22dc000
[febfffff] *pgd=00000000
Internal error: Oops: 801 [#1] PREEMPT
Modules linked in: mcu(+) edmak irqk cmemk
CPU: 0    Not tainted  (3.0.0-rc7+ #93)
PC is at irq_gc_mask_set_bit+0x68/0x7c
LR is at vprintk+0x22c/0x484
pc : [<c0080c0c>]    lr : [<c00457e0>]    psr: 60000093
sp : c33e3ba0  ip : c33e3af0  fp : c33e3bc4
r10: c04555bc  r9 : c33d4340  r8 : 60000013
r7 : 0000002d  r6 : c04555bc  r5 : fec67010  r4 : 00000000
r3 : c04734c8  r2 : fec00000  r1 : ffffffff  r0 : 00000026
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 822dc000  DAC: 00000015
Process modprobe (pid: 526, stack limit = 0xc33e2270)
Stack: (0xc33e3ba0 to 0xc33e4000)
3ba0: 00000000 c007d3d4 c33e3bcc c04555bc c04555bc c33d4340 c33e3bdc c33e3bc8
3bc0: c007f5f8 c0080bb4 00000000 c04555bc c33e3bf4 c33e3be0 c007f654 c007f5c0
3be0: 00000000 c04555bc c33e3c24 c33e3bf8 c007e6e8 c007f618 c01f2284 c0350af8
3c00: c0405214 bf016c98 00000001 00000000 c33dc008 0000002d c33e3c54 c33e3c28
3c20: c007e888 c007e408 00000001 c23ef880 c33dc000 00000000 c33dc080 c25caa00
3c40: c0487498 bf017078 c33e3c94 c33e3c58 bf016b44 c007e7d4 bf017078 c33dc008
3c60: c25caa08 c33dc008 c33e3c84 bf017484 c25caa00 c25caa00 c01f5f48 c25caa08
3c80: c0496d60 bf017484 c33e3ca4 c33e3c98 c022a698 bf01692c c33e3cd4 c33e3ca8
3ca0: c01f5d88 c022a688 00000000 bf017484 c25caa00 c25caa00 c01f5f48 c25caa08
3cc0: c0496d60 00000000 c33e3cec c33e3cd8 c01f5f8c c01f5d10 00000000 c33e3cf0
3ce0: c33e3d14 c33e3cf0 c01f5210 c01f5f58 c303cb48 c25ecf94 c25caa00 c25caa00
3d00: c25caa34 c33e3dd8 c33e3d34 c33e3d18 c01f6044 c01f51b8 c0496d3c c25caa00
3d20: c044e918 c33e3dd8 c33e3d44 c33e3d38 c01f4ff4 c01f5fcc c33e3d94 c33e3d48
3d40: c01f3d10 c01f4fd8 00000000 c044e918 00000000 00000000 c01f52c0 c034d570
3d60: c33e3d84 c33e3d70 c022bf84 c25caa00 00000000 c044e918 c33e3dd8 c25c2e00
3d80: c0496d60 bf01763c c33e3db4 c33e3d98 c022b1a0 c01f384c c25caa00 c33e3dd8
3da0: 00000000 c33e3dd8 c33e3dd4 c33e3db8 c022b27c c022b0e8 00000000 bf01763c
3dc0: c0451c80 c33e3dd8 c33e3e34 c33e3dd8 bf016f60 c022b210 5f75636d 746e6f63
3de0: 006c6f72 00000000 00000000 00000000 00000000 00000000 00000000 bf0174bc
3e00: 00000000 00989680 00000000 00000020 c0451c80 c0451c80 bf0174dc c01f5eb0
3e20: c33f0f00 bf0174dc c33e3e44 c33e3e38 c01f72f4 bf016e2c c33e3e74 c33e3e48
3e40: c01f5d88 c01f72e4 00000000 c0451c80 c0451cb4 bf0174dc c01f5eb0 c33f0f00
3e60: c0473100 00000000 c33e3e94 c33e3e78 c01f5f44 c01f5d10 00000000 c33e3e98
3e80: bf0174dc c01f5eb0 c33e3ebc c33e3e98 c01f5534 c01f5ec0 c303c038 c3061c30
3ea0: 00003cd8 00098258 bf0174dc c0462ac8 c33e3ecc c33e3ec0 c01f5bec c01f54dc
3ec0: c33e3efc c33e3ed0 c01f4d30 c01f5bdc bf0173a0 c33e2000 00003cd8 00098258
3ee0: bf0174dc c33e2000 c00301a4 bf019000 c33e3f1c c33e3f00 c01f6588 c01f4c8c
3f00: 00003cd8 00098258 00000000 c33e2000 c33e3f2c c33e3f20 c01f777c c01f6524
3f20: c33e3f3c c33e3f30 bf019014 c01f7740 c33e3f7c c33e3f40 c002f3ec bf019010
3f40: 00000000 00003cd8 00098258 bf017518 00000000 00003cd8 00098258 bf017518
3f60: 00000000 c00301a4 c33e2000 00000000 c33e3fa4 c33e3f80 c007b934 c002f3c4
3f80: c00b307c c00b2f48 00003cd8 00000000 00000003 00000080 00000000 c33e3fa8
3fa0: c0030020 c007b8b8 00003cd8 00000000 00098288 00003cd8 00098258 00098240
3fc0: 00003cd8 00000000 00000003 00000080 00098008 00098028 00098288 00000001
3fe0: be892998 be892988 00013d7c 40178740 60000010 00098288 09089041 00200845
Backtrace:
[<c0080ba4>] (irq_gc_mask_set_bit+0x0/0x7c) from [<c007f5f8>] (irq_enable+0x48/0x58)
 r6:c33d4340 r5:c04555bc r4:c04555bc
[<c007f5b0>] (irq_enable+0x0/0x58) from [<c007f654>] (irq_startup+0x4c/0x54)
 r5:c04555bc r4:00000000
[<c007f608>] (irq_startup+0x0/0x54) from [<c007e6e8>] (__setup_irq+0x2f0/0x3cc)
 r5:c04555bc r4:00000000
[<c007e3f8>] (__setup_irq+0x0/0x3cc) from [<c007e888>] (request_threaded_irq+0xc4/0x110)
 r8:0000002d r7:c33dc008 r6:00000000 r5:00000001 r4:bf016c98
[<c007e7c4>] (request_threaded_irq+0x0/0x110) from [<bf016b44>] (mcu_spi_probe+0x228/0x37c [mcu])
[<bf01691c>] (mcu_spi_probe+0x0/0x37c [mcu]) from [<c022a698>] (spi_drv_probe+0x20/0x24)
[<c022a678>] (spi_drv_probe+0x0/0x24) from [<c01f5d88>] (driver_probe_device+0x88/0x1b0)
[<c01f5d00>] (driver_probe_device+0x0/0x1b0) from [<c01f5f8c>] (__device_attach+0x44/0x48)
[<c01f5f48>] (__device_attach+0x0/0x48) from [<c01f5210>] (bus_for_each_drv+0x68/0x94)
 r5:c33e3cf0 r4:00000000
[<c01f51a8>] (bus_for_each_drv+0x0/0x94) from [<c01f6044>] (device_attach+0x88/0xa0)
 r7:c33e3dd8 r6:c25caa34 r5:c25caa00 r4:c25caa00
[<c01f5fbc>] (device_attach+0x0/0xa0) from [<c01f4ff4>] (bus_probe_device+0x2c/0x4c)
 r7:c33e3dd8 r6:c044e918 r5:c25caa00 r4:c0496d3c
[<c01f4fc8>] (bus_probe_device+0x0/0x4c) from [<c01f3d10>] (device_add+0x4d4/0x648)
[<c01f383c>] (device_add+0x0/0x648) from [<c022b1a0>] (spi_add_device+0xc8/0x128)
[<c022b0d8>] (spi_add_device+0x0/0x128) from [<c022b27c>] (spi_new_device+0x7c/0xb4)
 r7:c33e3dd8 r6:00000000 r5:c33e3dd8 r4:c25caa00
[<c022b200>] (spi_new_device+0x0/0xb4) from [<bf016f60>] (mcu_probe+0x144/0x224 [mcu])
 r7:c33e3dd8 r6:c0451c80 r5:bf01763c r4:00000000
[<bf016e1c>] (mcu_probe+0x0/0x224 [mcu]) from [<c01f72f4>] (platform_drv_probe+0x20/0x24)
[<c01f72d4>] (platform_drv_probe+0x0/0x24) from [<c01f5d88>] (driver_probe_device+0x88/0x1b0)
[<c01f5d00>] (driver_probe_device+0x0/0x1b0) from [<c01f5f44>] (__driver_attach+0x94/0x98)
[<c01f5eb0>] (__driver_attach+0x0/0x98) from [<c01f5534>] (bus_for_each_dev+0x68/0x94)
 r7:c01f5eb0 r6:bf0174dc r5:c33e3e98 r4:00000000
[<c01f54cc>] (bus_for_each_dev+0x0/0x94) from [<c01f5bec>] (driver_attach+0x20/0x28)
 r7:c0462ac8 r6:bf0174dc r5:00098258 r4:00003cd8
[<c01f5bcc>] (driver_attach+0x0/0x28) from [<c01f4d30>] (bus_add_driver+0xb4/0x258)
[<c01f4c7c>] (bus_add_driver+0x0/0x258) from [<c01f6588>] (driver_register+0x74/0x158)
[<c01f6514>] (driver_register+0x0/0x158) from [<c01f777c>] (platform_driver_register+0x4c/0x60)
 r7:c33e2000 r6:00000000 r5:00098258 r4:00003cd8
[<c01f7730>] (platform_driver_register+0x0/0x60) from [<bf019014>] (mcu_init+0x14/0x20 [mcu])
[<bf019000>] (mcu_init+0x0/0x20 [mcu]) from [<c002f3ec>] (do_one_initcall+0x38/0x170)
[<c002f3b4>] (do_one_initcall+0x0/0x170) from [<c007b934>] (sys_init_module+0x8c/0x1a4)
[<c007b8a8>] (sys_init_module+0x0/0x1a4) from [<c0030020>] (ret_fast_syscall+0x0/0x2c)
 r7:00000080 r6:00000003 r5:00000000 r4:00003cd8
Code: e1844003 e585400c e596300c e5932064 (e7814002)
---[ end trace 1820e9849d265227 ]---
note: modprobe[526] exited with preempt_count 1
BUG: scheduling while atomic: modprobe/526/0x40000002
Modules linked in: mcu(+) edmak irqk cmemk
Backtrace:
[<c0032ee0>] (dump_backtrace+0x0/0x10c) from [<c0350934>] (dump_stack+0x18/0x1c)
 r7:0008d000 r6:c25cf600 r5:0008d000 r4:00000000
[<c035091c>] (dump_stack+0x0/0x1c) from [<c003d71c>] (__schedule_bug+0x54/0x60)
[<c003d6c8>] (__schedule_bug+0x0/0x60) from [<c0350fc8>] (schedule+0x320/0x460)
 r5:0008d000 r4:00000000
[<c0350ca8>] (schedule+0x0/0x460) from [<c003d9f8>] (__cond_resched+0x18/0x24)
[<c003d9e0>] (__cond_resched+0x0/0x24) from [<c03512a0>] (_cond_resched+0x3c/0x44)
[<c0351264>] (_cond_resched+0x0/0x44) from [<c00a0b2c>] (unmap_vmas+0x2bc/0x64c)
[<c00a0870>] (unmap_vmas+0x0/0x64c) from [<c00a365c>] (exit_mmap+0x134/0x2d0)
[<c00a3528>] (exit_mmap+0x0/0x2d0) from [<c004274c>] (mmput+0x40/0xf8)
[<c004270c>] (mmput+0x0/0xf8) from [<c00469e0>] (exit_mm+0x154/0x1b8)
 r5:c2aa9a80 r4:c25cf600
[<c004688c>] (exit_mm+0x0/0x1b8) from [<c0048900>] (do_exit+0x590/0x750)
 r7:c03e78f8 r6:00000801 r5:c33e2000 r4:0000000b
[<c0048370>] (do_exit+0x0/0x750) from [<c0033450>] (die+0x1bc/0x1e4)
[<c0033294>] (die+0x0/0x1e4) from [<c0034fec>] (__do_kernel_fault+0x6c/0x8c)
[<c0034f80>] (__do_kernel_fault+0x0/0x8c) from [<c003523c>] (do_bad_area+0x48/0x70)
 r9:bf000000 r8:00000000 r7:00000000 r6:e7814002 r5:c04732f8
r4:fec00000
[<c00351f4>] (do_bad_area+0x0/0x70) from [<c0036f84>] (do_alignment+0xf4/0x748)
[<c0036e90>] (do_alignment+0x0/0x748) from [<c002f320>] (do_DataAbort+0x3c/0xa0)
[<c002f2e4>] (do_DataAbort+0x0/0xa0) from [<c002fbcc>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc33e3b58 to 0xc33e3ba0)
3b40:                                                       00000026 ffffffff
3b60: fec00000 c04734c8 00000000 fec67010 c04555bc 0000002d 60000013 c33d4340
3b80: c04555bc c33e3bc4 c33e3af0 c33e3ba0 c00457e0 c0080c0c 60000093 ffffffff
 r8:60000013 r7:0000002d r6:c04555bc r5:c33e3b8c r4:ffffffff
[<c0080ba4>] (irq_gc_mask_set_bit+0x0/0x7c) from [<c007f5f8>] (irq_enable+0x48/0x58)
 r6:c33d4340 r5:c04555bc r4:c04555bc
[<c007f5b0>] (irq_enable+0x0/0x58) from [<c007f654>] (irq_startup+0x4c/0x54)
 r5:c04555bc r4:00000000
[<c007f608>] (irq_startup+0x0/0x54) from [<c007e6e8>] (__setup_irq+0x2f0/0x3cc)
 r5:c04555bc r4:00000000
[<c007e3f8>] (__setup_irq+0x0/0x3cc) from [<c007e888>] (request_threaded_irq+0xc4/0x110)
 r8:0000002d r7:c33dc008 r6:00000000 r5:00000001 r4:bf016c98
[<c007e7c4>] (request_threaded_irq+0x0/0x110) from [<bf016b44>] (mcu_spi_probe+0x228/0x37c [mcu])
[<bf01691c>] (mcu_spi_probe+0x0/0x37c [mcu]) from [<c022a698>] (spi_drv_probe+0x20/0x24)
[<c022a678>] (spi_drv_probe+0x0/0x24) from [<c01f5d88>] (driver_probe_device+0x88/0x1b0)
[<c01f5d00>] (driver_probe_device+0x0/0x1b0) from [<c01f5f8c>] (__device_attach+0x44/0x48)
[<c01f5f48>] (__device_attach+0x0/0x48) from [<c01f5210>] (bus_for_each_drv+0x68/0x94)
 r5:c33e3cf0 r4:00000000
[<c01f51a8>] (bus_for_each_drv+0x0/0x94) from [<c01f6044>] (device_attach+0x88/0xa0)
 r7:c33e3dd8 r6:c25caa34 r5:c25caa00 r4:c25caa00
[<c01f5fbc>] (device_attach+0x0/0xa0) from [<c01f4ff4>] (bus_probe_device+0x2c/0x4c)
 r7:c33e3dd8 r6:c044e918 r5:c25caa00 r4:c0496d3c
[<c01f4fc8>] (bus_probe_device+0x0/0x4c) from [<c01f3d10>] (device_add+0x4d4/0x648)
[<c01f383c>] (device_add+0x0/0x648) from [<c022b1a0>] (spi_add_device+0xc8/0x128)
[<c022b0d8>] (spi_add_device+0x0/0x128) from [<c022b27c>] (spi_new_device+0x7c/0xb4)
 r7:c33e3dd8 r6:00000000 r5:c33e3dd8 r4:c25caa00
[<c022b200>] (spi_new_device+0x0/0xb4) from [<bf016f60>] (mcu_probe+0x144/0x224 [mcu])
 r7:c33e3dd8 r6:c0451c80 r5:bf01763c r4:00000000
[<bf016e1c>] (mcu_probe+0x0/0x224 [mcu]) from [<c01f72f4>] (platform_drv_probe+0x20/0x24)
[<c01f72d4>] (platform_drv_probe+0x0/0x24) from [<c01f5d88>] (driver_probe_device+0x88/0x1b0)
[<c01f5d00>] (driver_probe_device+0x0/0x1b0) from [<c01f5f44>] (__driver_attach+0x94/0x98)
[<c01f5eb0>] (__driver_attach+0x0/0x98) from [<c01f5534>] (bus_for_each_dev+0x68/0x94)
 r7:c01f5eb0 r6:bf0174dc r5:c33e3e98 r4:00000000
[<c01f54cc>] (bus_for_each_dev+0x0/0x94) from [<c01f5bec>] (driver_attach+0x20/0x28)
 r7:c0462ac8 r6:bf0174dc r5:00098258 r4:00003cd8
[<c01f5bcc>] (driver_attach+0x0/0x28) from [<c01f4d30>] (bus_add_driver+0xb4/0x258)
[<c01f4c7c>] (bus_add_driver+0x0/0x258) from [<c01f6588>] (driver_register+0x74/0x158)
[<c01f6514>] (driver_register+0x0/0x158) from [<c01f777c>] (platform_driver_register+0x4c/0x60)
 r7:c33e2000 r6:00000000 r5:00098258 r4:00003cd8
[<c01f7730>] (platform_driver_register+0x0/0x60) from [<bf019014>] (mcu_init+0x14/0x20 [mcu])
[<bf019000>] (mcu_init+0x0/0x20 [mcu]) from [<c002f3ec>] (do_one_initcall+0x38/0x170)
[<c002f3b4>] (do_one_initcall+0x0/0x170) from [<c007b934>] (sys_init_module+0x8c/0x1a4)
[<c007b8a8>] (sys_init_module+0x0/0x1a4) from [<c0030020>] (ret_fast_syscall+0x0/0x2c)
 r7:00000080 r6:00000003 r5:00000000 r4:00003cd8
BUG: scheduling while atomic: modprobe/526/0x40000002
Modules linked in: mcu(+) edmak irqk cmemk
Backtrace:
[<c0032ee0>] (dump_backtrace+0x0/0x10c) from [<c0350934>] (dump_stack+0x18/0x1c)
 r7:00000000 r6:c25cf600 r5:00000007 r4:00000000
[<c035091c>] (dump_stack+0x0/0x1c) from [<c003d71c>] (__schedule_bug+0x54/0x60)
[<c003d6c8>] (__schedule_bug+0x0/0x60) from [<c0350fc8>] (schedule+0x320/0x460)
 r5:00000007 r4:00000000
[<c0350ca8>] (schedule+0x0/0x460) from [<c003d9f8>] (__cond_resched+0x18/0x24)
[<c003d9e0>] (__cond_resched+0x0/0x24) from [<c03512a0>] (_cond_resched+0x3c/0x44)
[<c0351264>] (_cond_resched+0x0/0x44) from [<c0046c1c>] (put_files_struct+0xd0/0xf0)
[<c0046b4c>] (put_files_struct+0x0/0xf0) from [<c0046ca0>] (exit_files+0x64/0x68)
[<c0046c3c>] (exit_files+0x0/0x68) from [<c0048910>] (do_exit+0x5a0/0x750)
 r5:c33e2000 r4:0000000b
[<c0048370>] (do_exit+0x0/0x750) from [<c0033450>] (die+0x1bc/0x1e4)
[<c0033294>] (die+0x0/0x1e4) from [<c0034fec>] (__do_kernel_fault+0x6c/0x8c)
[<c0034f80>] (__do_kernel_fault+0x0/0x8c) from [<c003523c>] (do_bad_area+0x48/0x70)
 r9:bf000000 r8:00000000 r7:00000000 r6:e7814002 r5:c04732f8
r4:fec00000
[<c00351f4>] (do_bad_area+0x0/0x70) from [<c0036f84>] (do_alignment+0xf4/0x748)
[<c0036e90>] (do_alignment+0x0/0x748) from [<c002f320>] (do_DataAbort+0x3c/0xa0)
[<c002f2e4>] (do_DataAbort+0x0/0xa0) from [<c002fbcc>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc33e3b58 to 0xc33e3ba0)
3b40:                                                       00000026 ffffffff
3b60: fec00000 c04734c8 00000000 fec67010 c04555bc 0000002d 60000013 c33d4340
3b80: c04555bc c33e3bc4 c33e3af0 c33e3ba0 c00457e0 c0080c0c 60000093 ffffffff
 r8:60000013 r7:0000002d r6:c04555bc r5:c33e3b8c r4:ffffffff
[<c0080ba4>] (irq_gc_mask_set_bit+0x0/0x7c) from [<c007f5f8>] (irq_enable+0x48/0x58)
 r6:c33d4340 r5:c04555bc r4:c04555bc
[<c007f5b0>] (irq_enable+0x0/0x58) from [<c007f654>] (irq_startup+0x4c/0x54)
 r5:c04555bc r4:00000000
[<c007f608>] (irq_startup+0x0/0x54) from [<c007e6e8>] (__setup_irq+0x2f0/0x3cc)
 r5:c04555bc r4:00000000
[<c007e3f8>] (__setup_irq+0x0/0x3cc) from [<c007e888>] (request_threaded_irq+0xc4/0x110)
 r8:0000002d r7:c33dc008 r6:00000000 r5:00000001 r4:bf016c98
[<c007e7c4>] (request_threaded_irq+0x0/0x110) from [<bf016b44>] (mcu_spi_probe+0x228/0x37c [mcu])
[<bf01691c>] (mcu_spi_probe+0x0/0x37c [mcu]) from [<c022a698>] (spi_drv_probe+0x20/0x24)
[<c022a678>] (spi_drv_probe+0x0/0x24) from [<c01f5d88>] (driver_probe_device+0x88/0x1b0)
[<c01f5d00>] (driver_probe_device+0x0/0x1b0) from [<c01f5f8c>] (__device_attach+0x44/0x48)
[<c01f5f48>] (__device_attach+0x0/0x48) from [<c01f5210>] (bus_for_each_drv+0x68/0x94)
 r5:c33e3cf0 r4:00000000
[<c01f51a8>] (bus_for_each_drv+0x0/0x94) from [<c01f6044>] (device_attach+0x88/0xa0)
 r7:c33e3dd8 r6:c25caa34 r5:c25caa00 r4:c25caa00
[<c01f5fbc>] (device_attach+0x0/0xa0) from [<c01f4ff4>] (bus_probe_device+0x2c/0x4c)
 r7:c33e3dd8 r6:c044e918 r5:c25caa00 r4:c0496d3c
[<c01f4fc8>] (bus_probe_device+0x0/0x4c) from [<c01f3d10>] (device_add+0x4d4/0x648)
[<c01f383c>] (device_add+0x0/0x648) from [<c022b1a0>] (spi_add_device+0xc8/0x128)
[<c022b0d8>] (spi_add_device+0x0/0x128) from [<c022b27c>] (spi_new_device+0x7c/0xb4)
 r7:c33e3dd8 r6:00000000 r5:c33e3dd8 r4:c25caa00
[<c022b200>] (spi_new_device+0x0/0xb4) from [<bf016f60>] (mcu_probe+0x144/0x224 [mcu])
 r7:c33e3dd8 r6:c0451c80 r5:bf01763c r4:00000000
[<bf016e1c>] (mcu_probe+0x0/0x224 [mcu]) from [<c01f72f4>] (platform_drv_probe+0x20/0x24)
[<c01f72d4>] (platform_drv_probe+0x0/0x24) from [<c01f5d88>] (driver_probe_device+0x88/0x1b0)
[<c01f5d00>] (driver_probe_device+0x0/0x1b0) from [<c01f5f44>] (__driver_attach+0x94/0x98)
[<c01f5eb0>] (__driver_attach+0x0/0x98) from [<c01f5534>] (bus_for_each_dev+0x68/0x94)
 r7:c01f5eb0 r6:bf0174dc r5:c33e3e98 r4:00000000
[<c01f54cc>] (bus_for_each_dev+0x0/0x94) from [<c01f5bec>] (driver_attach+0x20/0x28)
 r7:c0462ac8 r6:bf0174dc r5:00098258 r4:00003cd8
[<c01f5bcc>] (driver_attach+0x0/0x28) from [<c01f4d30>] (bus_add_driver+0xb4/0x258)
[<c01f4c7c>] (bus_add_driver+0x0/0x258) from [<c01f6588>] (driver_register+0x74/0x158)
[<c01f6514>] (driver_register+0x0/0x158) from [<c01f777c>] (platform_driver_register+0x4c/0x60)
 r7:c33e2000 r6:00000000 r5:00098258 r4:00003cd8
[<c01f7730>] (platform_driver_register+0x0/0x60) from [<bf019014>] (mcu_init+0x14/0x20 [mcu])
[<bf019000>] (mcu_init+0x0/0x20 [mcu]) from [<c002f3ec>] (do_one_initcall+0x38/0x170)
[<c002f3b4>] (do_one_initcall+0x0/0x170) from [<c007b934>] (sys_init_module+0x8c/0x1a4)
[<c007b8a8>] (sys_init_module+0x0/0x1a4) from [<c0030020>] (ret_fast_syscall+0x0/0x2c)
 r7:00000080 r6:00000003 r5:00000000 r4:00003cd8

--
Jon Povey
jon.povey at racelogic.co.uk


Racelogic is a limited company registered in England. Registered number 2743719 .
Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .

The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network
