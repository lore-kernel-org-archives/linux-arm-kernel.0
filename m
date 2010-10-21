From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 21 Oct 2010 21:14:41 +0200
Subject: [PATCHv4 2/2] ARM: imx: Add wake functionality to GPIO
In-Reply-To: <1287687324-6101-2-git-send-email-Dinh.Nguyen@freescale.com>
References: <1287687324-6101-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1287687324-6101-2-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20101021191441.GY19834@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 21, 2010 at 01:55:24PM -0500, Dinh.Nguyen at freescale.com wrote:
> From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> 
> Add function definition for irq_chip.set_wake to enable GPIO to
> wake-up the system.
> 
> This patch is based on Sascha Hauer's imx/linux-2.6 for-rmk tree.
> 
> This patch has been tested on a MX51 Babbage system that had suspend
> code implemented. The set_wake implementation is necessary for a
> GPIO to wake up a system from suspend.
> 
> Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> ---
>  arch/arm/plat-mxc/gpio.c |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
> index 9d38da0..9c3e362 100644
> --- a/arch/arm/plat-mxc/gpio.c
> +++ b/arch/arm/plat-mxc/gpio.c
> @@ -20,6 +20,7 @@
>   */
>  
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
>  #include <linux/gpio.h>
> @@ -201,11 +202,42 @@ static void mx2_gpio_irq_handler(u32 irq, struct irq_desc *desc)
>  	}
>  }
>  
> +/*
> + * Set interrupt number "irq" in the GPIO as a wake-up source.
> + * While system is running, all registered GPIO interrupts need to have
> + * wake-up enabled. When system is suspended, only selected GPIO interrupts
> + * need to have wake-up enabled.
> + * @param  irq          interrupt source number
> + * @param  enable       enable as wake-up if equal to non-zero
> + * @return       This function returns 0 on success.
> + */
> +static int gpio_set_wake_irq(u32 irq, u32 enable)
> +{
> +	u32 gpio = irq_to_gpio(irq);
> +	u32 gpio_idx = gpio & 0x1F;
> +	struct mxc_gpio_port *port = &mxc_gpio_ports[gpio / 32];
> +
> +	if (enable) {
> +		if (port->irq_high && (gpio_idx >= 16))
> +			enable_irq_wake(port->irq_high);
> +		else
> +			enable_irq_wake(port->irq);
> +	} else {
> +		if (port->irq_high && (gpio_idx >= 16))
> +			disable_irq_wake(port->irq_high);
> +		else
> +			disable_irq_wake(port->irq);
> +	}
> +
> +	return 0;
> +}
> +
Is this really enough to let the CPU wake up?  Is this implementation
correct for all i.MX SoCs?

Best regards
Uwe

>  static struct irq_chip gpio_irq_chip = {
>  	.ack = gpio_ack_irq,
>  	.mask = gpio_mask_irq,
>  	.unmask = gpio_unmask_irq,
>  	.set_type = gpio_set_irq_type,
> +	.set_wake = gpio_set_wake_irq,
>  };
>  
>  static void _set_gpio_direction(struct gpio_chip *chip, unsigned offset,
> -- 
> 1.6.0.4
> 
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
