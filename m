From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 11 Nov 2013 17:37:41 -0500 (EST)
Subject: [PATCH v3 3/4] ARM: EXYNOS: add Exynos Dual Cluster Support
In-Reply-To: <20131111200152.GF3166@localhost.localdomain>
References: <20131108184036.GD2602@localhost.localdomain>
 <alpine.LFD.2.03.1311081356300.15571@syhkavp.arg>
 <52808E09.9060902@samsung.com> <5280FB9A.7030500@samsung.com>
 <alpine.LFD.2.10.1311111107040.9667@knanqh.ubzr>
 <20131111200152.GF3166@localhost.localdomain>
Message-ID: <alpine.LFD.2.10.1311111724480.9667@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Nov 2013, Dave Martin wrote:

> On Mon, Nov 11, 2013 at 11:27:46AM -0500, Nicolas Pitre wrote:
> > It is preferable if the power_up and power_down don't wait.
> 
> I agree with this.
> 
> If a wait is needed anywhere, it is
> 
>  a) in power_down_finish(), and
>  b) *before* the call to exynos_core_power_control() in
>         exynos_core_power_up() (see below for explanation)
> 
> Any waits should not be busy-waits either: we should use msleep or
> similar.  This is fine that we only wait from contexts that can sleep --
> I think this is OK for the power_up() and power_down_finish() paths
> (which aren't executed on the target CPU), but not on the power_down()
> path.

Beware.. exynos_core_power_up() is called with a lock held.

> Busy-waiting for 1ms every time we power a CPU down is not great for
> power-saving...
> 
> In both cases, we should check the PMU status bits first, and only
> wait if they are not already in the desired state.  The most likely
> case will always by that the target CPU already caught up.

There is no need for the CPU going down to check the PMU status.  It can 
only have one state at that point.

> Nico currently disagrees with me on (b), so we need to explore that
> (below).
> 
> > No need to wait for a power_up to be complete as the only CPU that can 
> > do a power_down is the CPU being powered up itself.
> 
> To extend this argument further, there is no conceiveable situation
> where we would need to wait for power_up to complete explicitly.
> 
> We will only ever need to wait for power_down to complete.

Exact.

> > 
> > The exynos_core_power_down call is now appropriately located i.e. within 
> > the lock protected area.  That's fine because we know power won't be cut 
> > until the lock is released and WFI is executed.
> > 
> > Also, if exynos_core_power_up() is called from another CPU right after 
> > the lock is released on the CPU trying to shut itself down but before it 
> > actually executes WFI then the WFI will not be effective and the 
> > power_down method is expected to return in that case.  So no problem 
> > there either.
> > 
> > The only case where it is important to really wait for the power down to 
> > be effective is for kexec.  This is why Dave introduced the 
> > power_down_finish method (you may find this in linux-next at the 
> > moment).  That would be the place where to use your controller_wait 
> > code.
> 
> For (b), I think we're still missing some information here...
> 
> Suppose CPU0 is powering down.  The PMU has been told to power the CPU
> down, and CPU0 has released edcs_lock.  Suppose soon afterwards, CPU1
> wants to turn CPU0 back on again.
> 
> Now, unless CPU1 checks the power controller status, CPU1 has no way
> to know whether the power-down request is still in progress before CPU1
> issues a new power-up request for CPU0.

Does it matter?  As you say ...

> Now, what behaviour does the power controller guarantee when it is still
> in this state, and a new power-up request is issued to it?
> 
> I worry that the power controller may not cope with a new request while
> in this state, or may not guarantee predictable behaviour.  If so then
> the new power-up request may just get lost

This is not the case on TC2 it seems.  We never check if a power-down 
sequence has completed before issuing a power-up request.  Given each 
CPU has its own request bit then this might not matter.

Where this matters is when you really want to ensure a given CPU is not 
executing code anymore and therefore need to know when power-down has 
effectively completed, hence the power_down_finish method.


Nicolas
