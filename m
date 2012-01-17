From: srinidhi.kasagar@stericsson.com (Srinidhi KASAGAR)
Date: Tue, 17 Jan 2012 11:52:26 +0530
Subject: [PATCH 1/2] mach-ux500: cache operations are atomic on PL310
In-Reply-To: <20120116145008.GH9068@mudshark.cambridge.arm.com>
References: <1326346663-6112-1-git-send-email-srinidhi.kasagar@stericsson.com>
 <20120113181422.GB24373@mudshark.cambridge.arm.com>
 <20120116110528.GA24824@bnru02>
 <20120116145008.GH9068@mudshark.cambridge.arm.com>
Message-ID: <20120117062224.GA26832@bnru02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 15:50:08 +0100, Will Deacon wrote:
> On Mon, Jan 16, 2012 at 11:05:29AM +0000, Srinidhi KASAGAR wrote:
> > On Fri, Jan 13, 2012 at 19:14:22 +0100, Will Deacon wrote:
> > > Hi guys,
> > > 
> > > On Thu, Jan 12, 2012 at 05:37:42AM +0000, Srinidhi KASAGAR wrote:
> > > > Apply ERRATA_753970 for ux500 variant of cache sync too
> > > > 
> > > > Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> > > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > > ---
> > > >  arch/arm/mach-ux500/cache-l2x0.c |   11 ++++++++---
> > > >  1 files changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > I hadn't noticed the existence of this file before, but this patch really
> > > shows why it's not a good idea to copy files out of core ARM code and into
> > > the mach-* directories. I see that the commit introducing this file 458eef2f
> > > ("mach-ux500: factor out l2x0 handling code") mentions that mach-imx does
> > > the same thing, but I can't find the code there.
> > > 
> > > On top of that, it seems as though you provide an inv_all implementation
> > > but your disable function is empty. Surely this can lead to data loss?
> > 
> > We can't disable l2x0 from non secure mode and either we do not have
> > special SMI to handle the same and hence it is empty. So for kexec
> > to work on this platform we need to have a non-locking variant of
> > inv_all() otherwise we seems to be looping forever in spin locks
> > as such L1 caches are disabled at that moment in cpu_proc_fin().
> > So we had to override this inv_all for this machine.
> 
> Actually, now that I've fixed kexec, we don't use inv_all in that path. It's
> only used in the power management code now, it seems. But my point still
> stands - invalidating a cache that is enabled is a *really* bad idea, that's
> why we have this in cache-l2x0.c:
> 
> 	/* Invalidating when L2 is enabled is a nono */
> 	BUG_ON(readl(l2x0_base + L2X0_CTRL) & 1);
> 
> > Otherwise, what do you suggest? Whats the effect if we remove
> > that spin lock in inv_all as such I don't see much users using
> > inv_all.
> 
> The lock needs to stay. Besides, the problem isn't with inv_all, the problem
> is with not being able to disable the outer cache. So can't you just do
> something nasty like:
> 
> 	outer_cache.disable = NULL;
> 
> after your call to l2x0_init?

hmm..patch below

> 
> Also, if you can't disable the L2 from non-secure, does that mean that you
> boot Linux with the L2 enabled?

Yes, we boot with L2 enabled.

>From 46fdbda7d2d9a9f4df0933341bcc467b3bdd03d6 Mon Sep 17 00:00:00 2001
From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Date: Tue, 17 Jan 2012 11:29:39 +0530
Subject: [PATCH] mach-ux500: Do not override outer.inv_all

outer.inv_all is currently being used only in kexec path.
Invalidating outer cache without disabling it is a big
nono, and so, remove the machine specific outer.inv_all
assuming that kexec does not call inv_all in its path.

And at the same time it does not prevent us overriding
outer.disable as we do not have any such secure SMI to
handle the same while kexec disables the outer cache.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
---
 arch/arm/mach-ux500/cache-l2x0.c |   48 +++++--------------------------------
 1 files changed, 7 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 122ddde..45111c8 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -12,44 +12,6 @@
 
 static void __iomem *l2x0_base;
 
-static inline void ux500_cache_wait(void __iomem *reg, unsigned long mask)
-{
-	/* wait for the operation to complete */
-	while (readl_relaxed(reg) & mask)
-		cpu_relax();
-}
-
-static inline void ux500_cache_sync(void)
-{
-	writel_relaxed(0, l2x0_base + L2X0_CACHE_SYNC);
-	ux500_cache_wait(l2x0_base + L2X0_CACHE_SYNC, 1);
-}
-
-/*
- * The L2 cache cannot be turned off in the non-secure world.
- * Dummy until a secure service is in place.
- */
-static void ux500_l2x0_disable(void)
-{
-}
-
-/*
- * This is only called when doing a kexec, just after turning off the L2
- * and L1 cache, and it is surrounded by a spinlock in the generic version.
- * However, we're not really turning off the L2 cache right now and the
- * PL310 does not support exclusive accesses (used to implement the spinlock).
- * So, the invalidation needs to be done without the spinlock.
- */
-static void ux500_l2x0_inv_all(void)
-{
-	uint32_t l2x0_way_mask = (1<<16) - 1;	/* Bitmask of active ways */
-
-	/* invalidate all ways */
-	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
-	ux500_cache_wait(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
-	ux500_cache_sync();
-}
-
 static int __init ux500_l2x0_unlock(void)
 {
 	int i;
@@ -85,9 +47,13 @@ static int __init ux500_l2x0_init(void)
 	/* 64KB way size, 8 way associativity, force WA */
 	l2x0_init(l2x0_base, 0x3e060000, 0xc0000fff);
 
-	/* Override invalidate function */
-	outer_cache.disable = ux500_l2x0_disable;
-	outer_cache.inv_all = ux500_l2x0_inv_all;
+	/*
+	 * We can't disable l2 as we are in non secure mode, currently
+	 * this seems being called only during kexec path. So let's
+	 * override outer.disable with nasty assignment until we have
+	 * some SMI service available.
+	 */
+	outer_cache.disable = NULL;
 
 	return 0;
 }
-- 
1.7.4.3
