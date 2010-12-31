From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 30 Dec 2010 23:16:15 -0700
Subject: [PATCH v7 08/12] gpio: add ti-ssp gpio driver
In-Reply-To: <1291733522-3626-9-git-send-email-cyril@ti.com>
References: <1291733522-3626-1-git-send-email-cyril@ti.com>
	<1291733522-3626-9-git-send-email-cyril@ti.com>
Message-ID: <20101231061615.GA3733@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 09:51:58AM -0500, Cyril Chemparathy wrote:
> TI's SSP controller pins can be directly read and written to behave like a
> GPIO.  This patch adds a GPIO driver that exposes such functionality.
> 
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> ---
>  drivers/gpio/Kconfig       |   10 ++
>  drivers/gpio/Makefile      |    1 +
>  drivers/gpio/ti-ssp-gpio.c |  206 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/ti_ssp.h |    4 +
>  4 files changed, 221 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/gpio/ti-ssp-gpio.c
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 3143ac7..05bbe4c 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -128,6 +128,16 @@ config GPIO_VX855
>  	  additional drivers must be enabled in order to use the
>  	  functionality of the device.
>  
> +config GPIO_TI_SSP
> +	tristate "TI Sequencer Serial Port - GPIO Support"
> +	depends on MFD_TI_SSP
> +	help
> +	  Say yes here to support a GPIO interface on TI SSP port pins.
> +	  Each SSP port translates into 4 GPIOs.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called ti-ssp-gpio.
> +
>  comment "I2C GPIO expanders:"
>  
>  config GPIO_MAX7300
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index bdf3dde..0e2a844 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_GPIO_PL061)	+= pl061.o
>  obj-$(CONFIG_GPIO_STMPE)	+= stmpe-gpio.o
>  obj-$(CONFIG_GPIO_TC35892)	+= tc35892-gpio.o
>  obj-$(CONFIG_GPIO_TIMBERDALE)	+= timbgpio.o
> +obj-$(CONFIG_GPIO_TI_SSP)	+= ti-ssp-gpio.o
>  obj-$(CONFIG_GPIO_TWL4030)	+= twl4030-gpio.o
>  obj-$(CONFIG_GPIO_UCB1400)	+= ucb1400_gpio.o
>  obj-$(CONFIG_GPIO_XILINX)	+= xilinx_gpio.o
> diff --git a/drivers/gpio/ti-ssp-gpio.c b/drivers/gpio/ti-ssp-gpio.c
> new file mode 100644
> index 0000000..387970e
> --- /dev/null
> +++ b/drivers/gpio/ti-ssp-gpio.c
> @@ -0,0 +1,206 @@
> +/*
> + * Sequencer Serial Port (SSP) based virtual GPIO driver
> + *
> + * Copyright (C) 2010 Texas Instruments Inc
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
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/ti_ssp.h>
> +
> +struct ti_ssp_gpio_chip {
> +	struct gpio_chip		chip;
> +	struct device			*dev;
> +	spinlock_t			lock;
> +	u8				out;
> +	u32				iosel;
> +};
> +
> +#define to_ssp_gpio_chip(c) container_of(c, struct ti_ssp_gpio_chip, chip)
> +
> +static int direction_in(struct gpio_chip *chip, unsigned gpio_num)
> +{
> +	struct ti_ssp_gpio_chip *gpio = to_ssp_gpio_chip(chip);
> +	int error = 0;
> +
> +	spin_lock(&gpio->lock);
> +
> +	gpio->iosel &= ~SSP_PIN_MASK(gpio_num);
> +	gpio->iosel |=  SSP_PIN_SEL(gpio_num, SSP_IN);
> +
> +	error = ti_ssp_set_iosel(gpio->dev, gpio->iosel);
> +
> +	spin_unlock(&gpio->lock);
> +
> +	return error;
> +}
> +
> +static int direction_out(struct gpio_chip *chip, unsigned gpio_num, int val)

All of these static functions still need to have the driver-specific
prefix to avoid any possibility of collisions in the global namespace.
I haven't checked the rest of the patches, but this comment does stand
for the whole series.
