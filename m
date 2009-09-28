From: mikpe@it.uu.se (Mikael Pettersson)
Date: Mon, 28 Sep 2009 21:39:27 +0200
Subject: [PATCH 1/2] n2100: support assigning XINT1 to UART
In-Reply-To: <19136.41115.286197.101467@pilspetsen.it.uu.se>
References: <19134.28977.5491.323804@pilspetsen.it.uu.se>
	<20090928095813.GJ1773@mail.wantstofly.org>
	<20090928100535.GE6715@n2100.arm.linux.org.uk>
	<19136.41115.286197.101467@pilspetsen.it.uu.se>
Message-ID: <19137.4335.996148.644761@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson writes:
 > Russell King - ARM Linux writes:
 >  > On Mon, Sep 28, 2009 at 11:58:13AM +0200, Lennert Buytenhek wrote:
 >  > > Can't you detect whether the 8250 IRQ is routed at boot?  E.g. cause
 >  > > the UART to throw an interrupt, check the XINT, clear the interrupt,
 >  > > and check the XINT again, and see if the 8250 interrupt status
 >  > > corresponds to the XINT or not?  (And then printk the result of the
 >  > > detection.)
 >  > 
 >  > 8250 already has support for auto-probing its interrupt.
 > 
 > The question is how well things work if the 2nd uhci and
 > serial share (software) interrupt. I'll have to check.

Auto-probing doesn't seem to work.

If I disable the new option, making the n2100 board support code
assigns interrupts as before, and set CONFIG_SERIAL_8250_DETECT_IRQ=y,
I get

irq 28: nobody cared (try booting with the "irqpoll" option)
Backtrace: 
[<c002433c>] (dump_backtrace+0x0/0x110) from [<c0238364>] (dump_stack+0x18/0x1c)
 r7:00000000 r6:10000000 r5:c02e1988 r4:c02e1988
[<c023834c>] (dump_stack+0x0/0x1c) from [<c00584ec>] (__report_bad_irq+0x3c/0x94)
[<c00584b0>] (__report_bad_irq+0x0/0x94) from [<c0058694>] (note_interrupt+0x150/0x1e0)
 r4:c02e1988
[<c0058544>] (note_interrupt+0x0/0x1e0) from [<c0058f94>] (handle_level_irq+0xb0/0xe4)
[<c0058ee4>] (handle_level_irq+0x0/0xe4) from [<c0020070>] (_text+0x70/0x8c)
 r5:df823e48 r4:0000001c
[<c0020000>] (_text+0x0/0x8c) from [<c0020ac8>] (__irq_svc+0x48/0x80)
Exception stack(0xdf823da0 to 0xdf823de8)
3da0: c02fa940 00000000 c02fa940 20000013 df822000 00000000 10000200 00000102 
3dc0: df822000 df846b40 0000000a df823e1c df823e20 df823de8 c0034244 c003412c 
3de0: 20000013 ffffffff                                                       
 r5:df823dd4 r4:ffffffff
[<c00340e4>] (__do_softirq+0x0/0x11c) from [<c0034244>] (irq_exit+0x44/0x88)
[<c0034200>] (irq_exit+0x0/0x88) from [<c0020074>] (_text+0x74/0x8c)
[<c0020000>] (_text+0x0/0x8c) from [<c0020ac8>] (__irq_svc+0x48/0x80)
Exception stack(0xdf823e48 to 0xdf823e90)
3e40:                   df914f80 00000001 00000007 00000004 00000037 df914c00 
3e60: df914800 00000038 df822000 df846b40 df914f80 df823ee4 df823e30 df823e90 
3e80: c0137c38 c0239104 80000013 ffffffff                                     
 r5:df823e7c r4:ffffffff
[<c01379e4>] (n_tty_write+0x0/0x3b0) from [<c01354fc>] (tty_write+0x18c/0x22c)
[<c0135370>] (tty_write+0x0/0x22c) from [<c0135620>] (redirected_tty_write+0x84/0x94)
[<c013559c>] (redirected_tty_write+0x0/0x94) from [<c00816dc>] (vfs_write+0xb0/0xd8)
 r7:00000038 r6:df823f70 r5:be821680 r4:df846b40
[<c008162c>] (vfs_write+0x0/0xd8) from [<c00817c8>] (sys_write+0x44/0x70)
 r6:df846b40 r5:00000000 r4:00000000
[<c0081784>] (sys_write+0x0/0x70) from [<c0020e60>] (ret_fast_syscall+0x0/0x3c)
 r8:c0021004 r7:00000004 r6:401d6688 r5:be821680 r4:00000038
handlers:
[<c0193168>] (usb_hcd_irq+0x0/0xa0)
Disabling IRQ #28

when the kernel starts init, and the serial console remains in polling mode.

If I add "| UPF_AUTO_IRQ" to the plat_serial8250_port .flags, the serial
core does detect and use irq 28 for the uart, but so does the 2nd uhci,
and uhci appears to swallow everything on irq 28 because the console goes
silent as init is started and the uart switches to irq mode.

So a boot option or a probe in the n2100 board support code, with followup
adjustments of the irq assignments, seems like the only ways to do this
dynamically without a compile-time option.

/Mikael
