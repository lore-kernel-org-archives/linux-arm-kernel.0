From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 11 Oct 2010 14:12:07 +0200
Subject: [PATCH] mxc/gpio: make _set_value work with values != 0/1
In-Reply-To: <1286798345-32647-1-git-send-email-jacmet@sunsite.dk>
References: <1286798345-32647-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <4CB2FF17.1020803@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2010 01:59 PM, Peter Korsgaard wrote:
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

what about using "!!value" instead of just "value".

> +	l = __raw_readl(reg);
> +	if (value)
> +		l |= 1 << offset;
> +	else
> +		l &= ~(1 << offset);
>  	__raw_writel(l, reg);
>  	spin_unlock_irqrestore(&port->lock, flags);
>  }

cheers, Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101011/2c692258/attachment.sig>
