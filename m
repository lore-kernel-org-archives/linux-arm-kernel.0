From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Sat, 12 Nov 2011 11:15:25 +0100
Subject: [PATCH 1/3] ARM: EXYNOS4: Add ASV feature for Exynos4 series
In-Reply-To: <1320904083-19173-2-git-send-email-boyko.lee@samsung.com>
References: <1320904083-19173-1-git-send-email-boyko.lee@samsung.com>
 <1320904083-19173-2-git-send-email-boyko.lee@samsung.com>
Message-ID: <4EBE473D.4040408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2011 06:48 AM, Jongpill Lee wrote:
> This patch adds ASV feature for exynos4 series.
> ASV(Adaptive support voltage) feature support to get spec of SoC.
> And we can use to adjust voltage for operation SoC using by ASV result.
> 
> Signed-off-by: Jongpill Lee<boyko.lee@samsung.com>
> ---
...
> diff --git a/arch/arm/mach-exynos4/asv.c b/arch/arm/mach-exynos4/asv.c
> new file mode 100644
> index 0000000..b13d182
> --- /dev/null
> +++ b/arch/arm/mach-exynos4/asv.c
> @@ -0,0 +1,66 @@
> +/* linux/arch/arm/mach-exynos4/asv.c
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * EXYNOS4 - ASV(Adaptive Support Voltage) driver
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
> +		return -ENOMEM;
> +
> +	/* I will add asv driver of exynos4 series to regist */
> +
> +	if (exynos_asv->check_vdd_arm) {
> +		if (exynos_asv->check_vdd_arm())
> +			goto out;
> +	}
> +
> +	/* Get HPM Delay value */
> +	if (exynos_asv->get_hpm) {
> +		if (exynos_asv->get_hpm(exynos_asv))
> +			goto out;
> +	} else
> +		goto out;

The 'else' statements should also be enclosed in brackets, according to the coding
style rules. How about just doing: 

	if (!exynos_asv->get_hpm || exynos_asv->get_hpm(exynos_asv))
		goto out;
?
> +
> +	/* Get IDS ARM Value */
> +	if (exynos_asv->get_ids) {
> +		if (exynos_asv->get_ids(exynos_asv))
> +			goto out;
> +	} else
> +		goto out;
> +
> +	if (exynos_asv->store_result) {
> +		if (exynos_asv->store_result(exynos_asv))
> +			goto out;
> +	} else
> +		goto out;
> +
> +	return 0;
> +out:
> +	pr_err("EXYNOS : Fail to initialize ASV\n");
> +
> +	kfree(exynos_asv);
> +
> +	return -EINVAL;
> +}
...
