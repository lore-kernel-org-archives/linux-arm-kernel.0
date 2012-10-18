From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 18 Oct 2012 10:01:00 -0700
Subject: [RFC/NOT FOR MERGING 2/5] arm: omap: don't forcefully runtime
 suspend a device
In-Reply-To: <1350488043-5053-3-git-send-email-balbi@ti.com> (Felipe Balbi's
 message of "Wed, 17 Oct 2012 18:34:00 +0300")
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
 <1350488043-5053-3-git-send-email-balbi@ti.com>
Message-ID: <87fw5bg1f7.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi <balbi@ti.com> writes:

> device drivers should be smart enough to provide
> ->suspend/->resume callbacks when needed and they
> should take care of doing whatever needs to be
> done in order to allow a device to be suspended.
>
> Calling pm_runtime_* from system suspend isn't
> the right way to achieve that, as it creates a
> situation where OMAP's PM has different requirements
> and semantics than all other architectures.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

NAK

This support is required to handle some restrictions placed on runtime
PM and system PM interactions.   Basically, runtime PM transitions are
disabled part way through system PM (that itself was a much debated
topic last year, but that's how it works today.)

Because of this limitation, drivers that are active during the suspend
phase (commonly becasue they are used by [late] suspend methods of other
devices) may have multiple runtime PM transitions during static
suspend/resume.  These drivers have the problem that after runtime PM
has been disabled, even when they pm_runtime_put*, they will not
actually be transitioned (and their runtime PM callbacks will not be
called.)

So these devices are in a "ready to runtime suspend" state, but they
will not transition because runtime PM is disabled.

After your patch, they will still be idled (omap_device_idle), but the
driver will have no notification that this has happened because you
removed the calling of the runtime PM callbacks.

In the changelog, you seem to be implying that anything the driver
should be doing should be done in its suspend/resume callbacks instead
of the runtime suspend/resume callbacks (but don't give your reasoning.)

Using the current approach (which was actually suggested by Rafael), it
means many transiactional drivers (like I2C) can be implemented as
runtime PM only, and don't need to provide suspend/resume callbacks at
all.  It also means they can be used throughout the suspend/resume path
(well until noirq methods.)

The approach in $SUBJECT patch would mean that drivers should not be
used after their suspend method has been called.  That places some
severe limitations on drivers like I2C, SPI, HSI, UART etc. that are
often used by the suspend/resume methods of other drivers.

Kevin

> ---
>  arch/arm/plat-omap/omap_device.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 935f416..cd84eac 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -817,11 +817,9 @@ static int _od_suspend_noirq(struct device *dev)
>  	ret = pm_generic_suspend_noirq(dev);
>  
>  	if (!ret && !pm_runtime_status_suspended(dev)) {
> -		if (pm_generic_runtime_suspend(dev) == 0) {
> -			if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
> -				omap_device_idle(pdev);
> -			od->flags |= OMAP_DEVICE_SUSPENDED;
> -		}
> +		if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
> +			omap_device_idle(pdev);
> +		od->flags |= OMAP_DEVICE_SUSPENDED;
>  	}
>
>  	return ret;
> @@ -841,7 +839,6 @@ static int _od_resume_noirq(struct device *dev)
>  		od->flags &= ~OMAP_DEVICE_SUSPENDED;
>  		if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
>  			omap_device_enable(pdev);
> -		pm_generic_runtime_resume(dev);
>  	}
>  
>  	return pm_generic_resume_noirq(dev);
