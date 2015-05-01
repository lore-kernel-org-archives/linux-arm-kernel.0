From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Fri, 1 May 2015 12:18:24 -0700
Subject: [PATCH arm 1/2] arm64: Use common outgoing-CPU-notification code
In-Reply-To: <20150501162915.GI27755@e104818-lin.cambridge.arm.com>
References: <20150423200603.GA9473@linux.vnet.ibm.com>
 <1429819654-10498-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20150430095055.GI18867@e104818-lin.cambridge.arm.com>
 <20150501150848.GC5381@linux.vnet.ibm.com>
 <20150501162915.GI27755@e104818-lin.cambridge.arm.com>
Message-ID: <20150501191824.GG5381@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 01, 2015 at 05:29:15PM +0100, Catalin Marinas wrote:
> On Fri, May 01, 2015 at 08:08:48AM -0700, Paul E. McKenney wrote:
> > On Thu, Apr 30, 2015 at 10:50:55AM +0100, Catalin Marinas wrote:
> > > On Thu, Apr 23, 2015 at 01:07:33PM -0700, Paul E. McKenney wrote:
> > > > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > > > index 328b8ce4b007..6dc727a6e73e 100644
> > > > --- a/arch/arm64/kernel/smp.c
> > > > +++ b/arch/arm64/kernel/smp.c
> > > > @@ -252,15 +252,13 @@ static int op_cpu_kill(unsigned int cpu)
> > > >  	return cpu_ops[cpu]->cpu_kill(cpu);
> > > >  }
> > > >  
> > > > -static DECLARE_COMPLETION(cpu_died);
> > > > -
> > > >  /*
> > > >   * called on the thread which is asking for a CPU to be shutdown -
> > > >   * waits until shutdown has completed, or it is timed out.
> > > >   */
> > > >  void __cpu_die(unsigned int cpu)
> > > >  {
> > > > -	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
> > > > +	if (!cpu_wait_death(cpu, 5)) {
> > > >  		pr_crit("CPU%u: cpu didn't die\n", cpu);
> > > >  		return;
> > > >  	}
> > > > @@ -293,7 +291,7 @@ void cpu_die(void)
> > > >  	local_irq_disable();
> > > >  
> > > >  	/* Tell __cpu_die() that this CPU is now safe to dispose of */
> > > > -	complete(&cpu_died);
> > > > +	(void)cpu_report_death();
> > > >  
> > > >  	/*
> > > >  	 * Actually shutdown the CPU. This must never fail. The specific hotplug
> > > 
> > > Are these functions are only defined when HOTPLUG_CPU is enabled? On
> > > arm64 we can end up with this option disabled if SUSPEND is disabled.
> > 
> > Yep, only with HOTPLUG_CPU.  And yes, both SUSPEND and HIBERNATION can
> > force HOTPLUG_CPU, so if you have neiter SUSPEND nor HIBERNATION, you
> > won't have HOTPLUG_CPU.  This -should- be OK, because you should also
> > not have __cpu_die() if !HOTPLUG_CPU.
> 
> Ah, you are right. I got myself confused.
> 
> So is this patch ready for upstreaming or just for our information?

It does need some testing, and I don't have access to an arm64 system.
That said, very similar patches have worked for other architectures.
So if it works on one of your systems, it should be ready to go upstream.
Which would be better than me sending it individually to people who
run into the new more-strict diagnostics.  ;-)

							Thanx, Paul
