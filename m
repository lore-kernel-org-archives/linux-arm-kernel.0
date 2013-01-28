From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Jan 2013 14:46:04 +0000
Subject: [PATCH v2 02/16] ARM: b.L: secondary kernel entry code
In-Reply-To: <1359008879-9015-3-git-send-email-nicolas.pitre@linaro.org>
References: <1359008879-9015-1-git-send-email-nicolas.pitre@linaro.org>
 <1359008879-9015-3-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130128144604.GC23470@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Thu, Jan 24, 2013 at 06:27:45AM +0000, Nicolas Pitre wrote:
> CPUs in a big.LITTLE systems have special needs when entering the kernel
> due to a hotplug event, or when resuming from a deep sleep mode.
> 
> This is vectorized so multiple CPUs can enter the kernel in parallel
> without serialization.
> 
> Only the basic structure is introduced here.  This will be extended
> later.
> 
> TODO: MPIDR based indexing should eventually be made runtime adjusted.

What's your plan for this TODO? Do you aim to merge the code first and add
that later? If so, maybe add a TODO comment in the code as well?

> diff --git a/arch/arm/common/bL_entry.c b/arch/arm/common/bL_entry.c
> new file mode 100644
> index 0000000000..4e1044612d
> --- /dev/null
> +++ b/arch/arm/common/bL_entry.c
> @@ -0,0 +1,29 @@
> +/*
> + * arch/arm/common/bL_entry.c -- big.LITTLE kernel re-entry point
> + *
> + * Created by:  Nicolas Pitre, March 2012
> + * Copyright:   (C) 2012-2013  Linaro Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +
> +#include <asm/bL_entry.h>

Similarly with the naming... was there any consensus to replace bL_ with
something else? I personally find the capitalisation pretty jarring and at
odds with the rest of the kernel, but "bl" is branch-and-link so that's also
not much better.

> diff --git a/arch/arm/include/asm/bL_entry.h b/arch/arm/include/asm/bL_entry.h
> new file mode 100644
> index 0000000000..7525614243
> --- /dev/null
> +++ b/arch/arm/include/asm/bL_entry.h
> @@ -0,0 +1,35 @@
> +/*
> + * arch/arm/include/asm/bL_entry.h
> + *
> + * Created by:  Nicolas Pitre, April 2012
> + * Copyright:   (C) 2012-2013  Linaro Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef BL_ENTRY_H
> +#define BL_ENTRY_H
> +
> +#define BL_MAX_CPUS_PER_CLUSTER	4
> +#define BL_MAX_CLUSTERS		2

Again, do you have any ideas/plans on how to remove these constant limits?

Cheers,

Will
