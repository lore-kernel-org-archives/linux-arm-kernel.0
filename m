From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 2 Nov 2011 14:50:51 +0100
Subject: [PATCH V3] AMBA: Put devices into low-power state in	suspend_noirq
In-Reply-To: <20111102104950.GY19187@n2100.arm.linux.org.uk>
References: <1320142497-16750-1-git-send-email-ulf.hansson@stericsson.com>
	<CAJ0PZbTjoEbiaLpQ7DiVWT1FT3asWUYWp3voFQPXrAq_AjEDog@mail.gmail.com>
	<20111102104950.GY19187@n2100.arm.linux.org.uk>
Message-ID: <4EB14ABB.6020103@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Nov 02, 2011 at 07:33:03PM +0900, MyungJoo Ham wrote:
>> If the reason of this patch is for device_may_wakeup condition where
>> AMBA needs to keep something up if any of its devices may wakeup, I
>> guess you need another approach. For example, checking
>> devices_may_wakeup conditions of all devices at ABMA suspend callback,
>> save the information at AMBA's data, use the saved information, set
>> the ABMA bus device with AMBA's suspend_noirq callback based on the
>> saved information or at syscore.
> 
> I think this patch is trying to address the variability in the state of
> the bus clock when a device is suspended.
> 
> Originally, we didn't do any bus clock management, so all the calls into
> the driver were assured that the bus clock would always be running.
> 
> Then, when bus clock management was added, we ensured that it was enabled
> before the driver was probed, and disabled after the driver has been
> removed.  A driver wishing to manage the bus clock for its device must
> then manage it appropriately given those pre-conditions (which means if
> it turns off the bus clock before probe returns, it has to be prepared
> to turn the bus clock back on when the suspend or remove callbacks are
> made.)
> 
> When runtime-PM was added to the bus layer, this took control of the
> bus clock management, but we've kept the same guarantees - although
> runtime PM will be enabled, it is up to the driver to drop the use
> count to make it runtime-suspend the device - and if that is done it is
> up to the driver to make whatever runtime PM calls are necessary to
> bring the bus clock back on when required.
> 
> I don't see any reason drivers can't continue to use pm_runtime_get_sync()
> in their suspend callback if they're doing runtime-PM - the runtime PM
> stuff hasn't been disabled at this point and so the runtime resume should
> still happen.
> 
> What won't happen is that you won't be able to use runtime PM to turn the
> bus clock off - but that's also the case for a non-runtime PM driver as
> well.  The solution to this is to -at the end- of the suspend callback
> to call amba_pclk_disable(), and -at the beginning- of the resume callback
> to call amba_pclk_enable(), both provided that the device can cope with it.
> At the end of the resume callback, call pm_runtime_put() to balance the
> pm_runtime_get_sync() in the suspend callback.

Just some thinking, you may comment if you like....

When using a power_domain this will then mean that the power domain 
callbacks for suspend|resume should take similar actions as they do in 
their runtime_suspend|resume callbacks to put the devices into low power 
state. This should be in line of what you prefer?

Alright, let's skip this patch and make sure each device driver handles 
the things from their suspend|suspend_noirq instead.

This will mean some duplicated code but at the same time give the device 
driver full control and responsibility of putting its device in 
low-power state.

In parallel it would then also make sense to remove the pm_runtime 
handling completely from the amba bus and let the pclk be fully runtime 
handled from the device driver instead. Since it must handle it from 
suspend anyway...

> 
> So, I don't see any bus-layer patches are necessary or desirable.  Trying
> to fix this at the bus layer changes the entry conditions for the suspend
> and resume callbacks, and makes it _much_ harder for drivers to work out
> what state things are in at that point - which means we're creating a
> recipe for bugs.
> 
