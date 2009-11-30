From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Nov 2009 20:51:29 +0100
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
Message-ID: <20091130195129.GA19172@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Nov 30, 2009 at 02:54:54PM +0100, Thomas Gleixner wrote:
> On Mon, 30 Nov 2009, Uwe Kleine-K?nig wrote:
> > For shared irqs IRQF_DISABLED is only guaranteed for the first handler.
> > So only warn starting at the second registration.
> > 
> > The warning is moved to __setup_irq having the additional benefit of
> > catching actions registered using setup_irq not only register_irq.
> > 
> > This doesn't fix the cases where setup order is wrong but it should
> > report the broken cases more reliably.
> 
> The whole IRQF_DISABLED trickery is questionable and I'm pretty
> unhappy about the warning in general.
> 
> While it is true that there is no guarantee of IRQF_DISABLED on shared
> interrupts (at least not for the secondary handlers) we really need to
> think about the reason why we want to run interrupt handlers with
> interrupts enabled at all.
> 
> The separation of interrupt handlers which run with interrupts
> disabled/enabled goes all the way back to Linux 1.0, which had two
> interrupt handling modes:
> 
> 1) handlers installed with SA_INTERRUPT ran atomically with interrupts
>    disabled.
> 
> 2) handlers installed without SA_INTERRUPT ran with interrupts enabled
>    as they did more complex stuff like signal handling in the kernel.

> The interrupt which was always run with interrupts disabled was the
> timer interrupt because some of the "slower" interrupt handlers were
> relying on jiffies being updated, which is only possible when they run
> with interrupts enabled and no such handler can interrupt the timer
> interrupt.
> 
> In the 2.1.x timeframe the discussion about shared interrupt handlers
> and the treatment of SA_INTERRUPT (today IRQF_DISABLED) was resolved
> by changing the code to what we have right now. If you read back in
> the archives you will find the same arguments as we have seen in this
> thread and a boatload of different solutions to that.
> 
> The real question is why we want to run an interrupt handler with
> interrupts enabled at all. There are two reaons AFAICT:
> 
> 1) interrupt handler relies on jiffies being updated:
> 
>    I don't think that this is the case anymore and if we still have
>    code which does it is probably historic crap which is unused for
>    quite a time.
> 
> 2) interrupt handler runs a long time:
> 
>    I'm sure we still have some of those especially in the
>    archaelogical corners of drivers/* and in the creative space of the
>    embedded "oh, I don't know why but it works" departement. That's
>    code which needs to be fixed anyway.

I think there is

 3) you can only benefit from decent priority hardware if irqs are
    processed while irqs are enabled.

I think 

	git grep handle_fasteoi_irq

gives an overview here: some hits in arch/powerpc, arch/sparc and
arch/x86/kernel/apic/io_apic.c.  (There is handle_prio_irq in
arch/arm/mach-ns9xxx, but the priodecoder is crappy and actually it
should use handle_level_irq IIRC.)

Best regards
Uwe
 
-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
