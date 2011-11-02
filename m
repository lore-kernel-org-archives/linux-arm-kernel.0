From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Wed, 2 Nov 2011 19:33:03 +0900
Subject: [PATCH V3] AMBA: Put devices into low-power state in suspend_noirq
In-Reply-To: <1320142497-16750-1-git-send-email-ulf.hansson@stericsson.com>
References: <1320142497-16750-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CAJ0PZbTjoEbiaLpQ7DiVWT1FT3asWUYWp3voFQPXrAq_AjEDog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 1, 2011 at 7:14 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> Previously it was possible for device drivers doing
> pm_runtime_suspend and pm_runtime_put_sync from their suspend
> callbacks. From the following commit, which solved a race issue,
> this is not possible anymore.
>
> PM: Limit race conditions between runtime PM and system sleep (v2)
>
> Therefore some devices might not be in full low-power state after
> device's suspend callbacks has been executed. To make sure this is
> done the suspend_noirq callback is used.
>
> In the resume_noirq the power is restored to the device if it were
> previously cut in suspend_noirq. This to make sure the device is
> put back into the same state as the device driver left it in from
> it's suspend callback.
>
> If a device is configured as wakeup device this will prevent the
> bus from putting it into low-power state during suspend_noirq.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> ---
>
> Changes in v3:
> ? ? ? ?- Fixup comments and commit message (including the header).
>
> Changes in v2:
> ? ? ? ?- Integrated code directly into suspend|resume_noirq and get rid
> ? ? ? ?of not needed ifdefs.
> ? ? ? ?- Prevent runtime suspend if device is configured as wakeup.
>
> ---
> ?drivers/amba/bus.c | ? 20 ++++++++++++++++++++
> ?1 files changed, 20 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index bd230e8..e3ecf66 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -14,6 +14,7 @@
> ?#include <linux/slab.h>
> ?#include <linux/io.h>
> ?#include <linux/pm.h>
> +#include <linux/pm_wakeup.h>
> ?#include <linux/pm_runtime.h>
> ?#include <linux/amba/bus.h>
>
> @@ -158,6 +159,7 @@ static int amba_pm_suspend(struct device *dev)
> ?static int amba_pm_suspend_noirq(struct device *dev)
> ?{
> ? ? ? ?struct device_driver *drv = dev->driver;
> + ? ? ? bool is_suspended = pm_runtime_status_suspended(dev);
> ? ? ? ?int ret = 0;
>
> ? ? ? ?if (!drv)
> @@ -168,6 +170,15 @@ static int amba_pm_suspend_noirq(struct device *dev)
> ? ? ? ? ? ? ? ? ? ? ? ?ret = drv->pm->suspend_noirq(dev);
> ? ? ? ?}
>
> + ? ? ? /*
> + ? ? ? ?* If the device's power hasn't already been cut and the
> + ? ? ? ?* device doesn't need to generate wakeup requests, cut
> + ? ? ? ?* the power now.
> + ? ? ? ?*/
> + ? ? ? if (!ret && !is_suspended && !device_may_wakeup(dev))
> + ? ? ? ? ? ? ? if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend)
> + ? ? ? ? ? ? ? ? ? ? ? ret = dev->bus->pm->runtime_suspend(dev);
> +
> ? ? ? ?return ret;
> ?}

If a device of AMBA bus is still in "running" state, the bus will
simply need to call pm->suspend() / pm->suspend_noirq(). And the
suspend/resume callbacks of the devices should be able to handle the
situation. In other words, the device driver's suspend() and
suspend_noirq() callbacks should be able to handle the transition from
running to suspended regardless whether it is already in "suspended"
(by runtime-pm) or in "running".

Yes, even if we cannot call pm_runtime_get/put in pm's suspend/resume
callbacks, that is same.

If the contents of runtime_pm_suspend() and suspend() callbacks are
the same, we only need to make another static function and use it at
the both callbacks at the device driver.

Things could be a bit different for devices whether it is being
suspended in runtime or in system-wide suspend, and the devices should
be able to distinguish them. (so, call suspend callback if it is
suspend, call runtime_pm_suspend callback if it is being suspended in
runtime.)



If the reason of this patch is for device_may_wakeup condition where
AMBA needs to keep something up if any of its devices may wakeup, I
guess you need another approach. For example, checking
devices_may_wakeup conditions of all devices at ABMA suspend callback,
save the information at AMBA's data, use the saved information, set
the ABMA bus device with AMBA's suspend_noirq callback based on the
saved information or at syscore.


Cheers!
MyungJoo

>
> @@ -192,6 +203,7 @@ static int amba_pm_resume(struct device *dev)
> ?static int amba_pm_resume_noirq(struct device *dev)
> ?{
> ? ? ? ?struct device_driver *drv = dev->driver;
> + ? ? ? bool is_suspended = pm_runtime_status_suspended(dev);
> ? ? ? ?int ret = 0;
>
> ? ? ? ?if (!drv)
> @@ -202,6 +214,14 @@ static int amba_pm_resume_noirq(struct device *dev)
> ? ? ? ? ? ? ? ? ? ? ? ?ret = drv->pm->resume_noirq(dev);
> ? ? ? ?}
>
> + ? ? ? /*
> + ? ? ? ?* If the device's power were cut during suspend_noirq
> + ? ? ? ?* restore the power to the device now.
> + ? ? ? ?*/
> + ? ? ? if (!ret && !is_suspended && !device_may_wakeup(dev))
> + ? ? ? ? ? ? ? if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume)
> + ? ? ? ? ? ? ? ? ? ? ? ret = dev->bus->pm->runtime_resume(dev);
> +
> ? ? ? ?return ret;
> ?}
>
> --
> 1.7.5.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
