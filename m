From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 03 Feb 2014 15:31:47 -0500
Subject: [PATCH v2 1/7] ARM: perf_event: Support percpu irqs for the CPU
 PMU
In-Reply-To: <1389808535-23852-2-git-send-email-sboyd@codeaurora.org>
References: <1389808535-23852-1-git-send-email-sboyd@codeaurora.org>
 <1389808535-23852-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <52EFFCB3.1020208@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2014 12:55 PM, Stephen Boyd wrote:
> Some CPU PMUs are wired up with one PPI for all the CPUs instead
> of with a different SPI for each CPU. Add support for these
> devices.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/kernel/perf_event.c     | 14 ++++--
>  arch/arm/kernel/perf_event_cpu.c | 97 ++++++++++++++++++++++++++++------------
>  2 files changed, 80 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index 789d846a9184..e76750980b38 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -16,6 +16,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/uaccess.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
>  
>  #include <asm/irq_regs.h>
>  #include <asm/pmu.h>
> @@ -295,9 +297,15 @@ validate_group(struct perf_event *event)
>  
>  static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
>  {
> -	struct arm_pmu *armpmu = (struct arm_pmu *) dev;
> -	struct platform_device *plat_device = armpmu->plat_device;
> -	struct arm_pmu_platdata *plat = dev_get_platdata(&plat_device->dev);
> +	struct arm_pmu *armpmu;
> +	struct platform_device *plat_device;
> +	struct arm_pmu_platdata *plat;
> +
> +	if (irq_is_percpu(irq))

In case anyone else is trying to follow along, this requires:

http://lkml.org/lkml/2013/12/4/316

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
