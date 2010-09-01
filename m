From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Sep 2010 11:01:55 +0100
Subject: [RFC] [PATCH] arm & sh: factorised duplicated clkdev.c
In-Reply-To: <1283253402-3139-1-git-send-email-plagnioj@jcrosoft.com>
References: <1283253402-3139-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20100901100155.GN8142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 31, 2010 at 01:16:42PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> diff --git a/arch/arm/include/asm/lookup_clkdev.h b/arch/arm/include/asm/lookup_clkdev.h
> new file mode 100644
> index 0000000..d57f7a6
> --- /dev/null
> +++ b/arch/arm/include/asm/lookup_clkdev.h
> @@ -0,0 +1,23 @@
> +/*
> + *  arch/arm/common/clkdev.c
> + *
> + *  Copyright (C) 2008 Russell King.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Helper for the clk API to assist looking up a struct clk.
> + */
> +
> +#ifndef __LOOKUP_CLK_DEV__
> +#define __LOOKUP_CLK_DEV__
> +
> +#include <mach/clkdev.h>
> +
> +static __inline__ struct clk_lookup_alloc *arch_kzalloc(size_t size)

No need to use __inline__ here - use inline instead.

> +static __inline__ struct clk_lookup_alloc *arch_kzalloc(size_t size)

Ditto.

> @@ -120,12 +124,12 @@ struct clk_lookup_alloc {
>  	char	con_id[MAX_CON_ID];
>  };
>  
> -struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
> -	const char *dev_fmt, ...)
> +struct clk_lookup * __init_refok
> +clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)

This looks like a nasty hack to get around the problem of calling a
boot-time only allocator - but I guess given what sh is doing we don't
have much choice here.

The choice of 'arch_kzalloc' is imho very poor - it potentially could
clash with some other use.  Maybe __clkdev_alloc() instead?
