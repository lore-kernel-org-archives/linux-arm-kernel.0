From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 8 Nov 2013 14:21:24 -0500 (EST)
Subject: [PATCH v3 3/4] ARM: EXYNOS: add Exynos Dual Cluster Support
In-Reply-To: <20131108184036.GD2602@localhost.localdomain>
References: <20131108184036.GD2602@localhost.localdomain>
Message-ID: <alpine.LFD.2.03.1311081356300.15571@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Nov 2013, Dave Martin wrote:

> On Thu, Nov 07, 2013 at 11:51:49AM -0500, Nicolas Pitre wrote:
> > On Thu, 7 Nov 2013, Dave Martin wrote:
> > 
> > > If there is a pending powerdown which has reached the __mcpm_cpu_down()
> > > stage, then the kernel has no way to know what is still pending.  This
> > > means that when calling exynos_power_up(cpu, cluster) after a successful
> > > call to exynos_power_down(same cpu, cluster), there is a chance that
> > > the CPU still gets powered down, because of the pending
> > > exynos_core_power_control() on the outbound side.
> > 
> > > This isn't an issue for TC2, because TC2's power controller queues
> > > requests and services them in order, so a new powerup request cannot
> > > race with a powerdown request in that way.
> 
> We still rely on the power controller doing some serialisation.
> 
> Come to think of it, I should go and take a look at how cpu_kill()
> should be implemented for DSCSB too.
> 
> > The reason why this isn't an issue for TC2 is because the request to 
> > power down request is sent from within the spinlock protected area which 
> > serializes all requests.  Here exynos_core_power_down() is invoked where 
> > there is no such protection.
> 
> We don't wait for the requests to complete before dropping the lock, so
> we still rely on the SPC doing some serialisation.

Yes.  But the request order is still preserved in that case.

In this case here, the exynos_core_power_up call is performed with a 
lock held, but exynos_core_power_down is not.  This means that, by the 
time exynos_core_power_down is about to be called, some other CPU might 
have decided that the current CPU should not power down after all and 
call exynos_core_power_up.  Which one will win the race and execute 
before the other is up in the air.

It is important that the actual power control be tightly related to the 
management of the usage count currently and properly done within the 
lock protected area.  If the use count is zero in the power_up request 
then the power has to be turned on.

However here there is still a chance that the power will be turned off 
right away afterwards based on the skip_wfi variable which is wrong.

> > The simple fix would be to simply move this call up, assuming that the 
> > power is actually turned off only when the WFI signal is asserted.
> 
> Can you explain?  I'm not sure I get this -- once the outbound CPU has
> gone into blackout there's no way to know when it's finished except
> to wait.

The issue here is not about whether or not the outbound has finished 
killing itself.  It is about making sure that the actual power knob is 
on or off according to the use count.  Therefore the power knob has to 
be toggled from within the same lock protected area as the use count for 
coherency to be preserved.  If exynos_core_power_down is called outside 
of the lock protected area, it is well possible that the use count might 
have gone back to 1 in the mean time.

> > > Maybe we should always just poll and wait, though.  exynos_power_up()
> > > should never be called for a CPU that the kernel thinks is already up,
> > > so it should either be down already (in which case we will poll the
> > > status once and then continue), or a power down is pending (in which
> > > case we must wait, but we know the wait will terminate).  This would
> > > be simpler than tracking a "power down pending" flag for each CPU.
> > 
> > That is also a good way to avoid the race.
> 
> I guess it will depend on exactly what the power controller does.

Right.

Samsung people: could you give us more info on the behavior of the power 
controller please?


Nicolas
