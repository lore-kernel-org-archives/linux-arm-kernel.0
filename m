From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Nov 2011 18:52:16 +0000
Subject: [PATCH 1/4] [RFC] Add generic ARM instruction set condition code
 checks.
In-Reply-To: <20111121183046.28964.23829.stgit@localhost6.localdomain6>
References: <20111121183046.28964.23829.stgit@localhost6.localdomain6>
Message-ID: <20111121185216.GK20611@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leif,

On Mon, Nov 21, 2011 at 06:30:46PM +0000, Leif Lindholm wrote:
> This patch breaks the ARM condition checking code out of nwfpe/fpopcode.{ch}
> into a standalone file for opcode operations. It also modifies the code
> somwhat for coding style adherence, and adds some temporary variables for
> increased readability.

s/somwhat/somewhat/

> diff --git a/arch/arm/kernel/opcodes.c b/arch/arm/kernel/opcodes.c
> new file mode 100644
> index 0000000..8adc20c
> --- /dev/null
> +++ b/arch/arm/kernel/opcodes.c
> @@ -0,0 +1,61 @@
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
> +#include <asm/opcodes.h>
> +
> +#define ARM_OPCODE_UNCONDITIONAL 0xf

Maybe ARM_OPCODE_CONDITION_UNCOND or something (in case we decide to put
more opcodes in here).

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
> + * 0 - if condition fails
> + * 1 - if condition passes (including AL)
> + * 2 - if unconditional encoding (or before ARMv3, NV condition)

Can you #define these in the header file please? You'll need to make sure
they're available to assembly code too.

> + * Code that needs to check whether a condition has explicitly passed,
> + * should compare the return value to 1.
> + * Code that wants to check if a condition means that the instruction
> + * should be executed, should compare the return value to !0.
> + */
> +unsigned int arm_check_condition(unsigned int opcode, unsigned int psr)

Why not just return int?

> +{
> +	unsigned int cc_bits  = opcode >> 28;
> +	unsigned int psr_cond = psr >> 28;
> +
> +	/* NV condition or unconditional */
> +	if (cc_bits == ARM_OPCODE_UNCONDITIONAL)
> +		return 2;
> +
> +	return (cc_map[cc_bits] >> (psr_cond)) & 1;
> +}

Then you can use the new defines here.

Will
