From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 10 Mar 2012 11:51:36 +0100 (CET)
Subject: [PATCH v6 2/3] clk: introduce the common clock framework
In-Reply-To: <1331366064-1273-3-git-send-email-mturquette@linaro.org>
References: <1331366064-1273-1-git-send-email-mturquette@linaro.org>
 <1331366064-1273-3-git-send-email-mturquette@linaro.org>
Message-ID: <alpine.LFD.2.02.1203101128100.2742@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Mar 2012, Mike Turquette wrote:
> +inline unsigned long __clk_get_enable_count(struct clk *clk)
> +{
> +	return !clk ? -EINVAL : clk->enable_count;

Returning negative error codes in a function with a return value
unsigned long is a bit strange at least. Shouldn't that be long ?

> +#ifndef __LINUX_CLK_PRIVATE_H
> +#define __LINUX_CLK_PRIVATE_H
> +
> +#include <linux/clk-provider.h>
> +#include <linux/list.h>
> +
> +/*
> + * WARNING: Do not include clk-private.h from any file that implements struct
> + * clk_ops.  Doing so is a layering violation!
> + *
> + * This header exists only to allow for statically initialized clock data.  Any
> + * static clock data must be defined in a separate file from the logic that
> + * implements the clock operations for that same data.

Now the question is whether you should provide a data structure which
is explicitely used for static initialization and instead of having
struct clk static you register the static initializer structure, which
would be initdata. I don't think that anything needs clocks before the
memory allocators are up and running. The clocks which are necessary
to get that far have to be enabled in the boot loader anyway.

The static initialization question should not hold off this set from
being merged, though settling it before growing users would be nice.

Otherwise this is a very well done infrastructure implementation!
Thanks a lot Mike!

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
