From: robh@kernel.org (Rob Herring)
Date: Wed, 5 Aug 2015 09:45:22 -0500
Subject: [PATCH 6/9] ARM: domain: Add platform handlers for CPU PM domains
In-Reply-To: <1438731339-58317-7-git-send-email-lina.iyer@linaro.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-7-git-send-email-lina.iyer@linaro.org>
Message-ID: <CAL_JsqKWekSGiFbZz6++3ibAzY_8Y6+0nOBQinFVw4cBk6JvEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 4, 2015 at 6:35 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> In addition to the common power up/down actions of CPU PM domain core,
> platforms may have additional configuration before the CPU domain can be
> powered off or considered active. Allow platform drivers to register
> handlers for CPU PM domains.
>
> Platform drivers may register their callbacks against a compatible
> string defined by their PM domain provider device node in the DT. At
> domain init, the platform driver can initialize the platform specific
> genpd attributes. The init callback would need to return successfully,
> for the platform power_on/off handlers to be registered with the CPU PM
> domain.
>
> The code uses __init section to reduce memory needed for platform
> handlers and therefore can be freed after the driver is initialized, a
> desirable outcome for single kernel image.

[...]

> diff --git a/arch/arm/include/asm/arm-pd.h b/arch/arm/include/asm/arm-pd.h
> new file mode 100644
> index 0000000..fc44abf
> --- /dev/null
> +++ b/arch/arm/include/asm/arm-pd.h
> @@ -0,0 +1,30 @@
> +/*
> + * linux/arch/arm/include/asm/arm-pd.h
> + *
> + * Copyright (C) 2015 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ARM_PD_H__
> +#define __ARM_PD_H__
> +
> +struct of_arm_pd_ops {
> +       int (*init)(struct device_node *dn, struct generic_pm_domain *d);
> +       int (*power_on)(struct generic_pm_domain *d);
> +       int (*power_off)(struct generic_pm_domain *d);
> +};
> +
> +struct of_arm_pd_method {
> +       const char *handle;
> +       struct of_arm_pd_ops *ops;
> +};
> +
> +#define ARM_PD_METHOD_OF_DECLARE(_name, _handle, _ops) \
> +       static const struct of_arm_pd_method __arm_pd_method_of_table_##_name \
> +       __used __section(__arm_pd_method_of_table)              \
> +       = { .handle = _handle, .ops = _ops }

AFAICT, you are not using this in this series. You should add it when
you have a user.

Ideally, we keep some amount of uniformity across various *_OF_DECLARE
which is why we have OF_DECLARE_1 and OF_DECLARE_2. This makes all the
sections just arrays of struct of_device_id. Not all users follow
this, but most do. So instead of putting the ops in here, platforms
can provide a function callback which can then set the ops. Then you
also don't need the .init() ops function as the callback function can
do any initialization too.

Rob
