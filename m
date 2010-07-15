From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jul 2010 12:18:23 +0100
Subject: [PATCH 3/6] U6715 gpio platform driver This driver is U6XXX
	platform generic
In-Reply-To: <1278688913-26417-4-git-send-email-philippe.langlais@stericsson.com>
References: <1278688913-26417-1-git-send-email-philippe.langlais@stericsson.com>
	<1278688913-26417-4-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <20100715111823.GB29322@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, this is much better.  Just a few remaining niggles.

On Fri, Jul 09, 2010 at 05:21:50PM +0200, Philippe Langlais wrote:
> diff --git a/arch/arm/mach-u67xx/board_u67xx_wavex.c b/arch/arm/mach-u67xx/board_u67xx_wavex.c
> index 633989f..235e80d 100644
> --- a/arch/arm/mach-u67xx/board_u67xx_wavex.c
> +++ b/arch/arm/mach-u67xx/board_u67xx_wavex.c
> @@ -23,6 +23,473 @@
>  #include <mach/hardware.h>
>  #include <mach/irqs.h>
>  #include <mach/timer.h>
> +#include <mach/gpio.h>

Should be linux/gpio.h

> diff --git a/arch/arm/mach-u67xx/devices.c b/arch/arm/mach-u67xx/devices.c
> index 1d00b35..e88a106 100644
> --- a/arch/arm/mach-u67xx/devices.c
> +++ b/arch/arm/mach-u67xx/devices.c
> @@ -11,10 +11,78 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/device.h>
> +#include <linux/ioport.h>
>  #include <linux/platform_device.h>
> +#include <linux/fs.h>
> +#include <linux/gpio.h>
> +#include <mach/hardware.h>
> +#include <mach/scon.h>
> +#include <mach/gpio.h>

You're already including linux/gpio.h, so this shouldn't be required.

> diff --git a/arch/arm/plat-u6xxx/gpio.c b/arch/arm/plat-u6xxx/gpio.c
> new file mode 100644
> index 0000000..40205d2
> --- /dev/null
> +++ b/arch/arm/plat-u6xxx/gpio.c
> @@ -0,0 +1,672 @@
> +/*
> + * linux/arch/arm/plat-u6xxx/gpio.c
> + *
> + * Copyright (C) ST-Ericsson SA 2010
> + * Author: Loic Pallardy <loic.pallardy@stericsson.com> for ST-Ericsson.
> + * License terms:  GNU General Public License (GPL), version 2
> + * Support functions for GPIO
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/sched.h>
> +#include <linux/interrupt.h>
> +#include <linux/ptrace.h>
> +#include <linux/sysdev.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#include <asm/irq.h>
> +#include <asm/mach/irq.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/irqs.h>
> +#include <mach/gpio.h>

linux/gpio.h again please.

> +static struct platform_driver u6_gpio_driver = {
> +	.probe = u6_gpio_probe,
> +	.remove = NULL,
> +	.suspend = NULL,
> +	.resume = NULL,

NULL initializers aren't required.

> +	.driver = {
> +		   .name = "u6-gpio",
> +		   },

} should be aligned with the '.' of '.driver'.

Lastly, I'm confused by this in a few places:

	local_irq_save(flags);
	writel(some value, register);
	local_irq_restore(flags);

Is there a reason why this apparantly simple register write need IRQs to
be disabled?

I don't think this patch needs another review cycle, unless someone else
wants to comment on it.
