From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Nov 2015 11:51:19 +0000
Subject: [PATCH v6 1/6] arm/arm64: add smccc
In-Reply-To: <1446106888-8983-2-git-send-email-jens.wiklander@linaro.org>
References: <1446106888-8983-1-git-send-email-jens.wiklander@linaro.org>
 <1446106888-8983-2-git-send-email-jens.wiklander@linaro.org>
Message-ID: <20151102115119.GB29657@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

On Thu, Oct 29, 2015 at 09:21:23AM +0100, Jens Wiklander wrote:
> Adds helpers to do SMC and HVC based on ARM SMC Calling Convention.
> CONFIG_HAVE_SMCCC is enabled for architectures that may support
> the SMC or HVC instruction. It's the responsibility of the caller
> to know if the SMC instruction is supported by the platform.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  arch/arm/Kconfig               |  4 ++
>  arch/arm/kernel/Makefile       |  2 +
>  arch/arm/kernel/smccc-call.S   | 49 +++++++++++++++++++++
>  arch/arm/kernel/smccc.c        | 18 ++++++++
>  arch/arm64/Kconfig             |  4 ++
>  arch/arm64/kernel/Makefile     |  1 +
>  arch/arm64/kernel/smccc-call.S | 43 ++++++++++++++++++
>  arch/arm64/kernel/smccc.c      | 18 ++++++++
>  include/linux/arm-smccc.h      | 98 ++++++++++++++++++++++++++++++++++++++++++

This should probably be split so that the arm and arm64 patches can be
merged separately.

>  9 files changed, 237 insertions(+)
>  create mode 100644 arch/arm/kernel/smccc-call.S
>  create mode 100644 arch/arm/kernel/smccc.c
>  create mode 100644 arch/arm64/kernel/smccc-call.S
>  create mode 100644 arch/arm64/kernel/smccc.c
>  create mode 100644 include/linux/arm-smccc.h

[...]

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 72ad724..29ab16a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -226,6 +226,9 @@ config NEED_RET_TO_USER
>  config ARCH_MTD_XIP
>  	bool
>  
> +config HAVE_SMCCC
> +	bool

If you want this to be selectable by multiple arches, wouldn't it be
better to define it out in a common Kconfig file? Maybe HAVE_ARM_SMCCC
too, for some better namespacing.

An alternative is just making your TEE driver depend on ARM || ARM64
and providing dummy smc wrappers that return an error code for cores
older than ARMv7.

> diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
> new file mode 100644
> index 0000000..9098bd8
> --- /dev/null
> +++ b/arch/arm64/kernel/smccc-call.S
> @@ -0,0 +1,43 @@
> +/*
> + * Copyright (c) 2015, Linaro Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License Version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + */
> +#include <linux/linkage.h>
> +
> +#define SMC_RES_X0_OFFS	0
> +#define SMC_RES_X2_OFFS	16

These should be generates in asm-offsets.c

> +
> +/*
> + * void smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2,
> + *		  unsigned long a3, unsigned long a4, unsigned long a5,
> + *		  unsigned long a6, unsigned long a7, struct smccc_res *res)
> + */
> +ENTRY(smccc_smc)
> +	smc	#0
> +	ldr	x4, [sp]
> +	stp	x0, x1, [x4, #SMC_RES_X0_OFFS]
> +	stp	x2, x3, [x4, #SMC_RES_X2_OFFS]
> +	ret
> +ENDPROC(smccc_smc)
> +
> +/*
> + * void smccc_hvc(unsigned long a0, unsigned long a1, unsigned long a2,
> + *		  unsigned long a3, unsigned long a4, unsigned long a5,
> + *		  unsigned long a6, unsigned long a7, struct smccc_res *res)
> + */
> +ENTRY(smccc_hvc)
> +	hvc	#0
> +	ldr	x4, [sp]
> +	stp	x0, x1, [x4, #SMC_RES_X0_OFFS]
> +	stp	x2, x3, [x4, #SMC_RES_X2_OFFS]
> +	ret
> +ENDPROC(smccc_hvc)

Maybe you could generate both of these from an asm macro that takes the
first instruction as a parameter?

> diff --git a/arch/arm64/kernel/smccc.c b/arch/arm64/kernel/smccc.c
> new file mode 100644
> index 0000000..ed13ba3
> --- /dev/null
> +++ b/arch/arm64/kernel/smccc.c
> @@ -0,0 +1,18 @@
> +/*
> + * Copyright (c) 2015, Linaro Limited
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +#include <linux/export.h>
> +#include <linux/arm-smccc.h>
> +
> +EXPORT_SYMBOL_GPL(smccc_smc);
> +EXPORT_SYMBOL_GPL(smccc_hvc);

Again, I think you want an arm_ prefix for some better namespacing.

> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h

[...]

> +#define SMCCC_SMC_32			(0 << 30)
> +#define SMCCC_SMC_64			(1 << 30)
> +#define SMCCC_FAST_CALL			(1 << 31)
> +#define SMCCC_STD_CALL			(0 << 31)
> +
> +#define SMCCC_OWNER_MASK		0x3F
> +#define SMCCC_OWNER_SHIFT		24
> +
> +#define SMCCC_FUNC_MASK			0xFFFF
> +
> +#define SMCCC_IS_FAST_CALL(smc_val)	((smc_val) & SMCCC_FAST_CALL)
> +#define SMCCC_IS_64(smc_val)		((smc_val) & SMCCC_SMC_64)
> +#define SMCCC_FUNC_NUM(smc_val)		((smc_val) & SMCCC_FUNC_MASK)
> +#define SMCCC_OWNER_NUM(smc_val) \
> +	(((smc_val) >> SMCCC_OWNER_SHIFT) & SMCCC_OWNER_MASK)
> +
> +#define SMCCC_CALL_VAL(type, calling_convention, owner, func_num) \
> +			((type) | (calling_convention) | \
> +			(((owner) & SMCCC_OWNER_MASK) << SMCCC_OWNER_SHIFT) | \
> +			((func_num) & SMCCC_FUNC_MASK))
> +
> +#define SMCCC_OWNER_ARCH		0
> +#define SMCCC_OWNER_CPU			1
> +#define SMCCC_OWNER_SIP			2
> +#define SMCCC_OWNER_OEM			3
> +#define SMCCC_OWNER_STANDARD		4
> +#define SMCCC_OWNER_TRUSTED_APP		48
> +#define SMCCC_OWNER_TRUSTED_APP_END	49
> +#define SMCCC_OWNER_TRUSTED_OS		50
> +#define SMCCC_OWNER_TRUSTED_OS_END	63
> +
> +/**
> + * struct smccc_res - Result from SMC/HVC call
> + * @a0-a3 result values from registers 0 to 3
> + */
> +struct smccc_res {
> +	unsigned long a0;
> +	unsigned long a1;
> +	unsigned long a2;
> +	unsigned long a3;
> +};

Are there any endianness considerations for this structure?

Will
