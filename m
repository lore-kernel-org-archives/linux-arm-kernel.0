From: gnurou@gmail.com (Alexandre Courbot)
Date: Sat, 21 Jun 2014 16:39:42 +0900
Subject: [PATCH V4 1/3] gpio: Add APM X-Gene SoC GPIO controller support
In-Reply-To: <1403136531-20808-2-git-send-email-fkan@apm.com>
References: <1403136531-20808-1-git-send-email-fkan@apm.com>
 <1403136531-20808-2-git-send-email-fkan@apm.com>
Message-ID: <CAAVeFu+=VX-f9UrZN4WPihZY0KDGrue1ixofP9Kb+KVvpDCfuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 9:08 AM, Feng Kan <fkan@apm.com> wrote:
> Add APM X-Gene SoC gpio controller driver.
>
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  drivers/gpio/Kconfig      |   9 ++
>  drivers/gpio/Makefile     |   1 +
>  drivers/gpio/gpio-xgene.c | 252 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 262 insertions(+)
>  create mode 100644 drivers/gpio/gpio-xgene.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 4a1b511..833996a02 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -334,6 +334,15 @@ config GPIO_TZ1090_PDC
>         help
>           Say yes here to support Toumaz Xenif TZ1090 PDC GPIOs.
>
> +config GPIO_XGENE
> +       bool "APM X-Gene GPIO controller support"
> +       depends on ARM64 && OF_GPIO
> +       help
> +         This driver is to support the GPIO block within the APM X-Gene SoC
> +         platform's generic flash controller. The GPIO pins are muxed with
> +         the generic flash controller's address and data pins. Say yes
> +         here to enable the GFC GPIO functionality.
> +
>  config GPIO_XILINX
>         bool "Xilinx GPIO support"
>         depends on PPC_OF || MICROBLAZE || ARCH_ZYNQ
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index d10f6a9..1bf5f82 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -98,6 +98,7 @@ obj-$(CONFIG_GPIO_VX855)      += gpio-vx855.o
>  obj-$(CONFIG_GPIO_WM831X)      += gpio-wm831x.o
>  obj-$(CONFIG_GPIO_WM8350)      += gpio-wm8350.o
>  obj-$(CONFIG_GPIO_WM8994)      += gpio-wm8994.o
> +obj-$(CONFIG_GPIO_XGENE)       += gpio-xgene.o
>  obj-$(CONFIG_GPIO_XILINX)      += gpio-xilinx.o
>  obj-$(CONFIG_GPIO_XTENSA)      += gpio-xtensa.o
>  obj-$(CONFIG_GPIO_ZEVIO)       += gpio-zevio.o
> diff --git a/drivers/gpio/gpio-xgene.c b/drivers/gpio/gpio-xgene.c
> new file mode 100644
> index 0000000..3a747cc
> --- /dev/null
> +++ b/drivers/gpio/gpio-xgene.c
> @@ -0,0 +1,252 @@
> +/*
> + * AppliedMicro X-Gene SoC GPIO Driver
> + *
> + * Copyright (c) 2014, Applied Micro Circuits Corporation
> + * Author: Feng Kan <fkan@apm.com>.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/spinlock.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of.h>
> +#include <linux/gpio.h>

Please use the new GPIO headers, linux/gpio/driver.h. I also don't
think you will need of_gpio.h with it.

> +#include <linux/types.h>
> +#include <linux/clk.h>

Why is clk.h needed here?

Apart from these minor points I guess I have nothing to complain about
for this version. :)

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
