From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Thu, 21 May 2015 05:48:33 -0700
Subject: [PATCH tip/core/rcu 7/9] arm64: Use common
 outgoing-CPU-notification code
In-Reply-To: <20150521085806.GC21920@arm.com>
References: <20150512214945.GA813@linux.vnet.ibm.com>
 <1431467407-1223-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <1431467407-1223-7-git-send-email-paulmck@linux.vnet.ibm.com>
 <20150521085806.GC21920@arm.com>
Message-ID: <20150521124833.GJ6776@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 09:58:06AM +0100, Will Deacon wrote:
> Hi Paul,
> 
> Sorry for being late on this one.

No problem!  In fact, just in time -- I was going to bug you about
this later today.  ;-)

> On Tue, May 12, 2015 at 10:50:05PM +0100, Paul E. McKenney wrote:
> > From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > 
> > This commit removes the open-coded CPU-offline notification with new
> > common code.  In particular, this change avoids calling scheduler code
> > using RCU from an offline CPU that RCU is ignoring.  This is a minimal
> > change.  A more intrusive change might invoke the cpu_check_up_prepare()
> > and cpu_set_state_online() functions at CPU-online time, which would
> > allow onlining throw an error if the CPU did not go offline properly.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/smp.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> I don't have a better idea, so:
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Is this queued via -tip already, or can we pick it into the arm64 tree
> for 4.2?

Feel free to take it into the arm64 tree.  Just let me know, and I
will drop it from my tree.

Now I only need to bug the arm32 guys.  ;-)

							Thanx, Paul

> Cheers,
> 
> Will
> 
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 2cb008177252..a899c1beff54 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -253,15 +253,13 @@ static int op_cpu_kill(unsigned int cpu)
> >  	return cpu_ops[cpu]->cpu_kill(cpu);
> >  }
> >  
> > -static DECLARE_COMPLETION(cpu_died);
> > -
> >  /*
> >   * called on the thread which is asking for a CPU to be shutdown -
> >   * waits until shutdown has completed, or it is timed out.
> >   */
> >  void __cpu_die(unsigned int cpu)
> >  {
> > -	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
> > +	if (!cpu_wait_death(cpu, 5)) {
> >  		pr_crit("CPU%u: cpu didn't die\n", cpu);
> >  		return;
> >  	}
> > @@ -294,7 +292,7 @@ void cpu_die(void)
> >  	local_irq_disable();
> >  
> >  	/* Tell __cpu_die() that this CPU is now safe to dispose of */
> > -	complete(&cpu_died);
> > +	(void)cpu_report_death();
> >  
> >  	/*
> >  	 * Actually shutdown the CPU. This must never fail. The specific hotplug
> > -- 
> > 1.8.1.5
> > 
> 
