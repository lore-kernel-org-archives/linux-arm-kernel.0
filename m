From: josh.cartwright@gmail.com (Josh Cartwright)
Date: Tue, 20 Nov 2012 14:10:26 -0600
Subject: [PATCH V3 1/2] clocksource: add common of_clksrc_init() function
In-Reply-To: <1353439206-1654-1-git-send-email-swarren@wwwdotorg.org>
References: <1353439206-1654-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121120201026.GF6280@kryptos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 12:20:05PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> It is desirable to move all clocksource drivers to drivers/clocksource,
> yet each requires its own initialization function. We'd rather not
> pollute <linux/> with a header for each function. Instead, create a
> single of_clksrc_init() function which will determine which clocksource
> driver to initialize based on device tree.
> 
> Inspired by a similar patch for drivers/irqchip by Thomas Petazzoni.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> v3: Use a linker section to replace manually maintained table.
> v2: New patch.
> 
[..]
> --- /dev/null
> +++ b/drivers/clocksource/clksrc-of.c
> @@ -0,0 +1,41 @@
> +/*
> + * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/of.h>
> +
> +extern struct of_device_id *__start_clksrc_of_match_tables[];
> +extern struct of_device_id *__stop_clksrc_of_match_tables[];
> +
> +void __init clocksource_of_init(void)
> +{
> +	struct of_device_id **table;
> +	struct of_device_id **stop;
> +	struct device_node *np;
> +	const struct of_device_id *match;
> +	void (*init_func)(void);
> +
> +	table = __start_clksrc_of_match_tables;
> +	stop = __stop_clksrc_of_match_tables;
> +
> +	for ( ; table < stop; table++) {
> +		for_each_matching_node(np, *table) {
> +			match = of_match_node(*table, np);
> +			init_func = match->data;
> +			init_func();

Hmm.  Am I crazy, or does this for_each_matching_node()/of_match_node()
pattern end up walking the match table twice, unnecessarily?

I'm wondering if we can come up with a for_each_matching_node_id() macro
that also provides a pointer to the matching of_device_id...

   Josh
