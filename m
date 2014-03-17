From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Mon, 17 Mar 2014 12:14:50 +0100
Subject: [PATCH v5 3/9] at91: pinctrl: don't request GPIOs used for
 interrupts but lock them as IRQ
In-Reply-To: <53205A46.6000304@gmail.com>
References: <1393841162-25339-1-git-send-email-jjhiblot@traphandler.com>
 <1393841162-25339-4-git-send-email-jjhiblot@traphandler.com>
 <53205A46.6000304@gmail.com>
Message-ID: <CACh+v5N+Ms9ZVFN=F_sQQhRbwhiYFg6LO+383UL8iw7qYaPKtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Sorry for being late, I was on vacation.
Yes this patch can be dropped from the serie.

2014-03-12 13:59 GMT+01:00 Boris BREZILLON <b.brezillon.dev@gmail.com>:
> Hi JJ,
>
> IIRC this patch was necessary for the DM9000 device, which is not defined
> in this series anymore.
> And, correct me if I'm wrong, but there's still a discussion about how
> this should be fixed properly (https://lkml.org/lkml/2014/2/25/388).
>
> As a result, shouldn't we remove this patch from this series ?
>
> Best Regards,
>
> Boris
>
> Le 03/03/2014 11:05, Jean-Jacques Hiblot a ?crit :
>
>> During the xlate stage of the DT interrupt parsing, the at91 pinctrl
>> driver
>> requests the GPIOs that are described as interrupt sources. This prevents
>> a
>> driver to request the gpio later to get its electrical value.
>> This patch replaces the gpio_request with a gpio_lock_as_irq to prevent
>> the
>> gpio to be set as an ouput while allowing a subsequent gpio_request to
>> succeed
>>
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>> ---
>>   drivers/pinctrl/pinctrl-at91.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-at91.c
>> b/drivers/pinctrl/pinctrl-at91.c
>> index d990e33..db55b96 100644
>> --- a/drivers/pinctrl/pinctrl-at91.c
>> +++ b/drivers/pinctrl/pinctrl-at91.c
>> @@ -1478,18 +1478,17 @@ static int at91_gpio_irq_domain_xlate(struct
>> irq_domain *d,
>>   {
>>         struct at91_gpio_chip *at91_gpio = d->host_data;
>>         int ret;
>> -       int pin = at91_gpio->chip.base + intspec[0];
>>         if (WARN_ON(intsize < 2))
>>                 return -EINVAL;
>>         *out_hwirq = intspec[0];
>>         *out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
>>   -     ret = gpio_request(pin, ctrlr->full_name);
>> +       ret = gpio_lock_as_irq(&at91_gpio->chip, intspec[0]);
>>         if (ret)
>>                 return ret;
>>   -     ret = gpio_direction_input(pin);
>> +       ret = at91_gpio_direction_input(&at91_gpio->chip, intspec[0]);
>>         if (ret)
>>                 return ret;
>>
>
>
