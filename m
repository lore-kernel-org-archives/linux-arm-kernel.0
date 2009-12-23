From: maz@misterjones.org (Marc Zyngier)
Date: Wed, 23 Dec 2009 11:23:06 +0100
Subject: [PATCH] pxa: fix gpio_to_irq() for GPIOs on expander chips
In-Reply-To: <771cded00912230107v5d2cbb18y733b62b0d6303887@mail.gmail.com>
References: <1259148990-10372-1-git-send-email-mad_soft@inbox.ru>
	<74d0deb30912140149hc20c19dy605a259dc3f6e6e0@mail.gmail.com>
	<771cded00912230107v5d2cbb18y733b62b0d6303887@mail.gmail.com>
Message-ID: <20091223112306.4a45064e@life-in-the-fast-lane>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Dec 2009 04:07:34 -0500
Haojian Zhuang <haojian.zhuang@gmail.com> wrote:

> I not prefer the patch in that link
> (http://www.spinics.net/lists/arm-kernel/msg53803.html). I think
> gpio_to_irq() macro is enough. When we handle gpio expander, we could
> implement an independant gpio_to_irq() function in expander driver.
> It's like Marc's patch
> ((http://www.spinics.net/lists/arm-kernel/msg79587.html).

I'm not sure I really get it. In my patch, the pca953x_gpio_to_irq()
function can only be called from __gpio_to_irq(). As such, it is only
useful with Philipp's patch when used on PXA.

> In platform driver, we can declare the relationship directly in below.
> 
>  static struct pca953x_platform_data gpio_exp[] = {
>         [0] = {
>                .gpio_base      = PXA_GPIO_IRQ_NUM,
>                .irq_base       = PXA_GPIO_IRQ_BASE + PXA_GPIO_IRQ_NUM,
>         },
>         [1] = {
>                .gpio_base      = PXA_GPIO_IRQ_NUM + 16,
>                .irq_base       = PXA_GPIO_IRQ_BASE + PXA_GPIO_IRQ_NUM + 16,
>         },
>  };
> 
> But I don't suggest to append ARCH_NR_GPIOS in gpio.h. Could it be
> appended into platform driver only? Since not each platform have more
> than 256 GPIOs.

We could mimic what s3c2410 does to provide some extra GPIO space for
platforms that require it (arch/arm/mach-s3c2410/include/mach/gpio.h):

#define ARCH_NR_GPIOS   (256 + CONFIG_S3C24XX_GPIO_EXTRA)

	M.
-- 
Fast. Cheap. Reliable. Pick two.
