From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 07 Jul 2011 18:45:43 -0700
Subject: [RFC PATCH 05/17] ARM: kernel: save/restore kernel IF
In-Reply-To: <1310053830-23779-6-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-6-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <4E166147.70504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/7/2011 8:50 AM, Lorenzo Pieralisi wrote:
> In order to define a common idle interface for the kernel
> to enter low power modes, this patch provides include files
> and code that manages OS calls for low power entry and exit.
>

[....]

> diff --git a/arch/arm/kernel/sr_entry.S b/arch/arm/kernel/sr_entry.S
> new file mode 100644
> index 0000000..4fa9bef
> --- /dev/null
> +++ b/arch/arm/kernel/sr_entry.S
> @@ -0,0 +1,213 @@
> +/*
> + * Copyright (c) 2008-2011 ARM Ltd
> + *
> + * Author(s):  Jon Callan, Lorenzo Pieralisi
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include<linux/linkage.h>
> +#include<generated/asm-offsets.h>
> +#include<asm/thread_info.h>
> +#include<asm/memory.h>
> +#include<asm/ptrace.h>
> +#include<asm/glue-proc.h>
> +#include<asm/assembler.h>
> +#include<asm-generic/errno-base.h>
> +#include<mach/entry-macro.S>
> +
> +	.text
> +
> +ENTRY(default_sleep)
> +	b out		@ BTAC allocates branch and enters loop mode
> +idle:			@ power down is entered with GIC CPU IF still on which
> +	dsb		@ might get wfi instruction to complete before the
> +	wfi		@ CPU is shut down -- infinite loop
> +out:
> +    	b idle
> +ENDPROC(default_sleep)

Q: What happens for some reason CPU didn't hit targeted
state in IDLE. Does CPU keep looping here forever.

On OMAP4, we need to issue additional interconnect
barrier before WFI. How can we make provision for the same

Regards
Santosh
