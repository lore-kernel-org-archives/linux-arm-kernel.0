From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 14 Jan 2013 11:54:52 -0500 (EST)
Subject: [PATCH 08/16] ARM: bL_platsmp.c: make sure the GIC interface of
 a dying CPU is disabled
In-Reply-To: <20130114163902.GC31341@mudshark.cambridge.arm.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-9-git-send-email-nicolas.pitre@linaro.org>
 <20130114163902.GC31341@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1301141154130.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Jan 2013, Will Deacon wrote:

> On Thu, Jan 10, 2013 at 12:20:43AM +0000, Nicolas Pitre wrote:
> > Otherwise there might be some interrupts or IPIs becoming pending and the
> > CPU will not enter low power mode when doing a WFI.  The effect of this
> > is a CPU that loops back into the kernel, go through the first man
> > election, signals itself as alive,  and prevent the cluster from being
> > shut down.
> > 
> > This could benefit from a better solution.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > ---
> >  arch/arm/common/bL_platsmp.c        | 1 +
> >  arch/arm/common/gic.c               | 6 ++++++
> >  arch/arm/include/asm/hardware/gic.h | 2 ++
> >  3 files changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm/common/bL_platsmp.c b/arch/arm/common/bL_platsmp.c
> > index 0ae44123bf..6a3b251b97 100644
> > --- a/arch/arm/common/bL_platsmp.c
> > +++ b/arch/arm/common/bL_platsmp.c
> > @@ -68,6 +68,7 @@ static void __ref bL_cpu_die(unsigned int cpu)
> >  	pcpu = mpidr & 0xff;
> >  	pcluster = (mpidr >> 8) & 0xff;
> >  	bL_set_entry_vector(pcpu, pcluster, NULL);
> > +	gic_cpu_if_down();
> 
> I'm starting to sound like a stuck record (and not a very tuneful one at
> that) but... I think you need a barrier here.

And I'm getting puzzled at the repetition.  ;-)


Nicolas
