From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Fri, 15 Apr 2011 18:51:48 -0700
Subject: [PATCH 4/6] ARM: msm: update GPIO chained IRQ handler to use
	entry/exit functions
In-Reply-To: <1302633340-4795-5-git-send-email-will.deacon@arm.com>
References: <1302633340-4795-1-git-send-email-will.deacon@arm.com>
	<1302633340-4795-5-git-send-email-will.deacon@arm.com>
Message-ID: <4DA8F634.9080803@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:
> This patch updates the MSM gpio chained IRQ handler to use the chained
> IRQ enter/exit functions in order to function correctly on primary
> controllers with different methods of flow control.
> 
> Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/mach-msm/gpio-v2.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-msm/gpio-v2.c b/arch/arm/mach-msm/gpio-v2.c
> index 56a964e..cc9c4fd 100644
> --- a/arch/arm/mach-msm/gpio-v2.c
> +++ b/arch/arm/mach-msm/gpio-v2.c
> @@ -27,6 +27,9 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
> +
> +#include <asm/mach/irq.h>
> +
>  #include <mach/msm_iomap.h>
>  #include "gpiomux.h"
>  
> @@ -309,8 +312,10 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int flow_type)
>   */
>  static void msm_summary_irq_handler(unsigned int irq, struct irq_desc *desc)
>  {
> -	struct irq_data *data = irq_desc_get_irq_data(desc);
>  	unsigned long i;
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +
> +	chained_irq_enter(chip, desc);
>  
>  	for (i = find_first_bit(msm_gpio.enabled_irqs, NR_GPIO_IRQS);
>  	     i < NR_GPIO_IRQS;
> @@ -319,7 +324,8 @@ static void msm_summary_irq_handler(unsigned int irq, struct irq_desc *desc)
>  			generic_handle_irq(msm_gpio_to_irq(&msm_gpio.gpio_chip,
>  							   i));
>  	}
> -	data->chip->irq_ack(data);
> +
> +	chained_irq_exit(chip, desc);
>  }
>  
>  static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)

Reviewed-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Tested-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>

-- 
--
Sent by an employee of the Qualcomm Innovation Center, Inc. The Qualcomm 
Innovation Center, Inc. is a member of the Code Aurora Forum.
