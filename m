From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Jun 2013 21:05:12 +0200
Subject: [PATCH v2 7/7] ARM: davinci: Start using gpiolib API inplace of
 inline functions
In-Reply-To: <1371202532-14628-8-git-send-email-avinashphilip@ti.com>
References: <1371202532-14628-1-git-send-email-avinashphilip@ti.com>
 <1371202532-14628-8-git-send-email-avinashphilip@ti.com>
Message-ID: <CACRpkdY+6x6UyrHLrh+ya3Y+e8MjsWjZ8FS3RoQwW14mr6x6Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 11:35 AM, Philip Avinash <avinashphilip@ti.com> wrote:

> Remove NEED_MACH_GPIO_H config select option for ARCH_DAVINCI to start
> use gpiolib interface for davinci platforms. However with this software
> latencies for gpio_get/set APIs will affect. Latency has increased by 18
> microsecond with gpiolib API as compared with inline API's.
>
> Software latency is calculated on da850 EVM for gpio_get_value API by
> taking the printk timing for API execution with interrupts disabled.
> Experiment has done for inline and gpiolib API interface.
>
>   inline gpio API with interrupt disabled
>   [   29.734337] before gpio_get
>   [   29.736847] after gpio_get
>
>   Time difference 0.00251
>
>   gpio library with interrupt disabled
>   [  272.876763] before gpio_get
>   [  272.879291] after gpio_get
>
>   Time difference 0.002528
>   Latency increased by (0.002528 -  0.00251) = 18 microsecond.
>
> Also being here
> - Moved following definitions from mach folder to include directory
>         struct davinci_gpio_controller
>         Macro GPIO(x)
>         inline function __gpio_mask
> - Removed GPIO_TYPE_DAVINCI enum definition as GPIO Davinci is converted
>   to Linux device driver model.
> - With removal of select option of NEED_MACH_GPIO_H for ARCH_DAVINCI,
>   gpio-tnetv107x also start using gpiolib interface. Hence removes
>   related header files
>         arch/arm/mach-davinci/include/mach/gpio-davinci.h
>         arch/arm/mach-davinci/include/mach/gpio.h
>
>   and include linux/platform_data/gpio-davinci.h header file to support
>   gpio-davinci platform definitions.
>
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> Changes since v1:
>         - Remove inline GPIO API support for tnetv107x platforms
>         - Remove gpio header files in mach directory.
>         - Remove include of gpio header files from mach directory.
>         - Moved enum davinci_gpio_type to include folder
>         - Replace __ASM_ARCH_DAVINCI_GPIO_H with __DAVINCI_GPIO_PLATFORM_H

Acked-by: Linus Walleij <linus.walleij@linaro.org>
on this as well, and this whole 7-patch series.

For sure things look better after this series than before it,
even if there may be details I think need to be adressed later.

Yours,
Linus Walleij
