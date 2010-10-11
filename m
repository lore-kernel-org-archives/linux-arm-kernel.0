From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 11 Oct 2010 14:15:11 +0200
Subject: [PATCH] mxc/gpio: make _set_value work with values != 0/1
In-Reply-To: <1286798345-32647-1-git-send-email-jacmet@sunsite.dk>
References: <1286798345-32647-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <20101011121511.GY29673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallali,

On Mon, Oct 11, 2010 at 01:59:05PM +0200, Peter Korsgaard wrote:
> Documentation/gpio.txt specifies that the value argument to
> gpio_set_value() should be handled as a boolean (E.G. != 0 is high),
> so use the same logic as in _set_direction().
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> ---
>  arch/arm/plat-mxc/gpio.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
> index 57ec4a8..e226801 100644
> --- a/arch/arm/plat-mxc/gpio.c
> +++ b/arch/arm/plat-mxc/gpio.c
> @@ -234,8 +234,13 @@ static void mxc_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>  	u32 l;
>  	unsigned long flags;
>  
> +
>  	spin_lock_irqsave(&port->lock, flags);
> -	l = (__raw_readl(reg) & (~(1 << offset))) | (value << offset);
> +	l = __raw_readl(reg);
> +	if (value)
> +		l |= 1 << offset;
> +	else
> +		l &= ~(1 << offset);
Why not just

	l = (__raw_readl(reg) & (~(1 << offset))) | (!!value << offset);

?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
