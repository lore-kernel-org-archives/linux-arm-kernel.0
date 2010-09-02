From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 14:06:14 +0100
Subject: [RFC] [PATCH v2] arm & sh: factorised duplicated clkdev.c
In-Reply-To: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
References: <1283253402-3139-1-git-send-email-plagnioj@jcrosoft.com>
	<1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20100902130614.GC26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 02:48:36PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> diff --git a/arch/arm/include/asm/clkdev.h b/arch/arm/include/asm/clkdev.h
> index b56c138..1293780 100644
> --- a/arch/arm/include/asm/clkdev.h
> +++ b/arch/arm/include/asm/clkdev.h
> @@ -1,5 +1,5 @@
>  /*
> - *  arch/arm/include/asm/clkdev.h
> + *  arch/arm/include/linux/clkdev.h

?

> +/*
> + * Returns a clock. Note that we first try to use device id on the bus
> + * and clock name. If this fails, we try to use clock name only.
> + */

This comment is actually wrong, and conflicts with the commentry against
clk_find(), which describes completely how clocks are found.  Therefore,
this comment should be deleted.

> diff --git a/arch/sh/include/asm/clkdev.h b/include/linux/clkdev.h
> similarity index 85%
> rename from arch/sh/include/asm/clkdev.h
> rename to include/linux/clkdev.h
> index 5645f35..bd2ec89 100644
> --- a/arch/sh/include/asm/clkdev.h
> +++ b/include/linux/clkdev.h
> @@ -1,7 +1,5 @@
>  /*
> - *  arch/sh/include/asm/clkdev.h
> - *
> - * Cloned from arch/arm/include/asm/clkdev.h:
> + *  include/linux/clkdev.h
>   *
>   *  Copyright (C) 2008 Russell King.
>   *
> @@ -11,8 +9,10 @@
>   *
>   * Helper for the clk API to assist looking up a struct clk.
>   */
> -#ifndef __ASM_CLKDEV_H
> -#define __ASM_CLKDEV_H
> +#ifndef __CLKDEV_H
> +#define __CLKDEV_H
> +
> +#include <asm/clkdev.h>
>  
>  struct clk;
>  

This should really be a clone of the ARM version of clkdev.h - the sh
version misses the predeclaration of 'struct device' which is required
for the function prototypes in this file.
