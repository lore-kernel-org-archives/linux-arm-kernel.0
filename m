From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 6 Apr 2012 13:28:38 +0200 (CEST)
Subject: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map; use
 irq_alloc_desc() instead
In-Reply-To: <m2bon59k68.fsf@igel.home>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <m2hax2qeqs.fsf@igel.home>
 <20120402202848.1EB833E02A7@localhost> <m2y5qdow0v.fsf@igel.home>
 <20120404154020.40C513E09D5@localhost> <m2r4w1akz4.fsf@igel.home>
 <alpine.LFD.2.02.1204061315040.2542@ionos> <m2bon59k68.fsf@igel.home>
Message-ID: <alpine.LFD.2.02.1204061327080.2542@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Fri, 6 Apr 2012, Andreas Schwab wrote:

> Thomas Gleixner <tglx@linutronix.de> writes:
> 
> > And it looks like the irqdomain code is the real culprit.
> >
> > void irq_set_virq_count(unsigned int count)
> > {
> >         pr_debug("irq: Trying to set virq count to %d\n", count);
> >
> >         BUG_ON(count < NUM_ISA_INTERRUPTS);
> >         if (count < NR_IRQS)
> >                 irq_virq_count = count;
> > }
> >
> > That looks simply wrong.....
> 
> There is a single use of irq_set_virq_count, which is only relevant to
> the PS3.

Though irq_virq_count is statically initialized to NR_IRQS and it's
used in the code more than once.
