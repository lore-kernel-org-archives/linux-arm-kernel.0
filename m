From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Oct 2010 20:33:09 +0200
Subject: [PATCH v2] i.MX31 and i.MX35 : fix errate TLSbo65953 and
	ENGcm09472
In-Reply-To: <1286280012-19809-1-git-send-email-eric@eukrea.com>
References: <20101005094510.GJ28242@pengutronix.de>
	<1286280012-19809-1-git-send-email-eric@eukrea.com>
Message-ID: <20101005183308.GX11737@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric,

On Tue, Oct 05, 2010 at 02:00:12PM +0200, Eric B?nard wrote:
> Without this exiting WFI can result in cache corruption.
> Code taken from Freescale's 2.6.27 BSP and tested on i.MX35
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
> v2 : use cpu_ismx3x() and add comments.
> 
>  arch/arm/plat-mxc/include/mach/system.h |   32 ++++++++++++++++++++++++++++--
>  1 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/system.h b/arch/arm/plat-mxc/include/mach/system.h
> index 4acd114..70e66d3 100644
> --- a/arch/arm/plat-mxc/include/mach/system.h
> +++ b/arch/arm/plat-mxc/include/mach/system.h
> @@ -1,7 +1,7 @@
>  /*
>   *  Copyright (C) 1999 ARM Limited
>   *  Copyright (C) 2000 Deep Blue Solutions Ltd
> - *  Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
> + *  Copyright 2004-2008 Freescale Semiconductor, Inc. All Rights Reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -28,8 +28,34 @@ static inline void arch_idle(void)
>  		mxc91231_prepare_idle();
>  	}
>  #endif
> -
> -	cpu_do_idle();
> +	/* fix i.MX31 errata TLSbo65953 and i.MX35 errata ENGcm09472 */
> +	if (cpu_is_mx31() || cpu_is_mx35()) {
> +		unsigned long reg = 0;
> +		__asm__ __volatile__(
> +			/* disable I and D cache */
> +			"mrc p15, 0, %0, c1, c0, 0\n"
> +			"bic %0, %0, #0x00001000\n"
> +			"bic %0, %0, #0x00000004\n"
> +			"mcr p15, 0, %0, c1, c0, 0\n"
> +			/* invalidate I cache */
> +			"mov %0, #0\n"
> +			"mcr p15, 0, %0, c7, c5, 0\n"
> +			/* clear and invalidate D cache */
> +			"mov %0, #0\n"
mcr doesn't change the value of %0, does it?  Then there's no need to
set it to 0 once more.

> +			"mcr p15, 0, %0, c7, c14, 0\n"
> +			/* WFI */
> +			"mov %0, #0\n"
ditto

> +			"mcr p15, 0, %0, c7, c0, 4\n"
> +			"nop\n" "nop\n" "nop\n" "nop\n"
> +			"nop\n" "nop\n" "nop\n"
> +			/* enable I and D cache */
> +			"mrc p15, 0, %0, c1, c0, 0\n"
If you spend two registers there is no need to reread this register.

> +			"orr %0, %0, #0x00001000\n"
> +			"orr %0, %0, #0x00000004\n"
> +			"mcr p15, 0, %0, c1, c0, 0\n"
> +			:: "r" (reg));
... and the s/:: "/: "=/ as I suggested earlier.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
