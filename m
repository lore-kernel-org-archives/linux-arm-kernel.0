From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 30 Sep 2013 18:26:12 +0100
Subject: [RFC PATCH 3/3] ARM: vexpress/TC2: Implement MCPM
 power_down_finish()
In-Reply-To: <alpine.LFD.2.03.1309301300390.6331@syhkavp.arg>
References: <1380553607-3271-1-git-send-email-Dave.Martin@arm.com>
 <1380553607-3271-4-git-send-email-Dave.Martin@arm.com>
 <alpine.LFD.2.03.1309301300390.6331@syhkavp.arg>
Message-ID: <20130930172612.GD3209@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 01:14:38PM -0400, Nicolas Pitre wrote:
> On Mon, 30 Sep 2013, Dave Martin wrote:
> 
> > This patch implements the power_down_finish() method for TC2, to
> > enable the kernel to confirm when CPUs are safely powered down.
> > 
> > The information required for determining when a CPU is parked
> > cannot be obtained from any single place, so a few sources of
> > information must be combined:
> > 
> >   * mcpm_cpu_power_down() must be pending for the CPU, so that we
> >     don't get confused by false STANDBYWFI positives arising from
> >     CPUidle.  This is detected by waiting for the tc2_pm use count
> >     for the target CPU to reach 0.
> > 
> >   * Either the SPC must report that the CPU has asserted
> >     STANDBYWFI, or the TC2 tile's reset control logic must be
> >     holding the CPU in reset.
> > 
> >     Just checking for STANDBYWFI is not sufficient, because this
> >     signal is not latched when the the cluster is clamped off and
> >     powered down: the relevant status bits just drop to zero.  This
> >     means that STANDBYWFI status cannot be used for reliable
> >     detection of the last CPU in a cluster reaching WFI.
> > 
> > This patch is required in order for kexec to work with MCPM on TC2.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> > 
> > The mdelay(1) in tc2_pm_power_down_finish() is arbitrary.  The power
> > controller can show millisecond response times in the worst case, and
> > CPU hotplug is not expected to be performance-critical.
> > 
> > It may be wise to add a timeout to this function, but that's open to
> > discussion.
> 
> That would be a good idea.  I'd suggest you reduce the polling loop to 
> something like 10 ms and bail out after one second.   We've been 
> affected by funny STANDBYWFI 
> behaviors before.

OK, I'm happy to do that.  I don't have a strong opinion on the correct
answer here -- the main thing is to avoid thrashing the bus and wasting
power, so even quite a short delay will help considerably.

I'll just loop 100 times and then give up and return 0.

So far as I've seen, it's very unlikely in practice that repeated polling
is needed.  The most likely cause is that cluster powerdown involves a
lengthy drain of L2 within the blackout period.

Cheers
---Dave
