From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Mon, 13 Aug 2012 14:57:12 -0700
Subject: [PATCH 4/9] ARM: pmu: remove arm_pmu_type enumeration
In-Reply-To: <1344620195-22372-5-git-send-email-will.deacon@arm.com>
References: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
 <1344620195-22372-5-git-send-email-will.deacon@arm.com>
Message-ID: <50297838.7080208@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/10/2012 10:36 AM, Will Deacon wrote:
> From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
>
> The arm_pmu_type enumeration was initially introduced to identify
> different PMU types in the system, the usual one being that on the CPU
> (ARM_PMU_DEVICE_CPU). With the removal of the PMU reservation code and
> the introduction of devicetree bindings for the CPU PMU, the enumeration
> is no longer required.
>
> This patch removes the enumeration and updates the various CPU PMU
> platform devices so that they no longer pass an .id field referring
> to identify the PMU type.
>
> Cc: JD Zheng <jdzheng@broadcom.com>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Signed-off-by: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
> [will: cosmetic edits and actual removal of the enum type]
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm/include/asm/pmu.h               |   10 ----------
>   arch/arm/mach-bcmring/arch.c             |    3 +--
>   arch/arm/mach-omap2/devices.c            |    3 +--
>   arch/arm/mach-pxa/devices.c              |    3 +--
>   arch/arm/mach-realview/realview_eb.c     |    3 +--
>   arch/arm/mach-realview/realview_pb1176.c |    3 +--
>   arch/arm/mach-realview/realview_pb11mp.c |    3 +--
>   arch/arm/mach-realview/realview_pba8.c   |    3 +--
>   arch/arm/mach-realview/realview_pbx.c    |    3 +--
>   arch/arm/mach-tegra/devices.c            |    3 +--
>   arch/arm/mach-ux500/cpu-db8500.c         |    3 +--
>   arch/arm/mach-vexpress/ct-ca9x4.c        |    3 +--
>   arch/arm/plat-iop/pmu.c                  |    3 +--
>   arch/arm/plat-samsung/devs.c             |    3 +--
>   14 files changed, 13 insertions(+), 36 deletions(-)
>
> diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
> index 05e0401..fbec73a 100644
> --- a/arch/arm/include/asm/pmu.h
> +++ b/arch/arm/include/asm/pmu.h
> @@ -16,15 +16,6 @@
>   #include <linux/perf_event.h>
>   
>   /*
> - * Types of PMUs that can be accessed directly and require mutual
> - * exclusion between profiling tools.
> - */
> -enum arm_pmu_type {
> -	ARM_PMU_DEVICE_CPU	= 0,
> -	ARM_NUM_PMU_DEVICES,
> -};
> -
> -/*
>    * struct arm_pmu_platdata - ARM PMU platform data
>    *
>    * @handle_irq: an optional handler which will be called from the
> @@ -73,7 +64,6 @@ struct pmu_hw_events {
>   
>   struct arm_pmu {
>   	struct pmu	pmu;
> -	enum arm_pmu_type type;
>   	cpumask_t	active_irqs;
>   	char		*name;
>   	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
> diff --git a/arch/arm/mach-bcmring/arch.c b/arch/arm/mach-bcmring/arch.c
> index 45c97b1..76e7953 100644
> --- a/arch/arm/mach-bcmring/arch.c
> +++ b/arch/arm/mach-bcmring/arch.c
> @@ -29,7 +29,6 @@
>   #include <asm/setup.h>
>   #include <asm/mach-types.h>
>   #include <asm/mach/time.h>
> -#include <asm/pmu.h>
>   
>   #include <asm/mach/arch.h>
>   #include <mach/dma.h>
> @@ -116,7 +115,7 @@ static struct resource pmu_resource = {
>   
>   static struct platform_device pmu_device = {
>   	.name		= "arm-pmu",
> -	.id		= ARM_PMU_DEVICE_CPU,
> +	.id		= -1,
>   	.resource	= &pmu_resource,
>   	.num_resources	= 1,
>   };
>
Isn't it clearer to define a meaningful name for "-1", esp. if "-1" is 
being checked somewhere else?

Regards,
JD
