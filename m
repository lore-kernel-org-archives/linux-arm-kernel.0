From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Oct 2014 16:16:56 +0100
Subject: [PATCH v1 1/3] gpio: Add APM X-Gene standby GPIO controller driver
In-Reply-To: <CAL4ahLeyPgska0AcgS756y1Nh2tEeJ4A4k4bTJrU0pzqgG08PA@mail.gmail.com>
References: <1412779948-28769-1-git-send-email-yvo@apm.com>
 <2178918.XVCQXOyoGA@wuerfel>
 <CAL4ahLeyPgska0AcgS756y1Nh2tEeJ4A4k4bTJrU0pzqgG08PA@mail.gmail.com>
Message-ID: <2250730.N6DdkCTXkh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 October 2014 22:09:00 Y Vo wrote:
> Hi Arnd,
> 
> Per Linus, shall we hold this driver until the GIC submission complete
> ? Or we will send the version without access GIC to read status in
> case the GPIO is configured IRQ ?

I'm fine with it either way.

> +static int xgene_gpio_sb_get(struct gpio_chip *gc, u32 gpio)
> +{
> +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +       struct xgene_gpio_sb *chip = to_xgene_gpio_sb(mm_gc);
> +       u32 data;
> +
> +       data = ioread32(mm_gc->regs + MPA_GPIO_IN_ADDR);
> +
> +       return (data &  GPIO_MASK(gpio)) ? 1 : 0;
> +}

This would be actually broken, right? Maybe it's better to change the
driver so that it refuses to map GPIO lines that are hardwired to
the interrupt controller, until we can support that.

	Arnd
