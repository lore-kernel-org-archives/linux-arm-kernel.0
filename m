From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 18 Apr 2011 15:40:06 -0700
Subject: [PATCH 05/10] clk: Add support for simple dividers
In-Reply-To: <1302894495-6879-6-git-send-email-s.hauer@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-6-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4DACBDC6.2000500@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just minor nitpicks.

On 04/15/2011 12:08 PM, Sascha Hauer wrote:
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> new file mode 100644
> index 0000000..2de94df
> --- /dev/null
> +++ b/drivers/clk/clk-divider.c
> @@ -0,0 +1,132 @@
> +/*
> + * Copyright (C) 2011 Sascha Hauer <s.hauer@pengutronix.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Standard functionality for the common clock API.
> + */
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#define to_clk_divider(clk) (container_of(clk, struct clk_divider, clk))

Can you make this a static inline function with actual types? We get
slightly more type safety that way. Ditto for similar constructs in this
series.

> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index d014341..6f9771b 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -180,6 +180,37 @@ unsigned long clk_parent_get_rate(struct clk *clk);
>  long clk_parent_round_rate(struct clk *clk, unsigned long rate);
>  int clk_parent_set_rate(struct clk *clk, unsigned long rate);
>  
> +/**
> + * clock divider
> + *
> + * @clk		clock source
> + * @reg		register containing the divider
> + * @shift	shift to the divider
> + * @width	width of the divider
> + * @lock	register lock
> + * @parent	parent clock
> + *
> + * This clock implements get_rate/set_rate/round_rate. prepare/unprepare and
> + * enable/disable are passed through to the parent.
> + *
> + * The divider is calculated as div = reg_val + 1
> + * or if CLK_DIVIDER_FLAG_ONE_BASED is set as div = reg_val
> + * (with reg_val == 0 considered invalid)
> + */

This isn't kernel-doc notation. See Documentation/kernel-doc-nano-HOWTO.txt

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
