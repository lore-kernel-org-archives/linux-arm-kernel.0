From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 May 2012 10:58:05 +0100
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <1337072084-21967-7-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-7-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <4FB228AD.5000507@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 09:54, Thomas Petazzoni wrote:
> From: Gregory CLEMENT<gregory.clement@free-electrons.com>
>
> Signed-off-by: Gregory CLEMENT<gregory.clement@free-electrons.com>
> Signed-off-by: Thomas Petazzoni<thomas.petazzoni@free-electrons.com>
> Signed-off-by: Lior Amsalem<alior@marvell.com>
> ---
>   arch/arm/boot/dts/axp-db.dts  |   40 ++++++++++++++++++++++++++++++++++++++++
>   arch/arm/mach-armada/Kconfig  |    6 ++++++
>   arch/arm/mach-armada/Makefile |    2 +-
>   arch/arm/mach-armada/axp-dt.c |   41 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 88 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/boot/dts/axp-db.dts
>   create mode 100644 arch/arm/mach-armada/axp-dt.c
>
> diff --git a/arch/arm/boot/dts/axp-db.dts b/arch/arm/boot/dts/axp-db.dts
> new file mode 100644
> index 0000000..916be09
> --- /dev/null
> +++ b/arch/arm/boot/dts/axp-db.dts

see previous comments.

> diff --git a/arch/arm/mach-armada/Kconfig b/arch/arm/mach-armada/Kconfig
> index 7995813..2903096 100644
> --- a/arch/arm/mach-armada/Kconfig
> +++ b/arch/arm/mach-armada/Kconfig
> @@ -8,6 +8,12 @@ config MACH_ARMADA_370_DT
>   	  Say 'Y' here if you want your kernel to support
>   	  boards based on Marvell Armada 370 with device tree.
>
> +config MACH_ARMADA_XP_DT
> +	bool "Marvell Armada XP boards with device-tree support"
> +	help
> +	  Say 'Y' here if you want your kernel to support
> +	  boards based on Marvell Armada XP with device tree.
> +
>   endmenu
>
>   endif
> diff --git a/arch/arm/mach-armada/Makefile b/arch/arm/mach-armada/Makefile
> index ac39fae..7a3c438 100644
> --- a/arch/arm/mach-armada/Makefile
> +++ b/arch/arm/mach-armada/Makefile
> @@ -1,3 +1,3 @@
>   obj-y += common.o irq.o time.o
>   obj-$(CONFIG_MACH_ARMADA_370_DT) += a370-dt.o
> -
> +obj-$(CONFIG_MACH_ARMADA_XP_DT)	 += axp-dt.o
> diff --git a/arch/arm/mach-armada/axp-dt.c b/arch/arm/mach-armada/axp-dt.c
> new file mode 100644
> index 0000000..2c13d4e
> --- /dev/null
> +++ b/arch/arm/mach-armada/axp-dt.c
> @@ -0,0 +1,41 @@
> +/*
> + * Device Tree support for Armada XP platforms.
> + *
> + * Copyright (C) 2012 Marvell
> + *
> + * Lior Amsalem<alior@marvell.com>
> + * Gregory CLEMENT<gregory.clement@free-electrons.com>
> + * Thomas Petazzoni<thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include<linux/kernel.h>
> +#include<linux/init.h>
> +#include<linux/of_platform.h>
> +#include<asm/mach-types.h>
> +#include<asm/mach/arch.h>
> +#include<mach/armada.h>
> +#include "common.h"
> +
> +static void __init axp_dt_init(void)
> +{
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}
> +
> +static const char * const axp_dt_board_dt_compat[] = {
> +	"marvell,axp-db",
> +	NULL,

This is where the device support becomes confusing.

I would strongly advise on using "mrvl,mv78230" as the binding
name. It isn't as if you can't have multiple names associated
with one binding.

Also, given how close they are, do we really need separate machine
support files?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
