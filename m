From: balbi@ti.com (Felipe Balbi)
Date: Thu, 23 Feb 2012 14:31:31 +0200
Subject: [PATCH 6/6] gpio/omap: fix _set_gpio_irqenable implementation
In-Reply-To: <1329999031-6914-7-git-send-email-tarun.kanti@ti.com>
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
 <1329999031-6914-7-git-send-email-tarun.kanti@ti.com>
Message-ID: <20120223123130.GJ18463@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 05:40:31PM +0530, Tarun Kanti DebBarma wrote:
> This function should be capable of both enabling and disabling interrupts
> based upon the *enable* parameter. Right now the function only enables
> the interrupt and *enable* is not used at all. So add the interrupt
> disable capability also using the parameter.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

This one should probably be ported to stable releases, adding
stable at vger to the cc list

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/gpio/gpio-omap.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 67535c8..acc71a0 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -473,7 +473,10 @@ static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
>  
>  static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)
>  {
> -	_enable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
> +	if (enable)
> +		_enable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
> +	else
> +		_disable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
>  }
>  
>  /*
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120223/f56fa8fd/attachment-0001.sig>
