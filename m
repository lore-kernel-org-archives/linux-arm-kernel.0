From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Tue, 25 Feb 2014 10:35:50 +0100
Subject: [PATCH v4 2/8] at91: pinctrl: don't request GPIOs used for
 interrupts but lock them as IRQ
In-Reply-To: <CACRpkdb8BUkLcF8=oEXsGemgFAQk6pyaX0j8t3v1xjymJsM=VQ@mail.gmail.com>
References: <1392199607-27452-1-git-send-email-jjhiblot@traphandler.com>
 <1392199607-27452-3-git-send-email-jjhiblot@traphandler.com>
 <CACRpkdb8BUkLcF8=oEXsGemgFAQk6pyaX0j8t3v1xjymJsM=VQ@mail.gmail.com>
Message-ID: <CACh+v5Mz43dcuDh7PQV+LgNxMOV+CpamNGR69f_6TTiEB5SVJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

2014-02-24 14:25 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
> On Wed, Feb 12, 2014 at 11:06 AM, Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
>
>> During the xlate stage of the DT interrupt parsing, the at91 pinctrl driver
>> requests the GPIOs that are described as interrupt sources. This prevents a
>> driver to request the gpio later to get its electrical value.
>> This patch replaces the gpio_request with a gpio_lock_as_irq to prevent the
>> gpio to be set as an ouput while allowing a subsequent gpio_request to succeed
>>
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>
> OK, but is this really correct:
>
>> @@ -1478,18 +1478,17 @@ static int at91_gpio_irq_domain_xlate(struct irq_domain *d,
>>  {
>>         struct at91_gpio_chip *at91_gpio = d->host_data;
>>         int ret;
>> -       int pin = at91_gpio->chip.base + intspec[0];
>>
>>         if (WARN_ON(intsize < 2))
>>                 return -EINVAL;
>>         *out_hwirq = intspec[0];
>>         *out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
>>
>> -       ret = gpio_request(pin, ctrlr->full_name);
>> +       ret = gpio_lock_as_irq(&at91_gpio->chip, intspec[0]);
>
> So when resolving an IRQ resource, we take for granted that it will be used
> for IRQs and IRQs only? Is it not possible that this resolution is done
> and then the driver using it unloads or whatever and it is still marked
> as IRQ?
No, once it's reserved for irq, it'll be for irq only.
>
> I don't think the xlate function should have such side effects on
> the gpio_chip internal state. I think it should just translate.

I agree but I choose to only replace the gpio_request by a
lock_as_irq(), not rework the whole thing. It seemed it would have
more chance to be accepted this way. IMO the right time to do this is
at the time of the request_irq()
>
> The line is locked for IRQ the moment its startup() callback is
> called, is it not?
>
>> -       ret = gpio_direction_input(pin);
>> +       ret = at91_gpio_direction_input(&at91_gpio->chip, intspec[0]);
>
> I actually don't like this either. This kind of thing was causing
> problems in the OMAP driver like hell.
But calling gpio_direction_input() defeats the purpose of removing the
gpio_request() because it ensures that the gpio is requested.
>
> I think this should be deleted from xlate and at91_gpio_direction_input()
> be called from the irqchip's .startup() or even .unmask() function
> instead.
irq_startup and irq_shutdown seem the right place for this because
they're called when requesting and freeing the interrupt. It'll
require a change to __setup_irq() though to check the return value of
irq_startup.

Jean-Jacques
>
> Yours,
> Linus Walleij
