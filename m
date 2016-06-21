From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 Jun 2016 18:42:16 -0700
Subject: [PATCH v2 13/15] clk: sunxi-ng: Add N-K-M-P factor clock
In-Reply-To: <20160607204154.31967-14-maxime.ripard@free-electrons.com>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
 <20160607204154.31967-14-maxime.ripard@free-electrons.com>
Message-ID: <20160621014216.GS1521@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07, Maxime Ripard wrote:
> diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
> new file mode 100644
> index 000000000000..9f2b98e19dc9
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
> @@ -0,0 +1,167 @@
> +/*
> + * Copyright (C) 2016 Maxime Ripard
> + * Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/rational.h>
> +
> +#include "ccu_gate.h"
> +#include "ccu_nkmp.h"
> +
> +struct _ccu_nkmp {
> +	unsigned long	n, max_n;
> +	unsigned long	k, max_k;
> +	unsigned long	m, max_m;
> +	unsigned long	p, max_p;
> +};
> +
> +static void ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
> +			       struct _ccu_nkmp *nkmp)
> +{
> +	unsigned long best_rate = 0;
> +	unsigned long best_n = 0, best_k = 0, best_m = 0, best_p = 0;
> +	unsigned long _n, _k, _m, _p;
> +
> +	for (_k = 1; _k <= nkmp->max_k; _k++) {
> +		for (_p = 0; _p <= nkmp->max_p; _p++) {
> +			unsigned long tmp_rate;
> +
> +			rational_best_approximation(rate / _k, parent >> _p,
> +						    nkmp->max_n, nkmp->max_m,
> +						    &_n, &_m);

Is there a select for RATIONAL somewhere? If not please add it to
the Kconfig. I know that COMMON_CLK has it, but I think we should
try to reduce bloat by not forcing all the basic types on drivers
that aren't using them. Instead we should have drivers start
selecting that code. So it's best to not rely on the common clk
select.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
