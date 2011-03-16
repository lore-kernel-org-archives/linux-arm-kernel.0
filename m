From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 16 Mar 2011 11:13:23 +0100
Subject: [PATCH 1/7] ARM: add GPMI support for imx23/imx28
In-Reply-To: <1300239773-4222-2-git-send-email-b32955@freescale.com>
References: <1300239773-4222-1-git-send-email-b32955@freescale.com>
	<1300239773-4222-2-git-send-email-b32955@freescale.com>
Message-ID: <19840.36163.967469.53941@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie writes:
> add the clock and iomux initialization for GPMI in the imx23 and imx28.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/mach-mxs/Kconfig                       |    2 +
>  arch/arm/mach-mxs/clock-mx23.c                  |    3 +
>  arch/arm/mach-mxs/clock-mx28.c                  |    3 +
>  arch/arm/mach-mxs/devices-mx23.h                |    3 +
>  arch/arm/mach-mxs/devices-mx28.h                |    3 +
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-gpmi.c       |  144 +++++++++++++++++++++++
>  arch/arm/mach-mxs/include/mach/devices-common.h |    4 +
>  arch/arm/mach-mxs/include/mach/gpmi-nfc.h       |   75 ++++++++++++
>  arch/arm/mach-mxs/mach-mx23evk.c                |   37 ++++++
>  arch/arm/mach-mxs/mach-mx28evk.c                |   37 ++++++
>  12 files changed, 315 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-gpmi.c
>  create mode 100644 arch/arm/mach-mxs/include/mach/gpmi-nfc.h
> 
> diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> index 4f6f174..8ab0fcb 100644
> --- a/arch/arm/mach-mxs/Kconfig
> +++ b/arch/arm/mach-mxs/Kconfig
> @@ -22,6 +22,7 @@ config MACH_MX23EVK
>  	select SOC_IMX23
>  	select MXS_HAVE_AMBA_DUART
>  	select MXS_HAVE_PLATFORM_AUART
> +	select MXS_HAVE_PLATFORM_GPMI
>  	select MXS_HAVE_PLATFORM_MXSFB
>  	default y
>  	help
> @@ -33,6 +34,7 @@ config MACH_MX28EVK
>  	select SOC_IMX28
>  	select MXS_HAVE_AMBA_DUART
>  	select MXS_HAVE_PLATFORM_AUART
> +	select MXS_HAVE_PLATFORM_GPMI
>  	select MXS_HAVE_PLATFORM_FEC
>
In my alphabet 'F' sorts before 'G', so please keep this list sorted
alphabetically!

> diff --git a/arch/arm/mach-mxs/devices/platform-gpmi.c b/arch/arm/mach-mxs/devices/platform-gpmi.c
> new file mode 100644
> index 0000000..038226b
> --- /dev/null
> +++ b/arch/arm/mach-mxs/devices/platform-gpmi.c
> @@ -0,0 +1,144 @@
> +/*
> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +#include <asm/sizes.h>
> +#include <mach/mx23.h>
> +#include <mach/mx28.h>
> +#include <mach/gpmi-nfc.h>
> +#include <mach/devices-common.h>
> +
> +#ifdef CONFIG_SOC_IMX23
> +const struct gpmi_nfc_platform_data  gpmi_platform_data_imx23 __initconst = {
> +	.chip_version		= CHIP_VERSION_IMX23,
> +	.clock_name		= GPMI_NFC_CLOCK_NAME,
>
The same abuse of the clock infrastructure, that Russell has pointed
out several times already. There is no need to pass around clock names
to drivers. The correct clock can be determined from the
platform_device name!

All in all I do not like this driver in any way. I already vomitted
over it, when I saw it in the Freescale BSP.
There is no need for the multiple layers of abstraction that are
papered over the MTD layer.
There is no need for spilling the driver over a dozen files.
There is no need for two versions of the 'HAL' (for i.MX23 and i.MX28)
that differ only marginally.
...

BTW: patch 2/7 seems to be missing from the patch series.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
