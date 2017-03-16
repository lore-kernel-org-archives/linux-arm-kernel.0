From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Thu, 16 Mar 2017 15:39:19 +0000
Subject: [PATCH 1/1] pinctrl: st: add irq_request_resources callback
In-Reply-To: <CACRpkdb1WYRYifUp=C9QpEXN4ntxNfFx_H1+mA1-0UJw=dUFPQ@mail.gmail.com>
References: <1488203368-13574-1-git-send-email-patrice.chotard@st.com>
 <CACRpkdb1WYRYifUp=C9QpEXN4ntxNfFx_H1+mA1-0UJw=dUFPQ@mail.gmail.com>
Message-ID: <e80366b0-a044-0908-13bd-49856827a407@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/14/2017 03:05 PM, Linus Walleij wrote:
> On Mon, Feb 27, 2017 at 2:49 PM,  <patrice.chotard@st.com> wrote:
>
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> When using GPIO as IRQ source, the GPIO must be configured
>> in INPUT. The callback dedicated for this was missing in
>> pinctrl-st driver.
>>
>> This fix the following kernel error when trying to lock a gpio
>> as IRQ:
>>
>> [    7.521095] gpio gpiochip7: (PIO11): gpiochip_lock_as_irq: tried to flag a GPIO set as output for IRQ
>> [    7.526018] gpio gpiochip7: (PIO11): unable to lock HW IRQ 6 for IRQ
>> [    7.529405] genirq: Failed to request resources for 0-0053 (irq 81) on irqchip GPIO
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>
> I see what problem you are trying to solve.
>
>> +static int st_gpio_irq_request_resources(struct irq_data *d)
>> +{
>> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>> +       int pin = d->hwirq;
>> +
>> +       return st_gpio_direction_input(gc, pin);
>> +}
> (...)
>> +       .irq_request_resources  = st_gpio_irq_request_resources,
>
> But this is just hiding the problem I'm afraid.
>

Hi Linus

> Now thay you override .irq_request_resources()
> gpiochip_irq_reqres() will not be called, so then you have
> to lock the irq in the driver, with something like:
>
> ret = gpiochip_lock_as_irq(&chip->gc, d->hwirq);
>         if (ret)
>                 goto out;
>

Ah yes, i didn't noticed that point, thanks for the tips.

> You also have to implement the .irq_release_resources()
> callback and unlock the IRQ there.

In this case, yes the release becomes mandatory.

I will send a v2.

Thanks

Patrice

>
> Yours,
> Linus Walleij
>
