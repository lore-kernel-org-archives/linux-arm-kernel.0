From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 07 Sep 2012 14:22:36 -0700
Subject: [PATCH RFC] clk: use spinlock for clk_get_rate
In-Reply-To: <504A43D0.7060406@calxeda.com>
References: <1346919146-25972-1-git-send-email-shawn.guo@linaro.org>
 <5049EFE5.4080002@calxeda.com> <504A43D0.7060406@calxeda.com>
Message-ID: <20120907212236.20289.14547@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Mark Langsdorf (2012-09-07 11:58:24)
> > From: Shawn Guo <shawn.guo@linaro.org>
> >
> > A nested locking issue is seen on imx6q (CA9 Quad) as below when cpufreq
> > driver is running.  It looks like the issue is caused by a simultaneous
> > call to clk_get_rate from two smp_twd threads.
> > 
> > 1) cpu0_set_target
> >      cpufreq_notify_transition
> >        ...
> >          twd_cpufreq_transition
> >            twd_update_frequency
> >              clk_get_rate
> > 
> > 2) do_exit
> >      kernel_init
> >        smp_prepare_cpus
> >          percpu_timer_setup
> >            twd_timer_setup
> >              clk_get_rate
> > 
> > The patch "clk: new locking scheme for reentrancy" does not help the
> > issue.  I'm not sure if this is an issue that should be fixed in
> > smp_twd driver or it's an use case which should be supported by clk API.
> > 
> > Looking at clk_get_rate() API, it just reads a cached clock rate and
> > should be fast enough to hold a spinlock than mutex.  It's a quick
> > fix to the issue, but I'm not really sure it's the correct one. That's
> > why this is a RFC patch.
> 
> I was seeing a similar issue while developing cpufreq support for the
> Calxeda Highbank SoC. This patch seems to have resolved the issue. I
> don't know if it's correct, but it works for me.
> 

The fix is not correct.  clk->rate is protected by the prepare_lock
mutex and not the enable_lock spinlock.  This change makes it so that we
have two different locks protecting the same structure member at
different times and accesses are unsynchronized.

This can be fixed in the framework and I'll post more on that soon.

Regards,
Mike

> --Mark Langsdorf
> Calxeda, Inc.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
