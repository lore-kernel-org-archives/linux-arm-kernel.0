From: darkstar6262@gmail.com (Cory Maccarrone)
Date: Mon, 6 Dec 2010 21:20:24 -0800
Subject: [PATCH v8 04/11] OMAP7xx: GPIO: Introduce support for GPIO init
In-Reply-To: <1290689318-10191-5-git-send-email-charu@ti.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
	<1290689318-10191-5-git-send-email-charu@ti.com>
Message-ID: <AANLkTi=jjqj8Gv5tWqfMnndM037U-Qidtp=ju3VmhQyF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 4:48 AM, Varadarajan, Charulatha <charu@ti.com> wrote:
> Add support for handling OMAP7xx specific gpio_init by
> providing platform device data and doing device registration.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
> ?arch/arm/mach-omap1/gpio7xx.c | ?261 +++++++++++++++++++++++++++++++++++++++++
> ?1 files changed, 261 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-omap1/gpio7xx.c
>
> diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
> new file mode 100644
> index 0000000..94bccd4
> --- /dev/null
> +++ b/arch/arm/mach-omap1/gpio7xx.c
> @@ -0,0 +1,261 @@
> +/*
> + * OMAP7xx specific gpio init
> + *
> + * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * Author:
> + * ? ? Charulatha V <charu@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/gpio.h>
> +
> +#define OMAP7XX_GPIO1_BASE ? ? ? ? ? ? 0xfffbc000
> +#define OMAP7XX_GPIO2_BASE ? ? ? ? ? ? 0xfffbc800
> +#define OMAP7XX_GPIO3_BASE ? ? ? ? ? ? 0xfffbd000
> +#define OMAP7XX_GPIO4_BASE ? ? ? ? ? ? 0xfffbd800
> +#define OMAP7XX_GPIO5_BASE ? ? ? ? ? ? 0xfffbe000
> +#define OMAP7XX_GPIO6_BASE ? ? ? ? ? ? 0xfffbe800
> +#define OMAP1_MPUIO_VBASE ? ? ? ? ? ? ?OMAP1_MPUIO_BASE
> +
> +/* mpu gpio */
> +static struct __initdata resource omap7xx_mpu_gpio_resources[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .start ?= OMAP1_MPUIO_VBASE,
> + ? ? ? ? ? ? ? .end ? ?= OMAP1_MPUIO_VBASE + SZ_2K - 1,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .start ?= INT_7XX_MPUIO,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_IRQ,
> + ? ? ? },
> +};
> +
> +static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
> + ? ? ? .virtual_irq_start ? ? ?= IH_MPUIO_BASE,
> + ? ? ? .bank_type ? ? ? ? ? ? ?= METHOD_MPUIO,
> + ? ? ? .bank_width ? ? ? ? ? ? = 32,

I think we need

    .dbck_flag = false,

here -- we don't have a dbclk on omap7xx.  Without this, we get:

    omap_gpio omap_gpio.5: Could not get gpio dbck
    omap_gpio omap_gpio.6: Could not get gpio dbck

This needs to be added to the other 5 GPIO blocks in this file as well.

- Cory
