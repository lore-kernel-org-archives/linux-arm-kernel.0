From: robherring2@gmail.com (Rob Herring)
Date: Thu, 15 Dec 2011 17:24:02 -0600
Subject: Very sparse and high interrupt map with SPARSE_IRQ
In-Reply-To: <4EEA6435.5040207@codeaurora.org>
References: <4EEA6435.5040207@codeaurora.org>
Message-ID: <4EEA8192.7050306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2011 03:18 PM, Michael Bohan wrote:
> Hi,
> 
> I am working with a Qualcomm SPMI device that supports up to 32768
> interrupts. Now, in practice, not nearly all of these interrupts will be
> populated on a real device. Most likely on the order of 200-300
> interrupts will be specified in Device Tree. The problem is the set of
> active interrupts will change on future devices sharing the same
> architecture, and there's really no predicting which of this range will
> be active. Ideally, the supporting code should never have to change.
> 
> To support such a device, I am considering using SPARSE_IRQ and
> allocating the irq_desc at runtime as necessary while walking the Device
> Tree. To keep the mapping function simple and fast, I was thinking of
> using discontinuous, high system interrupt numbers that can be computed
> with a simple O(1) operation. Alternatively, I could use a radix tree or
> hash to map these to more traditional, lower and contiguous interrupt
> numbers, but I'm not aware of any significant benefit in doing so.
> 
> As far as I can tell, the only potential problems with using such high
> interrupt numbers (eg. 33102) are:
> 
> 1. IRQ_BITMAP_BITS must be expanded to support the entire possible range
> (eg. ~0-33500). IRQ_BITMAP_BITS is defined as NR_IRQS. This will waste
> ~3 KB on such a range. To me 3 KB can be justified if it speeds up the
> fast path interrupt handling.
> 2. NR_IRQS will increase beyond the HARDIRQ_BITS limitation, which
> governs the number of nested interrupts. But as mentioned, we won't
> actually have more real interrupts than the maximum setting (10 bit) --
> it's just that our NR_IRQ definition will be so high to trip an older
> ARM check for NR_IRQS going beyond HARDIRQ_BITS.
> 
> So basically, I'm asking whether this analysis is correct, and what I'm
> doing seems reasonable. I'd also like to propose a couple changes as a
> consequence of what I mentioned above:
> 
> 1. Add another macro to distinguish between the actual number of
> interrupts a system supports and the *highest* number it supports. Eg.
> NR_IRQS seems to imply a quantity - not a maximum value. But it's
> currently being used to cover both constraints.
> 2. Remove the check in arch/arm/include/asm/hardirq.h for HARDIRQ_BITS
> being too low. Actually, if 1) were really implemented, then most likely
> NR_IRQS would be below 1024, and this check would not be violated. But
> regardless, per the comment in kernel/irq/internals.h, we're probably
> bound by interrupt stack for such systems, anyways.

Have you looked at irq_domain (kernel/irq/irqdomain.c). This is meant to
support complex mappings like this. Although in its current form it
needs some work to support this. Is there no sub-grouping of interrupts
at all?

The hwirq # is stored in irq_data, so converting from Linux irq to hwirq
# is O(1). Going the other way is implemented per domain and would
depend on the implementation of .to_irq.

Rob
