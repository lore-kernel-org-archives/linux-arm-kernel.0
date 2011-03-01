From: will.deacon@arm.com (Will Deacon)
Date: Tue, 01 Mar 2011 21:55:24 +0000
Subject: [patch v1 2/3] arm: pmu: support pmu irq routed from CTI
In-Reply-To: <1298998711-8165-3-git-send-email-tom.leiming@gmail.com>
References: <1298998711-8165-1-git-send-email-tom.leiming@gmail.com>
	<1298998711-8165-3-git-send-email-tom.leiming@gmail.com>
Message-ID: <1299016524.5379.27.camel@jazzbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ming Lei,

It's good to see somebody looking at OMAP4 since I've been hearing from
people having trouble getting perf going on the PandaBoard.


On Tue, 2011-03-01 at 16:58 +0000, tom.leiming at gmail.com wrote:
> From: Ming Lei <tom.leiming@gmail.com>
> 
> This patch introduces pmu_platform_data struct to
> support pmu irq routed from CTI, such as implemented
> on OMAP4.
> 
> Generally speaking, clearing cti irq should be done in
> irq handler, also enabling cti module after calling
> request_irq and disabling cti module before calling
> free_irq.
> 
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  arch/arm/include/asm/pmu.h   |   12 +++++++++
>  arch/arm/kernel/perf_event.c |   57 ++++++++++++++++++++++++++++++-----------
>  2 files changed, 53 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
> index 7544ce6..6162aaf 100644
> --- a/arch/arm/include/asm/pmu.h
> +++ b/arch/arm/include/asm/pmu.h
> @@ -13,20 +13,32 @@
>  #define __ARM_PMU_H__
> 
>  #include <linux/interrupt.h>
> +#include <asm/cti.h>
> 
>  enum arm_pmu_type {
>         ARM_PMU_DEVICE_CPU      = 0,
>         ARM_NUM_PMU_DEVICES,
>  };
> 
> +#define MAX_CTI_NUM  4

Why is this in the PMU header file rather than the CTI one?

>  /*
>   * struct arm_pmu_platdata - ARM PMU platform data
>   *
> + * @use_cti_irq: pmu irq is routed from cti
> + * @cti_cnt: cti counts used for pmu irq routing
> + * @cti: cti instances used to help access cti registers
>   * @handle_irq: an optional handler which will be called from the interrupt and
>   * passed the address of the low level handler, and can be used to implement
>   * any platform specific handling before or after calling it.
> + *
> + * If pmu irq is routed from CTI, @use_cti_irq, @cti_cnt and
> + * @cti must be initialized and passed to pmu driver.
>   */
>  struct arm_pmu_platdata {
> +       int use_cti_irq;
> +       int cti_cnt;
> +       struct cti cti[MAX_CTI_NUM];
> +
>         irqreturn_t (*handle_irq)(int irq, void *dev,
>                                   irq_handler_t pmu_handler);
>  };
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index 22e194eb..9027a8f 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -377,18 +377,39 @@ validate_group(struct perf_event *event)
>         return 0;
>  }
> 
> -static irqreturn_t armpmu_platform_irq(int irq, void *dev)
> +static inline int cti_irq(struct arm_pmu_platdata *data)
>  {
> -       struct arm_pmu_platdata *plat = dev_get_platdata(&pmu_device->dev);
> +       return data && data->use_cti_irq;
> +}
> +
> +static inline struct cti *irq_to_cti(struct arm_pmu_platdata *data,
> +       int irq)
> +{
> +       int idx;
> 
> -       return plat->handle_irq(irq, dev, armpmu->handle_irq);
> +       for(idx = 0; idx < data->cti_cnt; idx++)
> +               if (data->cti[idx].irq == irq)
> +                       return &data->cti[idx];
> +       return NULL;
> +}

Hmm, since OMAP is the only platform using this, I'm not especially
happy sticking this directly in the PMU code.

> +static inline irqreturn_t armpmu_handle_irq(int irq_num, void *dev)
> +{
> +       struct arm_pmu_platdata *plat = dev;
> +
> +       if (cti_irq(plat))
> +               cti_irq_ack(irq_to_cti(plat, irq_num));
> +
> +       if (plat && plat->handle_irq)
> +               return plat->handle_irq(irq_num, dev, armpmu->handle_irq);
> +       else
> +               return armpmu->handle_irq(irq_num, NULL);
>  }
> 
You can use the new arm_pmu_platdata.handle_irq function to register
your own IRQ callback. I don't think we should define the handler here.

>  static int
>  armpmu_reserve_hardware(void)
>  {
>         struct arm_pmu_platdata *plat;
> -       irq_handler_t handle_irq;
>         int i, err = -ENODEV, irq;
> 
>         pmu_device = reserve_pmu(ARM_PMU_DEVICE_CPU);
> @@ -399,11 +420,7 @@ armpmu_reserve_hardware(void)
> 
>         init_pmu(ARM_PMU_DEVICE_CPU);
> 
> -       plat = dev_get_platdata(&pmu_device->dev);
> -       if (plat && plat->handle_irq)
> -               handle_irq = armpmu_platform_irq;
> -       else
> -               handle_irq = armpmu->handle_irq;
> +       plat = platform_get_drvdata(pmu_device);
> 
>         if (pmu_device->num_resources < 1) {
>                 pr_err("no irqs for PMUs defined\n");
> @@ -415,21 +432,25 @@ armpmu_reserve_hardware(void)
>                 if (irq < 0)
>                         continue;
> 
> -               err = request_irq(irq, handle_irq,
> +               err = request_irq(irq, armpmu_handle_irq,
>                                   IRQF_DISABLED | IRQF_NOBALANCING,
> -                                 "armpmu", NULL);
> +                                 "armpmu", plat);
>                 if (err) {
>                         pr_warning("unable to request IRQ%d for ARM perf "
>                                 "counters\n", irq);
>                         break;
> -               }
> +               } else if (cti_irq(plat))
> +                       cti_enable(irq_to_cti(plat, irq));
>         }
> 
>         if (err) {
>                 for (i = i - 1; i >= 0; --i) {
>                         irq = platform_get_irq(pmu_device, i);
> -                       if (irq >= 0)
> -                               free_irq(irq, NULL);
> +                       if (irq >= 0) {
> +                               if (cti_irq(plat))
> +                                       cti_disable(irq_to_cti(plat, irq));
> +                               free_irq(irq, plat);
> +                       }
>                 }
>                 release_pmu(pmu_device);
>                 pmu_device = NULL;
> @@ -442,11 +463,15 @@ static void
>  armpmu_release_hardware(void)
>  {
>         int i, irq;
> +       struct arm_pmu_platdata *plat = platform_get_drvdata(pmu_device);
> 
>         for (i = pmu_device->num_resources - 1; i >= 0; --i) {
>                 irq = platform_get_irq(pmu_device, i);
> -               if (irq >= 0)
> -                       free_irq(irq, NULL);
> +               if (irq >= 0) {
> +                       if (cti_irq(plat))
> +                               cti_disable(irq_to_cti(plat, irq));
> +                       free_irq(irq, plat);
> +               }
>         }
>         armpmu->stop();
> 
Right, so I think a better way to do this is to put all the CTI stuff in
its own file. Whether this lives in the OMAP BSP is up to you (perhaps
the best place for it at the moment, until other platforms use it too).

Then we can add ->enable and ->disable hooks in the platdata which are
not CTI-specific and may also be useful for other platforms and PMU
implementations.

Does that work for you?

Cheers,

Will
