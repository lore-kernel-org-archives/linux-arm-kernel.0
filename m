From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 29 Jan 2013 17:12:30 +0100
Subject: [BUG] i.MX25: soft lockups/freezes while getnstimeofday
Message-ID: <20130129161230.GA3128@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I have a problem with an imx25 on 3.7.2 kernel.

* Scenario

The scenario is as follows:

Under normal circumstances (i.e. system is running some daemons, but apart from
that idles most of the time), soft lockups happen after several hours. When the
watchdog_timer_fn has printed its stack dump, the system hangs for about 6min
and then continues to run as nothing ever happend.
I am able to force the lockup when I run the following little code snippet:

	while(1)
		syscall(SYS_clock_gettime, CLOCK_REALTIME, &tp);

With this running on the system, the lockup happens after 10-30mins:

[ 1175.247095] BUG: soft lockup - CPU#0 stuck for 22s! [time-test:268]
[ 1175.253421] Modules linked in:
[ 1175.256537] irq event stamp: 555315876
[ 1175.260318] hardirqs last  enabled at (555315875): [<c000df28>] __irq_svc+0x48/0x54
[ 1175.268073] hardirqs last disabled at (555315876): [<c000df14>] __irq_svc+0x34/0x54
[ 1175.275802] softirqs last  enabled at (555315874): [<c00243dc>] __do_softirq+0x210/0x2a0
[ 1175.283977] softirqs last disabled at (555315867): [<c0024854>] irq_exit+0x64/0xc8
[ 1175.291610]
[ 1175.293134] Pid: 268, comm:            time-test
[ 1175.297788] CPU: 0    Not tainted  (3.7.2-Katara-00060-g49acf87-dirty #25)
[ 1175.304707] PC is at getnstimeofday+0xc4/0xf0
[ 1175.309104] LR is at getnstimeofday+0x98/0xf0
[ 1175.313503] pc : [<c0052b4c>]    lr : [<c0052b20>]    psr: 80000013
[ 1175.313503] sp : d104bf38  ip : 00000005  fp : d104bf74
[ 1175.325022] r10: 43ecbb48  r9 : d104bf88  r8 : d1811020
[ 1175.330280] r7 : ffffffff  r6 : c4653600  r5 : f02f5ec5  r4 : ce61ad4b
[ 1175.336840] r3 : fffffffb  r2 : 00001243  r1 : 00000000  r0 : 3b9ac9ff
[ 1175.343402] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[ 1175.350572] Control: 0005317f  Table: 912ec000  DAC: 00000015
[ 1175.356408] [<c00130dc>] (unwind_backtrace+0x0/0xec) from [<c0391514>] (dump_stack+0x20/0x24)
[ 1175.365020] [<c0391514>] (dump_stack+0x20/0x24) from [<c000f2f0>] (show_regs+0x4c/0x58)
[ 1175.373115] [<c000f2f0>] (show_regs+0x4c/0x58) from [<c0071c18>] (watchdog_timer_fn+0x108/0x15c)
[ 1175.381991] [<c0071c18>] (watchdog_timer_fn+0x108/0x15c) from [<c0043470>] (__run_hrtimer+0x11c/0x250)
[ 1175.391378] [<c0043470>] (__run_hrtimer+0x11c/0x250) from [<c0043d40>] (hrtimer_interrupt+0x104/0x268)
[ 1175.400775] [<c0043d40>] (hrtimer_interrupt+0x104/0x268) from [<c00196a0>] (mxc_timer_interrupt+0x34/0x44)
[ 1175.410515] [<c00196a0>] (mxc_timer_interrupt+0x34/0x44) from [<c00726a0>] (handle_irq_event_percpu+0x88/0x274)
[ 1175.420677] [<c00726a0>] (handle_irq_event_percpu+0x88/0x274) from [<c00728d8>] (handle_irq_event+0x4c/0x6c)
[ 1175.430583] [<c00728d8>] (handle_irq_event+0x4c/0x6c) from [<c0074fc8>] (handle_level_irq+0xe0/0xf8)
[ 1175.439793] [<c0074fc8>] (handle_level_irq+0xe0/0xf8) from [<c0071ec4>] (generic_handle_irq+0x30/0x40)
[ 1175.449179] [<c0071ec4>] (generic_handle_irq+0x30/0x40) from [<c000ecec>] (handle_IRQ+0x70/0x94)
[ 1175.458036] [<c000ecec>] (handle_IRQ+0x70/0x94) from [<c0008740>] (avic_handle_irq+0x44/0x50)
[ 1175.466630] [<c0008740>] (avic_handle_irq+0x44/0x50) from [<c000df24>] (__irq_svc+0x44/0x54)
[ 1175.475104] Exception stack(0xd104bef0 to 0xd104bf38)
[ 1175.480202] bee0:                                     3b9ac9ff 00000000 00001243 fffffffb
[ 1175.488436] bf00: ce61ad4b f02f5ec5 c4653600 ffffffff d1811020 d104bf88 43ecbb48 d104bf74
[ 1175.496660] bf20: 00000005 d104bf38 c0052b20 c0052b4c 80000013 ffffffff
[ 1175.503346] [<c000df24>] (__irq_svc+0x44/0x54) from [<c0052b4c>] (getnstimeofday+0xc4/0xf0)
[ 1175.511785] [<c0052b4c>] (getnstimeofday+0xc4/0xf0) from [<c003d1b0>] (posix_clock_realtime_get+0x1c/0x24)
[ 1175.521524] [<c003d1b0>] (posix_clock_realtime_get+0x1c/0x24) from [<c003e5a8>] (sys_clock_gettime+0x3c/0x9c)
[ 1175.531520] [<c003e5a8>] (sys_clock_gettime+0x3c/0x9c) from [<c000e300>] (ret_fast_syscall+0x0/0x38)

The board itself supposedly worked up until v3.4.

The mxc-timer is set up to use ipg_clk_highfreq with a per5_div set to 2,
therefore it is clocked with 120MHz. I tried to set the per5_div to 4 to have
a 60MHz clock, but this didn't change anything.
On the other hand, I tried parenting the ipg_clk to the per5_clk to get a
66MHz clock. This seems to be working fine, but I only have it running for 4h now.


* Suspects

The current suspect is arch/arm/plat-mxc/time.c or the GPT respectively.
Is it okay to clock the gpt via the ipg_clk_highfreq? It is a valid clksrc according
to the datasheet, but that doesn't mean that the timer is stable then ;-)
It seems, that it is not correct to use the highfreq-clock, but I can't be absolutely
sure from the datasheet, maybe someone with access to the verilog/vhdl code can shed
some insight?!

Or is it valid, but leads to some very obscure and rare condition in the timer?
What I don't understand than, is why it worked with older kernels, when the
clocks are not okay. And what is happening in those 6mins when the system is
hanging?

It does not appear to be:
	- some timer wrap around (should happen more often)
	- some race condition with the set_next_event
	- something with getnstimeofday itself

I hope I didn't forget anything of importance and Shawn (someone) has an idea.
Or can tell me, that ipg_clk_highfreq is definitely wrong, because of $reason.


Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
