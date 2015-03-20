From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 20 Mar 2015 07:38:36 +0000
Subject: [PATCH v3 1/6] clk: qcom: Add support for GDSCs
In-Reply-To: <1426832483-27026-2-git-send-email-rnayak@codeaurora.org>
References: <1426832483-27026-1-git-send-email-rnayak@codeaurora.org>
 <1426832483-27026-2-git-send-email-rnayak@codeaurora.org>
Message-ID: <550BCE7C.3030000@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor Nit picks,

On 20/03/15 06:21, Rajendra Nayak wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
>
> GDSCs (Global Distributed Switch Controllers) are responsible for
> safely collapsing and restoring power to peripherals in the SoC.
> These are best modelled as power domains using genpd and given
> the registers are scattered throughout the clock controller register
> space, its best to have the support added through the clock driver.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>   drivers/clk/qcom/Kconfig  |   5 ++
>   drivers/clk/qcom/Makefile |   1 +
>   drivers/clk/qcom/gdsc.c   | 166 ++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/clk/qcom/gdsc.h   |  46 +++++++++++++
>   4 files changed, 218 insertions(+)
>   create mode 100644 drivers/clk/qcom/gdsc.c
>   create mode 100644 drivers/clk/qcom/gdsc.h
>
...
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/export.h>
?? Do you need this?

> +#include <linux/jiffies.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include "gdsc.h"
> +
> +#define PWR_ON_MASK		BIT(31)
> +#define EN_REST_WAIT_MASK	GENMASK(23, 20)
> +#define EN_FEW_WAIT_MASK	GENMASK(19, 16)
> +#define CLK_DIS_WAIT_MASK	GENMASK(15, 12)
> +#define SW_OVERRIDE_MASK	BIT(2)
> +#define HW_CONTROL_MASK		BIT(1)
> +#define SW_COLLAPSE_MASK	BIT(0)
> +
> +/* Wait 2^n CXO cycles between all states. Here, n=2 (4 cycles). */
> +#define EN_REST_WAIT_VAL	(0x2 << 20)
> +#define EN_FEW_WAIT_VAL		(0x8 << 16)
> +#define CLK_DIS_WAIT_VAL	(0x2 << 12)
> +
> +#define TIMEOUT_US		100
> +
> +static int gdsc_is_enabled(struct gdsc *sc)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(sc->regmap, sc->gdscr, &val);
> +	if (ret)
> +		return ret;
Line after this would be good.
> +	return !!(val & PWR_ON_MASK);
> +}
> +
> +static int gdsc_toggle_logic(struct gdsc *sc, bool en)
> +{
> +	int ret;
> +	u32 val = en ? 0 : SW_COLLAPSE_MASK;
> +	u32 check = en ? PWR_ON_MASK : 0;
> +	unsigned long timeout;
> +
> +	ret = regmap_update_bits(sc->regmap, sc->gdscr, SW_COLLAPSE_MASK, val);
> +	if (ret)
> +		return ret;
> +
> +	timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
> +	do {
> +		ret = regmap_read(sc->regmap, sc->gdscr, &val);
> +		if (ret)
> +			return ret;
> +		if ((val & PWR_ON_MASK) == check)
> +			return 0;
> +	} while (time_before(jiffies, timeout));
> +
> +	ret =  regmap_read(sc->regmap, sc->gdscr, &val);
> +	if (ret)
> +		return ret;
New line here.
> +	if ((val & PWR_ON_MASK) == check)
> +		return 0;
> +
> +	return -ETIMEDOUT;
> +}
> +
...

> +
> +int gdsc_register(struct device *dev, struct gdsc **scs, size_t num,
> +		  struct regmap *regmap)
> +{
> +	int i, ret;
> +	struct genpd_onecell_data *data;
> +
> +	if (!num || !scs || !dev || !dev->of_node)
> +		return 0;
Should it not return -EINVAL here?

> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->domains = devm_kzalloc(dev, sizeof(*data->domains) * num,
> +				     GFP_KERNEL);
> +	if (!data->domains)
> +		return -ENOMEM;
> +
> +	data->num_domains = num;
> +	for (i = 0; i < num; i++) {
> +		if (!scs[i])
> +			continue;
> +		scs[i]->regmap = regmap;
> +		ret = gdsc_init(scs[i]);
> +		if (ret)
> +			return ret;
> +		data->domains[i] = &scs[i]->pd;
> +	}
New line?
> +	return of_genpd_add_provider_onecell(dev->of_node, data);
> +}
> +
> +void gdsc_unregister(struct device *dev)
> +{
> +	of_genpd_del_provider(dev->of_node);
> +}
> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> new file mode 100644
> index 0000000..02e2990
> --- /dev/null
> +++ b/drivers/clk/qcom/gdsc.h
> @@ -0,0 +1,46 @@
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __QCOM_GDSC_H__
> +#define __QCOM_GDSC_H__
> +
> +#include <linux/pm_domain.h>
> +
> +struct regmap;
> +
> +/**
> + * struct gdsc - Globally Distributed Switch Controller
> + * @pd: generic power domain
> + * @regmap: regmap for MMIO accesses
> + * @gdscr: gsdc control register
> + */
> +struct gdsc {
> +	struct generic_pm_domain	pd;
> +	struct regmap			*regmap;
> +	unsigned int			gdscr;
> +};
> +
> +#define domain_to_gdsc(domain) container_of(domain, struct gdsc, pd)
> +
> +#ifdef CONFIG_QCOM_GDSC
> +int gdsc_register(struct device *, struct gdsc **, size_t n, struct regmap *);
> +void gdsc_unregister(struct device *);
> +#else
> +int gdsc_register(struct device *d, struct gdsc **g, size_t n, struct regmap *r)

static inline here??? else it would result in muliple definitions?

> +{
> +	return 0;
return -ENOSYS; I
> +}
> +
> +void gdsc_unregister(struct device *d) {};
same static inline...
Braces should be in next line too.
> +#endif /* CONFIG_QCOM_GDSC */
> +#endif /* __QCOM_GDSC_H__ */
>


--srini
