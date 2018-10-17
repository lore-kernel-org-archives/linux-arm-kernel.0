From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 11:32:13 -0700
Subject: [PATCH 2/6] clk: mvebu: add helper file for Armada AP and CP
 clocks
In-Reply-To: <20180922181709.13007-3-gregory.clement@bootlin.com>
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
 <20180922181709.13007-3-gregory.clement@bootlin.com>
Message-ID: <153980113358.5275.6784587664499905114@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gregory CLEMENT (2018-09-22 11:17:05)
> diff --git a/drivers/clk/mvebu/armada_ap_cp_helper.c b/drivers/clk/mvebu/armada_ap_cp_helper.c
> new file mode 100644
> index 000000000000..5f2457719b10
> --- /dev/null
> +++ b/drivers/clk/mvebu/armada_ap_cp_helper.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Marvell Armada AP and CP110 helper
> + *
> + * Copyright (C) 2018 Marvell
> + *
> + * Gregory Clement <gregory.clement@bootlin.com>
> + *
> + */
> +
> +#include "armada_ap_cp_helper.h"
> +#include <linux/device.h>
> +
> +char *ap_cp_unique_name(struct device *dev, struct device_node *np,
> +                       const char *name)
> +{
> +       const __be32 *reg;
> +       u64 addr;
> +
> +       /* Do not create a name if there is no clock */
> +       if (!name)
> +               return NULL;
> +
> +       reg = of_get_property(np, "reg", NULL);
> +       addr = of_translate_address(np, reg);
> +       return devm_kasprintf(dev, GFP_KERNEL, "%llx-%s",
> +                             (unsigned long long)addr, name);

We probably don't want to leak physical addresses into debugfs, but I
guess this is how it's already been, so maybe something in the future
should change this for security purposes.

> +}
> diff --git a/drivers/clk/mvebu/armada_ap_cp_helper.h b/drivers/clk/mvebu/armada_ap_cp_helper.h
> new file mode 100644
> index 000000000000..23aa29f3fcf7
> --- /dev/null
> +++ b/drivers/clk/mvebu/armada_ap_cp_helper.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __ARMADA_AP_CP_HELPER_H
> +#define __ARMADA_AP_CP_HELPER_H
> +
> +#include <linux/of.h>
> +#include <linux/of_address.h>

Drop these includes? And forward declare 

struct device;
struct device_node;

> +
> +char *ap_cp_unique_name(struct device *dev, struct device_node *np,
> +                       const char *name);
> +#endif
