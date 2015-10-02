From: yvo@apm.com (Y Vo)
Date: Fri, 2 Oct 2015 21:03:47 +0700
Subject: [PATCH 1/2] gpio: xgene: add support to configure GPIO line as
 input, output or external IRQ pin
In-Reply-To: <CACRpkdbos6r_S06r9gR9Mn7qu-ri61UJcQM332JK6S4gFwSN-A@mail.gmail.com>
References: <1441963332-13329-1-git-send-email-yvo@apm.com>
 <1441963332-13329-2-git-send-email-yvo@apm.com>
 <CACRpkdbos6r_S06r9gR9Mn7qu-ri61UJcQM332JK6S4gFwSN-A@mail.gmail.com>
Message-ID: <CAL4ahLfYO5nGvUbi6L5SUfhrj6o-O4-uvhFdrppojvH8Hwumjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 2, 2015 at 4:51 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Sep 11, 2015 at 2:22 AM, Y Vo <yvo@apm.com> wrote:
>
>> Add support to configure GPIO line as input, output or external IRQ pin.
>>
>> Signed-off-by: Y Vo <yvo@apm.com>
>
> Mostly OK but...
>
>>  #define XGENE_MAX_GPIO_DS              22
>>  #define XGENE_MAX_GPIO_DS_IRQ          6
>> +#define XGENE_GPIO8_HWIRQ              0x48
>> +#define XGENE_GPIO8_IDX                        8
> (...)
>> +static int xgene_irq_to_line(u32 irq)
>> +{
>> +       u32 offset = irq_get_irq_data(irq)->hwirq - XGENE_GPIO8_HWIRQ;
>> +
>> +       return (offset < XGENE_MAX_GPIO_DS_IRQ) ?
>> +                       (offset + XGENE_GPIO8_IDX) : -EINVAL;
>> +}
>
> What is this hardcoded IRQ 0x48 business?

This is hardware irq number ~ GPIO_DS8. So we use it to get the gpio
number from hwirq. But we are preparing another version which is
better to configure the GPIO lines as interrupt or direction(in/out).

>
> This patch needs kerneldoc for this xgene_irq_to_line() to explain
> what exactly is going on, or noone will understand it enough to
> debug or refactor the code.
>
> I hope this 0x48 is not some way of compensating for Linux internal
> IRQ offsets, that is what irqdomain is for.
>
> Yours,
> Linus Walleij
