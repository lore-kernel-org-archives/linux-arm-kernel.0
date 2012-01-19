From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2012 22:57:10 +0000
Subject: [PATCH] arm: irq: Allow for specification of no preallocated irqs
In-Reply-To: <1327013024-22530-1-git-send-email-mbohan@codeaurora.org>
References: <1327013024-22530-1-git-send-email-mbohan@codeaurora.org>
Message-ID: <20120119225710.GG10404@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 02:43:44PM -0800, Michael Bohan wrote:
> For cases with SPARSE_IRQ enabled, irqs preallocated with
> arch_probe_nr_irqs() are already marked as allocated in the
> allocated_irqs bitmap. As a consequence, irq chip drivers that
> allocate irqs will feel one of two behaviors:
> 
> 1. An allocation will succeed with the starting irq_base one
> more than the preallocated irqs. This will thus waste the
> preceeding interrupt resources that were preallocated, unless a
> legacy chip driver happens to assume ownership of these by some
> platform definition. The GIC driver is a typical primary chip
> driver, and abides to the allocation APIs. So this can be a
> problem in many trivial usecases.
> 
> 2. An allocation will fail with < 0. This can also happen in the
> GIC driver, which interprets this value as meaning the irq_descs
> are already preallocated. But in Device Tree configurations, the
> fallback irq_base is -1. This results in an invalid irq_base
> value.
> 
> Looking forward, we are moving towards a world where preallocation
> of irqs is no longer necessary. irq_domain is scoped to handle all
> irq_desc allocations in the future. Thus, we should support
> configurations where the platform wants to preallocate no irqs.

Actually, leave nr_irqs unsigned.  Even when we have no preallocation,
we do not want to allow anything to get IRQ0.  Platforms which don't
want to have any preallocated IRQs should set NR_IRQS to zero as well
as their platforms nr_irqs entry.

That's basically how it works today, so no code changes should be
necessary.
