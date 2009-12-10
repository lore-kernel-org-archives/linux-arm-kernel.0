From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Dec 2009 10:31:57 +0000
Subject: [RFC][PATCH 05/10] mxc: Add board support for the i.MX51
	babbage board
In-Reply-To: <0559d42bc9f32e30264fea6ca6fa679121f6a241.1259893118.git.amit.kucheria@canonical.com>
References: <cover.1259893118.git.amit.kucheria@canonical.com>
	<0559d42bc9f32e30264fea6ca6fa679121f6a241.1259893118.git.amit.kucheria@canonical.com>
Message-ID: <20091210103157.GB6207@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2009 at 04:47:05AM +0200, Amit Kucheria wrote:
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <mach/common.h>
> +#include <mach/hardware.h>
> +#include <asm/irq.h>
> +#include <asm/setup.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +#include <mach/memory.h>

No one should be including mach/memory.h.  Please remove it and find a
better include to use.  (mach/memory.h exists to provide asm/memory.h
with the platform specific bits it needs, so maybe asm/memory.h is
what you want here).

> +#define SPIN_DELAY	1000000 /* in nanoseconds */

That's 1ms.

> +	/* Wait for lock */
> +	getnstimeofday(&nstimeofday);
> +	while (!(__raw_readl(pllbase + MXC_PLL_DP_CTL) & MXC_PLL_DP_CTL_LRF)) {
> +		getnstimeofday(&curtime);

I doubt getnstimeofday is particularly light-weight, so I'm not sure
what you're gaining over a loop based around udelay() and counting the
iterations.

> +		if (curtime.tv_nsec - nstimeofday.tv_nsec > SPIN_DELAY)
> +			panic("pll relock failed\n");

Is a panic really justified?

> diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
> new file mode 100644
> index 0000000..b258917
> --- /dev/null
> +++ b/arch/arm/mach-mx5/mm.c
> @@ -0,0 +1,86 @@
> +/*
> + * Copyright 2008-2009 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License.  You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + *
> + * Create static mapping between physical to virtual memory.
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/init.h>
> +#include <mach/hardware.h>
> +#include <asm/pgtable.h>

I don't see anything needing asm/pgtable.h in here.
