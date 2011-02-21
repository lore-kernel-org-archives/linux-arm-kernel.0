From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 21 Feb 2011 17:30:28 +0100
Subject: [PATCH v2 01/13] mfd: pruss mfd driver.
In-Reply-To: <1297435892-28278-2-git-send-email-subhasish@mistralsolutions.com>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-2-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <20110221163027.GF10686@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Subhasish,

On Fri, Feb 11, 2011 at 08:21:20PM +0530, Subhasish Ghosh wrote:
> This patch adds the pruss MFD driver and associated include files.
A more detailed changelog would be better. What is this device, why is it an
MFD and what are its potential subdevices ?

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index fd01836..6c437df 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -81,6 +81,16 @@ config MFD_DM355EVM_MSP
>  	  boards.  MSP430 firmware manages resets and power sequencing,
>  	  inputs from buttons and the IR remote, LEDs, an RTC, and more.
>  
> +config MFD_DA8XX_PRUSS
> +	tristate "Texas Instruments DA8XX PRUSS support"
> +	depends on ARCH_DAVINCI && ARCH_DAVINCI_DA850
Why are we depending on those ?


> +	select MFD_CORE
> +	help
> +	    This driver provides support api's for the programmable
> +		realtime unit (PRU) present on TI's da8xx processors. It
> +		provides basic read, write, config, enable, disable
> +		routines to facilitate devices emulated on it.
Please fix your identation here.

> --- /dev/null
> +++ b/drivers/mfd/da8xx_pru.c
> @@ -0,0 +1,446 @@
> +/*
> + * Copyright (C) 2010 Texas Instruments Incorporated
s/2010/2011/ ? 

> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as  published by the
> + * Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
> + * whether express or implied; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/errno.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/mfd/pruss/da8xx_prucore.h>
> +#include <linux/mfd/pruss/da8xx_pru.h>
> +#include <linux/mfd/core.h>
> +#include <linux/io.h>
> +#include <mach/da8xx.h>
Is that include needed ?


> +struct da8xx_pruss {
What is the "ss" suffix for ?


> +u32 pruss_disable(struct device *dev, u8 pruss_num)
> +{
> +	struct da8xx_pruss *pruss = dev_get_drvdata(dev->parent);
> +	da8xx_prusscore_regs h_pruss;
> +	u32 temp_reg;
> +
> +	if (pruss_num == DA8XX_PRUCORE_0) {
> +		/* Disable PRU0  */
> +		h_pruss = (da8xx_prusscore_regs)
> +			((u32) pruss->ioaddr + 0x7000);
So it seems you're doing this in several places, and I have a few comments:

- You don't need the da8xx_prusscore_regs at all.
- Define the register map through a set of #define in your header file.
- Use a static routine that takes the core number and returns the register map
offset.

Then routines like this one will look a lot more readable.

> +s16 pruss_writeb(struct device *dev, u32 u32offset,
> +		u8 *pu8datatowrite, u16 u16bytestowrite)
