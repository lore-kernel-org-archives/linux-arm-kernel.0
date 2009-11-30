From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 30 Nov 2009 18:46:37 +0100 (CET)
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <20091130143703.GA7028@n2100.arm.linux.org.uk>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
	<20091130143703.GA7028@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0911301834220.24119@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Nov 2009, Russell King - ARM Linux wrote:
> On Mon, Nov 30, 2009 at 02:54:54PM +0100, Thomas Gleixner wrote:
> Maybe a "safer" way forward is to go and find all those request_irq()
> sites and add IRQF_DISABLED to them all, wait for regression reports and
> selectively remove the IRQF_DISABLED flags?  We would then be able to
> build up a picture of the problematical drivers that need to be reworked,
> and whether the "run everything with irqs disabled" is even a practical
> proposition.

Well, that's basically the same as removing IRQF_DISABLED, setting the
default to run disabled and provide a new flag IRQF_ENABLE_IRQS which
can be added to drivers when regressions show up. That way you just
have to grep for IRQF_ENABLE_IRQS instead of doing a search for
everything which has it removed. We can keep IRQF_DISABLED around by
setting it to 0 for the transition, so we don't have to touch the
world in the first place.
 
> Now, at the risk of covering old ground, how about we have two separate
> irqaction lists, one for handlers to be called with irqs disabled and
> one for handlers with irqs enabled.  We run the irqs-disabled list
> first, naturally with irqs disabled.  If, at the end of that run (or
> maybe after each handler), IRQs have ended being enabled, print some
> diagnostics.  (We're going to need something like this to ensure that
> drivers interrupt handlers don't enable IRQs themselves.)  Then enable
> IRQs and run the irqs-enabled chain.

Pretty old ground. :) That was discussed 10 years ago and never found
much love, but yes we could do that. Either two list or sorting the
entries. That might avoid the obvious pitfall, but I doubt it'd help
us to fix the drivers which think that they need to do the irqs
enabled dance.

Thanks,

	tglx
