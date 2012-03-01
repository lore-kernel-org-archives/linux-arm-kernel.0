From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 1 Mar 2012 12:03:55 +0200
Subject: [PATCHv3 4/4] ARM: OMAP3+: add prcm chain interrupts to the
 interrupt list
In-Reply-To: <20120301094653.GA7413@n2100.arm.linux.org.uk>
References: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
 <1330529106-10423-5-git-send-email-t-kristo@ti.com>
 <20120301094653.GA7413@n2100.arm.linux.org.uk>
Message-ID: <1330596235.2116.81.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-03-01 at 09:46 +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 29, 2012 at 05:25:06PM +0200, Tero Kristo wrote:
> > Currently PRCM chain handler for OMAP4 requires SPARSE_IRQ to be enabled
> > from kernel config, however enabling this option breaks the OMAP kernel
> > completely and it can't be used.
> 
> No it does not.  Look:
> 
> 	irq_alloc_descs(start, from, num, -1)
> 
> will allocate num interrupt descriptors from within from..NR_IRQS if
> sparse IRQ is disabled.  So, provided there is sufficient space within
> the available NR_IRQS, irq_alloc_descs() works for non-sparse IRQ.
> There is no need to get rid of it at all.
> 
> If start is -1, then it will allocate from where-ever it can in the
> range from..NR_IRQS.  Otherwise, it will fail if it can't get an
> allocation starting at 'start'.
> 
> If sparse IRQ is enabled, then it will start allocating from whatever
> the last figure output from the:
> 
> 	NR_IRQS:%d nr_irqs:%d %d
> 
> line.

With the patch from Benoit
(http://marc.info/?l=linux-arm-kernel&m=133043468329275&w=2) this patch
is no longer needed. Previously the NR_IRQS definition was too small for
omap4 and the alloc_descs was failing because of that. It seems I
overshoot with this patch of mine and dropped also the irq_alloc_desc
implementation while fixing the problem.

-Tero
