From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 11 Jan 2011 11:16:36 +0100
Subject: [PATCH 1/2] Add a common struct clk
In-Reply-To: <1294199462.348449.192344022926.1.gpush@pororo>
References: <1294199462.347935.472473715866.0.gpush@pororo>
	<1294199462.348449.192344022926.1.gpush@pororo>
Message-ID: <20110111101636.GF26617@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 11:51:02AM +0800, Jeremy Kerr wrote:
> diff --git a/kernel/clk.c b/kernel/clk.c
> new file mode 100644
> index 0000000..8de8fe3
> --- /dev/null
> +++ b/kernel/clk.c
> @@ -0,0 +1,102 @@
> +/*
> + * Copyright (C) 2010 Canonical Ltd <jeremy.kerr@canonical.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Standard functionality for the common clock API.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +

...

> +
> +int clk_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	if (clk->ops->set_parent)
> +		return clk->ops->set_parent(clk, parent);
> +	return -ENOSYS;
> +}
> +EXPORT_SYMBOL_GPL(clk_set_parent);

The i.MX clk implementation disables the old parent if clk is enabled
and enables the new parent if clk is enabled (modulo bugs). Shouldn't
we do this here aswell? Otherwise at least the enable_count of both the
old and the new parent will be wrong after calling clk_set_parent for an
enabled clk.

I thought about returning -EBUSY if clk_set_parent is called for an
enabled clk, but this way we could never reparent the cpu clock which I
think is done in the Freescale BSP for power saving.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
