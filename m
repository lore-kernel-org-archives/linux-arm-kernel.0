From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 24 Jun 2010 09:27:32 +0200
Subject: [PATCHv3 4/5] mtd: mxc_nand fixups
In-Reply-To: <80lja6awlb.fsf@merkur.tec.linutronix.de>
References: <20100618205401.GA12115@pengutronix.de>
	<80sk4ivkga.fsf@merkur.tec.linutronix.de>
	<AANLkTimA7Rbm_nHpVYpEPqaPCjrOse9s8YyiInWlhfEK@mail.gmail.com>
	<80tyoyhxey.fsf_-_@merkur.tec.linutronix.de>
	<AANLkTikRj_dMkKLyFhW78yld9jIYAIFncfPaPAF8WqUY@mail.gmail.com>
	<80iq5bqd07.fsf_-_@merkur.tec.linutronix.de>
	<AANLkTimJKNEwOoKldq4a4_ufxNY6IY7r6tAfAM055hlW@mail.gmail.com>
	<80vd9ab0d2.fsf@merkur.tec.linutronix.de>
	<AANLkTinVaXjCneg-XpxB7YNlmGOwQFTnm5RUcetPdToI@mail.gmail.com>
	<80lja6awlb.fsf@merkur.tec.linutronix.de>
Message-ID: <20100624072732.GQ12115@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 23, 2010 at 12:10:08PM +0200, John Ogness wrote:
> On 2010-06-23, Ivo Clarysse <ivo.clarysse@gmail.com> wrote:
> > But is it OK to use a regular (non-volatile) variable to communicate
> > between interrupt context and the non-interrupt context ?
> 
> In this case, yes.
> 
> > My original patch for i.MX21 used completions instead:
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2010-April/012694.html
> 
> Ah. It seems you've been through all this before. I wish I had noticed
> that thread before. I will need to check more carefully in the future.
> 
> Yes, your original patch achieves the exact same thing. Whether we use
> wait_event() with a flag or wait_completion() really is the same
> thing. So I guess Sascha can decide what we should do there.
> 
> What I like about your original patch is that only the i.MX21 has the
> cost of constantly enabling/disabling the irq line. It adds 5
> cpu_is_mx21() blocks to the code, but will lead to less work for the CPU
> on non-i.MX21 boards.

Ok, if it's the only way out to have 5 cpu_is_* blocks, then lets go for
it.

BTW I observed that at least on i.MX27 the latencies introduced by
waiting for an interrupt cause a significant performance drop. The
driver gets much faster when we just poll all the time. I don't know how
this affects system performance otherwise, but it may be a possibility
to drop interrupt support at least for i.MX21. I have no idea how long
the longest possible time we'd have to poll is though.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
