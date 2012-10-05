From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Oct 2012 10:02:04 +0100
Subject: [PATCH v3] GPIO: Add support for GPIO on CLPS711X-target platform
In-Reply-To: <1349106153-27371-1-git-send-email-shc_work@mail.ru>
References: <1349106153-27371-1-git-send-email-shc_work@mail.ru>
Message-ID: <20121005090204.GL4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2012 at 07:42:33PM +0400, Alexander Shiyan wrote:
> The CLPS711X CPUs provide some GPIOs for use in the system. This
> driver provides support for these via gpiolib. Due to platform
> limitations, driver does not support interrupts, only inputs and
> outputs.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/Kconfig                           |    1 +
>  arch/arm/mach-clps711x/include/mach/gpio.h |   27 +++++
>  drivers/gpio/Kconfig                       |    4 +
>  drivers/gpio/Makefile                      |    1 +
>  drivers/gpio/gpio-clps711x.c               |  152 ++++++++++++++++++++++++++++
>  5 files changed, 185 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-clps711x/include/mach/gpio.h
>  create mode 100644 drivers/gpio/gpio-clps711x.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 2f88d8d..e73bf9d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -384,6 +384,7 @@ config ARCH_CLPS711X
>  	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
>  	select CPU_ARM720T
>  	select ARCH_USES_GETTIMEOFFSET
> +	select ARCH_REQUIRE_GPIOLIB
>  	select NEED_MACH_MEMORY_H
>  	help
>  	  Support for Cirrus Logic 711x/721x/731x based boards.
> diff --git a/arch/arm/mach-clps711x/include/mach/gpio.h b/arch/arm/mach-clps711x/include/mach/gpio.h
> new file mode 100644
> index 0000000..cbcc985
> --- /dev/null
> +++ b/arch/arm/mach-clps711x/include/mach/gpio.h
> @@ -0,0 +1,27 @@
> +/*
> + *  This file contains the CLPS711X GPIO definitions.
> + *
> + *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +/* Simple helper for convert port & pin to GPIO number */
> +#define CLPS711X_GPIO(port, bit)	((port) * 8 + (bit))
> +
> +/* Temporaty definitions for GPIO-ports */
> +/* Will be removed after remove clps_read(write) macros */
> +#include <mach/hardware.h>
> +#define _PADR	(CLPS711X_VIRT_BASE + PADR)
> +#define _PBDR	(CLPS711X_VIRT_BASE + PBDR)
> +#define _PCDR	(CLPS711X_VIRT_BASE + PCDR)
> +#define _PDDR	(CLPS711X_VIRT_BASE + PDDR)
> +#define _PADDR	(CLPS711X_VIRT_BASE + PADDR)
> +#define _PBDDR	(CLPS711X_VIRT_BASE + PBDDR)
> +#define _PCDDR	(CLPS711X_VIRT_BASE + PCDDR)
> +#define _PDDDR	(CLPS711X_VIRT_BASE + PDDDR)
> +#define _PEDR	(CLPS711X_VIRT_BASE + PEDR)
> +#define _PEDDR	(CLPS711X_VIRT_BASE + PEDDR)

Why can't this file (or the bulk of it) live in drivers/gpio ?
