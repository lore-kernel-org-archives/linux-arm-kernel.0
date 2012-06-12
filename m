From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jun 2012 13:09:18 +0000
Subject: [PATCH v2 4/8] arm: mach-mvebu: add support for Armada 370 and
 Armada XP with DT
In-Reply-To: <1339433585-28087-5-git-send-email-gregory.clement@free-electrons.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <1339433585-28087-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201206121309.18532.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 June 2012, Gregory CLEMENT wrote:
> +	soc {
> +		serial at d0012000 {
> +			clock-frequency = <200000000>;
> +		};
> +		timer at d0020300 {
> +			clock-frequency = <600000000>;
> +
> +		};
> +	};
> +};

In most platforms, we mark the "serial" device and anything else that
might not be connected as "disabled" in the .dtsi file, and enable the
ones that are actually used in the board specific .dts file. I think it
makes sense to also do that here.

> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 72d39e5..ad2faa2 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -2,6 +2,13 @@ if ARCH_MVEBU
>  
>  menu "Marvell SOC with device tree"
>  
> +config MACH_ARMADA_370_XP_DT
> +	bool "Marvell Armada 370 and Aramada XP boards with device-tree support"
> +	help
> +
> +	  Say 'Y' here if you want your kernel to support boards based on
> +	  Marvell Armada 370 or Armada XP with device tree.
> +
>  endmenu
>  
>  endif
> --- /dev/null
> +++ b/arch/arm/mach-mvebu/armada-370-xp-dt.c

Please dtop the _dt postfix everywhere here.

> @@ -0,0 +1,65 @@
> +/*
> + * Device Tree support for Armada XP platforms.
> + *
> + * Copyright (C) 2012 Marvell
> + *
> + * Lior Amsalem <alior@marvell.com>
> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_platform.h>
> +#include <linux/io.h>
> +#include <asm/mach/arch.h>
> +#include <mach/mvebu.h>
> +#include <mach/armada-370-xp.h>
> +#include "common.h"
> +
> +#define SOFT_RESET_OUT_EN	0x1
> +#define RSTOUTN_MASK_ADDR	(MVEBU_REGS_VIRT_BASE | \
> +					ARMADA_370_XP_RSTOUTN_MASK_OFFSET)
> +#define SOFT_RESET		0x1
> +#define SYSTEM_SOFT_RESET_ADDR	(MVEBU_REGS_VIRT_BASE| \
> +					ARMADA_370_XP_SYSTEM_SOFT_RESET_OFFSET)

We should not be hardcoding addresses like this any more IMHO:

> +static void armada_370_xp_restart(char mode, const char *cmd)
> +{
> +	/*
> +	* Enable soft reset to assert RSTOUTn.
> +	*/
> +	writel(SOFT_RESET_OUT_EN, RSTOUTN_MASK_ADDR);
> +	/*
> +	* Assert soft reset.
> +	*/
> +	writel(SOFT_RESET, SYSTEM_SOFT_RESET_ADDR);
> +	while (1)
> +		;
> +}

This function is the same one that's used for the existing mvebu platforms,
just with a different offset. I think it would be nice to put it into a
reset.c file along with some code that looks for the location.

For instance, you can look for the device that holds the "bridge regs"
and then either add the 0x108 or the 0x18260 offset, depending on its
compatible property.

> diff --git a/arch/arm/mach-mvebu/time-armada-370-xp.c b/arch/arm/mach-mvebu/time-armada-370-xp.c
> new file mode 100644
> index 0000000..104b88a
> --- /dev/null
> +++ b/arch/arm/mach-mvebu/time-armada-370-xp.c

I think this file should go into drivers/clocksource instead of the arch directory.

	Arnd
