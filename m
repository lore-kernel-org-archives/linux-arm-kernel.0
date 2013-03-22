From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Mar 2013 09:33:53 -0600
Subject: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
In-Reply-To: <CACRpkdYHj-rEF3Rk_CWnmmMw_Amr7m8SgQ=-2zsDYuLeuu3azw@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <1329321854-24490-4-git-send-email-b-cousson@ti.com>
 <4F44FA56.7020000@gmail.com> <4F44FC37.2000701@ti.com>
 <4F452484.5080503@gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com>
 <4F47AD08.4030504@ti.com>
 <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
 <512D39DA.7020306@ti.com> <512D3AB1.1080202@wwwdotorg.org>
 <512D3EC2.6050408@ti.com> <20130302200524.D230F3E1571@localhost>
 <51391F41.5000303@ti.com>
 <CAAwP0s1CFRO-rf==p5sYs1n0gigMif7wuT8Yv0N_iLUDMrtcOg@mail.gmail.com>
 <CACRpkdYHj-rEF3Rk_CWnmmMw_Amr7m8SgQ=-2zsDYuLeuu3azw@mail.gmail.com>
Message-ID: <514C79E1.4090106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2013 02:10 AM, Linus Walleij wrote:
> On Fri, Mar 15, 2013 at 12:21 PM, Javier Martinez Canillas
> <martinez.javier@gmail.com> wrote:
> 
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 159f5c5..f5feb43 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -807,6 +807,13 @@ static void gpio_unmask_irq(struct irq_data *d)
>>         spin_unlock_irqrestore(&bank->lock, flags);
>>  }
>>
>> +static int gpio_irq_request(struct irq_data *d)
>> +{
>> +       struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
>> +
>> +       return gpio_request(irq_to_gpio(bank, d->irq), "gpio-irq");
>> +}
>> +
>>  static struct irq_chip gpio_irq_chip = {
>>         .name           = "GPIO",
>>         .irq_shutdown   = gpio_irq_shutdown,
>> @@ -815,6 +822,7 @@ static struct irq_chip gpio_irq_chip = {
>>         .irq_unmask     = gpio_unmask_irq,
>>         .irq_set_type   = gpio_irq_type,
>>         .irq_set_wake   = gpio_wake_enable,
>> +       .irq_request    = gpio_irq_request,
>>  };
> 
> This is just turning everything on it's head. The normal order of things
> is this sequence for GPIO 14 something like:
> 
> gpio_request(14);
> int irq = gpio_to_irq(14);
> request_any_context_irq(irq);

That doesn't make any sense at all. Drivers don't want to care whether
the IRQ number they receive is a GPIO-that-can-act-like-an-IRQ or a pure
dedicated IRQ input.

To fully support the model you proprose, a driver would have to:

if (gpio_is_valid(pdata->gpio)) {
	gpio_request_one(pdata->gpio, GPIOF_IN, "foo irq");
	irq = gpio_to_irq(pdata->gpio);
} else
	irq = pdata->irq;
request_irq(...);

which means complex code in each driver, plus requiring some indication
in platform data and/or device tree re: whether the IRQ is hosted by a
GPIO or not.
