From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 30 May 2013 18:16:06 -0700
Subject: [RFC PATCHv4 3/6] clk: TI-Nspire clock drivers
In-Reply-To: <1369480087-24786-4-git-send-email-dt.tangr@gmail.com>
References: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
 <1369480087-24786-4-git-send-email-dt.tangr@gmail.com>
Message-ID: <20130531011606.21525.92648@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Daniel Tang (2013-05-25 04:08:04)
> diff --git a/drivers/clk/clk-nspire.c b/drivers/clk/clk-nspire.c
> new file mode 100644
> index 0000000..2546f7d
> --- /dev/null
> +++ b/drivers/clk/clk-nspire.c
> @@ -0,0 +1,155 @@
> +/*
> + *  linux/drivers/clk/clk-nspire.c

Hi Daniel,

It's best not to put any file path here, since it could change in the
future.  Please remove it.

> + *
> + *  Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2, as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +
> +#define MHZ (1000 * 1000)
> +
> +#define BASE_CPU_SHIFT         1
> +#define BASE_CPU_MASK          0x7F
> +
> +#define CPU_AHB_SHIFT          12
> +#define CPU_AHB_MASK           0x07
> +
> +#define FIXED_BASE_SHIFT       8
> +#define FIXED_BASE_MASK                0x01
> +
> +#define CLASSIC_BASE_SHIFT     16
> +#define CLASSIC_BASE_MASK      0x1F
> +
> +#define CX_BASE_SHIFT          15
> +#define CX_BASE_MASK           0x3F
> +
> +#define CX_UNKNOWN_SHIFT       21
> +#define CX_UNKNOWN_MASK                0x03
> +
> +struct nspire_clk_info {
> +       u32 base_clock;
> +       u16 base_cpu_ratio;
> +       u16 base_ahb_ratio;
> +};
> +
> +
> +#define EXTRACT(var, prop) (((var)>>prop##_SHIFT) & prop##_MASK)
> +static void nspire_clkinfo_cx(u32 val, struct nspire_clk_info *clk)
> +{
> +       if (EXTRACT(val, FIXED_BASE))
> +               clk->base_clock = 48 * MHZ;
> +       else
> +               clk->base_clock = 6 * EXTRACT(val, CX_BASE) * MHZ;
> +
> +       clk->base_cpu_ratio = EXTRACT(val, BASE_CPU) * EXTRACT(val, CX_UNKNOWN);
> +       clk->base_ahb_ratio = clk->base_cpu_ratio * (EXTRACT(val, CPU_AHB) + 1);
> +}
> +
> +static void nspire_clkinfo_classic(u32 val, struct nspire_clk_info *clk)
> +{
> +       if (EXTRACT(val, FIXED_BASE))
> +               clk->base_clock = 27 * MHZ;
> +       else
> +               clk->base_clock = (300 - 6 * EXTRACT(val, CLASSIC_BASE)) * MHZ;
> +
> +       clk->base_cpu_ratio = EXTRACT(val, BASE_CPU) * 2;
> +       clk->base_ahb_ratio = clk->base_cpu_ratio * (EXTRACT(val, CPU_AHB) + 1);
> +}
> +#undef EXTRACT

Any particular reason for the undef?

Rest looks good to me.  If you can respin this patch I'll take it into
clk-next.

Thanks,
Mike
