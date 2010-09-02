From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 09:56:52 +0100
Subject: [PATCH 04/74] ST SPEAr13XX: Adding machine specific header files
In-Reply-To: <216f9534163c6b7ccf403df870601bf254a3964f.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<216f9534163c6b7ccf403df870601bf254a3964f.1283161023.git.viresh.kumar@st.com>
Message-ID: <20100902085652.GF26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 30, 2010 at 04:08:35PM +0530, Viresh KUMAR wrote:
> +#ifndef __MACH_GENERIC_H
> +#define __MACH_GENERIC_H
> +
> +#include <asm/mach/time.h>
> +#include <asm/mach/map.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/amba/bus.h>

linux/ before asm/ please.

> +#ifndef __MACH_HARDWARE_H
> +#define __MACH_HARDWARE_H
> +
> +#include <mach/spear.h>
> +
> +/* Vitual to physical translation of statically mapped space */
> +#define IO_ADDRESS(x)		(x | 0xF0000000)
> +
> +/* typesafe io address */
> +#define __io_address(n)		__io(IO_ADDRESS(n))

Wrong use of __io().  __io() is just a macro for asm/io.h to make use of,
and in any case should be defined in your mach/io.h file.

> diff --git a/arch/arm/mach-spear13xx/include/mach/system.h b/arch/arm/mach-spear13xx/include/mach/system.h
> new file mode 100644
> index 0000000..6ce0819
> --- /dev/null
> +++ b/arch/arm/mach-spear13xx/include/mach/system.h
> @@ -0,0 +1,43 @@
> +/*
> + * arch/arm/mach-spear13xx/include/mach/system.h
> + *
> + * spear13xx Machine family specific architecture functions
> + *
> + * Copyright (C) 2010 ST Microelectronics
> + * Shiraz Hashim <shiraz.hashim@st.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __MACH_SYSTEM_H
> +#define __MACH_SYSTEM_H
> +
> +#include <linux/io.h>
> +#include <mach/hardware.h>
> +#include <mach/misc_regs.h>
> +
> +static inline void arch_idle(void)
> +{
> +	/*
> +	 * This should do all the clock switching
> +	 * and wait for interrupt tricks
> +	 */
> +	cpu_do_idle();
> +}
> +
> +static inline void arch_reset(char mode, const char *cmd)
> +{
> +	pr_info("Going to reboot...\n");

The kernel already prints a message for reboot, so this is superfluous.
