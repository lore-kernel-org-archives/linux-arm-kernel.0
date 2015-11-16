From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Nov 2015 16:09:28 +0100
Subject: [PATCH 2/2] drivers/gpio: Port gpio driver to layerscape platform
In-Reply-To: <1446549552-40675-2-git-send-email-Gang.Liu@freescale.com>
References: <1446549552-40675-1-git-send-email-Gang.Liu@freescale.com>
 <1446549552-40675-2-git-send-email-Gang.Liu@freescale.com>
Message-ID: <CACRpkdb-5jed6qkawXo0PLV5jeCm+mq0rSUe8Y0V8ma=4_ot3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 3, 2015 at 12:19 PM, Liu Gang <Gang.Liu@freescale.com> wrote:

> Layerscape has the same ip block/controller as
> GPIO on powerpc platform(MPC8XXX).
>
> So use portable i/o accessors, as in_be32/out_be32
> accessors are Power architecture specific whereas
> ioread32/iowrite32 and ioread32be/iowrite32be are
> available in other architectures.
>
> Layerscape GPIO controller's registers may be big
> or little endian, so the code needs to get the
> endian property from DTB, then make additional
> functions to fit right register read/write
> operations.
>
> Currently the code can support ls2080a GPIO with
> little endian registers. And it can also work well
> on other layerscape platform with big endian GPIO
> registers.
>
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>

This doesn't seem good. You are starting to duplicate stuff
that is already available inside the gpio-generic.c driver.

Why can't this driver just select GPIO_GENERIC in
Kconfig and use the common code for handling
the endianness accessors?

bgpio_init() takes a flag
BGPIOF_BIG_ENDIAN_BYTE_ORDER
to make all accesses big endian, so using the
generic GPIO library would save you a lot of code.

Just look at other drivers for those selecting GPIO_GENERIC,
including <linux/basic_mmio_gpio.h> and calling bgpio_init().
You might want to keep some local custom BE code around
the IRQ parts.

But I would do two patches:
- One that switches MPC8xxx to using GENERIC_GPIO
- One that adds BE support using that infrastructure

It will result in a lot less code. I think.

Yours,
Linus Walleij
