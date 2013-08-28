From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 28 Aug 2013 06:49:08 -0300
Subject: [PATCH v4 2/4] ARM: Add atomic_io_modify optimized routines
In-Reply-To: <20130828085340.GB58219@MacBook-Pro.local>
References: <1377358532-23802-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377358532-23802-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130828085340.GB58219@MacBook-Pro.local>
Message-ID: <20130828094907.GB2343@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 28, 2013 at 09:53:40AM +0100, Catalin Marinas wrote:
> On Sat, Aug 24, 2013 at 04:35:30PM +0100, Ezequiel Garcia wrote:
> > Implement arch-specific atomic_io_modify and atomic_io_modify_relaxed,
> > which are based on writel/readl_relaxed and writel_relaxed/readl_relaxed,
> > respectively.
> > In both cases, by relaxing the readl, perfomance can be improved.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  arch/arm/include/asm/io.h |  4 ++++
> >  arch/arm/kernel/io.c      | 29 +++++++++++++++++++++++++++++
> >  2 files changed, 33 insertions(+)
> > 
> > diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> > index d070741..53637b6 100644
> > --- a/arch/arm/include/asm/io.h
> > +++ b/arch/arm/include/asm/io.h
> > @@ -397,5 +397,9 @@ extern int devmem_is_allowed(unsigned long pfn);
> >  extern void register_isa_ports(unsigned int mmio, unsigned int io,
> >  			       unsigned int io_shift);
> >  
> > +#define __HAVE_ARCH_ATOMIC_IO_MODIFY
> > +extern void atomic_io_modify(void __iomem *reg, u32 mask, u32 set);
> > +extern void atomic_io_modify_relaxed(void __iomem *reg, u32 mask, u32 set);
> > +
> >  #endif	/* __KERNEL__ */
> >  #endif	/* __ASM_ARM_IO_H */
> > diff --git a/arch/arm/kernel/io.c b/arch/arm/kernel/io.c
> > index dcd5b4d..a8c9c9b 100644
> > --- a/arch/arm/kernel/io.c
> > +++ b/arch/arm/kernel/io.c
> > @@ -1,6 +1,35 @@
> >  #include <linux/export.h>
> >  #include <linux/types.h>
> >  #include <linux/io.h>
> > +#include <linux/spinlock.h>
> > +
> > +static DEFINE_RAW_SPINLOCK(__io_lock);
> > +
> > +void atomic_io_modify_relaxed(void __iomem *reg, u32 mask, u32 set)
> > +{
> > +	unsigned long flags;
> > +	u32 value;
> > +
> > +	raw_spin_lock_irqsave(&__io_lock, flags);
> > +	value = readl_relaxed(reg) & ~mask;
> > +	value |= (set & mask);
> > +	writel_relaxed(value, reg);
> > +	raw_spin_unlock_irqrestore(&__io_lock, flags);
> > +}
> > +EXPORT_SYMBOL(atomic_io_modify_relaxed);
> > +
> > +void atomic_io_modify(void __iomem *reg, u32 mask, u32 set)
> > +{
> > +	unsigned long flags;
> > +	u32 value;
> > +
> > +	raw_spin_lock_irqsave(&__io_lock, flags);
> > +	value = readl_relaxed(reg) & ~mask;
> > +	value |= (set & mask);
> > +	writel(value, reg);
> > +	raw_spin_unlock_irqrestore(&__io_lock, flags);
> > +}
> > +EXPORT_SYMBOL(atomic_io_modify);
> 
> Is this any different from the generic one introduced in patch 1/4? I
> would rather just use the generic definition.

Well, according to Will Deacon (and as documented in the commit log)
we can optimize in ARM by using readl_relaxed instead of readl.

Now, I'm sure you now better than me if that results (or not) in any
significant optimization.

> Similarly, a generic
> atomic_io_modify_relaxed() but guarded with something like
> __HAVE_ARCH_RELAXED_IO.
> 

No, that's not possible. As far as I understand, there's no guarantee
of _relaxed variants to be available architecture-wide.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
