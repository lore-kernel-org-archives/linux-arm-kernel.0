From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 31 Jul 2014 12:42:56 -0700
Subject: BUG: sleeping function called from invalid context at
 include/linux/clk.h:117
In-Reply-To: <53DA19B3.4090608@raritan.com>
References: <53D8E3EA.70500@raritan.com> <53DA19B3.4090608@raritan.com>
Message-ID: <20140731194256.4463.25477@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ronald Wahl (2014-07-31 03:25:55)
> On 30.07.2014 14:24, Ronald Wahl wrote:
> > Hi,
> >
> > after updating from 3.10.44 to 3.14.14 I get the following trace:
> >
> > [ 9957.810964] BUG: sleeping function called from invalid context at include/linux/clk.h:117
> > [ 9957.819069] in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper
> > [ 9957.825640] CPU: 0 PID: 0 Comm: swapper Tainted: G           O 3.14.14+ #2
> > [ 9957.832514] [<c000e790>] (unwind_backtrace) from [<c000cb10>] (show_stack+0x20/0x24)
> > [ 9957.840194] [<c000cb10>] (show_stack) from [<c0456d40>] (dump_stack+0x20/0x28)
> > [ 9957.847357] [<c0456d40>] (dump_stack) from [<c00432f4>] (__might_sleep+0xf8/0x118)
> > [ 9957.854880] [<c00432f4>] (__might_sleep) from [<c02aef0c>] (clk_on+0x44/0xa0)
> > [ 9957.861963] [<c02aef0c>] (clk_on) from [<c02afa18>] (pullup+0x74/0x11c)
> > [ 9957.868528] [<c02afa18>] (pullup) from [<c02afb2c>] (at91_vbus_session+0x6c/0xa0)
> > [ 9957.875958] [<c02afb2c>] (at91_vbus_session) from [<c02afbb4>] (at91_vbus_irq+0x54/0x64)
> > [ 9957.883997] [<c02afbb4>] (at91_vbus_irq) from [<c0054084>] (handle_irq_event_percpu+0xa8/0x28c)
> > [ 9957.892632] [<c0054084>] (handle_irq_event_percpu) from [<c00542b8>] (handle_irq_event+0x50/0x6c)
> > [ 9957.901445] [<c00542b8>] (handle_irq_event) from [<c00568e4>] (handle_simple_irq+0xb0/0xc8)
> > [ 9957.909739] [<c00568e4>] (handle_simple_irq) from [<c00537f4>] (generic_handle_irq+0x30/0x40)
> > [ 9957.918212] [<c00537f4>] (generic_handle_irq) from [<c0015f6c>] (gpio_irq_handler+0xb4/0xe4)
> > [ 9957.926586] [<c0015f6c>] (gpio_irq_handler) from [<c00537f4>] (generic_handle_irq+0x30/0x40)
> > [ 9957.934964] [<c00537f4>] (generic_handle_irq) from [<c0009fec>] (handle_IRQ+0x70/0x90)
> > [ 9957.942824] [<c0009fec>] (handle_IRQ) from [<c0008710>] (at91_aic_handle_irq+0x44/0x4c)
> > [ 9957.950773] [<c0008710>] (at91_aic_handle_irq) from [<c045caa4>] (__irq_svc+0x44/0x54)
> > [ 9957.958617] Exception stack(0xc06bff38 to 0xc06bff80)
> > [ 9957.963633] ff20:                                                       00000000 0005317f
> > [ 9957.971772] ff40: 00000000 60000013 c06be010 ffffffff c06be000 c06c6000 c3ff88a0 41069265
> > [ 9957.979895] ff60: 2069be8c c06bff8c c06bff80 c06bff80 c000a1c8 c000a1d4 60000013 ffffffff
> > [ 9957.988013] [<c045caa4>] (__irq_svc) from [<c000a1d4>] (arch_cpu_idle+0x40/0x48)
> > [ 9957.995358] [<c000a1d4>] (arch_cpu_idle) from [<c005372c>] (cpu_startup_entry+0x168/0x1d8)
> > [ 9958.003565] [<c005372c>] (cpu_startup_entry) from [<c0451fc8>] (rest_init+0x84/0x9c)
> > [ 9958.011266] [<c0451fc8>] (rest_init) from [<c0667a60>] (start_kernel+0x2c0/0x30c)
> >
> > Would be nice if this can be fixed quickly.
> 
> Further investigation showed that it might be caused by commit 
> 7628083227b6bc4a7e33d7c381d7a4e558424b6b (usb: gadget: at91_udc: prepare 
> clk before calling enable).
> 
> clk_prepare is not safe to be called in atomic context. Maybe clock 
> preparation should be done in at91udc_probe?

Yes, it is common to call clk_prepare from within a probe function. If
you are concerned about minimizing power consumption then you might call
clk_prepare_enable and clk_disable_unprepare from your driver's process
context logic. It's just a matter of how your driver is designed.

For very fine-grained power management you might call
clk_enable/clk_disable from interrupt context, but note that you MUST
have called (and completed) clk_prepare for that clock already (which as
you pointed out cannot be done in interrupt context).

Regards,
Mike

> 
> - ron
> 
> -- 
> Ronald Wahl - ronald.wahl at raritan.com - Phone +49 375271349-0 Fax -99
> Raritan Deutschland GmbH, Kornmarkt 7, 08056 Zwickau, Germany
> USt-IdNr. DE813094160, Steuer-Nr. 227/117/01749
> Amtsgericht Chemnitz HRB 23605
> Gesch?ftsf?hrung: Stuart Hopper, Ralf Ploenes
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
