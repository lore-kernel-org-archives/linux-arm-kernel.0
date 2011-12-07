From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 7 Dec 2011 12:30:19 -0500 (EST)
Subject: [PATCH] ARM: Add generic instruction opcode manipulation helpers
In-Reply-To: <1323278661-29195-1-git-send-email-dave.martin@linaro.org>
References: <1323278661-29195-1-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.02.1112071229580.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Dec 2011, Dave Martin wrote:

> This patch adds some endianness-agnostic helpers to convert machine
> instructions between canonical integer form and in-memory
> representation.
> 
> A canonical integer form for representing instructions is also
> formalised here.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
> Changes since RFC:
> 
> v1: Delete the unnecessarily heavyweight instruction read/write macros.
>     After discussion, it seems that these weren't likely to be very
>     useful.
> 
>  arch/arm/include/asm/opcodes.h |   70 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 70 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/include/asm/opcodes.h
> 
> diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
> new file mode 100644
> index 0000000..bb70898
> --- /dev/null
> +++ b/arch/arm/include/asm/opcodes.h
> @@ -0,0 +1,70 @@
> +/*
> + * arch/arm/include/asm/opcodes.h
> + *
> + * Copyright (C) 2011 Linaro Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +#ifndef __ARM_OPCODES_H
> +#define __ARM_OPCODES_H
> +
> +#include <linux/types.h>
> +#include <linux/swab.h>
> +
> +typedef u32 arm_opcode_t;
> +
> +/*
> + * Canonical instruction representation (arm_opcode_t):
> + *
> + *	ARM:		0xKKLLMMNN
> + *	Thumb 16-bit:	0x0000KKLL, where KK < 0xE8
> + *	Thumb 32-bit:	0xKKLLMMNN, where KK >= 0xE8
> + *
> + * There is no way to distinguish an ARM instruction in canonical representation
> + * from a Thumb instruction (just as these cannot be distinguished in memory).
> + * Where this distinction is important, it needs to be tracked separately.
> + *
> + * Note that values in the range 0x0000E800..0xE7FFFFFF intentionally do not
> + * represent any valid Thumb-2 instruction.  For this range,
> + * __opcode_is_thumb32() and __opcode_is_thumb16() will both be false.
> + */
> +
> +#ifdef CONFIG_CPU_ENDIAN_BE8
> +#define __opcode_to_mem_arm(x) swab32(x)
> +#define __opcode_to_mem_thumb16(x) swab16(x)
> +#define __opcode_to_mem_thumb32(x) swahb32(x)
> +#else
> +#define __opcode_to_mem_arm(x) (x) ((u32)(x))
> +#define __opcode_to_mem_thumb16(x) ((u16)(x))
> +#define __opcode_to_mem_thumb32(x) swahw32(x)
> +#endif
> +
> +#define __mem_to_opcode_arm(x) __opcode_to_mem_arm(x)
> +#define __mem_to_opcode_thumb16(x) __opcode_to_mem_thumb16(x)
> +#define __mem_to_opcode_thumb32(x) __opcode_to_mem_thumb32(x)
> +
> +/* Operations specific to Thumb opcodes */
> +
> +/* Instruction size checks: */
> +#define __opcode_is_thumb32(x) ((u32)(x) >= 0xE8000000UL)
> +#define __opcode_is_thumb16(x) ((u32)(x) < 0xE800UL)
> +
> +/* Operations to construct or split 32-bit Thumb instructions: */
> +#define __opcode_thumb32_first(x) ((u16)((thumb_opcode) >> 16))
> +#define __opcode_thumb32_second(x) ((u16)(thumb_opcode))
> +#define __opcode_thumb32_compose(first, second) \
> +	(((u32)(u16)(first) << 16) | (u32)(u16)(second))
> +
> +#endif /* ! __ARM_OPCODES_H */
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
