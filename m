From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Dec 2011 15:36:49 +0000
Subject: [PATCH 1/4] Add generic ARM instruction set condition code checks.
In-Reply-To: <20111208173138.7572.48841.stgit@localhost6.localdomain6>
References: <20111208173100.7572.9099.stgit@localhost6.localdomain6>
 <20111208173138.7572.48841.stgit@localhost6.localdomain6>
Message-ID: <20111209153649.GH5196@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leif,

This looks largely there, but I have some small comments inline.

On Thu, Dec 08, 2011 at 05:31:43PM +0000, Leif Lindholm wrote:
> diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
> new file mode 100644
> index 0000000..aea97bf
> --- /dev/null
> +++ b/arch/arm/include/asm/opcodes.h
> @@ -0,0 +1,20 @@
> +/*
> + *  arch/arm/include/asm/opcodes.h
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_ARM_OPCODES_H
> +#define __ASM_ARM_OPCODES_H
> +
> +#ifndef __ASSEMBLY__
> +extern unsigned int arm_check_condition(unsigned int opcode, unsigned int psr);
> +#endif

You could use u32 for the parameters to reinforce the point that they're
words.

> diff --git a/arch/arm/kernel/opcodes.c b/arch/arm/kernel/opcodes.c
> new file mode 100644
> index 0000000..ad966fe
> --- /dev/null
> +++ b/arch/arm/kernel/opcodes.c
> @@ -0,0 +1,69 @@
> +/*
> + *  linux/arch/arm/kernel/opcodes.c
> + *
> + *  A32 condition code lookup feature moved from nwfpe/fpopcode.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <asm/opcodes.h>
> +
> +#define ARM_OPCODE_CONDITION_UNCOND 0xf
> +
> +/*
> + * condition code lookup table
> + * index into the table is test code: EQ, NE, ... LT, GT, AL, NV
> + *
> + * bit position in short is condition code: NZCV
> + */
> +static const unsigned short cc_map[16] = {
> +	0xF0F0,			/* EQ == Z set            */
> +	0x0F0F,			/* NE                     */
> +	0xCCCC,			/* CS == C set            */
> +	0x3333,			/* CC                     */
> +	0xFF00,			/* MI == N set            */
> +	0x00FF,			/* PL                     */
> +	0xAAAA,			/* VS == V set            */
> +	0x5555,			/* VC                     */
> +	0x0C0C,			/* HI == C set && Z clear */
> +	0xF3F3,			/* LS == C clear || Z set */
> +	0xAA55,			/* GE == (N==V)           */
> +	0x55AA,			/* LT == (N!=V)           */
> +	0x0A05,			/* GT == (!Z && (N==V))   */
> +	0xF5FA,			/* LE == (Z || (N!=V))    */
> +	0xFFFF,			/* AL always              */
> +	0			/* NV                     */
> +};
> +
> +/*
> + * Returns:
> + * ARM_OPCODE_CONDTEST_FAIL   - if condition fails
> + * ARM_OPCODE_CONDTEST_PASS   - if condition passes (including AL)
> + * ARM_OPCODE_CONDTEST_UNCOND - if NV condition, or separate unconditional
> + *                              opcode space from v5 onwards
> + *
> + * Code that tests whether a conditional instruction would pass its condition
> + * check should check that return value == ARM_OPCODE_CONDTEST_PASS.
> + *
> + * Code that tests if a condition means that the instruction would be executed
> + * (regardless of conditional or unconditional) should instead check that the
> + * return value != ARM_OPCODE_CONDTEST_FAIL.
> + */
> +unsigned int arm_check_condition(unsigned int opcode, unsigned int psr)

I think you want asmlinkage for this function.

> +{
> +	unsigned int cc_bits  = opcode >> 28;
> +	unsigned int psr_cond = psr >> 28;
> +
> +	if (cc_bits != ARM_OPCODE_CONDITION_UNCOND) {
> +		if ((cc_map[cc_bits] >> (psr_cond)) & 1)
> +			return ARM_OPCODE_CONDTEST_PASS;
> +		else
> +			return ARM_OPCODE_CONDTEST_FAIL;
> +	} else {
> +		return ARM_OPCODE_CONDTEST_UNCOND;
> +	}
> +}

Maybe have a single return here returning a ret value which you assign in
the conditional blocks.

> +EXPORT_SYMBOL(arm_check_condition);

EXPORT_SYMBOL_GPL?

Will
