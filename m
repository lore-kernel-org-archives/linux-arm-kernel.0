From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Jan 2018 11:08:15 +0100
Subject: [PATCH 3/4] bcm2835-gpio-exp: Driver for GPIO expander via
 mailbox service
In-Reply-To: <bcac00c71b29c359b59053a30d817a8f17d6731d.1514898134.git.baruch@tkos.co.il>
References: <cover.1514898134.git.baruch@tkos.co.il>
 <bcac00c71b29c359b59053a30d817a8f17d6731d.1514898134.git.baruch@tkos.co.il>
Message-ID: <CACRpkdb73jGGRm5OrXLGYSOjMni-NsOwdC7TXH2k+iAEnAvL2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 2, 2018 at 2:19 PM, Baruch Siach <baruch@tkos.co.il> wrote:

> +config GPIO_BCM_EXP
> +       bool "Broadcom Exp GPIO"
> +       depends on OF_GPIO && RASPBERRYPI_FIRMWARE && (ARCH_BCM2835 || COMPILE_TEST)
> +       help
> +         Turn on GPIO support for Broadcom chips using the firmware mailbox
> +         to communicate with VideoCore on BCM283x chips.

Should this be

default RASPBERRYPI_FIRMWARE

So it is always available if the firmware interface is there?

> +#include <linux/err.h>
> +#include <linux/gpio.h>

Just use

#include <linux/driver.h>

> +#define MODULE_NAME "brcmexp-gpio"
> +#define NUM_GPIO 8
> +
> +struct brcmexp_gpio {
> +       struct gpio_chip gc;
> +       struct device *dev;
> +       struct rpi_firmware *fw;
> +};
> +
> +struct gpio_set_config {
> +       u32 gpio, direction, polarity, term_en, term_pull_up, state;
> +};
> +
> +struct gpio_get_config {
> +       u32 gpio, direction, polarity, term_en, term_pull_up;
> +};

Seems to support some pin control stuff, hm?

The pull ups seems unused though so OK.

Yours,
Linus Walleij
