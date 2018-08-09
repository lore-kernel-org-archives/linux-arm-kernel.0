From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 9 Aug 2018 04:49:52 +0200
Subject: [PATCH v2 3/7] drivers: gpio: Add support for GPIOs over Moxtet
 bus
In-Reply-To: <20180809022037.12001-4-marek.behun@nic.cz>
References: <20180809022037.12001-1-marek.behun@nic.cz>
 <20180809022037.12001-4-marek.behun@nic.cz>
Message-ID: <20180809024952.GC6884@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 1324c8f966a7..8db046da5850 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -84,7 +84,8 @@ obj-$(CONFIG_GPIO_MC33880)	+= gpio-mc33880.o
>  obj-$(CONFIG_GPIO_MC9S08DZ60)	+= gpio-mc9s08dz60.o
>  obj-$(CONFIG_GPIO_ML_IOH)	+= gpio-ml-ioh.o
>  obj-$(CONFIG_GPIO_MM_LANTIQ)	+= gpio-mm-lantiq.o
> -obj-$(CONFIG_GPIO_MOCKUP)      += gpio-mockup.o
> +obj-$(CONFIG_GPIO_MOCKUP)	+= gpio-mockup.o
> +obj-$(CONFIG_GPIO_MOXTET)	+= gpio-moxtet.o
>  obj-$(CONFIG_GPIO_MPC5200)	+= gpio-mpc5200.o
>  obj-$(CONFIG_GPIO_MPC8XXX)	+= gpio-mpc8xxx.o
>  obj-$(CONFIG_GPIO_MSIC)		+= gpio-msic.o
> @@ -100,7 +101,7 @@ obj-$(CONFIG_GPIO_PCI_IDIO_16)	+= gpio-pci-idio-16.o
>  obj-$(CONFIG_GPIO_PCIE_IDIO_24)	+= gpio-pcie-idio-24.o
>  obj-$(CONFIG_GPIO_PISOSR)	+= gpio-pisosr.o
>  obj-$(CONFIG_GPIO_PL061)	+= gpio-pl061.o
> -obj-$(CONFIG_GPIO_PMIC_EIC_SPRD)	+= gpio-pmic-eic-sprd.o
> +obj-$(CONFIG_GPIO_PMIC_EIC_SPRD)+= gpio-pmic-eic-sprd.o
>  obj-$(CONFIG_GPIO_PXA)		+= gpio-pxa.o
>  obj-$(CONFIG_GPIO_RC5T583)	+= gpio-rc5t583.o
>  obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o

Did you review your own patch? If so, you would of noticed something
odd going on here.

> diff --git a/drivers/gpio/gpio-moxtet.c b/drivers/gpio/gpio-moxtet.c
> new file mode 100644
> index 000000000000..d0b50581118d
> --- /dev/null
> +++ b/drivers/gpio/gpio-moxtet.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Turris Mox Moxtet GPIO expander
> + *
> + *  Copyright (C) 2018 Marek Behun <marek.behun@nic.cz>
> + */
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/gpio.h>
> +#include <linux/mfd/moxtet.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +
> +struct moxtet_gpio_chip {
> +	struct device		*dev;
> +	struct gpio_chip	gpio_chip;
> +	u8			in_mask;
> +	u8			out_mask;
> +};
> +
> +static int moxtet_gpio_dir_mask(struct gpio_chip *gc, unsigned int offset,
> +				int *dir, u8 *mask)
> +{
> +	struct moxtet_gpio_chip *chip = gpiochip_get_data(gc);
> +	int i;
> +
> +	*dir = 0;
> +	for (i = 0; i < 4; ++i) {
> +		*mask = 1 << i;
> +		if (*mask & chip->in_mask) {
> +			if (offset == 0)
> +				return 0;
> +			--offset;
> +		}
> +	}
> +
> +	*dir = 1;
> +	for (i = 0; i < 8; ++i) {
> +		*mask = 1 << i;
> +		if (*mask & chip->out_mask) {
> +			if (offset == 0)
> +				return 0;
> +		}
> +	}

You need some comment about what is going on here, because it is not
obvious.

	Andrew
