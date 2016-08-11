From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 11 Aug 2016 18:15:31 +0200
Subject: [PATCH 1/3] mailbox: Add Platform Message-Handling-Unit variant
 driver
In-Reply-To: <1470732737-18391-2-git-send-email-narmstrong@baylibre.com>
References: <1470732737-18391-1-git-send-email-narmstrong@baylibre.com>
 <1470732737-18391-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <c21f4740-47bb-8c4b-f18e-8db801ee7fc3@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2016 10:52 AM, Neil Armstrong wrote:
> Add Message-Handling-Unit driver for platform variants as mailbox controller.
> Actually, only the Amlogic Meson GXBB SoC MHU is supported.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/mailbox/Kconfig        |  10 ++
>  drivers/mailbox/Makefile       |   2 +
>  drivers/mailbox/platform_mhu.c | 203 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 215 insertions(+)
>  create mode 100644 drivers/mailbox/platform_mhu.c
> 
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 97c3729..4cc93c6 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -15,6 +15,16 @@ config ARM_MHU
>  	  The controller has 3 mailbox channels, the last of which can be
>  	  used in Secure mode only.
>  
> +config PLATFORM_MHU
> +	tristate "Platform MHU Mailbox"
> +	depends on OF
> +	depends on HAS_IOMEM
> +	help
> +	  Say Y here if you want to build a platform specific variant MHU
> +	  controller driver.
> +	  The controller has a maximum of 3 mailbox channels, the last of
> +	  which can be used in Secure mode only.
> +
>  config PL320_MBOX
>  	bool "ARM PL320 Mailbox"
>  	depends on ARM_AMBA
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index 66c38e3..ace6fed 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -6,6 +6,8 @@ obj-$(CONFIG_MAILBOX_TEST)	+= mailbox-test.o
>  
>  obj-$(CONFIG_ARM_MHU)	+= arm_mhu.o
>  
> +obj-$(CONFIG_PLATFORM_MHU)	+= platform_mhu.o
> +
>  obj-$(CONFIG_PL320_MBOX)	+= pl320-ipc.o
>  
>  obj-$(CONFIG_OMAP2PLUS_MBOX)	+= omap-mailbox.o
> diff --git a/drivers/mailbox/platform_mhu.c b/drivers/mailbox/platform_mhu.c
> new file mode 100644
> index 0000000..d657a50
> --- /dev/null
> +++ b/drivers/mailbox/platform_mhu.c
> @@ -0,0 +1,203 @@
> +/*
> + * Copyright (C) 2016 BayLibre SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + * Heavily based on arm_mhu.c from :
> + * Copyright (C) 2013-2015 Fujitsu Semiconductor Ltd.
> + * Copyright (C) 2015 Linaro Ltd.
> + * Author: Jassi Brar <jaswinder.singh@linaro.org>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/spinlock.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/mailbox_controller.h>
> +
> +#define INTR_SET_OFS	0x0
> +#define INTR_STAT_OFS	0x4
> +#define INTR_CLR_OFS	0x8
> +
> +#define MHU_LP_OFFSET	0x10
> +#define MHU_HP_OFFSET	0x1c
> +
> +#define TX_REG_OFFSET	0x24
> +
> +#define MHU_CHANS	2
> +
> +struct platform_mhu_link {
> +	unsigned int irq;

This should be a signed integer.... I will repost.

> +	void __iomem *tx_reg;
> +	void __iomem *rx_reg;
> +};
> +

[...]
