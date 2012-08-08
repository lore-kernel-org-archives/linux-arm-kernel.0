From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 08 Aug 2012 12:48:20 +0100
Subject: [PATCH] clk: convert ARM RealView to common clk
In-Reply-To: <1344270728-7550-1-git-send-email-linus.walleij@stericsson.com>
References: <1344270728-7550-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1344426500.2435.39.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-08-06 at 17:32 +0100, Linus Walleij wrote:
> This converts the ARM RealView machine over to using the common
> clock. The approach is similar to the one used for the Integrator,
> and we're reusing the ICST wrapper code.

I've just tried it with v3.6-rc1 and an EB Model and I get this:

------------[ cut here ]------------
WARNING: at /home/pawmol01/src/kernel.org/linux/kernel/timer.c:1076 del_timer_sync+0x34/0x5c()
Modules linked in:
[<c0014054>] (unwind_backtrace+0x0/0xe0) from [<c001ca3c>] (warn_slowpath_common+0x4c/0x64)
[<c001ca3c>] (warn_slowpath_common+0x4c/0x64) from [<c001ca6c>] (warn_slowpath_null+0x18/0x1c)
[<c001ca6c>] (warn_slowpath_null+0x18/0x1c) from [<c00285b8>] (del_timer_sync+0x34/0x5c)
[<c00285b8>] (del_timer_sync+0x34/0x5c) from [<c01d57e4>] (led_set_brightness+0x14/0x4c)
[<c01d57e4>] (led_set_brightness+0x14/0x4c) from [<c01d6270>] (led_trigger_event+0x30/0x70)
[<c01d6270>] (led_trigger_event+0x30/0x70) from [<c01c7ee8>] (mmc_request_done+0x68/0x90)
[<c01c7ee8>] (mmc_request_done+0x68/0x90) from [<c01d5770>] (mmci_irq+0x274/0x2d4)
[<c01d5770>] (mmci_irq+0x274/0x2d4) from [<c005a090>] (handle_irq_event_percpu+0x2c/0x170)
[<c005a090>] (handle_irq_event_percpu+0x2c/0x170) from [<c005a22c>] (handle_irq_event+0x58/0x78)
[<c005a22c>] (handle_irq_event+0x58/0x78) from [<c005ce68>] (handle_fasteoi_irq+0xcc/0x13c)
[<c005ce68>] (handle_fasteoi_irq+0xcc/0x13c) from [<c0059ae8>] (generic_handle_irq+0x20/0x30)
[<c0059ae8>] (generic_handle_irq+0x20/0x30) from [<c000eafc>] (handle_IRQ+0x78/0xb8)
[<c000eafc>] (handle_IRQ+0x78/0xb8) from [<c0008468>] (gic_handle_irq+0x3c/0x60)
[<c0008468>] (gic_handle_irq+0x3c/0x60) from [<c000d820>] (__irq_svc+0x40/0x54)
Exception stack(0xcf83be20 to 0xcf83be68)
be20: cfbfd26c 60000013 00130013 00000000 cf83be84 cfbfd000 00000000 cf83be94
be40: cf83beb8 c01c989c 00000000 00000000 00000000 cf83be68 c01c7f80 c02aaac0
be60: 40000013 ffffffff
[<c000d820>] (__irq_svc+0x40/0x54) from [<c02aaac0>] (_raw_spin_unlock_irqrestore+0x2c/0x30)
[<c02aaac0>] (_raw_spin_unlock_irqrestore+0x2c/0x30) from [<c01c7f80>] (mmc_wait_for_req_done+0x70/0x74)
[<c01c7f80>] (mmc_wait_for_req_done+0x70/0x74) from [<c01c83b8>] (mmc_wait_for_cmd+0x64/0x74)        
[<c01c83b8>] (mmc_wait_for_cmd+0x64/0x74) from [<c01cfcfc>] (mmc_send_io_op_cond+0x58/0xc4)
[<c01cfcfc>] (mmc_send_io_op_cond+0x58/0xc4) from [<c01cf8b0>] (mmc_attach_sdio+0x3c/0x304)
[<c01cf8b0>] (mmc_attach_sdio+0x3c/0x304) from [<c01c9ab0>] (mmc_rescan+0x214/0x290)
[<c01c9ab0>] (mmc_rescan+0x214/0x290) from [<c00328f4>] (process_one_work+0x240/0x3b8)
[<c00328f4>] (process_one_work+0x240/0x3b8) from [<c0032d70>] (worker_thread+0x2d8/0x434)
[<c0032d70>] (worker_thread+0x2d8/0x434) from [<c00373b0>] (kthread+0x84/0x94)
[<c00373b0>] (kthread+0x84/0x94) from [<c000ed44>] (kernel_thread_exit+0x0/0x8)
---[ end trace 93fc2bf490575317 ]---

I'm not sure who's fault it is (may be mine), will try to figure out
what is going on...

Cheers!

Pawe?
