From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 24 Feb 2011 16:42:08 +0100 (CET)
Subject: [PATCH 5/5] ARM: msm: update GPIO chained IRQ handler to use
	EOI in parent chip
In-Reply-To: <000401cbd42c$e9a957b0$bcfc0710$@deacon@arm.com>
References: <1298302096-21275-1-git-send-email-will.deacon@arm.com>
	<1298302096-21275-6-git-send-email-will.deacon@arm.com>
	<4D65A4BA.8030206@codeaurora.org>
	<alpine.LFD.2.00.1102241338410.2701@localhost6.localdomain6>
	<000401cbd42c$e9a957b0$bcfc0710$@deacon@arm.com>
Message-ID: <alpine.LFD.2.00.1102241641400.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Feb 2011, Will Deacon wrote:
> > On Wed, 23 Feb 2011, Abhijeet Dharmapurikar wrote:
> 
> Something like this?
> 
> diff --git a/arch/arm/mach-msm/gpio-v2.c b/arch/arm/mach-msm/gpio-v2.c
> index 0de19ec..90a968f 100644
> --- a/arch/arm/mach-msm/gpio-v2.c
> +++ b/arch/arm/mach-msm/gpio-v2.c
> @@ -310,6 +310,7 @@ static int msm_gpio_irq_set_type(unsigned int irq, unsigned int flow_type)
>  static void msm_summary_irq_handler(unsigned int irq, struct irq_desc *desc)
>  {
>         unsigned long i;
> +       struct irq_chip *chip = get_irq_desc_chip(desc);
>  
>         for (i = find_first_bit(msm_gpio.enabled_irqs, NR_GPIO_IRQS);
>              i < NR_GPIO_IRQS;
> @@ -318,7 +319,7 @@ static void msm_summary_irq_handler(unsigned int irq, struct irq_desc *desc)
>                         generic_handle_irq(msm_gpio_to_irq(&msm_gpio.gpio_chip,
>                                                            i));
>         }
> -       desc->chip->ack(irq);
> +       chip->irq_eoi(&desc->irq_data);

Yep. Thanks,

     tglx
> 
