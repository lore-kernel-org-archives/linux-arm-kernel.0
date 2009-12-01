From: awalls@radix.net (Andy Walls)
Date: Mon, 30 Nov 2009 20:42:53 -0500
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <200911301238.35750.david-b@pacbell.net>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301519120.24119@localhost.localdomain>
	<20091130144702.14bea0ee@lxorguk.ukuu.org.uk>
	<200911301238.35750.david-b@pacbell.net>
Message-ID: <1259631774.3099.26.camel@palomino.walls.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-11-30 at 12:38 -0800, David Brownell wrote:
> On Monday 30 November 2009, Alan Cox wrote:
> > SHARED|DISABLED ought to WARN_ON() and if that doesn't motivate people
> > then return -EINVAL. And with any luck that'll prove 6 months later that
> > most of the offenders are not used and we can delete them wholesale.
> 
> So ... merge an updated version of the original patch, to
> get full WARN coverage?
> 
> We've had that warning for a long time now.  The original
> patch just covered non-request_irq() cases.  So by your
> timetable we're ready for the "return -EINVAL" stage of
> the migration... at least, for request_irq() callers.

OK, I'm motivated.  I haven't followed the discussion closely though.

Can someone give me a clue as to the preferred way to correct this:

        /* Register IRQ */
        retval = request_irq(cx->pci_dev->irq, cx18_irq_handler,
                             IRQF_SHARED | IRQF_DISABLED,
                             cx->v4l2_dev.name, (void *)cx);


?
The top half handler performs as little work as it possibly can and
schedules the long duration activites on a workqueue already.

The device is always on a plug-in PCI card.

Regards,
Andy
