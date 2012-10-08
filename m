From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 8 Oct 2012 09:45:47 +0200
Subject: Kernel panic in mxs_auart_irq_handle with latest kernel?
In-Reply-To: <B437D8FD67C39240BFA9DD878702A627EB4BD8@mx2.grid-net.com>
References: <B437D8FD67C39240BFA9DD878702A627EB4BD8@mx2.grid-net.com>
Message-ID: <20121008074547.GA18531@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2012 at 11:58:26PM +0000, Subodh Nijsure wrote:
> 
> On my MX28 based board with top of the Linus's git tree I am consistently getting following kernel panic, anybody else seen this?
> (I will start bisecting and see if I can find a reason this wknd)
> 
> -Subodh
> 
This dump is not complete, there is at least a line missing that reads

	[   $timestamp] pgd = ....

It's a good habit to always provide the full info.

> [    9.700000] [00000118] *pgd=00000000
> [    9.700000] Internal error: Oops: 5 [#1] PREEMPT ARM
> [    9.700000] Modules linked in:
> [    9.700000] CPU: 0    Not tainted  (3.6.0-11641-gbe4ae13-dirty #1)
> [    9.700000] PC is at uart_insert_char+0x38/0x130
> [    9.700000] LR is at mxs_auart_irq_handle+0x198/0x2b0
> [    9.700000] pc : [<c025a3e0>]    lr : [<c0261700>]    psr: 40000093
> [    9.700000] sp : c0549ea0  ip : 00000000  fp : 00000001
> [    9.700000] r10: 00000000  r9 : c057e64e  r8 : 00000020
> [    9.700000] r7 : 00000000  r6 : 00080000  r5 : 00000000  r4 : c39566c0
> [    9.700000] r3 : 00000020  r2 : 00000000  r1 : 00000000  r0 : 00000000
I don't see what should access the address 0x118 here, can you please
provide the output of

	objdump -d vmlinux | sed -nr '/^[0-9]{8} <uart_insert_char/,/^$/p'

Best regards
Uwe

> [    9.700000] Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> [    9.700000] Control: 0005317f  Table: 40004000  DAC: 00000017
> [    9.700000] Process swapper (pid: 0, stack limit = 0xc0548270)
> [    9.700000] Stack: (0xc0549ea0 to 0xc054a000)
> [    9.700000] 9ea0: c0554c00 00200002 00000000 c39566c0 00000000 0052006d 0052006d c0261700
> [    9.700000] 9ec0: 00000000 c0548000 c398f980 c0548000 00000000 00000000 000000d3 c057e64e
> [    9.700000] 9ee0: c387d700 c0063e74 ffffffff 20000093 00000002 c387d700 c0548000 00000000
> [    9.700000] 9f00: c0549f9c 40004000 41069265 40541cd8 00000000 c006403c 427c4747 00000002
> [    9.700000] 9f20: c0548000 c0548000 c387d700 c00662dc 000000d3 000000d3 00000000 c00637b0
> [    9.700000] 9f40: c0568748 c000ffec f5000000 c0549f68 c0587814 c0008778 c0010144 60000013
> [    9.700000] 9f60: ffffffff c000eda0 00000000 0005317f 0005217f 60000013 c0548000 c05875a8
> [    9.700000] 9f80: c0554300 c0644480 40004000 41069265 40541cd8 00000000 600000d3 c0549fb0
> [    9.700000] 9fa0: c0010138 c0010144 60000013 ffffffff 60000093 c0010308 c05500a8 c0587520
> [    9.700000] 9fc0: c0543150 c0522700 ffffffff ffffffff c05221d0 00000000 00000000 c0543150
> [    9.700000] 9fe0: 00000000 00053175 c055001c c0543120 c05542f4 40008040 00000000 00000000
> [    9.700000] [<c025a3e0>] (uart_insert_char+0x38/0x130) from [<c0261700>] (mxs_auart_irq_handle+0x198/0x2b0)
> [    9.700000] [<c0261700>] (mxs_auart_irq_handle+0x198/0x2b0) from [<c0063e74>] (handle_irq_event_percpu+0x50/0x1c4)
> [    9.700000] [<c0063e74>] (handle_irq_event_percpu+0x50/0x1c4) from [<c006403c>] (handle_irq_event+0x54/0x84)
> [    9.700000] [<c006403c>] (handle_irq_event+0x54/0x84) from [<c00662dc>] (handle_level_irq+0x98/0x14c)
> [    9.700000] [<c00662dc>] (handle_level_irq+0x98/0x14c) from [<c00637b0>] (generic_handle_irq+0x20/0x30)
> [    9.700000] [<c00637b0>] (generic_handle_irq+0x20/0x30) from [<c000ffec>] (handle_IRQ+0x30/0x84)
> [    9.700000] [<c000ffec>] (handle_IRQ+0x30/0x84) from [<c0008778>] (icoll_handle_irq+0x34/0x48)
> [    9.700000] [<c0008778>] (icoll_handle_irq+0x34/0x48) from [<c000eda0>] (__irq_svc+0x40/0x6c)
> [    9.700000] Exception stack(0xc0549f68 to 0xc0549fb0)
> [    9.700000] 9f60:                   00000000 0005317f 0005217f 60000013 c0548000 c05875a8
> [    9.700000] 9f80: c0554300 c0644480 40004000 41069265 40541cd8 00000000 600000d3 c0549fb0
> [    9.700000] 9fa0: c0010138 c0010144 60000013 ffffffff
> [    9.700000] [<c000eda0>] (__irq_svc+0x40/0x6c) from [<c0010144>] (default_idle+0x38/0x40)
> [    9.700000] [<c0010144>] (default_idle+0x38/0x40) from [<c0010308>] (cpu_idle+0x9c/0xd4)
> [    9.700000] [<c0010308>] (cpu_idle+0x9c/0xd4) from [<c0522700>] (start_kernel+0x264/0x2a4)
> [    9.700000] [<c0522700>] (start_kernel+0x264/0x2a4) from [<40008040>] (0x40008040)
> [    9.700000] Code: 1a000012 e59d2020 e5cd3006 e5cd2007 (e5973118) 
> [    9.700000] ---[ end trace 179ba7640a9ebb7c ]---
> [    9.700000] Kernel panic - not syncing: Fatal exception in interrupt

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
