From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 26 Aug 2014 14:46:31 -0700
Subject: [PATCH v7 3/8] cpufreq: kirkwood: Remove use of the clk provider
 API
In-Reply-To: <20140822201112.GH17277@lunn.ch>
References: <1408375833-10703-1-git-send-email-tomeu.vizoso@collabora.com>
 <1408375833-10703-4-git-send-email-tomeu.vizoso@collabora.com>
 <20140820225513.5251.284@quantum> <53F5A587.9030200@collabora.com>
 <20140821133825.GH8608@lunn.ch> <20140822192933.5251.53733@quantum>
 <20140822201112.GH17277@lunn.ch>
Message-ID: <20140826214631.5251.66177@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Andrew Lunn (2014-08-22 13:11:12)
> > Thanks for reviewing. I think my patch is equivalent to the old way of
> > doing things, with one exception that I will address later below.
> > 
> > struct cpufreq_frequency_table kirkwood_freq_table has clock rates
> > initialized to zero, so there is no regression compared to my unsigned
> > long cpu_frequency variable used for tracking the clock rate. Both
> > implementations start with unknown rates in hardware and initialize a
> > variable to zero until that rate can be discovered later on in
> > kirkwood_cpufreq_probe().
> > 
> > kirkwood_cpufreq_get_cpu_frequency() returns the frequency based on the
> > state of the clock. As best I can tell, this clock is only touched by
> > this cpufreq driver and nowhere else
> 
> Not quite true. u-boot might of touch the clock. Weird things happen
> with some kirkwood boards. Some don't have the ability to control
> there power supplies. So some boards implement "power off" by
> rebooting, and letting u-boot spin until a button is pressed. I hope
> such a u-boot powers off as much as possible, and e.g. drops the CPU
> clock to the lower frequency. One would also hope it puts it back to
> high speed before calling the kernel.

I have a doubt about this.

The powersave clock in drivers/clk/mvebu/kirkwood.c does not set
CLK_IGNORE_UNUSED, nor do any of the clocks in kirkwood_gating_desc[].

So regardless of what U-boot does, if no driver has called clk_enable() on
powersave_clk by late_initcall-time then clk_disable_unused() will
disable it as a power-saving mechanism.

So are kirkwood systems that use cpufreq simply getting lucky and not
hanging?

Regards,
Mike

> 
> There is also the somewhat unlikely case that somebody uses kexec to
> go from one kernel to another. You have no idea what state the
> previous kernel left the clock in.
> 
> > , so the driver knows the state of
> > the clock implicitly and doesn't need to read any hardware registers to
> > see if it is enabled or not. Every time we enable or disable the clock
> > we can know the cpu frequency.
> > 
> > > 
> > > However, if you don't cause an actual state change, the WFI never
> > > returns. If this assumption is wrong, your box is dead the first time
> > > it tries to change cpu frequency.
> > 
> > So if a state change in hardware never occurs, the cpu will not wake up?
> 
> Correct. I had that situation a few times while developing this
> driver. And it is not obvious what has happened, since it does not
> happen immediately, but when the governor decides the CPU load passes
> a threshold and the frequency can be changed. I had it stop dead while
> i assume it executed some sleep in an /etc/init.d script.
> 
> > That sounds like a bad situation but I do not understand how it relates
> > to the changes I made in the driver. Could you explain how tracking
> > cpu_frequency in the driver would result in the cpu not waking up from
> > wfi?
> 
> It was clearer in earlier versions of the driver, but code has been
> refactored into the cpufreq core. The core should call
> kirkwood_cpufreq_get_cpu_frequency() in order to get the current
> frequency, and only perform a change if the requested frequency is
> different. In the current code, kirkwood_cpufreq_get_cpu_frequency()
> reads from the hardware what the current frequency is. So we are
> guaranteed to only call kirkwood_cpufreq_target() when there is a real
> change.
> 
> [snip]
> 
> > Can the driver's
> > view of the clock status be out of sync with the actual hardware?
> 
> Yes, at startup, as explained above, we have no idea what the current
> state of the hardware is. Once we do know the real state, we can track
> it within the driver, but we need to get that initial state correct,
> or we WFI forever on the first frequency change.
> 
>    Andrew
