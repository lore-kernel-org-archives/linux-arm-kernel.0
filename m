From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Apr 2014 11:24:55 +0100
Subject: [PATCH v3] arm64: enable EDAC on arm64
In-Reply-To: <1398096556-26799-1-git-send-email-robherring2@gmail.com>
References: <1398096556-26799-1-git-send-email-robherring2@gmail.com>
Message-ID: <20140422102455.GD7484@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Mon, Apr 21, 2014 at 05:09:16PM +0100, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> Implement atomic_scrub and enable EDAC for arm64.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

[...]

> diff --git a/arch/arm64/include/asm/edac.h b/arch/arm64/include/asm/edac.h
> new file mode 100644
> index 0000000..8a3d176
> --- /dev/null
> +++ b/arch/arm64/include/asm/edac.h
> @@ -0,0 +1,38 @@
> +/*
> + * Copyright 2013 Calxeda, Inc.
> + * Based on PPC version Copyright 2007 MontaVista Software, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +#ifndef ASM_EDAC_H
> +#define ASM_EDAC_H
> +/*
> + * ECC atomic, DMA, SMP and interrupt safe scrub function.

What do you mean by `DMA safe'? For coherent (cacheable) DMA buffers, this
should work fine, but for non-coherent (and potentially non-cacheable)
buffers, I think we'll have problems both due to the lack of guaranteed
exclusive monitor support and also eviction of dirty lines.

Will

> + * Implements the per arch atomic_scrub() that EDAC use for software
> + * ECC scrubbing.  It reads memory and then writes back the original
> + * value, allowing the hardware to detect and correct memory errors.
> + */
> +static inline void atomic_scrub(void *va, u32 size)
> +{
> +	unsigned int *virt_addr = va;
> +	unsigned int i;
> +
> +	for (i = 0; i < size / sizeof(*virt_addr); i++, virt_addr++) {
> +		long result;
> +		unsigned long tmp;
> +
> +		asm volatile("/* atomic_scrub */\n"
> +		"1:     ldxr    %w0, %2\n"
> +		"       stxr    %w1, %w0, %2\n"
> +		"       cbnz    %w1, 1b"
> +			: "=&r" (result), "=&r" (tmp), "+Q" (*virt_addr) : : );
> +	}
> +}
> +#endif
> -- 
> 1.9.1
> 
> 
