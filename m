From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 3 Nov 2009 10:57:37 +0000
Subject: dream: glue for mmc controller
In-Reply-To: <20091103105319.GA2492@elf.ucw.cz>
References: <20091103105319.GA2492@elf.ucw.cz>
Message-ID: <20091103105737.GE20341@fluff.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2009 at 11:53:20AM +0100, Pavel Machek wrote:
> 
> This is what I came up with (relative to the previous
> patches). Unfortunately, it does not quite work: mmc controller is
> detected, but it hangs trying to access the card.
> 
> Good news is that GPIO support seems to work, and I am able to flash
> the keyboard backlight.
> 
> Does anyone have an idea what is wrong? Do I need some more
> infrastructure to set up (DMA transfers or something?)?
> 
> I'm only setting up one mmc channel; I believe the other one is for
> wifi, and it should work like this...?
> 								Pavel
> 
> diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
> index 91e6f5c..16c0faa 100644
> --- a/arch/arm/mach-msm/Makefile
> +++ b/arch/arm/mach-msm/Makefile
> @@ -6,4 +6,4 @@ obj-y += clock.o clock-7x01a.o
>  
>  obj-$(CONFIG_MACH_HALIBUT) += board-halibut.o
>  
> -obj-$(CONFIG_MACH_TROUT) += board-dream.o
> +obj-$(CONFIG_MACH_TROUT) += board-dream.o board-dream-mmc.o board-dream-gpio.o generic_gpio.o
> diff --git a/arch/arm/mach-msm/board-dream-gpio.c b/arch/arm/mach-msm/board-dream-gpio.c
> new file mode 100644
> index 0000000..7e86a99
> --- /dev/null
> +++ b/arch/arm/mach-msm/board-dream-gpio.c
> @@ -0,0 +1,301 @@
> +/* arch/arm/mach-msm/board-dream-gpio.c
> + *
> + * Copyright (C) 2008 Google, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/irq.h>
> +#include <linux/pm.h>
> +#include <linux/sysdev.h>
> +
> +#include <asm/io.h>
> +#include <asm/gpio.h>
linux/gpio.h
linux/io.h


and why can't use you use gpiolib?

-- 
Ben (ben at fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
