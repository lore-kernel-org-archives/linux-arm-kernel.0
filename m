From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 14 Jun 2011 18:30:19 +0100
Subject: [PATCH] ARM: mm: cache-l2x0: Add support for re-enabling l2x0
In-Reply-To: <BANLkTingENSjDaE7O+Lb6P=ED4JtuJY1jkV25b3SW6RhsOQQkw@mail.gmail.com>
References: <1307926019-28958-1-git-send-email-ccross@android.com>
	<20110613101942.GA7924@e102568-lin.cambridge.arm.com>
	<BANLkTingENSjDaE7O+Lb6P=ED4JtuJY1jkV25b3SW6RhsOQQkw@mail.gmail.com>
Message-ID: <20110614173013.GA9234@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 07:20:34PM +0100, Colin Cross wrote:
> On Mon, Jun 13, 2011 at 3:19 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > On Mon, Jun 13, 2011 at 01:46:58AM +0100, Colin Cross wrote:
> >> Remove __init annotation from l2x0_init so it can be used to
> >> reinitialize the l2x0 after it has been reset during suspend.
> >>
> >> Only print the init messages the first time l2x0_init is called.
> >>
> >> Add l2x0_enable to re-enable the l2x0 after l2x0_disable if
> >> the l2x0 was not reset.
> >>
> >> l2x0_disable cannot use writel, as writel calls wmb(), and wmb()
> >> may call outer_cache_sync, which takes the same spinlock as
> >> l2x0_disable.
> >>
> >> Signed-off-by: Colin Cross <ccross@android.com>
> >> ---
> >> ?arch/arm/include/asm/hardware/cache-l2x0.h | ? ?3 ++-
> >> ?arch/arm/mm/cache-l2x0.c ? ? ? ? ? ? ? ? ? | ? 18 ++++++++++++++----
> >> ?2 files changed, 16 insertions(+), 5 deletions(-)
> >>
> >
> > [...]
> >
> >> +/* enables l2x0 after l2x0_disable, does not invalidate */
> >> +void l2x0_enable(void)
> >> +{
> >> + ? ? unsigned long flags;
> >> +
> >> + ? ? spin_lock_irqsave(&l2x0_lock, flags);
> >> + ? ? writel_relaxed(1, l2x0_base + L2X0_CTRL);
> >> + ? ? spin_unlock_irqrestore(&l2x0_lock, flags);
> >> +}
> >> +
> >> ?static void l2x0_disable(void)
> >> ?{
> >> ? ? ? unsigned long flags;
> >>
> >> ? ? ? spin_lock_irqsave(&l2x0_lock, flags);
> >> - ? ? writel(0, l2x0_base + L2X0_CTRL);
> >> + ? ? writel_relaxed(0, l2x0_base + L2X0_CTRL);
> >> ? ? ? spin_unlock_irqrestore(&l2x0_lock, flags);
> >> ?}
> >
> > This function is still dodgy to use, since we are disabling L2
> > possibly with current function stack lines allocated, which might wreak havoc.
> 
> From my JTAG debugging, I think the PL310 (at least the one I'm
> working with) flushes on disable.  I had a problem where reads with
> the cache disabled were getting incorrect data because the data was
> stuck in the cache.  With the CPU paused, I disabled the PL310 with
> the L2X0_CTRL register, and my data appeared in memory.  I'll try to
> find some documentation to support this.
> 

According to the PL310 TRM (r3p2 3-9) on disable the PL310 syncs, which means
it flushes internal buffers, but it is not supposed to clean dirty lines.
It seems unsafe to me to use the stack and other cacheable data right before
disabling.

> Otherwise, wouldn't a flush_cache_all() and l2x0_flush_all() in
> l2x0_disable() ensure the stack lines were flushed out?  Probably
> needs a readl_releaxed as well, to ensure the disable has taken
> effect.
> 

I reckon the safest option is to clean and disable in one C
function. Moreover at that point in time spinlocks might not be an option
anymore (CPU out of coherency), which makes those functions unusable.

> >>
> >> -void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
> >> +void l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
> >> ?{
> >> ? ? ? __u32 aux;
> >> ? ? ? __u32 cache_id;
> >> @@ -340,7 +350,7 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
> >> ? ? ? outer_cache.disable = l2x0_disable;
> >> ? ? ? outer_cache.set_debug = l2x0_set_debug;
> >>
> >> - ? ? printk(KERN_INFO "%s cache controller enabled\n", type);
> >> - ? ? printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d B\n",
> >> + ? ? pr_info_once("%s cache controller enabled\n", type);
> >> + ? ? pr_info_once("l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d B\n",
> >> ? ? ? ? ? ? ? ? ? ? ? ways, cache_id, aux, l2x0_size);
> >> ?}
> >
> > We might still need hooks to save/restore PL310 context since registers
> > like tag and data RAM control are gone on reset. Furthermore, on L2 RAM
> > retention we want to reinit L2 without having to invalidate L2 RAM(s),
> > which means we cannot use l2x0_init as it is. I added a couple of hooks to
> > outer_cache in order to carry out this task, patch coming.
> 
> I'm assuming that every platform has a function to set up the tag ram
> control the way they want them, which then calls l2x0_init.  That
> platform cache init function can be called instead of directly calling
> l2x0_init from the resume path.

I agree that it might solve the problem, and I understand that it allows
to reuse some code, but this will force us to call into platform code
to reinit L2 (which goes against the grain of platform notifiers);
if we manage to write a function doing the whole thing in
a single place it might be easier to use and factor out some replicated
code in the process.

Lorenzo
