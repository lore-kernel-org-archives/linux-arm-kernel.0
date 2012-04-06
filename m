From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 6 Apr 2012 13:17:04 +0200 (CEST)
Subject: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map; use
 irq_alloc_desc() instead
In-Reply-To: <m2r4w1akz4.fsf@igel.home>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <m2hax2qeqs.fsf@igel.home>
 <20120402202848.1EB833E02A7@localhost> <m2y5qdow0v.fsf@igel.home>
 <20120404154020.40C513E09D5@localhost> <m2r4w1akz4.fsf@igel.home>
Message-ID: <alpine.LFD.2.02.1204061315040.2542@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 6 Apr 2012, Andreas Schwab wrote:

> Grant Likely <grant.likely@secretlab.ca> writes:
> 
> > Can you attach console output logs for each of configs above and also
> > with NR_IRQS=128?  That might give me some clues as to which specific
> > code is causing the issues.
> 
> It really looks like the issue starts when irq_expand_nr_irqs is called
> the first time to make nr_irqs bigger than NR_IRQS.

And it looks like the irqdomain code is the real culprit.

void irq_set_virq_count(unsigned int count)
{
        pr_debug("irq: Trying to set virq count to %d\n", count);

        BUG_ON(count < NUM_ISA_INTERRUPTS);
        if (count < NR_IRQS)
                irq_virq_count = count;
}

That looks simply wrong.....

s/NR_IRQS/nr_irqs/ should do the trick.

Thanks,

	tglx
