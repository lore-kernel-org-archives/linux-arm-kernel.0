From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Feb 2016 16:51:57 +0100
Subject: [PATCH 3/4] gpio: ep93xx: remove private irq_to_gpio function
In-Reply-To: <1455551208-2825510-4-git-send-email-arnd@arndb.de>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <1455551208-2825510-1-git-send-email-arnd@arndb.de>
 <1455551208-2825510-4-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdb3nKTEDCvafURhKRPJipJ=K_y1oyE_kKc=-T8E=Bai0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 4:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The ep93xx goes through its own back-and-forth dance every time
> it wants to know the gpio number for an irq line, when it really
> just hardcodes a fixed offset in ep93xx_gpio_to_irq().
>
> This removes the pointless macro and replaces the conversion inside
> of the driver with simple add/subtract operations, using an
> explicit macro.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
(...)

> -#include <linux/gpio/driver.h>
> -/* FIXME: this is here for gpio_to_irq() - get rid of this! */
>  #include <linux/gpio.h>

No, what you want to get rid of is the #include <linux/gpio.h> not the
<linux/gpio/driver.h>, we want to be more specific. Sorry for putting the
comment wrong.

> @@ -35,6 +31,7 @@ void __iomem *ep93xx_gpio_base; /* FIXME: put this into irq_data */
>  #define EP93XX_GPIO_LINE_MAX           63
>
>  /* maximum value for irq capable line identifiers */
> +#define EP93XX_GPIO_IRQ_BASE           64
>  #define EP93XX_GPIO_LINE_MAX_IRQ       23

This doesn't apply to my tree :O

My EP93XX_GPIO_LINE_MAX_IRQ is in
arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h

So I think you must be having another patch somewhere in the ARM SoC
tree. (I can take it, just send it along with an update of this one.)

Yours,
Linus Walleij
