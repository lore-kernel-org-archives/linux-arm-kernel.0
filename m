From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Jun 2012 13:43:58 +0200
Subject: [PATCH] PINCTRL: SiRF: add CSR SiRFprimaII GPIO driver depending
 on pinmux APIs
In-Reply-To: <1337670845-14572-1-git-send-email-Barry.Song@csr.com>
References: <1337670845-14572-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdZfAcYiREryW=EXgxvZ1R8Adts8mb42gcnwkuiMP3T2mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 9:14 AM, Barry Song <Barry.Song@csr.com> wrote:

> +static inline struct sirfsoc_gpio_bank *sirfsoc_irq_to_bank(unsigned int irq)
> +{
> + ? ? ? return &sgpio_bank[(irq - SIRFSOC_GPIO_IRQ_START) / SIRFSOC_GPIO_BANK_SIZE];
> +}
> +
> +static inline int sirfsoc_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
> +{
> + ? ? ? return SIRFSOC_GPIO_IRQ_START + (chip->base + offset);
> +}
> +
> +static inline int sirfsoc_irq_to_offset(unsigned int irq)
> +{
> + ? ? ? return (irq - SIRFSOC_GPIO_IRQ_START) % SIRFSOC_GPIO_BANK_SIZE;
> +}
> +
> +static inline int sirfsoc_gpio_to_offset(unsigned int gpio)
> +{
> + ? ? ? return gpio % SIRFSOC_GPIO_BANK_SIZE;
> +}

Some of this is doing the work of irqdomain, which is supposed to map a certain
local IRQ number to the global space (I guess that is what is denoted by
SIRFSOC_GPIO_IRQ_START.)

Can you please look into using irqdomain for this?

There are several examples in drivers/gpio/* and drivers/pinctrl/*
for example:

drivers/gpio/gpio-pxa.c
drivers/pinctrl/pinctrl-nomadik.c


Yours,
Linus Walleij
