From: acourbot@nvidia.com (Alex Courbot)
Date: Wed, 11 Sep 2013 10:58:00 +0900
Subject: [PATCH 3/7] misc: ixp4-beeper: use gpiolib strictly
In-Reply-To: <1378816226-8016-1-git-send-email-linus.walleij@linaro.org>
References: <1378816226-8016-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <522FCE28.8020909@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2013 09:30 PM, Linus Walleij wrote:
> Request and free the GPIO line used for the beeper properly.
> Then use the gpiolib API to flip the output of the GPIO pin
> instead of relying on hacks to poke the register bits.
>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Arnd/Greg: seeking your ACK to take this through the GPIO tree
> as part of the attempt at cleaning out custom GPIO implementations.
> ---
>   drivers/input/misc/ixp4xx-beeper.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/ixp4xx-beeper.c
> index f14afd0..fb3bec5 100644
> --- a/drivers/input/misc/ixp4xx-beeper.c
> +++ b/drivers/input/misc/ixp4xx-beeper.c
> @@ -76,11 +76,13 @@ static int ixp4xx_spkr_event(struct input_dev *dev, unsigned int type, unsigned
>
>   static irqreturn_t ixp4xx_spkr_interrupt(int irq, void *dev_id)
>   {
> +	unsigned int pin = (unsigned int) dev_id;
> +
>   	/* clear interrupt */
>   	*IXP4XX_OSST = IXP4XX_OSST_TIMER_2_PEND;
>
>   	/* flip the beeper output */
> -	*IXP4XX_GPIO_GPOUTR ^= (1 << (unsigned int) dev_id);
> +	gpio_set_value(pin, ~gpio_get_value(pin));

Don't you want

	gpio_set_value(pin, !gpio_get_value(pin));

instead? From the deleted line I suppose you guess to invert the GPIO 
value, but using ~ will invert all the bits of the integer returned by 
gpio_get_value(), meaning that if it returns 1 you will end up calling 
gpio_set_value(-2). In practice your gpio is very unlikely to ever be 
set to 0.

>
>   	return IRQ_HANDLED;
>   }
> @@ -108,11 +110,15 @@ static int ixp4xx_spkr_probe(struct platform_device *dev)
>   	input_dev->sndbit[0] = BIT_MASK(SND_BELL) | BIT_MASK(SND_TONE);
>   	input_dev->event = ixp4xx_spkr_event;
>
> +	err = gpio_request(dev->id, "ixp4-beeper");
> +	if (err)
> +		goto err_free_device;
> +
>   	err = request_irq(IRQ_IXP4XX_TIMER2, &ixp4xx_spkr_interrupt,
>   			  IRQF_NO_SUSPEND, "ixp4xx-beeper",
>   			  (void *) dev->id);
>   	if (err)
> -		goto err_free_device;
> +		goto err_free_gpio;
>
>   	err = input_register_device(input_dev);
>   	if (err)
> @@ -124,6 +130,8 @@ static int ixp4xx_spkr_probe(struct platform_device *dev)
>
>    err_free_irq:
>   	free_irq(IRQ_IXP4XX_TIMER2, (void *)dev->id);
> + err_free_gpio:
> +	gpio_free(dev->id);
>    err_free_device:
>   	input_free_device(input_dev);
>
> @@ -142,6 +150,7 @@ static int ixp4xx_spkr_remove(struct platform_device *dev)
>   	ixp4xx_spkr_control(pin, 0);
>
>   	free_irq(IRQ_IXP4XX_TIMER2, (void *)dev->id);
> +	gpio_free(dev->id);

Just wondering, is there a reason for not using the devm_gpio functions 
here?

>
>   	return 0;
>   }
>
