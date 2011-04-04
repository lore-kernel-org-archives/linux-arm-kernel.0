From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 4 Apr 2011 17:00:42 -0400 (EDT)
Subject: [PATCH 1/4] ARM: kprobes: Fix probing of conditionally executed
	instructions
In-Reply-To: <1301949198-31570-2-git-send-email-tixy@yxit.co.uk>
References: <1301949198-31570-1-git-send-email-tixy@yxit.co.uk>
	<1301949198-31570-2-git-send-email-tixy@yxit.co.uk>
Message-ID: <alpine.LFD.2.00.1104041647400.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Apr 2011, Tixy wrote:

> diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
> index 8f6ed43..c88c8d2 100644
> --- a/arch/arm/kernel/kprobes-decode.c
> +++ b/arch/arm/kernel/kprobes-decode.c
> @@ -63,6 +63,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/kprobes.h>
> +#include "kprobes-decode.h"
>  
>  #define sign_extend(x, signbit) ((x) | (0 - ((x) & (1 << (signbit)))))
>  
> @@ -1384,6 +1385,13 @@ space_cccc_111x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
>  	return INSN_GOOD;
>  }
>  
> +static kprobe_check_cc* const condition_checks[16] = {
> +	&__check_eq, &__check_ne, &__check_cs, &__check_cc,
> +	&__check_mi, &__check_pl, &__check_vs, &__check_vc,
> +	&__check_hi, &__check_ls, &__check_ge, &__check_lt,
> +	&__check_gt, &__check_le, &__check_al, &__check_al
> +};

Here you create an array of function pointers.

> diff --git a/arch/arm/kernel/kprobes-decode.h b/arch/arm/kernel/kprobes-decode.h
> new file mode 100644
> index 0000000..d6b4337
> --- /dev/null
> +++ b/arch/arm/kernel/kprobes-decode.h
> @@ -0,0 +1,98 @@
> +/*
> + * arch/arm/kernel/kprobes-decode.h
> + *
> + * Copyright (C) 2011 Jon Medhurst <tixy@yxit.co.uk>.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +static inline unsigned long __kprobes __check_eq(unsigned long cpsr)
> +{
> +	return cpsr & PSR_Z_BIT;
> +}

And those functions are declared static inline in a header file.

Because the array needs pointers to those functions, there is no way the 
compiler will be able to make them inline.  Better put them right before 
the array.


Nicolas
