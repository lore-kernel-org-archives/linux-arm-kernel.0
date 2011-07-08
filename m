From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 8 Jul 2011 09:25:25 +0100
Subject: [RFC PATCH 13/17] ARM: mm: L2x0 save/restore support
In-Reply-To: <CAMbhsRRdMR4nv7Gqyq0xe=M6oUfe7t0otSiJMDd0mnctOEbdSA@mail.gmail.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-14-git-send-email-lorenzo.pieralisi@arm.com>
	<CAMbhsRRdMR4nv7Gqyq0xe=M6oUfe7t0otSiJMDd0mnctOEbdSA@mail.gmail.com>
Message-ID: <20110708082525.GA31338@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Colin for looking at this.

On Thu, Jul 07, 2011 at 11:06:13PM +0100, Colin Cross wrote:
> On Thu, Jul 7, 2011 at 8:50 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > When the system hits deep low power states the L2 cache controller
> > can lose its internal logic values and possibly its TAG/DATA RAM content.
> >
> > This patch adds save/restore hooks to the L2x0 subsystem to save/restore
> > L2x0 registers and clean/invalidate/disable the cache controller as
> > needed.
> >
> > The cache controller has to go to power down disabled even if its
> > RAM(s) are retained to prevent it from sending AXI transactions on the
> > bus when the cluster is shut-down which might leave the system in a
> > limbo state.
> >
> > Hence the save function cleans (completely or partially) L2 and disable
> > it in one single function to avoid playing with cacheable stack and
> > flush data to L3.
> >
> > The current code saving context for retention mode is still a hack and must be
> > improved.
> >
> > Fully tested on dual-core A9 cluster.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  arch/arm/include/asm/outercache.h |   22 +++++++++++++
> >  arch/arm/mm/cache-l2x0.c          |   63 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 85 insertions(+), 0 deletions(-)
> >
> 
> <snip>
> 
> > diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> > index ef59099..331fe9b 100644
> > --- a/arch/arm/mm/cache-l2x0.c
> > +++ b/arch/arm/mm/cache-l2x0.c
> > @@ -270,6 +270,67 @@ static void l2x0_disable(void)
> >        spin_unlock_irqrestore(&l2x0_lock, flags);
> >  }
> >
> > +static void l2x0_save_context(void *data, bool dormant, unsigned long end)
> > +{
> > +       u32 *l2x0_regs = (u32 *) data;
> > +       *l2x0_regs =  readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
> > +       l2x0_regs++;
> > +       *l2x0_regs =  readl_relaxed(l2x0_base + L2X0_TAG_LATENCY_CTRL);
> > +       l2x0_regs++;
> > +       *l2x0_regs =  readl_relaxed(l2x0_base + L2X0_DATA_LATENCY_CTRL);
> > +
> > +       if (!dormant) {
> > +               /* clean entire L2 before disabling it*/
> > +               writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_WAY);
> > +               cache_wait_way(l2x0_base + L2X0_CLEAN_WAY, l2x0_way_mask);
> > +       } else {
> > +               /*
> > +                * This is an ugly hack, which is there to clean
> > +                * the stack from L2 before disabling it
> > +                * The only alternative consists in using a non-cacheable stack
> > +                * but it is poor in terms of performance since it is only
> > +                * needed for cluster shutdown and L2 retention
> > +                * On L2 off mode the cache is cleaned anyway
> > +                */
> 
> You could avoid the need to pass in "end", and all the code to track
> it, if you just flush all of the used stack.  Idle is always called
> from a kernel thread, so it should be guaranteed that the stack is
> size THREAD_SIZE and  THREAD_SIZE aligned, so:
> end = ALIGN(start, THREAD_SIZE);
> 

Eheh, the used stack, that's what I am trying to achieve with the end
variable, I would avoid cleaning THREAD_SIZE worth of L2 when it is just
a matter of few bytes.

On the other end, you are right this code path is really horrible.
I would do it in assembly, or follow your suggestion and clean starting
from above thread_info.

> > +               register unsigned long start asm("sp");
> > +               start &= ~(CACHE_LINE_SIZE - 1);
> 
> Why doesn't this line modify sp?  You have declared start to be stored
> in sp, and modified start, but gcc seems to use a different register
> initialized from sp.  You still probably shouldn't modify start.
> 

You are right, gcc allocates a register but on second thoughts this code
does not look safe to me. I just wanted to avoid allocating another
stack variable when cleaning the stack. I will rework it, see above.

> > +               while (start < end) {
> > +                       cache_wait(l2x0_base + L2X0_CLEAN_LINE_PA, 1);
> > +                       writel_relaxed(__pa(start), l2x0_base +
> > +                                       L2X0_CLEAN_LINE_PA);
> > +                       start += CACHE_LINE_SIZE;
> > +               }
> > +       }
> > +       /*
> > +        * disable the cache implicitly syncs
> > +        */
> > +       writel_relaxed(0, l2x0_base + L2X0_CTRL);
> > +}
> > +
> 
> <snip>
> 
> Tested just this patch on Tegra to avoid flushing the whole L2 on idle, so:
> Tested-by: Colin Cross <ccross@android.com>
> 

On Tegra Colin, how do you make sure this call is atomic when calling
from cpu idle ? I reckon you are sure the calling cpu is the last one
up and running, am I right ?

Thanks.

Lorenzo
