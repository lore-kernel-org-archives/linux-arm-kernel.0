From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Nov 2011 10:49:50 +0000
Subject: [PATCH V3] AMBA: Put devices into low-power state in suspend_noirq
In-Reply-To: <CAJ0PZbTjoEbiaLpQ7DiVWT1FT3asWUYWp3voFQPXrAq_AjEDog@mail.gmail.com>
References: <1320142497-16750-1-git-send-email-ulf.hansson@stericsson.com>
	<CAJ0PZbTjoEbiaLpQ7DiVWT1FT3asWUYWp3voFQPXrAq_AjEDog@mail.gmail.com>
Message-ID: <20111102104950.GY19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 07:33:03PM +0900, MyungJoo Ham wrote:
> If the reason of this patch is for device_may_wakeup condition where
> AMBA needs to keep something up if any of its devices may wakeup, I
> guess you need another approach. For example, checking
> devices_may_wakeup conditions of all devices at ABMA suspend callback,
> save the information at AMBA's data, use the saved information, set
> the ABMA bus device with AMBA's suspend_noirq callback based on the
> saved information or at syscore.

I think this patch is trying to address the variability in the state of
the bus clock when a device is suspended.

Originally, we didn't do any bus clock management, so all the calls into
the driver were assured that the bus clock would always be running.

Then, when bus clock management was added, we ensured that it was enabled
before the driver was probed, and disabled after the driver has been
removed.  A driver wishing to manage the bus clock for its device must
then manage it appropriately given those pre-conditions (which means if
it turns off the bus clock before probe returns, it has to be prepared
to turn the bus clock back on when the suspend or remove callbacks are
made.)

When runtime-PM was added to the bus layer, this took control of the
bus clock management, but we've kept the same guarantees - although
runtime PM will be enabled, it is up to the driver to drop the use
count to make it runtime-suspend the device - and if that is done it is
up to the driver to make whatever runtime PM calls are necessary to
bring the bus clock back on when required.

I don't see any reason drivers can't continue to use pm_runtime_get_sync()
in their suspend callback if they're doing runtime-PM - the runtime PM
stuff hasn't been disabled at this point and so the runtime resume should
still happen.

What won't happen is that you won't be able to use runtime PM to turn the
bus clock off - but that's also the case for a non-runtime PM driver as
well.  The solution to this is to -at the end- of the suspend callback
to call amba_pclk_disable(), and -at the beginning- of the resume callback
to call amba_pclk_enable(), both provided that the device can cope with it.
At the end of the resume callback, call pm_runtime_put() to balance the
pm_runtime_get_sync() in the suspend callback.

So, I don't see any bus-layer patches are necessary or desirable.  Trying
to fix this at the bus layer changes the entry conditions for the suspend
and resume callbacks, and makes it _much_ harder for drivers to work out
what state things are in at that point - which means we're creating a
recipe for bugs.
