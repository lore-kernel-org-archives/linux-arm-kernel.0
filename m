From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 18 Feb 2011 10:05:52 -0500 (EST)
Subject: platform/i2c busses: pm runtime and system sleep
In-Reply-To: <AANLkTinsPqFcodH0w7LQeFEY+amodNH4CneRCRhhbKaz@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1102180952470.1972-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Feb 2011, Rabin Vincent wrote:

> How about something like the below?  If we have something like this, we
> can just switch platform to GENERIC_PM_OPS and add the
> pm_runtime_want_interaction() (or something better named)

Yes, please find a better name!  Maybe something starting with 
"generic_" to indicate that this applies only to devices using the 
GENERIC_PM_OPS.

>  call to the
> i2c and spi drivers using runtime PM.

> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 42615b4..2b8a099 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1069,6 +1069,30 @@ void pm_runtime_allow(struct device *dev)
>  EXPORT_SYMBOL_GPL(pm_runtime_allow);
> 
>  /**
> + * pm_runtime_want_interaction - Enable interaction between system sleep
> + *				 and runtime PM callbacks at the bus/subsystem
> + *				 level.
> + * @dev: Device to handle
> + *
> + * Set the power.want_interaction flage, which tells the generic PM subsystem
> + * ops that the following actions should be done during system suspend/resume:
> + *
> + * - If the device has been runtime suspended, the driver's
> + *   suspend() handler will not be invoked.
> + *
> + * - If the device has a resume() pm callback, and the resume()
> + *   callback returns success on system resume, the device's
> + *   runtime PM status will be set to active.
> + */

This last part is normally true for all devices.  If you don't want it 
to hold when want_interaction isn't set, you should add a good 
explanation to sections 6 and 7 in Documentation/power/runtime.txt.

> +void pm_runtime_want_interaction(struct device *dev)
> +{
> +	spin_lock_irq(&dev->power.lock);
> +	dev->power.want_interaction = 1;
> +	spin_unlock_irq(&dev->power.lock);
> +}
> +EXPORT_SYMBOL_GPL(pm_runtime_want_interaction);
> +
> +/**
>   * pm_runtime_no_callbacks - Ignore run-time PM callbacks for a device.
>   * @dev: Device to handle.
>   *

Don't forget that you also need to describe these things in 
Documentation/power/runtime.txt.

Alan Stern
