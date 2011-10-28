From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Fri, 28 Oct 2011 20:48:15 +0200
Subject: [PATCH 1/3] ARM: EXYNOS: Add ASV feature for Exynos4 series
In-Reply-To: <1319677938-25732-2-git-send-email-boyko.lee@samsung.com>
References: <1319677938-25732-1-git-send-email-boyko.lee@samsung.com>
	<1319677938-25732-2-git-send-email-boyko.lee@samsung.com>
Message-ID: <4EAAF8EF.5010201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/27/2011 03:12 AM, Jongpill Lee wrote:
> This patch adds ASV feature for exynos4 seires.

s/seires/series

> Asv(Adoptive support voltage) feature support to get spec of SoC.

So is this "Adoptive support voltage" or Adaptive Supply Voltage as commented
further in the patch ?

> And we can use to adjust voltage for operation SoC usign by ASV result.

s/usign/using

In general I find this commit description hard to understand. Could you please
provide a bit more detailed description, perhaps in the cover letter, of what 
this patch series does and why ?

> 
> Signed-off-by: Jongpill Lee<boyko.lee@samsung.com>
> ---
>   arch/arm/mach-exynos4/Makefile           |    2 +-
>   arch/arm/mach-exynos4/asv.c              |   78 ++++++++++++++++++++++++++++++
>   arch/arm/mach-exynos4/include/mach/asv.h |   42 ++++++++++++++++
>   3 files changed, 121 insertions(+), 1 deletions(-)
>   create mode 100644 arch/arm/mach-exynos4/asv.c
>   create mode 100644 arch/arm/mach-exynos4/include/mach/asv.h
> 
> diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
> index 2bb18f4..0f3affe 100644
> --- a/arch/arm/mach-exynos4/Makefile
> +++ b/arch/arm/mach-exynos4/Makefile
> @@ -12,7 +12,7 @@ obj-				:=
> 
>   # Core support for EXYNOS4 system
> 
> -obj-$(CONFIG_ARCH_EXYNOS4)	+= cpu.o init.o clock.o irq-combiner.o
> +obj-$(CONFIG_ARCH_EXYNOS4)	+= cpu.o init.o clock.o irq-combiner.o asv.o
>   obj-$(CONFIG_ARCH_EXYNOS4)	+= setup-i2c0.o irq-eint.o dma.o pmu.o
>   obj-$(CONFIG_CPU_EXYNOS4210)	+= clock-exynos4210.o
>   obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-exynos4212.o
> diff --git a/arch/arm/mach-exynos4/asv.c b/arch/arm/mach-exynos4/asv.c
> new file mode 100644
> index 0000000..498fac0
> --- /dev/null
> +++ b/arch/arm/mach-exynos4/asv.c
> @@ -0,0 +1,78 @@
> +/* linux/arch/arm/mach-exynos4/asv.c
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * EXYNOS4 - ASV(Adaptive Supply Voltage) driver
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include<linux/init.h>
> +#include<linux/types.h>
> +#include<linux/kernel.h>
> +#include<linux/err.h>
> +#include<linux/io.h>
> +#include<linux/slab.h>
> +
> +#include<mach/map.h>
> +#include<mach/asv.h>
> +
> +static struct samsung_asv *exynos_asv;
> +
> +static int __init exynos_asv_init(void)
> +{
> +	exynos_asv = kzalloc(sizeof(struct samsung_asv), GFP_KERNEL);
> +	if (!exynos_asv)
> +		goto out1;

Just return -ENOMEM here.

> +
> +	/* I will add asv driver of exynos4 series to regist */

> +
> +	if (exynos_asv->check_vdd_arm) {
> +		if (exynos_asv->check_vdd_arm()) {
> +			pr_info("EXYNOS: It is wrong vdd_arm\n");
> +			goto out2;
> +		}
> +	}
> +
> +	/* Get HPM Delay value */
> +	if (exynos_asv->get_hpm) {
> +		if (exynos_asv->get_hpm(exynos_asv)) {
> +			pr_info("EXYNOS: Fail to get HPM Value\n");
> +			goto out2;
> +		}
> +	} else {
> +		pr_info("EXYNOS: There is no get hpm function\n");

Are you sure all these info printks are needed in the mainline kernel?

> +		goto out2;
> +	}
> +
> +	/* Get IDS ARM Value */
> +	if (exynos_asv->get_ids) {
> +		if (exynos_asv->get_ids(exynos_asv)) {
> +			pr_info("EXYNOS: Fail to get IDS Value\n");
> +			goto out2;
> +		}
> +	} else {
> +		pr_info("EXYNOS: There is no get ids function\n");
> +		goto out2;
> +	}
> +
> +	if (exynos_asv->store_result) {
> +		if (exynos_asv->store_result(exynos_asv)) {
> +			pr_info("EXYNOS: Can not success to store result\n");
> +			goto out2;
> +		}
> +	} else {
> +		pr_info("EXYNOS: No store_result function\n");
> +		goto out2;
> +	}
> +
> +	return 0;
> +out2:
> +	kfree(exynos_asv);
> +out1:
> +	return -EINVAL;
> +}
> +device_initcall_sync(exynos_asv_init);
> diff --git a/arch/arm/mach-exynos4/include/mach/asv.h b/arch/arm/mach-exynos4/include/mach/asv.h
> new file mode 100644
> index 0000000..038a872
> --- /dev/null
> +++ b/arch/arm/mach-exynos4/include/mach/asv.h
> @@ -0,0 +1,42 @@
> +/* linux/arch/arm/mach-exynos4/include/mach/asv.h
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * EXYNOS4 - Adoptive Support Voltage Header file
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_ARCH_ASV_H
> +#define __ASM_ARCH_ASV_H __FILE__
> +
> +#define JUDGE_TABLE_END			NULL
> +
> +#define LOOP_CNT			10

These defines seem quite generic, if really needed perhaps it's worth to add
a prefix, e.g. EXYNOS4_. 

> +
> +struct asv_judge_table {
> +	unsigned int hpm_limit; /* HPM value to decide group of target */
> +	unsigned int ids_limit; /* IDS value to decide group of target */
> +};
> +
> +struct samsung_asv {

Wouldn't it be more appropriate to use more specific name, something like 'struct exynos_asv' ?

> +	unsigned int pkg_id;			/* fused value for pakage */
                                                                   ^^^^^^ 

> +	unsigned int ids_offset;		/* ids_offset of chip */
> +	unsigned int ids_mask;			/* ids_mask of chip */
> +	unsigned int hpm_result;		/* hpm value of chip */
> +	unsigned int ids_result;		/* ids value of chip */
> +	int (*check_vdd_arm)(void);		/* check vdd_arm value, this function is selectable */
> +	int (*pre_clock_init)(void);		/* clock init function to get hpm */
> +	int (*pre_clock_setup)(void);		/* clock setup function to get hpm */
> +	/* specific get ids function */
> +	int (*get_ids)(struct samsung_asv *asv_info);
> +	/* specific get hpm function */
> +	int (*get_hpm)(struct samsung_asv *asv_info);
> +	/* store into some repository to send result of asv */
> +	int (*store_result)(struct samsung_asv *asv_info);
> +};
> +
> +#endif /* __ASM_ARCH_ASV_H */

You're putting whole driver under arch/arm/, I'm wondering whether the functionality
it provides could be handled by some generic framework, like cpufreq or devfreq. 
How this driver is different from cpufreq drivers ?

--
Thanks,
Sylwester
