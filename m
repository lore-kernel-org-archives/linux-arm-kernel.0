From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Wed, 14 Mar 2012 07:23:20 +0530
Subject: [PATCH v3 11/13] gpio/omap: fix dataout register overwrite in
 _set_gpio_dataout_*
In-Reply-To: <8762e8v53q.fsf@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
 <1331118963-26364-12-git-send-email-tarun.kanti@ti.com>
 <87y5r5wkmu.fsf@ti.com>
 <CAC83ZvJ5rjNJoSZW=j=DXQWKWGgr_Wqu8ukOubxKd7xuEQ4pzQ@mail.gmail.com>
 <CAC83Zv+CZOGnSpOJgfCgEv-eyWXZzV+_mmd37CBMKM6iMtEksQ@mail.gmail.com>
 <CAC83ZvLmaLOr4_eZZzKyP2=KvkG+LjHjeOwvxdQHhuiB8+2L0w@mail.gmail.com>
 <8762e8v53q.fsf@ti.com>
Message-ID: <CAC83ZvLkPEu5usQsS9-5nVGdhz69vq3XQYaTwFBjo0FSnS8_Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 9:57 PM, Kevin Hilman <khilman@ti.com> wrote:
> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
>
>> On Tue, Mar 13, 2012 at 12:03 PM, DebBarma, Tarun Kanti
>> <tarun.kanti@ti.com> wrote:
>>> On Tue, Mar 13, 2012 at 11:33 AM, DebBarma, Tarun Kanti
>>> <tarun.kanti@ti.com> wrote:
>>>> On Tue, Mar 13, 2012 at 3:24 AM, Kevin Hilman <khilman@ti.com> wrote:
>>>>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>>>>
>>>>>> In the existing _set_gpio_dataout_*() implementation, the dataout
>>>>>> register is overwritten every time the function is called. This is
>>>>>> not intended behavior because that would end up one user of a GPIO
>>>>>> line overwriting what is written by another. Fix this so that previous
>>>>>> value is always preserved until explicitly changed by respective
>>>>>> user/driver of the GPIO line.
>>>>>>
>>>>>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>>>>>> ---
>>>>>> ?drivers/gpio/gpio-omap.c | ? ?3 +++
>>>>>> ?1 files changed, 3 insertions(+), 0 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>>>>> index 04c2677..2e8e476 100644
>>>>>> --- a/drivers/gpio/gpio-omap.c
>>>>>> +++ b/drivers/gpio/gpio-omap.c
>>>>>> @@ -114,6 +114,7 @@ static void _set_gpio_dataout_reg(struct gpio_bank *bank, int gpio, int enable)
>>>>>> ? ? ? else
>>>>>> ? ? ? ? ? ? ? reg += bank->regs->clr_dataout;
>>>>>>
>>>>>> + ? ? l |= __raw_readl(bank->base + bank->regs->set_dataout);
>>>>>
>>>>> minor: IMO, it's more reader-friendly if this looks like
>>>>>
>>>>> ? ? ? l = __raw_read(...)
>>>>> ? ? ? l |= GPIO_BIT(...)
>>>>> ? ? ? __raw_write(...)
>>>> Agreed. I will make the change.
>>> Also, the read should be: __raw_readl(bank->base + bank->regs->dataout);
>>> instead of bank->regs->set_dataout.
>> I see a problem with this implementation. It is not correct to write l
>> |= GPIO_BIT(...).
>> For example if we write to clr_dataout register we would end up
>> clearing bits which
>> we are not supposed to. We should just be operating on current GPIO_BIT(...).
>> The l |= GPIO_BIT(...) is needed just to make sure that we have the
>> right context
>> stored. So the overall sequence should be something like this:
>>
>> ? ? ? ? void __iomem *reg = bank->base;
>> ? ? ? ? u32 l = GPIO_BIT(bank, gpio);
>>
>> ? ? ? ? if (enable)
>> ? ? ? ? ? ? ? ? reg += bank->regs->set_dataout;
>> ? ? ? ? else
>> ? ? ? ? ? ? ? ? reg += bank->regs->clr_dataout;
>>
>> ? ? ? ? __raw_writel(l, reg);
>> ? ? ? ? l |= __raw_readl(bank->base + bank->regs->dataout);
>> ? ? ? ? bank->context.dataout = l;
>
> Again, you don't need the extra read-back here. ?Just set/clear the bit
> in the context. ?Untested patch below.
Alright.
--
Tarun
>
> Kevin
>
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 0b05629..db905c0 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -111,10 +111,13 @@ static void _set_gpio_dataout_reg(struct gpio_bank *bank, int gpio, int enable)
> ? ? ? ?void __iomem *reg = bank->base;
> ? ? ? ?u32 l = GPIO_BIT(bank, gpio);
>
> - ? ? ? if (enable)
> + ? ? ? if (enable) {
> ? ? ? ? ? ? ? ?reg += bank->regs->set_dataout;
> - ? ? ? else
> + ? ? ? ? ? ? ? bank->context.dataout |= l;
> + ? ? ? } else {
> ? ? ? ? ? ? ? ?reg += bank->regs->clr_dataout;
> + ? ? ? ? ? ? ? bank->context.dataout &= ~l;
> + ? ? ? }
