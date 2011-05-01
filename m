From: robherring2@gmail.com (Rob Herring)
Date: Sun, 01 May 2011 15:33:57 -0500
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4DBDC3B5.7070808@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jeremy,

On 04/15/2011 02:08 PM, Sascha Hauer wrote:
> From: Jeremy Kerr<jeremy.kerr@canonical.com>
>
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
> Herrenschmidt<benh@kernel.crashing.org>.
>
> Signed-off-by: Jeremy Kerr<jeremy.kerr@canonical.com>
> Signed-off-by: Uwe Kleine-K?nig<u.kleine-koenig@pengutronix.de>
> ---
>   drivers/clk/Kconfig  |    3 +
>   drivers/clk/Makefile |    1 +
>   drivers/clk/clk.c    |  132 ++++++++++++++++++++++++++++++++++++++++
>   drivers/clk/clkdev.c |    7 ++
>   include/linux/clk.h  |  164 +++++++++++++++++++++++++++++++++++++++++++++++---
>   5 files changed, 298 insertions(+), 9 deletions(-)
>   create mode 100644 drivers/clk/clk.c
>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 4168c88..6e3ae54 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -2,3 +2,6 @@
>   config CLKDEV_LOOKUP
>   	bool
>   	select HAVE_CLK
> +
> +config USE_COMMON_STRUCT_CLK
> +	bool
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 07613fa..a1a06d3 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -1,2 +1,3 @@
>
>   obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.o
> +obj-$(CONFIG_USE_COMMON_STRUCT_CLK) += clk.o
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> new file mode 100644
> index 0000000..0bc9c6f
> --- /dev/null
> +++ b/drivers/clk/clk.c
> @@ -0,0 +1,132 @@
> +/*
> + * Copyright (C) 2010-2011 Canonical Ltd<jeremy.kerr@canonical.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Standard functionality for the common clock API.
> + */
> +
> +#include<linux/clk.h>
> +#include<linux/module.h>
> +
> +int clk_prepare(struct clk *clk)
> +{
> +	int ret = 0;
> +

Shouldn't all these functions have some clk pointer checks:

	if (IS_ERR_OR_NULL(clk))
		return -EINVAL;


Rob
