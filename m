From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 13 Sep 2018 09:47:42 +0200
Subject: unexpected side effect of "gpiolib: override irq_enable/disable"
In-Reply-To: <f64fcb6a-172f-45e8-af8f-f1e7bae3b4d8@xs4all.nl>
References: <20180912145829.hzklqndjasac2ap4@M43218.corp.atmel.com>
 <f64fcb6a-172f-45e8-af8f-f1e7bae3b4d8@xs4all.nl>
Message-ID: <20180913074742.7cdvfiosb3nyc4ui@M43218.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Wed, Sep 12, 2018 at 05:30:35PM +0200, Hans Verkuil wrote:
> Hi Ludovic,
> 
> On 09/12/2018 04:58 PM, Ludovic Desroches wrote:
> > Hi,
> > 
> > Using next-20180912, my kernel hangs during the boot. Git bisect tell me
> > that the cause of my issue is the commit "gpiolib: override
> > irq_enable/disable"
> > 
> > I dug further and this patch can have some side effects. When booting, I
> > have an infinite loop when trying to enable a gpio irq. I don't know if
> > the pinctrl-at91 driver is the only one concerned or not.
> > 
> > The pattern leading to this issue is quite simple: we have several gpio
> > controllers sharing the same irq_chip structure. Installing the
> > irq_enable/irq_disable hook works well the first time. The second time,
> > since the irq_enable has been altered to use gpiochip_irq_enable,
> > this latest function will call itself again and again by calling
> > irq_enable.
> > 
> > I think it should be better to have one irq_chip structure per gpio
> > controller. I am going to do a patch for pinctrl-at91. Excepting if you
> > think it has to be solved in a different way.
> > 
> > 
> > Ludovic
> > 
> 
> Can you try this patch first?

Yes it works, I also have this kind of change in mind.

I am not sure which solution is the best. Of course I prefer this one as
I don't have to modify the pinctrl-at91 driver but if I have to modify
it to not share the same irq_chip structure, I'll handle it. Just let me
know.

Thanks

Regards

Ludovic

> 
> Thanks!
> 
> 	Hans
> 
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> ---
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index efce534a269b..e09e4e439928 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1859,6 +1859,8 @@ static void gpiochip_set_irq_hooks(struct gpio_chip *gpiochip)
>  	}
>  	if (WARN_ON(gpiochip->irq.irq_enable))
>  		return;
> +	if (irqchip->irq_enable == gpiochip_irq_enable)
> +		return;
>  	gpiochip->irq.irq_enable = irqchip->irq_enable;
>  	gpiochip->irq.irq_disable = irqchip->irq_disable;
>  	irqchip->irq_enable = gpiochip_irq_enable;
