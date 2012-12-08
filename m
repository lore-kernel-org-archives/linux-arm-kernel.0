From: linux-arm@dima.secretsauce.net (Dima Kogan)
Date: Fri, 7 Dec 2012 21:10:40 -0800
Subject: OMAP3 L3 application error interrupt receives "reserved" error
Message-ID: <20121207211040.58de6adb@shorty.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

This regards this bug report:

https://bugzilla.kernel.org/show_bug.cgi?id=51171

I'm using a Beagleboard xM with a v3.7-rc7 kernel. I bought a USB 802.11 adapter
based on the RTL8192 chip; the driver for this in in mainline. When bringing up
the network interface, I see this in the kernel log:


irq 26: nobody cared (try booting with the "irqpoll" option)
[<c0012fac>] (unwind_backtrace+0x0/0xf0) from [<c00924d4>] (__report_bad_irq+0x20/0xa4)
[<c00924d4>] (__report_bad_irq+0x20/0xa4) from [<c00926dc>] (note_interrupt+0x184/0x22c)
[<c00926dc>] (note_interrupt+0x184/0x22c) from [<c0090c84>] (handle_irq_event_percpu+0x1ec/0x220)
[<c0090c84>] (handle_irq_event_percpu+0x1ec/0x220) from [<c0090ce0>] (handle_irq_event+0x28/0x38)
[<c0090ce0>] (handle_irq_event+0x28/0x38) from [<c0092fc0>] (handle_level_irq+0xc8/0xf8)
[<c0092fc0>] (handle_level_irq+0xc8/0xf8) from [<c0090a88>] (generic_handle_irq+0x28/0x30)
[<c0090a88>] (generic_handle_irq+0x28/0x30) from [<c000e12c>] (handle_IRQ+0x60/0x84)
[<c000e12c>] (handle_IRQ+0x60/0x84) from [<c00086e8>] (omap3_intc_handle_irq+0x60/0x74)
[<c00086e8>] (omap3_intc_handle_irq+0x60/0x74) from [<c0442e80>] (__irq_svc+0x40/0x50)
Exception stack(0xc063de28 to 0xc063de70)
de20:                   00000000 00000000 00200000 0000000a c063c000 00000002
de40: 00000000 c06b0e40 552ebee6 00000010 00000000 c066394c 00000003 c063de70
de60: c0037d64 c0037b68 20000113 ffffffff
[<c0442e80>] (__irq_svc+0x40/0x50) from [<c0037b68>] (__do_softirq+0x58/0x1d4)
[<c0037b68>] (__do_softirq+0x58/0x1d4) from [<c0037d64>] (irq_exit+0x40/0x8c)
[<c0037d64>] (irq_exit+0x40/0x8c) from [<c000e130>] (handle_IRQ+0x64/0x84)
[<c000e130>] (handle_IRQ+0x64/0x84) from [<c00086e8>] (omap3_intc_handle_irq+0x60/0x74)
[<c00086e8>] (omap3_intc_handle_irq+0x60/0x74) from [<c0442e80>] (__irq_svc+0x40/0x50)
Exception stack(0xc063dee0 to 0xc063df28)
dee0: c063df28 00000045 00000000 fa200098 c064a638 c063df28 00000002 c064a3c0
df00: 552ebee6 00000010 00000000 00000010 00000010 c063df28 c0063798 c0350008
df20: 60000013 ffffffff
[<c0442e80>] (__irq_svc+0x40/0x50) from [<c0350008>] (cpuidle_wrap_enter+0x50/0xa4)
[<c0350008>] (cpuidle_wrap_enter+0x50/0xa4) from [<c0020c68>] (omap3_enter_idle_bm+0x12c/0x164)
[<c0020c68>] (omap3_enter_idle_bm+0x12c/0x164) from [<c034f9fc>] (cpuidle_enter+0x14/0x18)
[<c034f9fc>] (cpuidle_enter+0x14/0x18) from [<c034fa14>] (cpuidle_enter_state+0x14/0x68)
[<c034fa14>] (cpuidle_enter_state+0x14/0x68) from [<c0350190>] (cpuidle_idle_call+0x128/0x20c)
[<c0350190>] (cpuidle_idle_call+0x128/0x20c) from [<c000e5b4>] (cpu_idle+0x50/0xa8)
[<c000e5b4>] (cpu_idle+0x50/0xa8) from [<c060a680>] (start_kernel+0x290/0x2e0)
handlers:
[<c025abb8>] omap3_l3_app_irq
Disabling IRQ #26


Looking into it, IRQ 26 is the L3 application error interrupt. The ISR is
omap3_l3_app_irq() in drivers/bus/omap_l3_smx.c. I looked at pertinent variables
in that ISR, and I'm seeing this:

|     status | err_source | error |
|------------+------------+-------|
| 0x20000000 | 29         | 0     |

According to the documentation (page 642 of the OMAP35x Applications Processor
Technical Reference Manual), bit 29 of this register (L3_SI_FLAG_STATUS_0) is
reserved. This is reflected by the omap3_l3_app_bases array in omap_l3_smx.h.

So what is happening is that for some mysterious reason, the app error interrupt
is firing, the ISR tries to see why it is firing, can't figure it out and
returns IRQ_NONE. Then the interrupt fires again immediately, and the cycle
repeats. After 1000 cycles, the kernel gives up.

Does anybody have any ideas about what's going on? The issue may lie in the
RTL8192 driver, but I can't tell, especially with the reserved error code being
returned.

Thanks

dima
