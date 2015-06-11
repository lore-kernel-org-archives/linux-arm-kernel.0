From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 11 Jun 2015 18:27:33 +0530
Subject: [PATCH 1/6] clocksource: arm_arch_timer: Migrate to new
 'set-state' interface
In-Reply-To: <55797DB6.1040301@linaro.org>
References: <cover.1433768426.git.viresh.kumar@linaro.org>
 <80bb7da364daf25660d130513d386353ac78a640.1433768426.git.viresh.kumar@linaro.org>
 <55797DB6.1040301@linaro.org>
Message-ID: <20150611125733.GA28891@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-06-15, 14:23, Daniel Lezcano wrote:
> [ ... ]
> 
> Instead of returning zero in the functions
> 'timer_shutdown_virt|phys|virt_mem|phys_mem', do it here directly.
> 

> 
> As suggested above:
> 
> 	return timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
> 
> >  }

Sure.

> >@@ -286,17 +286,18 @@ static void __arch_timer_setup(unsigned type,

> >-	clk->set_mode(CLOCK_EVT_MODE_SHUTDOWN, clk);
> >+	clk->set_state_oneshot = arch_timer_set_oneshot;
> >+	clk->set_state_shutdown(clk);
> 
> Why don't you call clockevent_shutdown(clk) ?

I haven't changed the behavior as the current code doesn't do it that
way. If we want to change it, then it should be a separate patch.

Having said that, in this particular instance the device is not yet
registered with the core and we probably didn't wanted 'mode' to be
set to SHUTDOWN. That would have also hit a WARN/BUG as clockevents
core expected the device to be in UNUSED mode at registration.

> There is some initialization there, no ?

We don't want it at this point of time.

> >  	clockevents_config_and_register(clk, arch_timer_rate, 0xf, 0x7fffffff);
> >  }
> >@@ -506,7 +507,7 @@ static void arch_timer_stop(struct clock_event_device *clk)
> >  			disable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI]);
> >  	}
> >
> >-	clk->set_mode(CLOCK_EVT_MODE_UNUSED, clk);
> >+	clk->set_state_shutdown(clk);
> >  }
> 
> Ditto.

This is called from the CPU_DYING notifier, not sure what the
intention was behind not letting the clockevents core about mode
change.

But if it has to change, then it should happen in a separate patch.

-- 
viresh
