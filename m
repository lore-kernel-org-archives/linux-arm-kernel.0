From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 6 Jun 2013 11:45:50 -0400 (EDT)
Subject: [PATCH 4/5] ARM: crypto: add NEON accelerated XOR implementation
In-Reply-To: <1370530985-20619-5-git-send-email-ard.biesheuvel@linaro.org>
References: <1370530985-20619-1-git-send-email-ard.biesheuvel@linaro.org>
 <1370530985-20619-5-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LFD.2.03.1306061145210.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Jun 2013, Ard Biesheuvel wrote:

> Add a source file xor-neon.c (which is really just the reference
> C implementation passed through the GCC vectorizer) and hook it
> up to the XOR framework.
> 
> Output captured from a Cortex-A15 @ 1.7 GHz:
> 
> xor: measuring software checksum speed
>    arm4regs  :  2261.600 MB/sec
>    8regs     :  1771.600 MB/sec
>    32regs    :  1441.600 MB/sec
>    neon      :  3619.600 MB/sec
> xor: using function: neon (3619.600 MB/sec)
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/include/asm/xor.h | 73 ++++++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/lib/Makefile      |  6 ++++
>  arch/arm/lib/xor-neon.c    | 42 ++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+)
>  create mode 100644 arch/arm/lib/xor-neon.c
> 
> diff --git a/arch/arm/include/asm/xor.h b/arch/arm/include/asm/xor.h
> index 7604673..4ffb26d 100644
> --- a/arch/arm/include/asm/xor.h
> +++ b/arch/arm/include/asm/xor.h
> @@ -7,7 +7,10 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> +#include <linux/hardirq.h>
>  #include <asm-generic/xor.h>
> +#include <asm/hwcap.h>
> +#include <asm/neon.h>
>  
>  #define __XOR(a1, a2) a1 ^= a2
>  
> @@ -138,4 +141,74 @@ static struct xor_block_template xor_block_arm4regs = {
>  		xor_speed(&xor_block_arm4regs);	\
>  		xor_speed(&xor_block_8regs);	\
>  		xor_speed(&xor_block_32regs);	\
> +		NEON_TEMPLATES;			\
>  	} while (0)
> +
> +#ifdef CONFIG_KERNEL_MODE_NEON
> +
> +extern struct xor_block_template const xor_block_neon_inner;
> +
> +static void
> +xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> +{
> +	if (in_interrupt()) {
> +		xor_arm4regs_2(bytes, p1, p2);
> +	} else {
> +		kernel_neon_begin();
> +		xor_block_neon_inner.do_2(bytes, p1, p2);
> +		kernel_neon_end();
> +	}
> +}
> +
> +static void
> +xor_neon_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> +		unsigned long *p3)
> +{
> +	if (in_interrupt()) {
> +		xor_arm4regs_3(bytes, p1, p2, p3);
> +	} else {
> +		kernel_neon_begin();
> +		xor_block_neon_inner.do_3(bytes, p1, p2, p3);
> +		kernel_neon_end();
> +	}
> +}
> +
> +static void
> +xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> +		unsigned long *p3, unsigned long *p4)
> +{
> +	if (in_interrupt()) {
> +		xor_arm4regs_4(bytes, p1, p2, p3, p4);
> +	} else {
> +		kernel_neon_begin();
> +		xor_block_neon_inner.do_4(bytes, p1, p2, p3, p4);
> +		kernel_neon_end();
> +	}
> +}
> +
> +static void
> +xor_neon_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
> +		unsigned long *p3, unsigned long *p4, unsigned long *p5)
> +{
> +	if (in_interrupt()) {
> +		xor_arm4regs_5(bytes, p1, p2, p3, p4, p5);
> +	} else {
> +		kernel_neon_begin();
> +		xor_block_neon_inner.do_5(bytes, p1, p2, p3, p4, p5);
> +		kernel_neon_end();
> +	}
> +}
> +
> +static struct xor_block_template xor_block_neon = {
> +	.name	= "neon",
> +	.do_2	= xor_neon_2,
> +	.do_3	= xor_neon_3,
> +	.do_4	= xor_neon_4,
> +	.do_5	= xor_neon_5
> +};
> +
> +#define NEON_TEMPLATES	\
> +	do { if (cpu_has_neon()) xor_speed(&xor_block_neon); } while (0)
> +#else
> +#define NEON_TEMPLATES
> +#endif
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index af72969..aaf3a87 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -45,3 +45,9 @@ lib-$(CONFIG_ARCH_SHARK)	+= io-shark.o
>  
>  $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
>  $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
> +
> +ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
> +  NEON_FLAGS			:= -mfloat-abi=softfp -mfpu=neon
> +  CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
> +  lib-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
> +endif
> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> new file mode 100644
> index 0000000..f485e5a
> --- /dev/null
> +++ b/arch/arm/lib/xor-neon.c
> @@ -0,0 +1,42 @@
> +/*
> + * linux/arch/arm/lib/xor-neon.c
> + *
> + * Copyright (C) 2013 Linaro Ltd <ard.biesheuvel@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/raid/xor.h>
> +
> +#ifndef __ARM_NEON__
> +#error You should compile this file with '-mfloat-abi=softfp -mfpu=neon'
> +#endif
> +
> +/*
> + * Pull in the reference implementations while instructing GCC (through
> + * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
> + * NEON instructions.
> + */
> +#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
> +#pragma GCC optimize "tree-vectorize"
> +#else
> +/*
> + * While older versions of GCC do not generate incorrect code, they fail to
> + * recognize the parallel nature of these functions, and emit plain ARM code,
> + * which is known to be slower than the optimized ARM code in asm-arm/xor.h.
> + */
> +#warning This code requires at least version 4.6 of GCC
> +#endif
> +
> +#pragma GCC diagnostic ignored "-Wunused-variable"
> +#include <asm-generic/xor.h>
> +
> +struct xor_block_template const xor_block_neon_inner = {
> +	.name	= "__inner_neon__",
> +	.do_2	= xor_8regs_2,
> +	.do_3	= xor_8regs_3,
> +	.do_4	= xor_8regs_4,
> +	.do_5	= xor_8regs_5,
> +};
> -- 
> 1.8.1.2
> 
