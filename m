From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 26 Feb 2015 14:47:24 -0500 (EST)
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <1424978079.21020.5.camel@linaro.org>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <20150225125610.GY8656@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1502250941210.25484@knanqh.ubzr>
 <1424978079.21020.5.camel@linaro.org>
Message-ID: <alpine.LFD.2.11.1502261438480.25484@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Feb 2015, Daniel Thompson wrote:

> On Wed, 2015-02-25 at 11:47 -0500, Nicolas Pitre wrote:
> > On Wed, 25 Feb 2015, Russell King - ARM Linux wrote:
> > 
> > > On Thu, Feb 05, 2015 at 04:11:00PM +0000, Russell King - ARM Linux wrote:
> > > > On Thu, Feb 05, 2015 at 06:29:18AM -0800, Paul E. McKenney wrote:
> > > > > Works for me, assuming no hidden uses of RCU in the IPI code.  ;-)
> > > > 
> > > > Sigh... I kind'a new it wouldn't be this simple.  The gic code which
> > > > actually raises the IPI takes a raw spinlock, so it's not going to be
> > > > this simple - there's a small theoretical window where we have taken
> > > > this lock, written the register to send the IPI, and then dropped the
> > > > lock - the update to the lock to release it could get lost if the
> > > > CPU power is quickly cut at that point.
> > > > 
> > > > Also, we _do_ need the second cache flush in place to ensure that the
> > > > unlock is seen to other CPUs.
> > > 
> > > It's time to start discussing this problem again now that we're the
> > > other side of the merge window.
> > > 
> > > I've been thinking about the lock in the GIC code.  Do we actually need
> > > this lock in gic_raise_softirq(), or could we move this lock into the
> > > higher level code?
> > 
> > It could be a rw lock as you say.
> > 
> > > Let's consider the bL switcher.
> > > 
> > > I think the bL switcher is racy wrt CPU hotplug at the moment.  What
> > > happens if we're sleeping in wait_for_completion(&inbound_alive) and
> > > CPU hotplug unplugs the CPU outgoing CPU?  What protects us against
> > > this scenario?  I can't see anything in bL_switch_to() which ensures
> > > that CPU hotplug can't run.
> > 
> > True.  The actual switch would then be suspended in mid air until that 
> > CPU is plugged back in.  The inbound CPU would wait at mcpm_entry_gated 
> > until the outbound CPU comes back to open the gate.  There wouldn't be 
> > much harm besides the minor fact that the inbound CPU would be wasting 
> > more power while looping on a WFE compared to its previously disabled 
> > state.  I'm still debating if this is worth fixing.
> > 
> > > Let's assume that this rather glaring bug has been fixed, and that CPU
> > > hotplug can't run in parallel with the bL switcher (and hence
> > > gic_migrate_target() can't run concurrently with a CPU being taken
> > > offline.)
> > 
> > I'm still trying to figure out how this might happen.  At the point 
> > where gic_migrate_target() is called, IRQs are disabled and nothing can 
> > prevent the switch from happening anymore.  Any IPI attempting to stop 
> > that CPU for hotplug would be pending until the inbound CPU 
> > eventually honors it.
> > 
> > > If we have that guarantee, then we don't need to take a lock when sending
> > > the completion IPI - we would know that while a CPU is being taken down,
> > > the bL switcher could not run.  What we now need is a lock-less way to
> > > raise an IPI.
> > >
> > > Now, is the locking between the normal IPI paths and the bL switcher
> > > something that is specific to the interrupt controller, or should generic
> > > code care about it?  I think it's something generic code should care about
> > > - and I believe that would make life a little easier.
> > 
> > Well... The only reason for having a lock there is to ensure that no 
> > IPIs are sent to the outbound CPU after gic_cpu_map[] has been modified 
> > and pending IPIs on the outbound CPU have been migrated to the inbound 
> > CPU.  I think this is pretty specific to the GIC driver code.
> > 
> > If there was a way for gic_migrate_target() to be sure no other CPUs are 
> > using the old gic_cpu_map value any longer then no lock would be needed 
> > in gic_raise_softirq().  The code in gic_migrate_target() would only 
> > have to wait until it is safe to migrate pending IPIs on the outbound 
> > CPU without missing any.
> > 
> > > The current bL switcher idea is to bring the new CPU up, disable IRQs
> > > and FIQs on the outgoing CPU, change the IRQ/IPI targets, then read
> > > any pending SGIs and raise them on the new CPU.  But what about any
> > > pending SPIs?  These look like they could be lost.
> > 
> > SPIs are raised and cleared independently of their distribution config.  
> > So the only thing that gic_migrate_target() has to do is to disable the 
> > distribution target for the outbound CPU and enable the target for the 
> > inbound CPU.  This way unserviced IRQs become pending on the outbound 
> > CPU automatically. The only other part that plays with targets is 
> > gic_set_affinity() and irq_controller_lock protects against concurrency 
> > here.
> > 
> > > How about this for an idea instead - the bL switcher code:
> > > 
> > > - brings the new CPU online.
> > > - disables IRQs and FIQs.
> > > - takes the IPI lock, which prevents new IPIs being raised.
> > > - re-targets IRQs and IPIs onto the new CPU.
> > > - releases the IPI lock.
> > 
> > But aren't we trying to get rid of that IPI lock to start with?  I'd 
> > personally love to remove it -- it's been nagging me since I initially 
> > added it.
> > 
> > > - re-enables IRQs and FIQs.
> > > - polls the IRQ controller to wait for any remaining IRQs and IPIs
> > >   to be delivered.
> > 
> > Poll for how long? How can you be sure no other CPU is in the process of 
> > targetting an IPI to the outbound CPU?  With things like the FIQ 
> > debugger coming to mainline or even JTAG-based debuggers, this could 
> > represent an indetermined amount of time if the sending CPU is stopped 
> > at the right moment.
> > 
> > That notwithstanding, I'm afraid this would open a big can of worms.  
> > The CPU would no longer have functional interrupts since they're all 
> > directed to the inbound CPU at that point.  Any IRQ controls are now 
> > directed to the new CPU and things like self-IPIs (first scenario that 
> > comes to my mind) would no longer produce the expected result.  I'd much 
> > prefer to get over with the switch ASAP at that point rather than 
> > letting the outbound CPU run much longer in a degraded state.
> > 
> > > - re-disables IRQs and FIQs (which shouldn't be received anyway since
> > >   they're now targetting the new CPU.)
> > > - shuts down the tick device.
> > > - completes the switch
> > > 
> > > What this means is that we're not needing to have complex code in the
> > > interrupt controllers to re-raise interrupts on other CPUs, and we
> > > don't need a lock in the interrupt controller code synchronising IPI
> > > raising with the bL switcher.
> > > 
> > > I'd also suggest is that this IPI lock should _not_ be a spinlock - it
> > > should be a read/write spin lock - it's perfectly acceptable to have
> > > multiple CPUs raising IPIs to each other, but it is not acceptable to
> > > have any CPU raising an IPI when the bL switcher is modifying the IRQ
> > > targets.  That fits the rwlock semantics.
> > > 
> > > What this means is that gic_raise_softirq() should again become a lock-
> > > less function, which opens the door to using an IPI to complete the
> > > CPU hot-unplug operation cleanly.
> > > 
> > > Thoughts (especially from Nico)?
> > 
> > I completely agree with the r/w spinlock. Something like this ought to 
> > be sufficient to make gic_raise_softirq() reentrant which is the issue 
> > here, right?  I've been stress-testing it for a while with no problems 
> > so far.
> 
> Do you fancy trying patch 1 and 2 from this series?
> http://thread.gmane.org/gmane.linux.kernel/1881415
> 
> The recent FIQ work required gic_raise_softirq() to be reentrant so I
> came up with similar patches to yours. As soon as we tease out this code
> into a separate lock people observe that the lock can melt away entirely
> if the b.L switcher is not compiled in and make that the next move...

Patch #1 is wrong.  It provably opens a race.  I'll reply on that thread 
to explain why.  Patch #2 is fine.


Nicolas
