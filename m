From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 25 Jun 2010 09:26:43 -0600
Subject: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
In-Reply-To: <1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
Message-ID: <AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 24, 2010 at 5:43 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Implement the new runtime PM framework as a thin layer on top of the
> omap_device API. ?Since we don't have an OMAP-specific bus, override
> the runtime PM hooks for the platform_bus for the OMAP specific
> implementation.
>
> While the runtime PM API has three main states (idle, suspend, resume)
> This version treats idle and suspend the same way by implementing both
> on top of omap_device_disable(), which follows closely with how driver
> are currently using clock enable/disable calls. Longer-termm
> pm_runtime_idle() could take other constraints into consideration to
> make the decision, but the current
>
> Device driver ->runtime_suspend() hooks are called just before the
> device is disabled (via omap_device_idle()), and device driver
> ->runtime_resume() hooks are called just after device has been
> enabled (via omap_device_enable().)

Hi Kevin,

You shouldn't hijack the platform bus in this way, for a number of
reasons.  Not all platform devices in an OMAP system are internal OMAP
devices (as you know since you do an explicit check for omap devices).
 Right there that says that the abstraction is at the wrong level.
What happens when an mostly transparent bridge is added with its own
peripherals and its own special operations?  Does this routine then
need to be extended for each new special case?  It's not maintainable
in the long run.

This approach is also not multiplatform friendly (cc'ing Eric and
Nicolas who are working on ARM multiplatform).  It won't work for
building a kernel that supports, say, both versatile and OMAP.

The kernel already has the facility to do what you need.  We talked
about it briefly at ELC, and now that I look at it closer, I thing
gregkh is absolutely right.  Just create a new bus type for OMAP
devices.  It is simple to add one.  You can probably even call out to
the platform bus ops for most of the operations.  The fact that OMAP
devices have special behaviour that needs to be handled at the bus
type level means that they are not platform devices anymore.  This
also eliminates all the omap_device_is_valid and OMAP_DEVICE_MAGIC
gymnastics.

I see from the comments in omap_device.c that doing an
omap_bus/omap_device is being considered anyway.  Please don't merge
this patch and do the omap_bus_type instead.

Also, I notice that most of these hooks open-code the generic versions
of the runtime hooks.  Instead of open coding it, can the omap hooks
call the generic hooks before/after doing the omap-specific work?

Cheers,
g.

>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> ?arch/arm/mach-omap2/Makefile | ? ?7 +++-
> ?arch/arm/mach-omap2/pm_bus.c | ? 70 ++++++++++++++++++++++++++++++++++++++++++
> ?2 files changed, 76 insertions(+), 1 deletions(-)
> ?create mode 100644 arch/arm/mach-omap2/pm_bus.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index ea52b03..8ed47ea 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -46,12 +46,17 @@ obj-$(CONFIG_ARCH_OMAP2) ? ? ? ? ? ?+= sdrc2xxx.o
> ?ifeq ($(CONFIG_PM),y)
> ?obj-$(CONFIG_ARCH_OMAP2) ? ? ? ? ? ? ? += pm24xx.o
> ?obj-$(CONFIG_ARCH_OMAP2) ? ? ? ? ? ? ? += sleep24xx.o
> -obj-$(CONFIG_ARCH_OMAP3) ? ? ? ? ? ? ? += pm34xx.o sleep34xx.o cpuidle34xx.o
> +obj-$(CONFIG_ARCH_OMAP3) ? ? ? ? ? ? ? += pm34xx.o sleep34xx.o cpuidle34xx.o \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?pm_bus.o
> ?obj-$(CONFIG_PM_DEBUG) ? ? ? ? ? ? ? ? += pm-debug.o
>
> ?AFLAGS_sleep24xx.o ? ? ? ? ? ? ? ? ? ? :=-Wa,-march=armv6
> ?AFLAGS_sleep34xx.o ? ? ? ? ? ? ? ? ? ? :=-Wa,-march=armv7-a
>
> +ifeq ($(CONFIG_PM_VERBOSE),y)
> +CFLAGS_pm_bus.o ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?+= -DDEBUG
> +endif
> +
> ?endif
>
> ?# PRCM
> diff --git a/arch/arm/mach-omap2/pm_bus.c b/arch/arm/mach-omap2/pm_bus.c
> new file mode 100644
> index 0000000..9719a9f
> --- /dev/null
> +++ b/arch/arm/mach-omap2/pm_bus.c
> @@ -0,0 +1,70 @@
> +/*
> + * Runtime PM support code for OMAP
> + *
> + * Author: Kevin Hilman, Deep Root Systems, LLC
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/platform_device.h>
> +#include <linux/mutex.h>
> +
> +#include <plat/omap_device.h>
> +#include <plat/omap-pm.h>
> +
> +#ifdef CONFIG_PM_RUNTIME
> +int platform_pm_runtime_suspend(struct device *dev)
> +{
> + ? ? ? struct platform_device *pdev = to_platform_device(dev);
> + ? ? ? struct omap_device *odev = to_omap_device(pdev);
> + ? ? ? int r, ret = 0;
> +
> + ? ? ? dev_dbg(dev, "%s\n", __func__);
> +
> + ? ? ? if (dev->driver->pm && dev->driver->pm->runtime_suspend)
> + ? ? ? ? ? ? ? ret = dev->driver->pm->runtime_suspend(dev);
> + ? ? ? if (!ret && omap_device_is_valid(odev)) {
> + ? ? ? ? ? ? ? r = omap_device_idle(pdev);
> + ? ? ? ? ? ? ? WARN_ON(r);
> + ? ? ? }
> +
> + ? ? ? return ret;
> +};
> +
> +int platform_pm_runtime_resume(struct device *dev)
> +{
> + ? ? ? struct platform_device *pdev = to_platform_device(dev);
> + ? ? ? struct omap_device *odev = to_omap_device(pdev);
> + ? ? ? int r, ret = 0;
> +
> + ? ? ? dev_dbg(dev, "%s\n", __func__);
> +
> + ? ? ? if (omap_device_is_valid(odev)) {
> + ? ? ? ? ? ? ? r = omap_device_enable(pdev);
> + ? ? ? ? ? ? ? WARN_ON(r);
> + ? ? ? }
> +
> + ? ? ? if (dev->driver->pm && dev->driver->pm->runtime_resume)
> + ? ? ? ? ? ? ? ret = dev->driver->pm->runtime_resume(dev);
> +
> + ? ? ? return ret;
> +};
> +
> +int platform_pm_runtime_idle(struct device *dev)
> +{
> + ? ? ? int ret;
> +
> + ? ? ? ret = pm_runtime_suspend(dev);
> + ? ? ? dev_dbg(dev, "%s [%d]\n", __func__, ret);
> +
> + ? ? ? return 0;
> +};
> +#endif /* CONFIG_PM_RUNTIME */
> +
> --
> 1.7.0.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
