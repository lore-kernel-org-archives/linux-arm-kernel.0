From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 18 Apr 2012 22:59:58 +0200
Subject: [PATCH] gpio: pxa: Set PXA GPIO irq_chip IRQCHIP_SKIP_SET_WAKE
 flag
In-Reply-To: <1334777684.34148.YahooMailClassic@web29014.mail.ird.yahoo.com>
 (Paul Parsons's message of "Wed, 18 Apr 2012 20:34:44 +0100 (BST)")
References: <1334777684.34148.YahooMailClassic@web29014.mail.ird.yahoo.com>
Message-ID: <8762cwhi29.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Parsons <lost.distance@yahoo.com> writes:

> I had a quick look at arch/arm/mach-pxa/mioa701.c and
> noticed that it didn't call gpio_set_wake() for GPIO0.
> Does this help:
>
> diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
> index 061d570..23190bf 100644
> --- a/arch/arm/mach-pxa/mioa701.c
> +++ b/arch/arm/mach-pxa/mioa701.c
> @@ -726,6 +726,7 @@ static void __init mioa701_machine_init(void)
>  
>  
>  	pxa2xx_mfp_config(ARRAY_AND_SIZE(mioa701_pin_config));
> +	gpio_set_wake(GPIO0_KEY_POWER, 1);
>  	pxa_set_ffuart_info(NULL);
>  	pxa_set_btuart_info(NULL);
>  	pxa_set_stuart_info(NULL);

Yes, the wakeup works again with the gpio_set_wake() call.
But that shouldn't be necessary. The legacy method that worked, if I remember
correctly, was :
 - suspend is triggered
 - gpio_keys.c: gpio_keys_suspend() is called
 - as mioa701 setup the platform data for gpio_keys_data as :
   MIO_KEY(KEY_EXIT, GPIO0_KEY_POWER, "Power button", 1),
     => implies struct gpio_keys_button has the button with .wakeup=1
   This triggers in gpio_keys_suspend():
                     -> enable_irq_wake(bdata->irq)

This enable_irq_wake() should in the end call gpio_set_wake(0, 1), but apparently
it doesn't for some reason. This the part I have to check.

Cheers.

-- 
Robert
