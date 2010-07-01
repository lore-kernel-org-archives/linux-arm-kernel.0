From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 1 Jul 2010 22:08:07 +0200 (CEST)
Subject: [patch 0/2] ARM: Disable outer cache before kexec call
In-Reply-To: <20100701172128.GB15162@n2100.arm.linux.org.uk>
References: <20100701160206.539545857@linutronix.de>
	<1278000887.7482.12.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1007011820000.4507@localhost.localdomain>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5E41E0C@dbde02.ent.ti.com>
	<20100701170653.GA15162@n2100.arm.linux.org.uk>
	<20100701172128.GB15162@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1007012126440.4507@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Jul 2010, Russell King - ARM Linux wrote:
> On Thu, Jul 01, 2010 at 06:06:53PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Jul 01, 2010 at 10:08:37PM +0530, Shilimkar, Santosh wrote:
>
> Right, something like this.  I've not made an effort to fix the L2 bits,
> but I have marked the places where attention is required.  The interesting
> bit is the first two files.

I filled in the L2 bits for l2x0 in the following way:

Index: linux-2.6/arch/arm/mm/cache-l2x0.c
===================================================================
--- linux-2.6.orig/arch/arm/mm/cache-l2x0.c
+++ linux-2.6/arch/arm/mm/cache-l2x0.c
@@ -103,6 +103,18 @@ static void l2x0_cache_sync(void)
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
+static inline void l2x0_flush_all(void)
+{
+	unsigned long flags;
+
+	/* invalidate all ways */
+	spin_lock_irqsave(&l2x0_lock, flags);
+	writel(l2x0_way_mask, l2x0_base + L2X0_CLEAN_INV_WAY);
+	cache_wait(l2x0_base + L2X0_CLEAN_INV_WAY, l2x0_way_mask);
+	cache_sync();
+	spin_unlock_irqrestore(&l2x0_lock, flags);
+}
+
 static inline void l2x0_inv_all(void)
 {
 	unsigned long flags;
@@ -262,6 +274,7 @@ void __init l2x0_init(void __iomem *base
 	outer_cache.clean_range = l2x0_clean_range;
 	outer_cache.flush_range = l2x0_flush_range;
 	outer_cache.sync = l2x0_cache_sync;
+	outer_cache.flush_all = l2x0_cache_disable;
 
 	printk(KERN_INFO "%s cache controller enabled\n", type);
 	printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x\n",

Now I added outer_flush_all() calls to the places Russell pointed out.

Unfortunately that works just 5 times in a row, then the box stops
dead _after_ the decompressor jumps into the kernel. With current
mainline we fail in the decompressor itself. I guess we need the same
magic in the decompressor as well.

Adding the L2 disable function on top of these patches works like a
charm.

Seriously I think that keeping L2 enabled has enough unknown side
effects which might be dealt with by some random cache flushes, but
that's not a real solution to the underlying problem.

As a matter of sanity I think we should add the L2 disable
functionality. It's logical and it _DOES_ work. Further it solves a
real world problem as kexec is broken on any L2 enabled system AFAICT.

The sillyness of OMAP3 can be dealt with by those who invented that
insanity w/o imposing their wreckage on everyone.

Thanks,

	tglx
