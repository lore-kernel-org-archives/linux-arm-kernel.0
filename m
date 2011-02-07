From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 7 Feb 2011 08:05:24 +0100
Subject: [RFC,PATCH 1/3] Add a common struct clk
In-Reply-To: <1297058877.800158.458894385837.1.gpush@pororo>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<1297058877.800158.458894385837.1.gpush@pororo>
Message-ID: <20110207070524.GA27982@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 07, 2011 at 02:07:57PM +0800, Jeremy Kerr wrote:
> We currently have ~21 definitions of struct clk in the ARM architecture,
> each defined on a per-platform basis. This makes it difficult to define
> platform- (or architecture-) independent clock sources without making
> assumptions about struct clk, and impossible to compile two
> platforms with different struct clks into a single image.
> 
> This change is an effort to unify struct clk where possible, by defining
> a common struct clk, containing a set of clock operations. Different
> clock implementations can set their own operations, and have a standard
> interface for generic code. The callback interface is exposed to the
> kernel proper, while the clock implementations only need to be seen by
> the platform internals.
> 
> This allows us to share clock code among platforms, and makes it
> possible to dynamically create clock devices in platform-independent
> code.
> 
> Platforms can enable the generic struct clock through
> CONFIG_USE_COMMON_STRUCT_CLK. In this case, the clock infrastructure
> consists of a common struct clk:
> 
> struct clk {
> 	const struct clk_ops	*ops;
> 	unsigned int		enable_count;
> 	unsigned int		prepare_count;
> 	spinlock_t		enable_lock;
> 	struct mutex		prepare_lock;
> };
> 
> And a set of clock operations (defined per type of clock):
> 
> struct clk_ops {
> 	int             (*enable)(struct clk *);
> 	void            (*disable)(struct clk *);
> 	unsigned long   (*get_rate)(struct clk *);
> 	[...]
> };
> 
> To define a hardware-specific clock, machine code can "subclass" the
> struct clock into a new struct (adding any device-specific data), and
> provide a set of operations:
> 
> struct clk_foo {
> 	struct clk	clk;
> 	void __iomem	*some_register;
> };
> 
> struct clk_ops clk_foo_ops = {
> 	.get_rate = clk_foo_get_rate,
> };
> 
> The common clock definitions are based on a development patch from Ben
> Herrenschmidt <benh@kernel.crashing.org>.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> ---
>  drivers/clk/Kconfig  |    3 
>  drivers/clk/Makefile |    1 
>  drivers/clk/clk.c    |  134 +++++++++++++++++++++++++++++++
>  drivers/clk/clkdev.c |    5 +
>  include/linux/clk.h  |  184 ++++++++++++++++++++++++++++++++++++++++---
>  5 files changed, 318 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 4168c88..6e3ae54 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -2,3 +2,6 @@
>  config CLKDEV_LOOKUP
>  	bool
>  	select HAVE_CLK
> +
> +config USE_COMMON_STRUCT_CLK
> +	bool
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 07613fa..a1a06d3 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -1,2 +1,3 @@
>  
>  obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.o
> +obj-$(CONFIG_USE_COMMON_STRUCT_CLK) += clk.o
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> new file mode 100644
> index 0000000..12e0daf
> --- /dev/null
> +++ b/drivers/clk/clk.c
> @@ -0,0 +1,134 @@
> +/*
> + * Copyright (C) 2010-2011 Canonical Ltd <jeremy.kerr@canonical.com>
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
> +int clk_prepare(struct clk *clk)
> +{
> +	int ret = 0;
> +
> +	if (!clk->ops->prepare)
> +		return 0;
> +
> +	mutex_lock(&clk->prepare_lock);
> +	if (clk->prepare_count == 0)
> +		ret = clk->ops->prepare(clk);
> +
> +	if (!ret)
> +		clk->prepare_count++;
> +	mutex_unlock(&clk->prepare_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(clk_prepare);
> +
> +void clk_unprepare(struct clk *clk)
> +{
> +	if (!clk->ops->unprepare)
> +		return;
> +
> +	mutex_lock(&clk->prepare_lock);
> +	if (--clk->prepare_count == 0)
> +		clk->ops->unprepare(clk);
> +
> +	mutex_unlock(&clk->prepare_lock);
> +}
> +EXPORT_SYMBOL_GPL(clk_unprepare);
> +
> +int clk_enable(struct clk *clk)
> +{
> +	int ret = 0;
> +
Did we want to check for prepare_count > 0 here?  Russell's suggestion
was to do that without holding any lock.
(To make this a tad safer, you could use
ACCESS_ONCE(clk->enable_count)++ below. (Suggested by paulmck on irc.))

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
