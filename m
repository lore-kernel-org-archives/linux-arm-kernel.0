From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Nov 2011 14:04:53 +0000
Subject: [PATCH V3] AMBA: Put devices into low-power state in suspend_noirq
In-Reply-To: <4EB14ABB.6020103@stericsson.com>
References: <1320142497-16750-1-git-send-email-ulf.hansson@stericsson.com>
	<CAJ0PZbTjoEbiaLpQ7DiVWT1FT3asWUYWp3voFQPXrAq_AjEDog@mail.gmail.com>
	<20111102104950.GY19187@n2100.arm.linux.org.uk>
	<4EB14ABB.6020103@stericsson.com>
Message-ID: <20111102140453.GF19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 02:50:51PM +0100, Ulf Hansson wrote:
> Just some thinking, you may comment if you like....
>
> When using a power_domain this will then mean that the power domain  
> callbacks for suspend|resume should take similar actions as they do in  
> their runtime_suspend|resume callbacks to put the devices into low power  
> state. This should be in line of what you prefer?

If it is appropriate to cut the vcore for the device when in runtime
suspend state, then a driver itself has to explicitly do that.  vcore
handling is different from pclk handling because loss of vcore requires
the device to be reinitialized, whereas pclk does not.

> This will mean some duplicated code but at the same time give the device  
> driver full control and responsibility of putting its device in  
> low-power state.

It should not mean any duplicated code - if a driver itself wishes to call
its runtime suspend and resume handlers from its normal suspend/resume
handlers, that's a choice it can make (and it alone can make).  Again,
take a moment to think a little more about your original proposal of
pushing that into the bus layer.

And consider the case of a non-runtime PM system (where the runtime PM
callbacks are NULL) yet you have system suspend enabled, and you trigger
a system suspend.  Do you really want the suspend of the devices to be
skipped because the runtime PM callbacks were NULL because of system
configuration?

With them being explicit calls in the driver, this doesn't happen because
if you omit those functions for non-runtime PM, you'll get a link error.

> In parallel it would then also make sense to remove the pm_runtime  
> handling completely from the amba bus and let the pclk be fully runtime  
> handled from the device driver instead. Since it must handle it from  
> suspend anyway...

We know that it's safe to handle the pclk at the bus layer for normal
runtime PM as it causes no state loss.  We also know that throwing the
vcore handling in there is the wrong thing to do because it does cause
state loss and therefore needs proper handling at the driver level.

Hence, the bus code can take care of the pclk but not for vcore.

So, I don't see any reason to change the bus code.
