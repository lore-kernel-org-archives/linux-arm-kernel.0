From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Jan 2012 23:00:19 +0000
Subject: [PATCH] mx53_loco: add DA9053 PMIC support
In-Reply-To: <1326733853-13956-2-git-send-email-paul.liu@linaro.org>
References: <1326733853-13956-1-git-send-email-paul.liu@linaro.org>
 <1326733853-13956-2-git-send-email-paul.liu@linaro.org>
Message-ID: <20120116230019.GF32049@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 01:10:53AM +0800, Ying-Chun Liu (PaulLiu) wrote:
> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
> index fd8b524..61dd8c9 100644
> --- a/arch/arm/mach-mx5/board-mx53_loco.c
> +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> @@ -23,10 +23,21 @@
>  #include <linux/delay.h>
>  #include <linux/gpio.h>

You have this ^^^^^^^ include, which includes asm/gpio.h, and in turn
mach/gpio.h, but...

>  #include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/err.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/fixed.h>
> +#include <linux/mfd/da9052/da9052.h>
> +#include <linux/mfd/da9052/pdata.h>
>  
>  #include <mach/common.h>
>  #include <mach/hardware.h>
>  #include <mach/iomux-mx53.h>
> +#include <mach/irqs.h>
> +#include <mach/gpio.h>

you include mach/gpio.h here?  I don't see why you need mach/irqs.h
either.

That brings into this another question: you're adding 9 new linux/
includes above.  How many of those do you _actually_ need?  Eg, I
don't see you adding anything from linux/err.h to this file, so why
do you need this header?

Please don't add include files unnecessarily.
