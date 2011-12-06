From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 6 Dec 2011 21:59:55 +0100
Subject: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
In-Reply-To: <CA+55aFwZBr+3_S9kU-+m8zN8iwOvn2miuuAy-zt7sUjW_+abBg@mail.gmail.com>
References: <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
 <20111205180253.GB29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051310150.2357@xanadu.home>
 <20111205192605.GD29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051443190.2357@xanadu.home>
 <20111206093709.GB2274@linaro.org>
 <20111206104654.GN14542@n2100.arm.linux.org.uk>
 <CA+55aFwZBr+3_S9kU-+m8zN8iwOvn2miuuAy-zt7sUjW_+abBg@mail.gmail.com>
Message-ID: <20111206205955.GH4585@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

On Tue, Dec 06, 2011 at 11:20:49AM -0800, Linus Torvalds wrote:
> On Tue, Dec 6, 2011 at 2:46 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >
> > But.. let's make one thing clear: Alan Cox and Linus have been going on
> > about how IRQ0 should not be used. ?Let's be crystal clear: even x86
> > uses IRQ0.
> 
> Not for any device driver, though.
> 
> It's used entirely internally, and it doesn't even use
> "request_irq()". It uses the magic internal "setup_irq()" and never
> *ever* exposes irq0 as anything that a driver can see.
> 
> That's what matters. You can use irq0 in ARM land all you like, AS
> LONG AS IT'S SOME HIDDEN INTERNAL USE. No drivers. No *nothing* that
> ever uses that absolutely *idiotic* NO_IRQ crap.
> 
> In fact, you may be *forced* to use what is "physically" irq0 - it's
> just that you should never expose it as such to drivers. And x86
> doesn't.
> 
> So Russell, if you think this has anything to do with NO_IRQ, and how
> x86 isn't doing things right, you're wrong. It's just like the
> internal exception thing, or the magical "cascade interrupt", or the
> "x87 exception mapped through the PIC". They are magic hidden
> interrupts that are set up in one place (well, one place *each*), and
> are never exposed anywhere else.
Well there is try_misrouted_irq in kernel/irq/spurious.c that assumes
irq0 to be something that it never is on ARM (and maybe all other
platforms apart from x86). So at least it's not internal to a single
(x86 specific) place.

I tried to patch that two years ago, but that only ended in people
saying "don't use irq0". I don't know if try_misrouted_irq sees hardware
irqs, but if it does it's a bug even on archs != X86 that use virtual
irqs.

(Note that this doesn't oppose to your statement that using NO_IRQ is
crap.)

> The problem with NO_IRQ is that stupid "we expose our mind-numbingly
> stupid interfaces across the whole kernel".
> 
> x86 never did that.  ARM still does. x86 doesn't have to fix anything. ARM does.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
