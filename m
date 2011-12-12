From: robherring2@gmail.com (Rob Herring)
Date: Mon, 12 Dec 2011 16:39:38 -0600
Subject: [PATCH 2/5] ARM: picoxcell: don't reserve irq_descs
In-Reply-To: <1323726414-3319-3-git-send-email-jamie@jamieiles.com>
References: <1323726414-3319-1-git-send-email-jamie@jamieiles.com>
 <1323726414-3319-3-git-send-email-jamie@jamieiles.com>
Message-ID: <4EE682AA.2020700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2011 03:46 PM, Jamie Iles wrote:
> All irq_desc's are now dynamically allocated so we don't need to
> statically reserve them.
> 
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
>  arch/arm/mach-picoxcell/common.c            |    1 -
>  arch/arm/mach-picoxcell/include/mach/irqs.h |    9 ++-------
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
> index ad871bd..7d91165 100644
> --- a/arch/arm/mach-picoxcell/common.c
> +++ b/arch/arm/mach-picoxcell/common.c
> @@ -45,7 +45,6 @@ static void __init picoxcell_init_irq(void)
>  
>  DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
>  	.map_io		= picoxcell_map_io,
> -	.nr_irqs	= ARCH_NR_IRQS,

You should probably should set this to NR_IRQS_LEGACY (16) to skip irq 0
and ISA irqs.

>  	.init_irq	= picoxcell_init_irq,
>  	.handle_irq	= vic_handle_irq,
>  	.timer		= &picoxcell_timer,
> diff --git a/arch/arm/mach-picoxcell/include/mach/irqs.h b/arch/arm/mach-picoxcell/include/mach/irqs.h
> index 4d13ed9..59eac1e 100644
> --- a/arch/arm/mach-picoxcell/include/mach/irqs.h
> +++ b/arch/arm/mach-picoxcell/include/mach/irqs.h
> @@ -1,8 +1,6 @@
>  /*
>   * Copyright (c) 2011 Picochip Ltd., Jamie Iles
>   *
> - * This file contains the hardware definitions of the picoXcell SoC devices.
> - *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; either version 2 of the License, or
> @@ -16,10 +14,7 @@
>  #ifndef __MACH_IRQS_H
>  #define __MACH_IRQS_H
>  
> -#define ARCH_NR_IRQS			64
> -#define NR_IRQS				(128 + ARCH_NR_IRQS)
> -
> -#define IRQ_VIC0_BASE			0
> -#define IRQ_VIC1_BASE			32
> +/* We dynamically allocate our irq_desc's. */
> +#define NR_IRQS				0

Are you selecting SPARSE_IRQ?

Rob
