From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 9 Jul 2015 16:17:40 +0800
Subject: [PATCH] ARM: socfpga: put back v7_invalidate_l1 in
 socfpga_secondary_startup
In-Reply-To: <20150709075717.GO7557@n2100.arm.linux.org.uk>
References: <1436370711-18524-1-git-send-email-dinguyen@opensource.altera.com>
 <20150708165115.GM7557@n2100.arm.linux.org.uk>
 <559D765C.30102@opensource.altera.com>
 <20150708210734.GN7557@n2100.arm.linux.org.uk>
 <20150709115249.18fefe8d@xhacker>
 <20150709075717.GO7557@n2100.arm.linux.org.uk>
Message-ID: <20150709161740.3512fc5b@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

On Thu, 9 Jul 2015 08:57:17 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Jul 09, 2015 at 11:52:49AM +0800, Jisheng Zhang wrote:
> > Dear Russell,
> > 
> > On Wed, 8 Jul 2015 22:07:34 +0100
> > Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > 
> > > On Wed, Jul 08, 2015 at 02:13:32PM -0500, Dinh Nguyen wrote:
> > > > The value of CPACR is 0x00F00000. So cp11 and cp10 are privileged and
> > > > user mode access.
> > > 
> > > Hmm.
> > > 
> > > I think what you've found is a(nother) latent bug in the CPU bring up
> > > code.
> > > 
> > > For SMP CPUs, the sequence we're following during early initialisation is:
> > > 
> > > 1. Enable SMP coherency.
> > > 2. Invalidate the caches.
> > > 
> > > If the cache contains rubbish, enabling SMP coherency before invalidating
> > > the cache is plainly an absurd thing to do.
> > > 
> > > Can you try the patch below - not tested in any way, so you may need to
> > > tweak it, but it should allow us to prove that point.
> > > 
> > > diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> > > index 0716bbe19872..db5137fc297d 100644
> > > --- a/arch/arm/mm/proc-v7.S
> > > +++ b/arch/arm/mm/proc-v7.S
> > > @@ -275,6 +275,10 @@ __v7_b15mp_setup:
> > >  __v7_ca17mp_setup:
> > >  	mov	r10, #0
> > >  1:
> > > +	adr	r12, __v7_setup_stack		@ the local stack
> > > +	stmia	r12, {r0-r5, r7, r9-r11, lr}
> > > +	bl      v7_invalidate_l1
> > > +	ldmia	r12, {r0-r5, r7, r9-r11, lr}
> > 
> > Some CPUs such as CA7 need enable SMP before any cache maintenance.
> > 
> > CA7 TRM says something about SMP bit:
> > "You must ensure this bit is set to 1 before the caches and MMU are enabled,
> > or any cache and TLB maintenance operations are performed."
> 
> Frankly, that's wrong for two reasons.  Think about it for a moment...
> 
> If the cache contains crap - in other words, it contains random
> uninitialised data in the cache lines at random locations, some of
> which are marked valid and some of which are marked dirty - then
> enabling the SMP bit puts the caches into coherent mode, and they
> join the coherent cluster.
> 
> That means those cache lines containing crap become visible to other
> CPUs in the cluster, and can be migrated to other CPUs, and the crap
> data in them becomes visible to other CPUs.  This leads to state
> corruption on other CPUs in the cluster.
> 
> Moreover, the cache invalidation of the local L1 cache is broadcast
> to other CPUs in the cluster, and _their_ caches are also invalidated,
> again, leading to state corruption on already running CPUs.  We don't
> want the invalidation of the incoming CPU to be broadcast to the other
> CPUs.
> 
> This is all round a very bad thing.
> 
> > Also CA7 would invalidate L1 automatically once reset, can we remove the
> > invalidate op in CA7 case?
> 
> No, because we enter this path from multiple different situations, eg,
> after the decompressor has run, after the boot loader has run which
> may have enabled caches and not properly invalidated them prior to
> calling the kernel.
> 

Got it. Thanks very much for your detailed explanation!
