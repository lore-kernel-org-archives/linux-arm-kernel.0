From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 25 Apr 2014 07:37:47 +0200
Subject: [PATCH] ARM: imx6q: work around faulty PMU irq routing
In-Reply-To: <1398371029-21176-1-git-send-email-l.stach@pengutronix.de>
References: <1398371029-21176-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <5359F4AB.9090502@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.04.2014 22:23, Lucas Stach wrote:
> The i.MX6 PMU has a design errata where the interrupts of all cores are
> wired together into a single irq line. To work around this we have to
> bounce the interrupt around all cores until we find the one where the PMU
> counter overflow has happened.
>
> This causes the perf measurements to be less accurate and we can't really
> handle the case where two cores fire a PMU irq at the same time. The
> implemented woraround makes perf at least somewhat useable on imx6 SoCs
> with more than one core.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>   arch/arm/mach-imx/mach-imx6q.c | 38 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index e60456d85c9d..73976c484826 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -16,6 +16,7 @@
>   #include <linux/delay.h>
>   #include <linux/export.h>
>   #include <linux/init.h>
> +#include "linux/interrupt.h"
>   #include <linux/io.h>
>   #include <linux/irq.h>
>   #include <linux/irqchip.h>
> @@ -33,6 +34,7 @@
>   #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>   #include <asm/mach/arch.h>
>   #include <asm/mach/map.h>
> +#include "asm/pmu.h"
>   #include <asm/system_misc.h>
>
>   #include "common.h"
> @@ -261,6 +263,39 @@ static void __init imx6q_axi_init(void)
>   	}
>   }
>
> +/*
> + * The i.MX6 PMU has a design errata where the interrupts of all cores are
> + * wired together into a single irq line. To work around this we have to
> + * bounce the interrupt around all cores until we find the one where the PMU
> + * counter overflow has happened.
> + */
> +static irqreturn_t imx6q_pmu_handler(int irq, void *dev, irq_handler_t handler)
> +{
> +	irqreturn_t ret = handler(irq, dev);
> +	int next;
> +
> +	if (ret == IRQ_NONE) {
> +		/*
> +		 * Kick the irq over to the next cpu, regardless of it's
> +		 * online status (it might have gone offline while we were busy
> +		 * bouncing the irq).
> +		 */
> +		next = (smp_processor_id() + 1) % num_present_cpus();
> +		irq_set_affinity(irq, cpumask_of(next));
> +	}
> +
> +	return ret;
> +}
> +
> +struct arm_pmu_platdata imx6q_pmu_platdata = {
> +	.handle_irq		= imx6q_pmu_handler,
> +};
> +
> +static struct of_dev_auxdata imx6q_auxdata_lookup[] __initdata = {
> +	OF_DEV_AUXDATA("arm,cortex-a9-pmu", 0, "arm-pmu", &imx6q_pmu_platdata),
> +	{}
> +};
> +
>   static void __init imx6q_init_machine(void)
>   {
>   	struct device *parent;
> @@ -276,7 +311,8 @@ static void __init imx6q_init_machine(void)
>
>   	imx6q_enet_phy_init();
>
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
> +	of_platform_populate(NULL, of_default_bus_match_table,
> +			imx6q_auxdata_lookup, parent);
>
>   	imx_anatop_init();
>   	cpu_is_imx6q() ?  imx6q_pm_init() : imx6dl_pm_init();

Do you have anything like a test case which shows that it works (at 
least better) on a !single core with this patch? Compared to a 
non-patched system?

Many thanks

Dirk
