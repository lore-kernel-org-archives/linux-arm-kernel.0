From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Mon, 18 Apr 2016 15:17:55 +0200
Subject: [PATCH v2] arm64: Reduce verbosity on SMP CPU stop
In-Reply-To: <20160418121930.GH28645@arm.com>
References: <1460715876-10780-1-git-send-email-jglauber@cavium.com>
 <20160415113706.GE22906@arm.com> <20160418074333.GA16109@hardcore>
 <20160418121930.GH28645@arm.com>
Message-ID: <20160418131755.GA2826@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 01:19:31PM +0100, Will Deacon wrote:
> On Mon, Apr 18, 2016 at 09:43:33AM +0200, Jan Glauber wrote:
> > On Fri, Apr 15, 2016 at 12:37:06PM +0100, Will Deacon wrote:
> > > You can remove stop_lock altogether now, right? I also wonder whether
> > > it would be worth printing out which CPUs are still online in the case where
> > > we fail to stop all the secondaries?
> > 
> > Sorry, I've been a bit offline. Yes, the stop_lock can also be removed. 
> > 
> > How about below patch that prints the CPU ids for all CPUs that failed
> > to stop?
> 
> Yeah, this looks better, thanks. We might want to clear the "stopper"
> CPU from the mask, but it's hard to really care that much.

Then let's not do it, the fact that "the CPU that executes this code
is also still online" is not too wrong...

Jan


> Will
> 
> > 
> > Jan
> > 
> > --------------------------------
> > 
> > When CPUs are stopped during an abnormal operation like panic
> > for each CPU a line is printed and the stack trace is dumped.
> > 
> > This information is only interesting for the aborting CPU
> > and on systems with many CPUs it only makes it harder to
> > debug if after the aborting CPU the log is flooded with data
> > about all other CPUs too.
> > 
> > Therefore remove the stack dump and printk of other CPUs
> > and only print a single line that the other CPUs are going to be
> > stopped and, in case any CPUs remain online list them.
> > 
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > ---
> >  arch/arm64/kernel/smp.c | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index b2d5f4e..29f4e37 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -763,21 +763,11 @@ void arch_irq_work_raise(void)
> >  }
> >  #endif
> >  
> > -static DEFINE_RAW_SPINLOCK(stop_lock);
> > -
> >  /*
> >   * ipi_cpu_stop - handle IPI from smp_send_stop()
> >   */
> >  static void ipi_cpu_stop(unsigned int cpu)
> >  {
> > -	if (system_state == SYSTEM_BOOTING ||
> > -	    system_state == SYSTEM_RUNNING) {
> > -		raw_spin_lock(&stop_lock);
> > -		pr_crit("CPU%u: stopping\n", cpu);
> > -		dump_stack();
> > -		raw_spin_unlock(&stop_lock);
> > -	}
> > -
> >  	set_cpu_online(cpu, false);
> >  
> >  	local_irq_disable();
> > @@ -872,6 +862,9 @@ void smp_send_stop(void)
> >  		cpumask_copy(&mask, cpu_online_mask);
> >  		cpumask_clear_cpu(smp_processor_id(), &mask);
> >  
> > +		if (system_state == SYSTEM_BOOTING ||
> > +		    system_state == SYSTEM_RUNNING)
> > +			pr_crit("SMP: stopping secondary CPUs\n");
> >  		smp_cross_call(&mask, IPI_CPU_STOP);
> >  	}
> >  
> > @@ -881,7 +874,8 @@ void smp_send_stop(void)
> >  		udelay(1);
> >  
> >  	if (num_online_cpus() > 1)
> > -		pr_warning("SMP: failed to stop secondary CPUs\n");
> > +		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
> > +			   cpumask_pr_args(cpu_online_mask));
> >  }
> >  
> >  /*
> > -- 
> > 1.9.1
> > 
