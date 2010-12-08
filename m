From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 8 Dec 2010 13:09:35 +0100
Subject: [PATCH v2 04/15] ARM: mxs: Add interrupt support
In-Reply-To: <AANLkTik3ZDG05Lhu2txjUbk1TovbD-QE591Tco04Xz-P@mail.gmail.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-3-git-send-email-shawn.guo@freescale.com>
	<20101207210352.GC14775@pengutronix.de>
	<AANLkTin7jQ1uvnx1hU4Jj-j_YerKLgw=JXo6nDXmpa41@mail.gmail.com>
	<20101208093927.GI18244@pengutronix.de>
	<AANLkTik3ZDG05Lhu2txjUbk1TovbD-QE591Tco04Xz-P@mail.gmail.com>
Message-ID: <20101208120935.GP18244@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 06:46:49PM +0800, Shawn Guo wrote:
> Hi Uwe,
> 
> 2010/12/8 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hello Shawn,
> >
> > On Wed, Dec 08, 2010 at 04:27:56PM +0800, Shawn Guo wrote:
> >> 2010/12/8 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> >> > On Wed, Dec 08, 2010 at 12:31:54AM +0800, Shawn Guo wrote:
> >> [...]
> >> >> +
> >> >> +static void icoll_ack_irq(unsigned int irq)
> >> >> +{
> >> >> + ? ? __raw_writel(0, icoll_base + HW_ICOLL_VECTOR);
> >> > You need to write this before handling the irq, no? ?Note this question
> >> > is a repetition. ?You answered "No need, indeed. ?Will remove it."
> >> > According to MCIMX28RM a write to HW_ICOLL_VECTOR "indicates the
> >> > in-service state". ?Are you sure this is not needed? ?If no (i.e. it's
> >> > needed) the write should go into entry-macro.S. ?As I don't have
> >> > hardware yet I cannot test that. ?Maybe it's only needed when the
> >> > priority levels are used?!
> >> >
> >> Sorry. I made a mistake. ?I thought I had tested the removal of line
> >> and gave the comment, but actually not. The line is needed, and image
> >> will stop working without the line.
> >>
> >> Regarding to moving the writing to register VECTOR into entry-macro.S,
> >> can you please help me understand the reason behind the suggestion?
> > Section 5.2.1 of MCIMX28RM writes:
> >
> > ? ? ? ?After the CPU enters the interrupt service routine, it must
> > ? ? ? ?notify the interrupt collector as soon as possible. Software
> > ? ? ? ?indicates the in-service state by writing to the HW_ICOLL_VECTOR
> > ? ? ? ?register.
> >
> In case you will ask why, I would give the fact here.  I'm not sure
> what is your first thought.  Mine is to add it into get_irqnr_preamble
> as below.
> 
>         .macro  get_irqnr_preamble, base, tmp
>         ldr     \base, =ICOLL_ADDR
>         mov     \tmp, #0
>         str     \tmp, [\base]
>         .endm
It's wrong to do that in get_irqnr_preamble.

> But I got the following error.
> 
> [...]
> VFS: Mounted root (nfs filesystem) on device 0:11.
> Freeing init memory: 92K
> irq 101: nobody cared (try booting with the "irqpoll" option)
> [<c0025084>] (unwind_backtrace+0x0/0xe4) from [<c0063d54>] (__report_bad_irq+0x3
> 4/0x8c)
> [<c0063d54>] (__report_bad_irq+0x34/0x8c) from [<c0063ef8>] (note_interrupt+0x14
> c/0x1d8)
> [<c0063ef8>] (note_interrupt+0x14c/0x1d8) from [<c0064d5c>] (handle_level_irq+0x
> 108/0x198)
> [<c0064d5c>] (handle_level_irq+0x108/0x198) from [<c001f070>] (asm_do_IRQ+0x70/0
> x94)
> [<c001f070>] (asm_do_IRQ+0x70/0x94) from [<c0237050>] (__irq_svc+0x50/0x8c)
> Exception stack(0xc02e7d38 to 0xc02e7d80)
> 7d20:                                                       c02e7db0 00000000
> 7d40: ffffffd0 00000000 c7990800 00000000 c79a3820 000005a8 c02e7df8 c0217380
> 7d60: c7997a28 000005a8 00000000 c02e7d80 c02173a8 c02173c0 40000013 ffffffff
> [<c0237050>] (__irq_svc+0x50/0x8c) from [<c02173c0>] (xs_tcp_data_recv+0x40/0x62
> c)
> [<c02173c0>] (xs_tcp_data_recv+0x40/0x62c) from [<c01d6160>] (tcp_read_sock+0x70
> /0x1e8)
> [<c01d6160>] (tcp_read_sock+0x70/0x1e8) from [<c021734c>] (xs_tcp_data_ready+0x7
> c/0xb0)
> [<c021734c>] (xs_tcp_data_ready+0x7c/0xb0) from [<c01dee3c>] (tcp_rcv_establishe
> d+0x484/0x610)
> [<c01dee3c>] (tcp_rcv_established+0x484/0x610) from [<c01e5fd4>] (tcp_v4_do_rcv+
> 0x28/0x1c8)
> [<c01e5fd4>] (tcp_v4_do_rcv+0x28/0x1c8) from [<c01e65fc>] (tcp_v4_rcv+0x488/0x83
> c)
> [<c01e65fc>] (tcp_v4_rcv+0x488/0x83c) from [<c01ca038>] (ip_local_deliver+0x100/
> 0x1fc)
> [<c01ca038>] (ip_local_deliver+0x100/0x1fc) from [<c01c9efc>] (ip_rcv+0x540/0x57
> c)
> [<c01c9efc>] (ip_rcv+0x540/0x57c) from [<c01ad490>] (__netif_receive_skb+0x32c/0
> x388)
> [<c01ad490>] (__netif_receive_skb+0x32c/0x388) from [<c01ad56c>] (process_backlo
> g+0x80/0x140)
> [<c01ad56c>] (process_backlog+0x80/0x140) from [<c01ad8a4>] (net_rx_action+0x58/
> 0x180)
> [<c01ad8a4>] (net_rx_action+0x58/0x180) from [<c0037c50>] (__do_softirq+0x78/0x1
> 10)
> [<c0037c50>] (__do_softirq+0x78/0x110) from [<c0037d2c>] (irq_exit+0x44/0xa8)
> [<c0037d2c>] (irq_exit+0x44/0xa8) from [<c001f074>] (asm_do_IRQ+0x74/0x94)
> [<c001f074>] (asm_do_IRQ+0x74/0x94) from [<c0237050>] (__irq_svc+0x50/0x8c)
> Exception stack(0xc02e7f80 to 0xc02e7fc8)
> 7f80: 00000000 0005317f 0005217f 60000013 c02e6000 c001baf4 c001baf0 c02e9b60
> 7fa0: 4001a848 41069265 4001a7e0 00000000 600000d3 c02e7fc8 c0020bc4 c0020bd0
> 7fc0: 60000013 ffffffff
> [<c0237050>] (__irq_svc+0x50/0x8c) from [<c0020bd0>] (default_idle+0x2c/0x30)
> [<c0020bd0>] (default_idle+0x2c/0x30) from [<c002110c>] (cpu_idle+0x60/0xc0)
> [<c002110c>] (cpu_idle+0x60/0xc0) from [<c00088f0>] (start_kernel+0x238/0x27c)
> [<c00088f0>] (start_kernel+0x238/0x27c) from [<40008034>] (0x40008034)
> handlers:
> [<c01872e4>] (fec_enet_interrupt+0x0/0x3ec)
> Disabling IRQ #101
> 
> However, when I add it into get_irqnr_and_base as below.
> 
>         .macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
>         mov     \tmp, #0
>         str     \tmp, [\base]
>         ldr     \irqnr, [\base, #0x70]
>         cmp     \irqnr, #0x7F
>         moveqs  \irqnr, #0
>         .endm
> 
> Everything seems fine.

I think you need to do the following:

	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
	ldr     \irqnr, [\base, #0x70]
	cmp     \irqnr, #0x7F
	strne	\irqnr, [\base]
	moveq	\irqnr, #0
	.endm

(i.e. only write to VECTOR if there is an irq pending).

As before this is completely untested.

Another thing I just noticed is that you don't really want to hardcode
the 0x70, take a look into
arch/arm/mach-ns9xxx/include/mach/entry-macro.S for an example to avoid
it.
 
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
