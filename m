From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 17 Mar 2011 21:26:38 +0000
Subject: [PATCH 1/9] lpc2k: Core support
In-Reply-To: <1300377264-10843-2-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300377264-10843-2-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <20110317212637.GA2927@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 17, 2011 at 04:54:16PM +0100, Ithamar R. Adema wrote:
> Core files (including IRQ handling) for NXP LPC2K architecture.
> 
> Signed-off-by: Ithamar R. Adema <ithamar.adema@team-embedded.nl>
> ---
[...]
> diff --git a/arch/arm/mach-lpc2k/include/mach/entry-macro.S b/arch/arm/mach-lpc2k/include/mach/entry-macro.S
> new file mode 100644
> index 0000000..f6c7a46
> --- /dev/null
> +++ b/arch/arm/mach-lpc2k/include/mach/entry-macro.S
> @@ -0,0 +1,33 @@
> +/*
> + * Copyright 2011 Team Embedded VOF
> + *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <mach/hardware.h>
> +
> +        .macro  disable_fiq
> +        .endm
> +
> +		.macro	get_irqnr_preamble, base, tmp
> +		ldr	\base, =APH_VIC_BASE
> +		.endm
> +
> +		.macro	arch_ret_to_user, tmp1, tmp2
> +		.endm
> +
> +		.macro get_irqnr_and_base, irqnr, irqstat, base, tmp
> +		ldr	\irqstat, [\base, #0]
> +		mov     \irqnr, #0
> +1001:
> +		tst     \irqstat, #1
> +		bne     1002f
> +		add     \irqnr, \irqnr, #1
> +		mov     \irqstat, \irqstat, lsr #1
> +		cmp     \irqnr, #32
> +		bcc     1001b
> +1002:

Could you adapt the code in arch/arm/include/asm/entry-macro-vic2.S for 
a single VIC?  That eliminates the looping that you have here.

Jamie
