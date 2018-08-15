From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 15 Aug 2018 06:24:35 +0100
Subject: [PATCH v1 3/7] mfd: add atmel-lcdc driver
In-Reply-To: <20180812184629.3808-3-sam@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-3-sam@ravnborg.org>
Message-ID: <20180815052435.GA6412@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 12 Aug 2018, Sam Ravnborg wrote:

> The LCDC IP used by some Atmel SOC's have a
>     multifunction device that include two sub-devices:
>     - pwm
>     - display controller
> 
> This mfd device provide a regmap that can be used by the
> sub-devices to safely access the registers.
> The mfd device also support the clock used by the
> LCDC IP + a bus clock that in some cases are required.
> 
> The driver is based on the atmel-hlcdc driver.
> 
> The Atmel SOC's are at91sam9261, at91sam9263 etc.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/mfd/Kconfig            |  10 +++
>  drivers/mfd/Makefile           |   1 +
>  drivers/mfd/atmel-lcdc.c       | 158 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/atmel-lcdc.h | 184 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 353 insertions(+)
>  create mode 100644 drivers/mfd/atmel-lcdc.c
>  create mode 100644 include/linux/mfd/atmel-lcdc.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b860eb5aa194..f4851f0f033f 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -121,6 +121,16 @@ config MFD_ATMEL_HLCDC
>  	  additional drivers must be enabled in order to use the
>  	  functionality of the device.
>  
> +config MFD_ATMEL_LCDC
> +	tristate "Atmel LCDC (LCD Controller)"
> +	select MFD_CORE
> +	depends on OF
> +	help
> +	  If you say yes here you get support for the LCDC block.
> +	  This driver provides common support for accessing the device,
> +	  additional drivers must be enabled in order to use the
> +	  functionality of the device.
> +
>  config MFD_ATMEL_SMC
>  	bool
>  	select MFD_SYSCON
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index e9fd20dba18d..dba8465e0d96 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -186,6 +186,7 @@ obj-$(CONFIG_MFD_TPS65090)	+= tps65090.o
>  obj-$(CONFIG_MFD_AAT2870_CORE)	+= aat2870-core.o
>  obj-$(CONFIG_MFD_ATMEL_FLEXCOM)	+= atmel-flexcom.o
>  obj-$(CONFIG_MFD_ATMEL_HLCDC)	+= atmel-hlcdc.o
> +obj-$(CONFIG_MFD_ATMEL_LCDC)	+= atmel-lcdc.o
>  obj-$(CONFIG_MFD_ATMEL_SMC)	+= atmel-smc.o
>  obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
>  obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
> diff --git a/drivers/mfd/atmel-lcdc.c b/drivers/mfd/atmel-lcdc.c
> new file mode 100644
> index 000000000000..8928976bafca
> --- /dev/null
> +++ b/drivers/mfd/atmel-lcdc.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Sam Ravnborg
> + *
> + * Author: Sam Ravnborg <sam@ravnborg.org>
> + *
> + * Based on atmel-hlcdc.c wich is:
> + * Copyright (C) 2014 Free Electrons
> + * Copyright (C) 2014 Atmel
> + * Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
> + */
> +
> +#include <linux/mfd/atmel-lcdc.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#define ATMEL_LCDC_REG_MAX		(0x1000 - 0x4)
> +
> +struct lcdc_regmap {
> +	void __iomem *regs;
> +};
> +
> +static const struct mfd_cell lcdc_cells[] = {
> +	{
> +		.name = "atmel-lcdc-pwm",
> +		.of_compatible = "atmel,lcdc-pwm",
> +	},
> +	{
> +		.name = "atmel-lcdc-dc",
> +		.of_compatible = "atmel,lcdc-display-controller",
> +	},
> +};

Will you be adding any more devices, or is this the entirety of the
device?  If the latter, I suggest that this doesn't warrant being an
MFD.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
