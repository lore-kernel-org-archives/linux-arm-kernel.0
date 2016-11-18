From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Nov 2016 13:29:13 +0000
Subject: [PATCH 15/20] ARM/hw_breakpoint: Convert to hotplug state machine
In-Reply-To: <alpine.DEB.2.20.1611181401180.3615@nanos>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
 <20161117183541.8588-16-bigeasy@linutronix.de>
 <20161118120453.GI13470@arm.com>
 <alpine.DEB.2.20.1611181401180.3615@nanos>
Message-ID: <20161118132912.GM13470@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 02:11:58PM +0100, Thomas Gleixner wrote:
> On Fri, 18 Nov 2016, Will Deacon wrote:
> > On Thu, Nov 17, 2016 at 07:35:36PM +0100, Sebastian Andrzej Siewior wrote:
> > > @@ -1082,15 +1077,18 @@ static int __init arch_hw_breakpoint_init(void)
> > >  	register_undef_hook(&debug_reg_hook);
> > >  
> > >  	/*
> > > -	 * Reset the breakpoint resources. We assume that a halting
> > > -	 * debugger will leave the world in a nice state for us.
> > > +	 * Register CPU notifier which resets the breakpoint resources. We
> > > +	 * assume that a halting debugger will leave the world in a nice state
> > > +	 * for us.
> > >  	 */
> > > -	on_each_cpu(reset_ctrl_regs, NULL, 1);
> > > +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm/hw_breakpoint:online",
> > > +				dbg_reset_online, NULL);
> > 
> > I'm slightly unsure about this. The dbg_reset_online callback can execute
> > undefined instructions (unfortunately, there's no way to probe the presence
> > of some of the debug registers), so it absolutely has to run within the 
> > register_undef_hook/unregister_undef_hook calls that are in this function.
> > 
> > With this patch, I worry that the callback can be postponed to ONLINE time
> > for other CPUs, and then the kernel will panic.
> 
> No. The flow is the following:
> 
>   	register_undef_hook(&debug_reg_hook);
> 
> 	ret = cpuhp_setup_state(.., dbg_reset_online, NULL);
> 	      {
> 		for_each_online_cpu(cpu) {
> 			ret = call_on_cpu(cpu, dbg_reset_online);
> 			if (ret)
> 			      return ret:
> 		}
> 	      }
> 
>   	unregister_undef_hook(&debug_reg_hook);
> 	
> The only difference to the current code is that the call is not invoked via
> a smp function call (on_each_cpu), it's pushed to the hotplug thread
> context of each cpu and executed there.
> 
> But it's guaranteed that cpuhp_setup_state() will not return before the
> callback has been invoked on each online cpu.

Ok, that's good.

> If cpus are not yet online when that code is invoked, then it's the same
> behaviour as before. It will be invoked when the cpu comes online.

Just to check, but what stops a CPU from coming online between the call
to cpuhp_setup_state and the call to cpuhp_remove_state_nocalls in the
case of failure (debug_err_mask isn't empty)?

Will
