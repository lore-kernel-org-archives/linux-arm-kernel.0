From: olof@lixom.net (Olof Johansson)
Date: Thu, 24 Oct 2013 07:09:57 -0700
Subject: [PATCH v2] ARM: sa1100: remove complex GPIO interface
In-Reply-To: <1380025478-24831-1-git-send-email-linus.walleij@linaro.org>
References: <1380025478-24831-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAOesGMh01481i5tAotP6hbKHU+sOg7Ld_VhHXq3f1ZX1w8O9ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 5:24 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> The SA1100 was implementing its own variants of gpio_get_value()
> and gpio_set_value() and only selectively falling back to
> gpiolib for extended (EGPIO) handling. However the driver in
> gpio/gpio-sa1100.c already handles the same functionality for
> these lines, yet remain unused.
>
> The only upside would be things like a timing-critical hotpath
> on bit-banged GPIO, but that kind of things does not seem to
> happen on these GPIOs, so it is not worth having the extra
> complexity.
>
> Tested with some buttons on the Compaq iPAQ H3630.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - #include <linux/io.h> instead of <asm/io.h>.


Looks like this hit -next and it produces the following with simpad_defconfig:

../../arch/arm/include/asm/irq.h:9:0: warning: "NR_IRQS" redefined
[enabled by default]
 #define NR_IRQS NR_IRQS_LEGACY
 ^
In file included from ../../arch/arm/mach-sa1100/simpad.c:29:0:
../../arch/arm/mach-sa1100/include/mach/irqs.h:87:0: note: this is the
location of the previous definition
 #define NR_IRQS (IRQ_BOARD_START + NR_IRQS_LOCOMO)


http://arm-soc.lixom.net/buildlogs/next-thierry/next-20131023/buildall.arm.simpad_defconfig.log.passed


-Olof
