From: robherring2@gmail.com (Rob Herring)
Date: Thu, 07 Jun 2012 19:33:50 -0500
Subject: [PATCH v2] ARM: highbank: Add smc calls to enable/disable the L2
In-Reply-To: <1339021210-25970-1-git-send-email-robherring2@gmail.com>
References: <1338865900-11373-1-git-send-email-robherring2@gmail.com>
 <1339021210-25970-1-git-send-email-robherring2@gmail.com>
Message-ID: <4FD1486E.9080409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2012 05:20 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Linux runs in non-secure mode on highbank, so we need secure monitor calls
> to enable and disable the PL310. Rather than invent new smc calls, the same
> calling convention used by OMAP is used here.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Arnd, Olof,

Can you apply this fix for 3.5. It's needed to enable the L2 on highbank.

Rob

> ---
> v2:
>  - Only save registers required by ARM ABI
> 
>  arch/arm/mach-highbank/Makefile   |    6 +++++-
>  arch/arm/mach-highbank/core.h     |    1 +
>  arch/arm/mach-highbank/highbank.c |   14 ++++++++++++++
>  arch/arm/mach-highbank/smc.S      |   27 +++++++++++++++++++++++++++
>  4 files changed, 47 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-highbank/smc.S
> 
> diff --git a/arch/arm/mach-highbank/Makefile b/arch/arm/mach-highbank/Makefile
> index f8437dd..ded4652 100644
> --- a/arch/arm/mach-highbank/Makefile
> +++ b/arch/arm/mach-highbank/Makefile
> @@ -1,4 +1,8 @@
> -obj-y					:= clock.o highbank.o system.o
> +obj-y					:= clock.o highbank.o system.o smc.o
> +
> +plus_sec := $(call as-instr,.arch_extension sec,+sec)
> +AFLAGS_smc.o				:=-Wa,-march=armv7-a$(plus_sec)
> +
>  obj-$(CONFIG_DEBUG_HIGHBANK_UART)	+= lluart.o
>  obj-$(CONFIG_SMP)			+= platsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
> diff --git a/arch/arm/mach-highbank/core.h b/arch/arm/mach-highbank/core.h
> index d8e2d0b..141ed51 100644
> --- a/arch/arm/mach-highbank/core.h
> +++ b/arch/arm/mach-highbank/core.h
> @@ -8,3 +8,4 @@ extern void highbank_lluart_map_io(void);
>  static inline void highbank_lluart_map_io(void) {}
>  #endif
>  
> +extern void highbank_smc1(int fn, int arg);
> diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> index 410a112..8777612 100644
> --- a/arch/arm/mach-highbank/highbank.c
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -85,10 +85,24 @@ const static struct of_device_id irq_match[] = {
>  	{}
>  };
>  
> +#ifdef CONFIG_CACHE_L2X0
> +static void highbank_l2x0_disable(void)
> +{
> +	/* Disable PL310 L2 Cache controller */
> +	highbank_smc1(0x102, 0x0);
> +}
> +#endif
> +
>  static void __init highbank_init_irq(void)
>  {
>  	of_irq_init(irq_match);
> +
> +#ifdef CONFIG_CACHE_L2X0
> +	/* Enable PL310 L2 Cache controller */
> +	highbank_smc1(0x102, 0x1);
>  	l2x0_of_init(0, ~0UL);
> +	outer_cache.disable = highbank_l2x0_disable;
> +#endif
>  }
>  
>  static void __init highbank_timer_init(void)
> diff --git a/arch/arm/mach-highbank/smc.S b/arch/arm/mach-highbank/smc.S
> new file mode 100644
> index 0000000..407d17b
> --- /dev/null
> +++ b/arch/arm/mach-highbank/smc.S
> @@ -0,0 +1,27 @@
> +/*
> + * Copied from omap44xx-smc.S Copyright (C) 2010 Texas Instruments, Inc.
> + * Copyright 2012 Calxeda, Inc.
> + *
> + * This program is free software,you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/linkage.h>
> +
> +/*
> + * This is common routine to manage secure monitor API
> + * used to modify the PL310 secure registers.
> + * 'r0' contains the value to be modified and 'r12' contains
> + * the monitor API number.
> + * Function signature : void highbank_smc1(u32 fn, u32 arg)
> + */
> +
> +ENTRY(highbank_smc1)
> +	stmfd   sp!, {r4-r11, lr}
> +	mov	r12, r0
> +	mov 	r0, r1
> +	dsb
> +	smc	#0
> +	ldmfd   sp!, {r4-r11, pc}
> +ENDPROC(highbank_smc1)
