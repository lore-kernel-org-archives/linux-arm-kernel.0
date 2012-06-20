From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 20 Jun 2012 11:59:32 +0100
Subject: [PATCH] ARM: EXYNOS: Add smc call to support trustzone feature
In-Reply-To: <20120611090440.GA27207@july>
References: <20120611090440.GA27207@july>
Message-ID: <20120620105932.GB2179@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 06:04:40PM +0900, Kyungmin Park wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Linux runs in non-secure mode on some boards, so we need secure monitor calls
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
> index 9b58024..d3ec71c 100644
> --- a/arch/arm/mach-exynos/Makefile
> +++ b/arch/arm/mach-exynos/Makefile
> @@ -30,6 +30,11 @@ obj-$(CONFIG_EXYNOS4_MCT)	+= mct.o
>  
>  obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
>  
> +obj-$(CONFIG_ARM_TRUSTZONE)	+= exynos-smc.o
> +
> +plus_sec := $(call as-instr,.arch_extension sec,+sec)
> +AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
> +

If we can get DT bindings to say what the firmware is present, then
this can be decided at run-time (see the other thread), allowing a
single kernel to boot on boards deployed either with or without the
firmware.

Also, CONFIG_ARM_TRUSTZONE is probably not a good name: the issue here
is not whether TrustZone is present, but what firmware (if any) is
accessible via the SMC instruction.

Cheers
---Dave

>  # machine support
>  
>  obj-$(CONFIG_MACH_SMDKC210)		+= mach-smdkv310.o
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index aed2eeb..d3e2f29 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -21,6 +21,9 @@ void exynos4_restart(char mode, const char *cmd);
>  void exynos5_restart(char mode, const char *cmd);
>  void exynos_init_late(void);
>  
> +extern void exynos_smc(u32 cmd, u32 arg1, u32 arg2, u32 arg3);
> +extern u32 exynos_smc_readsfr(u32 addr, u32 *val);
> +
>  #ifdef CONFIG_PM_GENERIC_DOMAINS
>  int exynos_pm_late_initcall(void);
>  #else
> diff --git a/arch/arm/mach-exynos/exynos-smc.S b/arch/arm/mach-exynos/exynos-smc.S
> new file mode 100644
> index 0000000..2ef8f59
> --- /dev/null
> +++ b/arch/arm/mach-exynos/exynos-smc.S
> @@ -0,0 +1,46 @@
> +/*
> + * Copyright (C) 2012 Samsung Electronics.
> + *
> + * Copied from omap-smc.S Copyright (C) 2010 Texas Instruments, Inc.
> + *
> + * This program is free software,you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/linkage.h>
> +
> +/*
> + * Function signature: void exynos_smc(u32 cmd, u32 arg1, u32 arg2, u32 arg3)
> + */
> +
> +ENTRY(exynos_smc)
> +	stmfd	sp!, {r4-r11, lr}
> +	dsb
> +	smc	#0
> +	ldmfd	sp!, {r4-r11, pc}
> +ENDPROC(exynos_smc)
> +
> +/*
> + * Read registers
> + * Function signature: u32 exynos_smc_readsfr(u32 addr, u32 *val)
> + */
> +ENTRY(exynos_smc_readsfr)
> +	stmfd	sp!, {r4-r11, lr}
> +	mov	r2, #0
> +	lsr	r0, r0, #2
> +	mov	ip, r1
> +	mov	r3, r2
> +	orr	r1, r0, #0xC0000000
> +	mvn	r0, #100
> +	dsb
> +	smc	#0
> +	cmn	r0, #101
> +	beq	1f
> +	cmp	r0, #0
> +	streq	r2, [ip]
> +	ldmfd	sp!, {r4-r11, pc}
> +1:	subs	r0, r1, #0
> +	streq	r2, [ip]
> +	ldmfd	sp!, {r4-r11, pc}
> +ENDPROC(exynos_smc_readsfr)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
