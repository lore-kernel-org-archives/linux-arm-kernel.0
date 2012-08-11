From: ming.lei@canonical.com (Ming Lei)
Date: Sat, 11 Aug 2012 23:09:51 +0800
Subject: [PATCH 1/9] ARM: PMU: Add runtime PM Support
In-Reply-To: <1344620195-22372-2-git-send-email-will.deacon@arm.com>
References: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
 <1344620195-22372-2-git-send-email-will.deacon@arm.com>
Message-ID: <CACVXFVMg5Acx4_KGT5jn1JgO3JsXAjZzU8virR=B3+pBrT4o_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2012 at 1:36 AM, Will Deacon <will.deacon@arm.com> wrote:
> From: Jon Hunter <jon-hunter@ti.com>
>
> Add runtime PM support to the ARM PMU driver so that devices such as OMAP
> supporting dynamic PM can use the platform->runtime_* hooks to initialise
> hardware at runtime. Without having these runtime PM hooks in place any
> configuration of the PMU hardware would be lost when low power states are
> entered and hence would prevent PMU from working.
>
> This change also replaces the PMU platform functions enable_irq and disable_irq
> added by Ming Lei with runtime_resume and runtime_suspend funtions. Ming had
> added the enable_irq and disable_irq functions as a method to configure the
> cross trigger interface on OMAP4 for routing the PMU interrupts. By adding
> runtime PM support, we can move the code called by enable_irq and disable_irq
> into the runtime PM callbacks runtime_resume and runtime_suspend.
>
> Cc: Ming Lei <ming.lei@canonical.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/pmu.h   |   20 ++++++++++++--------
>  arch/arm/kernel/perf_event.c |   41 +++++++++++++++++++++++++++++++++--------
>  2 files changed, 45 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
> index 4432305..40d7dff 100644
> --- a/arch/arm/include/asm/pmu.h
> +++ b/arch/arm/include/asm/pmu.h
> @@ -31,18 +31,22 @@ enum arm_pmu_type {
>   *     interrupt and passed the address of the low level handler,
>   *     and can be used to implement any platform specific handling
>   *     before or after calling it.
> - * @enable_irq: an optional handler which will be called after
> - *     request_irq and be used to handle some platform specific
> - *     irq enablement
> - * @disable_irq: an optional handler which will be called before
> - *     free_irq and be used to handle some platform specific
> - *     irq disablement
> + * @runtime_resume: an optional handler which will be called by the
> + *     runtime PM framework following a call to pm_runtime_get().
> + *     Note that if pm_runtime_get() is called more than once in
> + *     succession this handler will only be called once.
> + * @runtime_suspend: an optional handler which will be called by the
> + *     runtime PM framework following a call to pm_runtime_put().
> + *     Note that if pm_runtime_get() is called more than once in
> + *     succession this handler will only be called following the
> + *     final call to pm_runtime_put() that actually disables the
> + *     hardware.
>   */
>  struct arm_pmu_platdata {
>         irqreturn_t (*handle_irq)(int irq, void *dev,
>                                   irq_handler_t pmu_handler);
> -       void (*enable_irq)(int irq);
> -       void (*disable_irq)(int irq);
> +       int (*runtime_resume)(struct device *dev);
> +       int (*runtime_suspend)(struct device *dev);
>  };
>
>  #ifdef CONFIG_CPU_HAS_PMU
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index ab243b8..c44647e 100644
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
> @@ -364,8 +365,6 @@ armpmu_release_hardware(struct arm_pmu *armpmu)
>  {
>         int i, irq, irqs;
>         struct platform_device *pmu_device = armpmu->plat_device;
> -       struct arm_pmu_platdata *plat =
> -               dev_get_platdata(&pmu_device->dev);
>
>         irqs = min(pmu_device->num_resources, num_possible_cpus());
>
> @@ -373,13 +372,11 @@ armpmu_release_hardware(struct arm_pmu *armpmu)
>                 if (!cpumask_test_and_clear_cpu(i, &armpmu->active_irqs))
>                         continue;
>                 irq = platform_get_irq(pmu_device, i);
> -               if (irq >= 0) {
> -                       if (plat && plat->disable_irq)
> -                               plat->disable_irq(irq);
> +               if (irq >= 0)
>                         free_irq(irq, armpmu);
> -               }
>         }
>
> +       pm_runtime_put_sync(&pmu_device->dev);

One question, each pmu is just inside one cpu core and should be
suspended individually, but looks the above don't support it, do it?

>         release_pmu(armpmu->type);
>  }
>
> @@ -412,6 +409,8 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
>                 return -ENODEV;
>         }
>
> +       pm_runtime_get_sync(&pmu_device->dev);

Similar with above.


Thanks,
--
Ming Lei
