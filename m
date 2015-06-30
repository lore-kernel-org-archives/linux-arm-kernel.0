From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Jun 2015 17:01:18 +0100
Subject: [PATCH] XOR implementation for ARMv8
In-Reply-To: <463b2fe9.7d02.14e245e3541.Coremail.liuxiaodong@nudt.edu.cn>
References: <463b2fe9.7d02.14e245e3541.Coremail.liuxiaodong@nudt.edu.cn>
Message-ID: <20150630160117.GQ27725@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 24, 2015 at 08:00:30AM +0100, ??? wrote:
> diff -pruN -X dontdiff linux-4.0.5-orig/arch/arm64/lib/xor.S linux-4.0.5-mod/arch/arm64/lib/xor.S
> --- linux-4.0.5-orig/arch/arm64/lib/xor.S       1970-01-01 08:00:00.000000000 +0800
> +++ linux-4.0.5-mod/arch/arm64/lib/xor.S        2015-06-24 09:25:49.969256540 +0800
> @@ -0,0 +1,228 @@
> +/*
> + * arch/arm64/lib/xor.S
> + *
> + * Copyright (C) Xiaodong Liu <liuxiaodong@nudt.edu.cn>, Changsha, P.R. China
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +.macro xor_vectorregs16
> +    eor v24.16b, v24.16b, v16.16b
> +    eor v25.16b, v25.16b, v17.16b
> +    eor v26.16b, v26.16b, v18.16b
> +    eor v27.16b, v27.16b, v19.16b
> +    eor v28.16b, v28.16b, v20.16b
> +    eor v29.16b, v29.16b, v21.16b
> +    eor v30.16b, v30.16b, v22.16b
> +    eor v31.16b, v31.16b, v23.16b
> +.endm
> +
> +.align 4
> +
> +/*
> + * void xor_arm64ldpregs16_2(unsigned long size, unsigned long * dst, unsigned long *src);
> + *
> + * Parameters:
> + *     x0 - size
> + *     x1 - dst
> + *     x2 - src
> + */
> +ENTRY(xor_arm64ldpregs16_2)
> +
> +    lsr x0, x0, #10
> +
> +.p2align 4
> +Loop23:
> +    ldp q16, q17, [x2], #32
> +    ldp q18, q19, [x2], #32
> +    ldp q20, q21, [x2], #32
> +    ldp q22, q23, [x2], #32

Have you tried using immediate offsets instead of post-index addressing?
E.g.

	ldp q16, q17, [x2]
	ldp q18, q19, [x2, #32], #32
	ldp q20, q21, [x2, #64], #32
	ldp q22, q23, [x2, #96]
	add x2, x2, #128

Will
