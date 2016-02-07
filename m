From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 6 Feb 2016 23:11:54 -0800
Subject: [PATCH v2 04/10] serial: mps2-uart: add MPS2 UART driver
In-Reply-To: <1454413199-26573-5-git-send-email-vladimir.murzin@arm.com>
References: <1454413199-26573-1-git-send-email-vladimir.murzin@arm.com>
 <1454413199-26573-5-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20160207071154.GA32017@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 11:39:53AM +0000, Vladimir Murzin wrote:
> This driver adds support to the UART controller found on ARM MPS2
> platform.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  drivers/tty/serial/Kconfig       |   12 +
>  drivers/tty/serial/Makefile      |    1 +
>  drivers/tty/serial/mps2-uart.c   |  584 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/serial_core.h |    3 +
>  4 files changed, 600 insertions(+)
>  create mode 100644 drivers/tty/serial/mps2-uart.c
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 39721ec..3a248be 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1450,6 +1450,18 @@ config SERIAL_EFM32_UART
>  	  This driver support the USART and UART ports on
>  	  Energy Micro's efm32 SoCs.
>  
> +config SERIAL_MPS2_UART_CONSOLE
> +	bool "MPS2 UART console support"
> +	depends on SERIAL_MPS2_UART
> +	select SERIAL_CORE_CONSOLE
> +
> +config SERIAL_MPS2_UART
> +	bool "MPS2 UART port"
> +	depends on ARM || COMPILE_TEST
> +	select SERIAL_CORE
> +	help
> +	  This driver support the UART ports on ARM MPS2.
> +
>  config SERIAL_EFM32_UART_CONSOLE
>  	bool "EFM32 UART/USART console support"
>  	depends on SERIAL_EFM32_UART=y
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index b391c9b..1062503 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -91,6 +91,7 @@ obj-$(CONFIG_SERIAL_CONEXANT_DIGICOLOR)	+= digicolor-usart.o
>  obj-$(CONFIG_SERIAL_MEN_Z135)	+= men_z135_uart.o
>  obj-$(CONFIG_SERIAL_SPRD) += sprd_serial.o
>  obj-$(CONFIG_SERIAL_STM32)	+= stm32-usart.o
> +obj-$(CONFIG_SERIAL_MPS2_UART)	+= mps2-uart.o
>  
>  # GPIOLIB helpers for modem control lines
>  obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
> diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
> new file mode 100644
> index 0000000..4d113ec
> --- /dev/null
> +++ b/drivers/tty/serial/mps2-uart.c
> @@ -0,0 +1,584 @@
> +/*
> + * Copyright (C) 2015 ARM Limited
> + *
> + * Author: Vladimir Murzin <vladimir.murzin@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * TODO: support for SysRq
> + */
> +
> +#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/console.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/serial_core.h>
> +#include <linux/tty_flip.h>
> +#include <linux/types.h>
> +
> +#define SERIAL_NAME "ttyS"

You can't be "ttyS", there's already a serial port named that, please
use a unique name and a new major/minor number (dynamic ideally).

thanks,

greg k-h
