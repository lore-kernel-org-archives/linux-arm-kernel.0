From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Nov 2009 21:27:18 +0100
Subject: [PATCH] genirq: warn about IRQF_SHARED|IRQF_DISABLED at the
	right place
In-Reply-To: <200911301221.30601.david-b@pacbell.net>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<200911301221.30601.david-b@pacbell.net>
Message-ID: <20091130202718.GC19172@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2009 at 12:21:30PM -0800, David Brownell wrote:
> On Monday 30 November 2009, Uwe Kleine-K?nig wrote:
> > +???????????????if (new->flags & IRQF_DISABLED)
> > +???????????????????????pr_warning("IRQ %d/%s: IRQF_DISABLED is not guaranteed "
> > +???????????????????????????????????????"on shared IRQs\n", irq, new->name);
> 
> This should have copied the original test ... this way,
> it's dropping the SHARED constraint, and trying to morph
> into a generic "IRQF_DISABLED is eeebil!" test.
No, it doesn't.  The inserted code is in an if block:

	old_ptr = &desc->action;
	old = *old_ptr;
	if (old) {
		/* ... */
		if (!((old->flags & new->flags) & IRQF_SHARED) ||
			((old->flags ^ new->flags) & IRQF_TRIGGER_MASK)) {
			old_name = old->name;
			goto mismatch;
		}

		...

+		if (new->flags & IRQF_DISABLED)
+			pr_warning("...");

and the mismatch label is further below.  So the warning is still only
hit if a shared irq is registered.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
