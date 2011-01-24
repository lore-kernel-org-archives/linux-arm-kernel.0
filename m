From: khilman@ti.com (Kevin Hilman)
Date: Mon, 24 Jan 2011 14:59:10 -0800
Subject: [PATCH] This patch fix a bug in the register indexing for GPIOs
	numbers > 31 to get the relevant hardware registers of
	tnetv107x to control the GPIOs.
In-Reply-To: <1295468222-10329-1-git-send-email-hirosh.dabui@snom.com> (Hirosh
	Dabui's message of "Wed, 19 Jan 2011 21:17:02 +0100")
References: <1295468222-10329-1-git-send-email-hirosh.dabui@snom.com>
Message-ID: <878vy96h8h.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hirosh,

Hirosh Dabui <hirosh.dabui@snom.com> writes:

> In the structure tnetv107x_gpio_regs:
>
> struct tnetv107x_gpio_regs {
>             u32     idver;
>             u32     data_in[3];
>             u32     data_out[3];
>             u32     direction[3];
>             u32     enable[3];
> };
>
> The GPIO hardware register addresses of tnetv107x are stored.
> The chip implements 3 registers of each entity to serve 96 GPIOs,
> each register provides a subset of 32 GPIOs.
> The driver provides these macros: gpio_reg_set_bit, gpio_reg_get_bit
> and gpio_reg_clear_bit.

The first sentence of the changelog has become the subject (and thus the
git shortlog) of this patch.   Please update and make the subject
something like it was before:

  davinci: tnetv107x: fix register indexing for GPIOs numbers > 31

Thanks,

Kevin

>
> The bug implied the use of macros to access the relevant hardware
> register e.g. the driver code used the macro like this:
> 'gpio_reg_clear_bit(&reg->data_out, gpio)'
>
> But it has to be used like this:
> 'gpio_reg_clear_bit(reg->data_out, gpio)'.
>
> The different results are shown here:
> - &reg->data_out + 1 (it will add the full array size of data_out i.e. 12 bytes)
> - reg->data_out + 1 (it will increment only the size of data_out i.e. only 4 bytes)
>
> Acked-by: Cyril Chemparathy <cyril@ti.com>
> Signed-off-by: Hirosh Dabui <hirosh.dabui@snom.com>
> ---
>  arch/arm/mach-davinci/gpio-tnetv107x.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/gpio-tnetv107x.c b/arch/arm/mach-davinci/gpio-tnetv107x.c
> index d102986..3fa3e28 100644
> --- a/arch/arm/mach-davinci/gpio-tnetv107x.c
> +++ b/arch/arm/mach-davinci/gpio-tnetv107x.c
> @@ -58,7 +58,7 @@ static int tnetv107x_gpio_request(struct gpio_chip *chip, unsigned offset)
>  
>  	spin_lock_irqsave(&ctlr->lock, flags);
>  
> -	gpio_reg_set_bit(&regs->enable, gpio);
> +	gpio_reg_set_bit(regs->enable, gpio);
>  
>  	spin_unlock_irqrestore(&ctlr->lock, flags);
>  
> @@ -74,7 +74,7 @@ static void tnetv107x_gpio_free(struct gpio_chip *chip, unsigned offset)
>  
>  	spin_lock_irqsave(&ctlr->lock, flags);
>  
> -	gpio_reg_clear_bit(&regs->enable, gpio);
> +	gpio_reg_clear_bit(regs->enable, gpio);
>  
>  	spin_unlock_irqrestore(&ctlr->lock, flags);
>  }
> @@ -88,7 +88,7 @@ static int tnetv107x_gpio_dir_in(struct gpio_chip *chip, unsigned offset)
>  
>  	spin_lock_irqsave(&ctlr->lock, flags);
>  
> -	gpio_reg_set_bit(&regs->direction, gpio);
> +	gpio_reg_set_bit(regs->direction, gpio);
>  
>  	spin_unlock_irqrestore(&ctlr->lock, flags);
>  
> @@ -106,11 +106,11 @@ static int tnetv107x_gpio_dir_out(struct gpio_chip *chip,
>  	spin_lock_irqsave(&ctlr->lock, flags);
>  
>  	if (value)
> -		gpio_reg_set_bit(&regs->data_out, gpio);
> +		gpio_reg_set_bit(regs->data_out, gpio);
>  	else
> -		gpio_reg_clear_bit(&regs->data_out, gpio);
> +		gpio_reg_clear_bit(regs->data_out, gpio);
>  
> -	gpio_reg_clear_bit(&regs->direction, gpio);
> +	gpio_reg_clear_bit(regs->direction, gpio);
>  
>  	spin_unlock_irqrestore(&ctlr->lock, flags);
>  
> @@ -124,7 +124,7 @@ static int tnetv107x_gpio_get(struct gpio_chip *chip, unsigned offset)
>  	unsigned gpio = chip->base + offset;
>  	int ret;
>  
> -	ret = gpio_reg_get_bit(&regs->data_in, gpio);
> +	ret = gpio_reg_get_bit(regs->data_in, gpio);
>  
>  	return ret ? 1 : 0;
>  }
> @@ -140,9 +140,9 @@ static void tnetv107x_gpio_set(struct gpio_chip *chip,
>  	spin_lock_irqsave(&ctlr->lock, flags);
>  
>  	if (value)
> -		gpio_reg_set_bit(&regs->data_out, gpio);
> +		gpio_reg_set_bit(regs->data_out, gpio);
>  	else
> -		gpio_reg_clear_bit(&regs->data_out, gpio);
> +		gpio_reg_clear_bit(regs->data_out, gpio);
>  
>  	spin_unlock_irqrestore(&ctlr->lock, flags);
>  }
