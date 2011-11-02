From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Nov 2011 12:51:09 +0000
Subject: [PATCH] AMBA: Use suspend_noriq to force devices into runtime
	suspend
In-Reply-To: <4EB121AE.1060905@stericsson.com>
References: <1319730524-29483-1-git-send-email-ulf.hansson@stericsson.com>
	<20111027155434.GN19187@n2100.arm.linux.org.uk>
	<CAKnu2MpGOKFKpO=2mmu4a74gmbCUdO8Ui5+1nEB6GbfitGBLRw@mail.gmail.com>
	<20111027194832.GO19187@n2100.arm.linux.org.uk>
	<4EAA7613.3030808@stericsson.com>
	<20111102090234.GW19187@n2100.arm.linux.org.uk>
	<4EB121AE.1060905@stericsson.com>
Message-ID: <20111102125109.GB19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 11:55:42AM +0100, Ulf Hansson wrote:
> As we do now, the AMBA bus do set up some prerequisites during probe  
> (enable vcore and pclk) and as well do runtime handling of the pclk.  
> This must each amba device take into consideration which can be a little  
> bit tricky, I think.

If you think that then you're missing a fundamental point about how the
bus layer has been setup.

Whatever the bus layer is doing has (and should continue to) remain
invisible to the driver.  Or to put it another way: before we had to
deal with the bus clock, drivers assumed that the bus clock was always
enabled while they owned the device.

When we had a platform where the bus clock could be disabled, I ensured
that we had a way for the bus layer to obtain that clock before probe
time and ensure that it was enabled until after remove time - this
ensures that we maintain the guarantee that the bus clock was enabled
while the driver owns the device.

If a driver _then_ decides it wants to disable the bus clock, it can, but
then the driver takes responsibility for ensuring that the bus clock is
appropriately managed _throughout_ the driver, and most importantly that
the bus clock is left enabled when returning from the ->remove callback
(to maintain the "illusion" that the bus clock has been enabled the whole
time.)

That same approach has been taken when runtime-PM support was added to the
bus layer: although runtime-PM support is enabled, it is left with a
ref-count of 1 at the point the drivers probe function is called.  This
ensures that we're in the runtime-resume state, which is the state that
the device should be in at that point.

At the point where the ->remove callback returns, we also expect the
device to be in the runtime-resume state.  Should the driver wish to make
use of the runtime-PM facility, it is up to the driver to start managing
that by doing a pm_runtime_put() in the probe function - but if it does
that it must do a pm_runtime_get() (or similar) in the remove function to
balance.

As for the suspend callback, it works like this:
- If the driver is not using runtime-PM, then the bus clock is still
  running anyway.  Effectively, the device is in 'runtime-resume' state.

- If the driver has enabled runtime-PM, the suspend callbacks can be
  entered in either runtime-resume or runtime-suspended state:

  + if it needs to access the device registers, it must do a
    pm_runtime_get_sync() call to ensure that the bus clock is running
    and the device is runtime-resumed - this gets us into the same
    position as the non-runtime PM drivers.

  + if it does not need to access the device registers, this is a more
    complicated case to handle because the final parts of suspend are
    conditional.  This can be resolved fairly easily though.

Now, if a driver wants to shut down the bus clock, _and_ the device is in
runtime-resume state (that test can be optimized away given the above
conditions), it can then call amba_pclk_disable().  If it wants to do more
than that (eg, all the runtime-suspend stuff) then it must do that itself.
Remember that a driver _should_ suspend properly with system suspend even
if runtime-PM is disabled.

On resume, if it called amba_pclk_disable() in the suspend callback, it
must call amba_pclk_enable() (and any other stuff that was shut down)
before accessing any registers.  Then it can access the registers etc.
Before returning from the resume callback:
- If the driver has enabled runtime-PM, it must call pm_runtime_put() to
  balance the call to pm_runtime_get_sync() in the suspend callback.
- If the driver is not using runtime-PM, then it is done as the bus clock
  is now running.

So, suspend callbacks should look something like this:

non_pm_runtime_driver_suspend(dev)
{
	save_device_state(dev);
	if (device_can_disable_pclk_at_suspend(dev) &&
	    (device_can_wakeup_with_pclk_disabled(dev) || !device_may_wakeup(dev)))
		amba_pclk_disable(dev);
	... and anything else which needs to be turned off ...
}

non_pm_runtime_driver_resume(dev)
{
	if (device_can_disable_pclk_at_suspend(dev) &&
	    (device_can_wakeup_with_pclk_disabled(dev) || !device_may_wakeup(dev)))
		amba_pclk_enable(dev);
	... and anything else which was turned off above needs to be turned back on ...
	restore_device_state(dev);
}

where device_can_disable_pclk_at_suspend() and device_can_wakeup_with_pclk_disabled()
are constants (and so the if condition is optimized appropriately or maybe
even eliminated completely.)

=== or ===

pm_runtime_driver_suspend(dev)
{
	pm_runtime_get_sync(dev);
	save_device_state(dev);
	if (device_can_disable_pclk_at_suspend(dev) &&
	    (device_can_wakeup_with_pclk_disabled(dev) || !device_may_wakeup(dev)))
		amba_pclk_disable(dev);
	... and anything else which needs to be turned off ...
}

pm_runtime_driver_resume(dev)
{
	if (device_can_disable_pclk_at_suspend(dev) &&
	    (device_can_wakeup_with_pclk_disabled(dev) || !device_may_wakeup(dev)))
		amba_pclk_enable(dev);
	... and anything else which was turned off above needs to be turned back on ...
	restore_device_state(dev);
	pm_runtime_put(dev);
}

=== or ===

pm_runtime_driver_suspend(dev)
{
	if (pm_runtime_status_suspended(dev))
		return;

	if (device_can_disable_pclk_at_suspend(dev) &&
	    (device_can_wakeup_with_pclk_disabled(dev) || !device_may_wakeup(dev)))
		amba_pclk_disable(dev);
	... and anything else which needs to be turned off ...
}

pm_runtime_driver_resume(dev)
{
	if (pm_runtime_status_suspended(dev))
		return;

	if (device_can_disable_pclk_at_suspend(dev) &&
	    (device_can_wakeup_with_pclk_disabled(dev) || !device_may_wakeup(dev)))
		amba_pclk_enable(dev);
	... and anything else which was turned off above needs to be turned back on ...
}

>>>> That brings up the question whether there has been any check to
>>>> ensure that there are no drivers already managing the bus clock in
>>>> their suspend methods - if there are, this patch has the potential
>>>> to make the bus clock enable count to negative.
>>> The count is always restored as well as the runtime state from   
>>> amba_pm_resume_noirq.
>>
>> No clock counts are ever 'restored' - they're never saved.  If you do
>> this:
>>
>> 	clk_enable(clk);
>> 	clk_disable(clk);
>> 	clk_disable(clk);
>>
>> then the second clk_disable() will spit out a warning and refuse to
>> decrement the count (because non-zero counts mean that the clock is
>> enabled.)
>
> I see your concern, but this will never happen. If I have not completely  
> missed something of course. :-)

Tell me why you think it won't happen.  I think it will:

	clk_enable(pclk) <-- before probe
	clk_disable(pclk) <-- inside amba_pclk_disable() in system
				suspend callback
	clk_disable(pclk) <-- amba_pm_suspend_noirq

> We will not call the runtime hooks from suspend@|resume_noirq if the  
> device already is runtime suspended.
>
> If is not runtime suspended, we call the runtime_suspend callback from  
> suspend_noirq. In resume_noirq we then will call the runtime_resume  
> callback as well. This means the "state" (meaning clocks, regulators and  
> other stuff) is restored to the state as they were when the driver left  
> it's normal suspend callback.

The problem with this is that it makes the driver writers task a lot
harder to comprehend what state things are in the various callbacks.
The driver writer can no longer be sure _what_ needs to be done in the
suspend callback because it depends whether they're writing a driver to
support runtime-PM, whether the device was in runtime-resume or runtime-
suspend state, etc.

So, the statement I made above becomes:

As for the suspend callback, it works like this:
- If the driver has enabled runtime-PM, it must do a pm_runtime_get_sync()
  call to ensure that the bus clock is running (and the device is
  runtime-resumed) if it needs to access the device registers.
- If the driver is not using runtime-PM, then the bus clock is still running
  anyway.
If the driver now wants the bus clock to remain on (eg, because the device
needs it for wakeup), it must call amba_pclk_enable() here.  Therefore,
this call must be added to _every_ existing driver right now to ensure
that the status-quo is maintained.

On resume, if it called amba_pclk_enable(), it must call amba_pclk_disable()
to balance the effects of the suspend callback, and this must be added to
every existing driver right now.  Before returning from the resume callback:
- If the driver has enabled runtime-PM, it must call pm_runtime_put() to
  balance the call to pm_runtime_get_sync() in the suspend callback.
- If the driver is not using runtime-PM, then it is done as the bus clock
  is now running.

I see in v3 you've dropped the bus clock management code for the noirq
path - so what we now have is yet more obfuscation of the suspend/resume
callback conditions.  We can now be partially runtime-suspended after
suspend_noirq (the effects of the runtime suspend handler but without
the bus clock being turned off.)

Given what I've said in the first hunk of this reply, I really don't see
any need for any patch to this code at all if a driver is implemented
using the scheme I outlined there.
