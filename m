From: will.deacon@arm.com (Will Deacon)
Date: Wed, 21 Nov 2012 15:15:56 +0000
Subject: [PATCH V6 1/5] arm: mvebu: Add support for coherency fabric in
 mach-mvebu
In-Reply-To: <1353509970-5237-2-git-send-email-gregory.clement@free-electrons.com>
References: <1353509970-5237-1-git-send-email-gregory.clement@free-electrons.com>
 <1353509970-5237-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121121151556.GO11990@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 02:59:26PM +0000, Gregory CLEMENT wrote:
> diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
> new file mode 100644
> index 0000000..74272b6
> --- /dev/null
> +++ b/arch/arm/mach-mvebu/coherency_ll.S
> @@ -0,0 +1,49 @@
> +/*
> + * Coherency fabric: low level functions
> + *
> + * Copyright (C) 2012 Marvell
> + *
> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * This file implements the assembly function to add a CPU to the
> + * coherency fabric. This function is called by each of the secondary
> + * CPUs during their early boot in an SMP kernel, this why this
> + * function have to callable from assembly. It can also be called by a
> + * primary CPU from C code during its boot.
> + */
> +
> +#include <linux/linkage.h>
> +#define ARMADA_XP_CFB_CTL_REG_OFFSET 0x0
> +#define ARMADA_XP_CFB_CFG_REG_OFFSET 0x4
> +
> +	.text
> +/*
> + * r0: Coherency fabric base register address
> + * r1: HW CPU id
> + */
> +ENTRY(ll_set_cpu_coherent)
> +	/* Create bit by cpu index */
> +	mov	r3, #(1 << 24)
> +	lsl     r1, r3, r1
> +
> +	/* Add CPU to SMP group - Atomic */
> +	add	r3, r0, #ARMADA_XP_CFB_CTL_REG_OFFSET
> +	ldr     r2, [r3]
> +	orr     r2, r2, r1
> +	str	r2, [r0]

This should be storing to [r3] but you get away with it because your
immediate offset evaluates to zero.

If you fix that:

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
