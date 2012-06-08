From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Jun 2012 10:47:08 +0100
Subject: [PATCH V2 01/10] ARM: PMU: Add runtime PM Support
In-Reply-To: <1339104132-26885-2-git-send-email-jon-hunter@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
 <1339104132-26885-2-git-send-email-jon-hunter@ti.com>
Message-ID: <20120608094708.GC19062@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Thu, Jun 07, 2012 at 10:22:03PM +0100, Jon Hunter wrote:
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index 186c8cb..00adb98 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
>  #include <linux/uaccess.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <asm/cputype.h>
>  #include <asm/irq.h>
> @@ -367,8 +368,6 @@ armpmu_release_hardware(struct arm_pmu *armpmu)
>  {
>  	int i, irq, irqs;
>  	struct platform_device *pmu_device = armpmu->plat_device;
> -	struct arm_pmu_platdata *plat =
> -		dev_get_platdata(&pmu_device->dev);
>  
>  	irqs = min(pmu_device->num_resources, num_possible_cpus());
>  
> @@ -376,14 +375,12 @@ armpmu_release_hardware(struct arm_pmu *armpmu)
>  		if (!cpumask_test_and_clear_cpu(i, &armpmu->active_irqs))
>  			continue;
>  		irq = platform_get_irq(pmu_device, i);
> -		if (irq >= 0) {
> -			if (plat && plat->disable_irq)
> -				plat->disable_irq(irq);
> +		if (irq >= 0)
>  			free_irq(irq, armpmu);
> -		}
>  	}
>  
>  	release_pmu(armpmu->type);
> +	pm_runtime_put_sync(&armpmu->plat_device->dev);

We probably want to suspend the device before releasing it, otherwise we
could race against somebody else trying to initialise the PMU again.

>  
>  static int
> @@ -403,6 +400,8 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
>  		return err;
>  	}
>  
> +	pm_runtime_get_sync(&armpmu->plat_device->dev);

Better pass &pmu_device->dev instead (similarly in release).

> +
>  	plat = dev_get_platdata(&pmu_device->dev);
>  	if (plat && plat->handle_irq)
>  		handle_irq = armpmu_platform_irq;
> @@ -440,8 +439,7 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
>  				irq);
>  			armpmu_release_hardware(armpmu);
>  			return err;
> -		} else if (plat && plat->enable_irq)
> -			plat->enable_irq(irq);
> +		}
>  
>  		cpumask_set_cpu(i, &armpmu->active_irqs);
>  	}
> @@ -584,6 +582,28 @@ static void armpmu_disable(struct pmu *pmu)
>  	armpmu->stop();
>  }

There are potential failure paths in the reservation code here where we
don't `put' the PMU back. Can you move the pm_runtime_get_sync call later in
the function, or does it have to called before we enable the IRQ line?

> +#ifdef CONFIG_PM_RUNTIME
> +static int armpmu_runtime_resume(struct device *dev)
> +{
> +	struct arm_pmu_platdata *plat = dev_get_platdata(dev);
> +
> +	if (plat->runtime_resume)

I think you need to check plat too since it may be NULL on other platforms.

> +		return plat->runtime_resume(dev);
> +
> +	return 0;
> +}
> +
> +static int armpmu_runtime_suspend(struct device *dev)
> +{
> +	struct arm_pmu_platdata *plat = dev_get_platdata(dev);
> +
> +	if (plat->runtime_suspend)

Same here.

Will
