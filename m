From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Sep 2016 11:13:30 +0100
Subject: [GIT PULL] Greybus driver subsystem for 4.9-rc1
In-Reply-To: <1473932133.10230.25.camel@nexus-software.ie>
References: <20160914100949.GA6179@kroah.com>
 <20160914173625.GB15356@leverpostej>
 <20160914180754.GA16053@kroah.com>
 <20160914182952.GA21615@kroah.com>
 <1473932133.10230.25.camel@nexus-software.ie>
Message-ID: <20160915101330.GB6718@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 10:35:33AM +0100, Bryan O'Donoghue wrote:
> On Wed, 2016-09-14 at 20:29 +0200, Greg KH wrote:
> > Bryan, any explanations you want to provide that would help in
> > clarifying Mark's issues?
> 
> As Douglas Adams would say - "don't panic".
> 
> If you look at the final state the code ends up in - we're doing
> get_cycles(); as opposed to reading an architectural timer directly.
>
> u64 gb_timesync_platform_get_counter(void)
> {
> ????????return (u64)get_cycles();
> }

I did in fact notice this, though my wording was somewhat unclear on
that part.

> You have the entire git history - from the early days where we were
> reading one of the unused ARMv8 timers the MSM8994 has to the later
> days where we just do get_cycles()...
>
> At the time when we first started writing the code it wasn't 100%
> clear if get_cycles() would do, so it was safer to allocate an unused
> architectural timer and read it directly. Later on and with some
> experimentation it was possible to switch to get_cycles().

I don't think the history matters, and I don't think that one can rely
on get_cycles() in this manner outside of arch code. Looking at the
state of the tree [1] as of the final commit [2] in the greybus branch,
my points still stand:

* The "google,greybus-frame-time-counter" node is superfluous. It does
  not describe a particular device, and duplicates information we have
  elsewhere. It does not explicitly define the relationship with the
  underlying clocksource.

* The clock-frequency property isn't necessary. The architected timer
  drivers know the frequency of the architected timers (MMIO or sysreg),
  and they should be queried as to the frequency.

* In general, get_cycles() isn't guaranteed to be any clocksource or
  cycle counter in particular, so even if the clock-frequency property
  matches the architected timer, that doesn't help.

Beyond that, the fallback code using cpufreq and presumably an actual
cycle counter will be broken in a number of cases -- cycle counts will
not match across CPUs, and on CPUs whic gate clocks in WFI/WFE, they'll
drift randomly.

Per the comment at the top of the file, it looks like you want a
system-wide stable clocksource. If you want that, you need to use a
generic API that allows drivers and arch code to actually provide that,
rather than building one yourself that doesn't work.

If you're trying to synchronise with other agents in the system that are
reading from the MMIO arch timers, then that relationship should be
described explicitly in the DT.

Thanks,
Mark.
 
[1] https://git.kernel.org/cgit/linux/kernel/git/gregkh/char-misc.git/tree/drivers/greybus/timesync_platform.c?h=greybus&id=f86bfc90a401681838866b5f6826d86cc4c7010c
[2] https://git.kernel.org/cgit/linux/kernel/git/gregkh/char-misc.git/commit/?h=greybus&id=f86bfc90a401681838866b5f6826d86cc4c7010c
