From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Tue, 13 Mar 2012 12:03:34 +0530
Subject: [PATCH v3 11/13] gpio/omap: fix dataout register overwrite in
 _set_gpio_dataout_*
In-Reply-To: <CAC83ZvJ5rjNJoSZW=j=DXQWKWGgr_Wqu8ukOubxKd7xuEQ4pzQ@mail.gmail.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
 <1331118963-26364-12-git-send-email-tarun.kanti@ti.com>
 <87y5r5wkmu.fsf@ti.com>
 <CAC83ZvJ5rjNJoSZW=j=DXQWKWGgr_Wqu8ukOubxKd7xuEQ4pzQ@mail.gmail.com>
Message-ID: <CAC83Zv+CZOGnSpOJgfCgEv-eyWXZzV+_mmd37CBMKM6iMtEksQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 11:33 AM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
> On Tue, Mar 13, 2012 at 3:24 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>
>>> In the existing _set_gpio_dataout_*() implementation, the dataout
>>> register is overwritten every time the function is called. This is
>>> not intended behavior because that would end up one user of a GPIO
>>> line overwriting what is written by another. Fix this so that previous
>>> value is always preserved until explicitly changed by respective
>>> user/driver of the GPIO line.
>>>
>>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>>> ---
>>> ?drivers/gpio/gpio-omap.c | ? ?3 +++
>>> ?1 files changed, 3 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>> index 04c2677..2e8e476 100644
>>> --- a/drivers/gpio/gpio-omap.c
>>> +++ b/drivers/gpio/gpio-omap.c
>>> @@ -114,6 +114,7 @@ static void _set_gpio_dataout_reg(struct gpio_bank *bank, int gpio, int enable)
>>> ? ? ? else
>>> ? ? ? ? ? ? ? reg += bank->regs->clr_dataout;
>>>
>>> + ? ? l |= __raw_readl(bank->base + bank->regs->set_dataout);
>>
>> minor: IMO, it's more reader-friendly if this looks like
>>
>> ? ? ? l = __raw_read(...)
>> ? ? ? l |= GPIO_BIT(...)
>> ? ? ? __raw_write(...)
> Agreed. I will make the change.
Also, the read should be: __raw_readl(bank->base + bank->regs->dataout);
instead of bank->regs->set_dataout.
--
Tarun
>
>>
>>> ? ? ? __raw_writel(l, reg);
>>> ? ? ? bank->context.dataout = l;
>>> ?}
>>> @@ -130,6 +131,8 @@ static void _set_gpio_dataout_mask(struct gpio_bank *bank, int gpio, int enable)
>>> ? ? ? ? ? ? ? l |= gpio_bit;
>>> ? ? ? else
>>> ? ? ? ? ? ? ? l &= ~gpio_bit;
>>> +
>>> + ? ? l |= __raw_readl(bank->base + bank->regs->set_dataout);
>>
>> There's already a __raw_read() in this function just above.
> Right. Thanks.
> --
> Tarun
>>
>>> ? ? ? __raw_writel(l, reg);
>>> ? ? ? bank->context.dataout = l;
>>> ?}
