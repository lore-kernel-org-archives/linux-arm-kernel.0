From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 26 Jul 2013 18:04:02 +0100
Subject: [PATCH 01/13] ARM: suspend: use hash of cpu_logical_map value to
 index into save array
In-Reply-To: <alpine.LFD.2.03.1307261139370.15022@syhkavp.arg>
References: <alpine.LFD.2.03.1307251203550.15022@syhkavp.arg>
 <20130726113110.GB28084@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1307261032330.15022@syhkavp.arg>
 <20130726153440.GD2282@localhost.localdomain>
 <alpine.LFD.2.03.1307261139370.15022@syhkavp.arg>
Message-ID: <20130726170402.GF28084@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 04:43:34PM +0100, Nicolas Pitre wrote:
> On Fri, 26 Jul 2013, Dave Martin wrote:
> 
> > On Fri, Jul 26, 2013 at 10:41:38AM -0400, Nicolas Pitre wrote:
> > > On Fri, 26 Jul 2013, Lorenzo Pieralisi wrote:
> > > 
> > > > On Thu, Jul 25, 2013 at 05:06:51PM +0100, Nicolas Pitre wrote:
> > > > > On Thu, 25 Jul 2013, Dave Martin wrote:
> > > > > 
> > > > > > On Wed, Jul 24, 2013 at 02:55:00PM -0400, Nicolas Pitre wrote:
> > > > > > > On Wed, 24 Jul 2013, Dave Martin wrote:
> > > > > > > 
> > > > > > > > But this patch commits us to requiring that on the suspend path 
> > > > > > > > specifically -- I think that ought to be mentioned somewhere. A 
> > > > > > > > comment in the preamble for __cpu_suspend would be enough, I think.
> > > > > > > 
> > > > > > > What comment would you suggest?  I want to make sure the possible 
> > > > > > > confusion you see is properly addressed.
> > > > > > 
> > > > > > I think we just need to state that the value of
> > > > > > cpu_logical_map(smp_processor_id()) must be the MPIDR of the physical
> > > > > > CPU the suspending logical CPU will resume on.  Consequently, if doing a
> > > > > > migration, cpu_logical_map() must be updated appropriately somewhere
> > > > > > between cpu_pm_enter() and cpu_suspend().
> > > > > 
> > > > > Excellent.  I've amended the patch with this:
> > > > > 
> > > > > diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
> > > > > index 2835d35234..caf938db62 100644
> > > > > --- a/arch/arm/kernel/suspend.c
> > > > > +++ b/arch/arm/kernel/suspend.c
> > > > > @@ -17,6 +17,11 @@ extern void cpu_resume_mmu(void);
> > > > >  /*
> > > > >   * Hide the first two arguments to __cpu_suspend - these are an implementation
> > > > >   * detail which platform code shouldn't have to know about.
> > > > > + *
> > > > > + * On SMP systems, the value of cpu_logical_map(smp_processor_id()) must be
> > > > > + * the MPIDR of the physical CPU the suspending logical CPU will resume on.
> > > > > + * Consequently, if doing a physical CPU migration, cpu_logical_map() must be
> > > > > + * updated appropriately somewhere between cpu_pm_enter() and cpu_suspend().
> > > > >   */
> > > > >  int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
> > > > >  {
> > > > > 
> > > > > I've put it against cpu_suspend() rather than __cpu_suspend(() as this 
> > > > > is what users should care about.
> > > > > 
> > > > > ACK?
> > > > 
> > > > We need this patch to allow IKS to store a cpu context at a specific
> > > > index, let's be honest. It is a moot point and I am not very happy
> > > > about changing this code for a very specific usage, but the way code is
> > > > implemented makes the change acceptable. I really do not think we should
> > > > write guidelines on how cpu_suspend users have to change cpu_logical_map
> > > > though, that's not needed apart from IKS and that should be limited to IKS
> > > > code only.
> > > > 
> > > > Again, that's just my opinion, but cpu_suspend API must be kept as it is
> > > > and we should not encourage people to use it in creative ways.
> > > 
> > > I tend to agree, but I'm now stuck between two conflicting requests.
> > 
> > Would it make sense to keep the same API to cpu_suspend(), but make it
> > a wrapper for another function which has the MPIDR argument?  Then people
> > calling cpu_suspend() continue as normal.  Only IKS needs to know about
> > the underlying MPIDR handling when calling this.
> 
> The fact is that the switcher _does_ need to swizzle the cpu_logical_map 
> anyway before suspending.  Hence really there is no point creating extra
> wrappers for this.
> 
> So Lorenzo's suggestion to simply not advertise this too much for people 
> to not get too creative is probably the best compromize IMHO.

We could add a function cpu_migrate, almost identical to cpu_suspend
but accepting an MPIDR parameter as Dave said. cpu_suspend would read its
own MPIDR using read_cpuid_mpidr() and pass it to __cpu_suspend, keeping the
current behaviour unchanged (well, MPIDR is now read in cpu_suspend instead
of __cpu_suspend).
cpu_migrate will pass the mpidr to __cpu_suspend, to say "migrate this CPU to
the CPU identified by this MPIDR"; IKS can swizzle cpu_logical_map internally.

Looks like lot of churn though, probably the intent is clearer and closer to
PSCI. Just an idea, probably useless.

I will apply and test the patch as it is first thing next week.

Lorenzo
