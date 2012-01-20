From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 20 Jan 2012 09:15:57 -0700
Subject: [PATCH] arm: irq: Allow for specification of no preallocated irqs
In-Reply-To: <4F18B577.8080101@codeaurora.org>
References: <1327013024-22530-1-git-send-email-mbohan@codeaurora.org>
 <4F18A18C.9090302@gmail.com> <4F18B577.8080101@codeaurora.org>
Message-ID: <20120120161557.GT4223@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 04:29:43PM -0800, Michael Bohan wrote:
> On 1/19/2012 3:04 PM, Rob Herring wrote:
> >No doubt that arch_probe_nr_irqs is doing the wrong thing on ARM, but no
> >pre-allocation is not what we want either. We ultimately want
> >arch_probe_nr_irqs to return NR_IRQS_LEGACY (16) to reserve IRQ0 (aka
> >NO_IRQ) and legacy ISA IRQs. With my series, NR_IRQS is set to
> >NR_IRQS_LEGACY for SPARSE_IRQ. You can accomplish the same thing without
> >that series by setting .nr_irqs to NR_IRQS for non-DT and to
> >NR_IRQS_LEGACY for DT. For platforms to work in single kernel builds,
> >they will need to select SPARSE_IRQ.
> 
> One issue here is that IRQ_BITMAP_BITS is defined as a function of
> NR_IRQS. Currently, there's a hack in place that arbitrarily tacks
> on 8196 bits to the end, giving the max virq supported as 8212 with
> your patches. Unfortunately, the system I'm running on will require
> higher values than that, so this actually breaks me.

Are that many irqs actually going to be in-use at one time?  If not, then the driver should use the irq_domain radix tree reverse map anyway.

g.
