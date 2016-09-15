From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 Sep 2016 15:50:55 +0200
Subject: [REGRESSION] BISECTED : ethernet gadget not working anymore on
 several atmel platforms
In-Reply-To: <CACQ1gAhUDq4G5Prjp0Fp2yY7++c3TNHuHZj=_st4JTVCLO1wRA@mail.gmail.com>
References: <CACQ1gAhUDq4G5Prjp0Fp2yY7++c3TNHuHZj=_st4JTVCLO1wRA@mail.gmail.com>
Message-ID: <20160915135055.tycoar3bvoqturcq@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15/09/2016 at 14:29:24 +0200, Richard Genoud wrote :
> Since:
> commit c32b5bcfa3c43a3c9bb59f65b5e76adb7384c4c8
> Author: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Date:   Tue Jul 12 22:45:59 2016 +0200
> 
>     ARM: dts: at91: Fix USB endpoint nodes
> 
>     Endpoint nodes have a reg property. Add their mandatory unit-address.
> 
> Booting with an USB gadget configured as Ethernet gadget + RNDIS

Good catch, I seem to have forgotten a patch in that series. I4ll send
that shortly.

> Gives a warning:
> 
> On AT91SAM9x5 platform (g35) :
> g_ether gadget: high-speed config #1: CDC Ethernet (ECM)
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at drivers/usb/gadget/udc/core.c:264
> usb_ep_queue+0x4c/0xec
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.8.0-rc6-00071-gcc183ac148d0 #134
> Hardware name: Atmel AT91SAM9
> [<c000f164>] (unwind_backtrace) from [<c000d158>] (show_stack+0x20/0x24)
> [<c000d158>] (show_stack) from [<c01ba940>] (dump_stack+0x20/0x28)
> [<c01ba940>] (dump_stack) from [<c0017f30>] (__warn+0xe0/0x10c)
> [<c0017f30>] (__warn) from [<c001802c>] (warn_slowpath_null+0x30/0x38)
> [<c001802c>] (warn_slowpath_null) from [<c02cd78c>] (usb_ep_queue+0x4c/0xec)
> [<c02cd78c>] (usb_ep_queue) from [<c02d55b8>] (ecm_do_notify+0x134/0x150)
> [<c02d55b8>] (ecm_do_notify) from [<c02d5840>] (ecm_set_alt+0x14c/0x154)
> [<c02d5840>] (ecm_set_alt) from [<c02c9144>] (composite_setup+0xa2c/0x13c0)
> [<c02c9144>] (composite_setup) from [<c02d3a90>] (usba_udc_irq+0x888/0xb4c)
> [<c02d3a90>] (usba_udc_irq) from [<c00458a0>]
> (__handle_irq_event_percpu+0x74/0x1dc)
> [<c00458a0>] (__handle_irq_event_percpu) from [<c0045a34>]
> (handle_irq_event_percpu+0x2c/0x68)
> [<c0045a34>] (handle_irq_event_percpu) from [<c0045aa8>]
> (handle_irq_event+0x38/0x4c)
> [<c0045aa8>] (handle_irq_event) from [<c0048a94>]
> (handle_fasteoi_irq+0xa0/0x114)
> [<c0048a94>] (handle_fasteoi_irq) from [<c004512c>]
> (generic_handle_irq+0x28/0x38)
> [<c004512c>] (generic_handle_irq) from [<c00451cc>]
> (__handle_domain_irq+0x90/0xb8)
> [<c00451cc>] (__handle_domain_irq) from [<c0009450>] (aic_handle+0xb0/0xb8)
> [<c0009450>] (aic_handle) from [<c000dca8>] (__irq_svc+0x68/0x84)
> Exception stack(0xc788dc68 to 0xc788dcb0)
> dc60:                   00000151 000004f6 00000151 c7075b70 c89693b0 c8964000
> dc80: c79c7400 000060e8 c79aa000 c7bd55c0 00000023 c788dd3c c788dd00 c788dcb8
> dca0: c0319cc0 c0319cd4 80000013 ffffffff
> [<c000dca8>] (__irq_svc) from [<c0319cd4>] (ubi_attach_fastmap+0x858/0xcc8)
> [<c0319cd4>] (ubi_attach_fastmap) from [<c0278744>]
> (ubi_scan_fastmap+0x644/0x854)
> [<c0278744>] (ubi_scan_fastmap) from [<c027542c>] (scan_fast+0x10c/0x17c)
> [<c027542c>] (scan_fast) from [<c02757c0>] (ubi_attach+0xb0/0x21c)
> [<c02757c0>] (ubi_attach) from [<c0269520>] (ubi_attach_mtd_dev+0x320/0x820)
> [<c0269520>] (ubi_attach_mtd_dev) from [<c06b42d4>] (ubi_init+0x1a8/0x248)
> [<c06b42d4>] (ubi_init) from [<c0697df0>] (do_one_initcall+0xb4/0x16c)
> [<c0697df0>] (do_one_initcall) from [<c0697fb0>]
> (kernel_init_freeable+0x108/0x1d4)
> [<c0697fb0>] (kernel_init_freeable) from [<c04e3c84>] (kernel_init+0x18/0x100)
> [<c04e3c84>] (kernel_init) from [<c000a470>] (ret_from_fork+0x14/0x24)
> ---[ end trace 8150ab0dc38dec93 ]---
> 
> Same on SAMA5D3:
> g_ether gadget: high-speed config #1: CDC Ethernet (ECM)
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at drivers/usb/gadget/udc/core.c:264
> usb_ep_queue+0x5c/0x64
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.8.0-rc6+ #135
> Hardware name: Atmel SAMA5
> [<c010ce70>] (unwind_backtrace) from [<c010a88c>] (show_stack+0x10/0x14)
> [<c010a88c>] (show_stack) from [<c0115bb0>] (__warn+0xe4/0xfc)
> [<c0115bb0>] (__warn) from [<c0115c78>] (warn_slowpath_null+0x20/0x28)
> [<c0115c78>] (warn_slowpath_null) from [<c03cc608>] (usb_ep_queue+0x5c/0x64)
> [<c03cc608>] (usb_ep_queue) from [<c03d1124>] (ecm_do_notify+0xec/0x14c)
> [<c03d1124>] (ecm_do_notify) from [<c03d130c>] (ecm_set_alt+0x74/0x150)
> [<c03d130c>] (ecm_set_alt) from [<c03c9364>] (composite_setup+0xb84/0x1570)
> [<c03c9364>] (composite_setup) from [<c03cf364>] (usba_udc_irq+0x878/0xd4c)
> [<c03cf364>] (usba_udc_irq) from [<c013f12c>]
> (__handle_irq_event_percpu+0x88/0x124)
> [<c013f12c>] (__handle_irq_event_percpu) from [<c013f1e4>]
> (handle_irq_event_percpu+0x1c/0x58)
> [<c013f1e4>] (handle_irq_event_percpu) from [<c013f248>]
> (handle_irq_event+0x28/0x3c)
> [<c013f248>] (handle_irq_event) from [<c0141c8c>]
> (handle_fasteoi_irq+0xa0/0x168)
> [<c0141c8c>] (handle_fasteoi_irq) from [<c013e87c>]
> (generic_handle_irq+0x24/0x34)
> [<c013e87c>] (generic_handle_irq) from [<c013ead8>]
> (__handle_domain_irq+0x54/0xa8)
> [<c013ead8>] (__handle_domain_irq) from [<c010b34c>] (__irq_svc+0x6c/0x90)
> [<c010b34c>] (__irq_svc) from [<c0130be4>] (finish_task_switch+0x4c/0x144)
> [<c0130be4>] (finish_task_switch) from [<c054b9d0>] (schedule+0x44/0x9c)
> [<c054b9d0>] (schedule) from [<c054bbd4>] (schedule_preempt_disabled+0xc/0x10)
> [<c054bbd4>] (schedule_preempt_disabled) from [<c01374b8>]
> (cpu_startup_entry+0x98/0xf4)
> [<c01374b8>] (cpu_startup_entry) from [<c0800c38>] (start_kernel+0x35c/0x368)
> [<c0800c38>] (start_kernel) from [<20008078>] (0x20008078)
> ---[ end trace 27b3e952067e1be6 ]---
> 
> And I guess it's the same on g45, 9rl, sama5d[2-4].
> 
> Bisect done with a 4.8-rc6 kernel.
> Here's the bisect log:
> git bisect start 'arch/arm/boot/dts/'
> # good: [882bd9fc46321c9d4721b376039a142cbfe8a17a] usb: gadget: udc:
> atmel: Also get regmap for at91sam9x5-pmc
> git bisect good 882bd9fc46321c9d4721b376039a142cbfe8a17a
> # bad: [694d0d0bb2030d2e36df73e2d23d5770511dbc8d] Linux 4.8-rc2
> git bisect bad 694d0d0bb2030d2e36df73e2d23d5770511dbc8d
> # good: [ab4b4340c7d74310a132cb457665bf3d98fdff79] Merge tag
> 'imx-dt-4.8' of
> git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into
> next/dt
> git bisect good ab4b4340c7d74310a132cb457665bf3d98fdff79
> # good: [349f9d5239c3dae3b984679fc9ee00b8deec542b] Merge tag
> 'sunxi-dt-for-4.8' of
> https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux into
> next/dt
> git bisect good 349f9d5239c3dae3b984679fc9ee00b8deec542b
> # bad: [262a5d84b2aea8deb67eca813dc3008836330596] Merge tag
> 'sunxi-dt-for-4.8-2-bis' of
> https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux into
> next/dt
> git bisect bad 262a5d84b2aea8deb67eca813dc3008836330596
> # good: [cda1c2bdf6df90c12363877fda594a0a1b7ac74a] Merge tag
> 'sti-late-v4.8' of
> git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti into
> next/late
> git bisect good cda1c2bdf6df90c12363877fda594a0a1b7ac74a
> # good: [a0e4eb4b81b44663f21b289d8126ca6f6dc8a863] ARM: dts: sun8i:
> Use sun8i-reference-design-tablet for polaroid mid2809pxe04
> git bisect good a0e4eb4b81b44663f21b289d8126ca6f6dc8a863
> # bad: [d3c1c7181f55f3464529decad189f2317a2932da] ARM: dts: at91:
> vinco: fix regulator name
> git bisect bad d3c1c7181f55f3464529decad189f2317a2932da
> # bad: [a63f6a64cc1e78366382657cab70772240b6dcc2] ARM: dts: at91:
> sama5d3_xplained: fix regulator name
> git bisect bad a63f6a64cc1e78366382657cab70772240b6dcc2
> # bad: [c32b5bcfa3c43a3c9bb59f65b5e76adb7384c4c8] ARM: dts: at91: Fix
> USB endpoint nodes
> git bisect bad c32b5bcfa3c43a3c9bb59f65b5e76adb7384c4c8
> # good: [c94afa132b6d7f8e412a12da44da6203d2cd23d4] ARM: dts: at91: Fix
> ADC trigger nodes
> git bisect good c94afa132b6d7f8e412a12da44da6203d2cd23d4
> # first bad commit: [c32b5bcfa3c43a3c9bb59f65b5e76adb7384c4c8] ARM:
> dts: at91: Fix USB endpoint nodes
> 
> on xplained board, I used at91-sama5d3_xplained.dtb and sama5_defconfig plus :
> CONFIG_USB_ETH=y
> CONFIG_USB_ETH_RNDIS=y

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
