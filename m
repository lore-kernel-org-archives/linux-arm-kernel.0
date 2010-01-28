From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Jan 2010 13:19:07 +0000
Subject: [PATCH 1/5] gic: prevent gic from crossing NR_IRQ
In-Reply-To: <20100127224309.GD29665@n2100.arm.linux.org.uk>
References: <20100127224309.GD29665@n2100.arm.linux.org.uk>
Message-ID: <1264684747.7064.61.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-01-27 at 22:43 +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 27, 2010 at 11:32:25AM -0800, adharmap at codeaurora.org wrote:
> > From: Abhijeet Dharmapurikar <adharmap@quicinc.com>
> >
> > The gic code tries to initialize interrupts beyond NR_IRQ. Prevent
> > code from doing that.
> 
> NAK.  This is completely the wrong approach.
> 
>         /*
>          * Find out how many interrupts are supported.
>          */
>         max_irq = readl(base + GIC_DIST_CTR) & 0x1f;
>         max_irq = (max_irq + 1) * 32;
> 
>         /*
>          * The GIC only supports up to 1020 interrupt sources.
>          * Limit this to either the architected maximum, or the
>          * platform maximum.
>          */
>         if (max_irq > max(1020, NR_IRQS))
>                 max_irq = max(1020, NR_IRQS);
> ...
>         for (i = irq_start; i < gic_data[gic_nr].irq_offset + max_irq; i++) {
> 
> This function is broken if irq_start != 0, and needs fixing - max_irq
> needs to be limited to the _minimum_ of 1020 or NR_IRQS - irq_start.

Actually I think in this case max_irq should be left to whatever the
hardware reads (but not more than 1020) since further down in this
function we configure the IRQs for the GIC and we also want to disable
those beyond NR_IRQS.

The "for" loop for set_irq_chip() should go to the minimum of max_irqs
and NR_IRQS.

-- 
Catalin
