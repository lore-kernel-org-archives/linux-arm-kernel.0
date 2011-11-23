From: khilman@ti.com (Kevin Hilman)
Date: Wed, 23 Nov 2011 11:54:15 -0800
Subject: [PATCH v8 24/24] gpio/omap: handle set_dataout reg capable IP on
 restore
In-Reply-To: <CAC83ZvL9w=7RhAuT=5ahbDX+d6miQMif1ngOenEiqP4UN2+mzg@mail.gmail.com>
 (Tarun Kanti DebBarma's message of "Wed, 23 Nov 2011 18:01:35 +0530")
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
 <1317803593-12259-25-git-send-email-tarun.kanti@ti.com>
 <87aa8bde2d.fsf@ti.com>
 <CAC83Zv+gac_Wd8+V+o6USxv73ia5i8JLjLDHj8VQiRiqZ7DOtQ@mail.gmail.com>
 <CAC83ZvL9w=7RhAuT=5ahbDX+d6miQMif1ngOenEiqP4UN2+mzg@mail.gmail.com>
Message-ID: <87zkfmaa3c.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Mon, Nov 7, 2011 at 5:35 PM, DebBarma, Tarun Kanti
> <tarun.kanti@ti.com> wrote:
>> On Fri, Nov 4, 2011 at 10:23 PM, Kevin Hilman <khilman@ti.com> wrote:
>>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>>
>>>> From: Nishanth Menon <nm@ti.com>
>>>>
>>>> GPIO IP revisions such as those used in OMAP4 have a set_dataout
>>>> while the previous revisions used a single dataout register.
>>>> Depending on what is available restore the dataout settings
>>>> to the right register.
>>>>
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>>>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> ---
>>>> ?drivers/gpio/gpio-omap.c | ? ?9 +++++++--
>>>> ?1 files changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>>> index 4009446..3df7a98 100644
>>>> --- a/drivers/gpio/gpio-omap.c
>>>> +++ b/drivers/gpio/gpio-omap.c
>>>> @@ -1073,7 +1073,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>>>> ? ? ? bank->get_context_loss_count = pdata->get_context_loss_count;
>>>> ? ? ? bank->regs = pdata->regs;
>>>>
>>>> - ? ? if (bank->regs->set_dataout && bank->regs->clr_dataout)
>>>> + ? ? if (bank->regs->set_dataout)
>>>
>>> This change isn't right.
>>>
>>> The _set_gpio_dataout_reg function depends on the existence of
>>> ->clr_dataout too.
>> Ok, I will add the clr_dataout condtion as well.
>
>>
>>>
>>>> ? ? ? ? ? ? ? bank->set_dataout = _set_gpio_dataout_reg;
>>>> ? ? ? else
>>>> ? ? ? ? ? ? ? bank->set_dataout = _set_gpio_dataout_mask;
>>>> @@ -1351,7 +1351,12 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
>>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? bank->base + bank->regs->risingdetect);
>>>> ? ? ? __raw_writel(bank->context.fallingdetect,
>>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? bank->base + bank->regs->fallingdetect);
>>>> - ? ? __raw_writel(bank->context.dataout, bank->base + bank->regs->dataout);
>>>> + ? ? if (bank->regs->set_dataout)
>>>
>>> Why the check again? ?The check has already been done in probe.
>>>
>>> Just use bank->set_dataout() here.
>> Sure, i will make the change.
>
> When I look at the signature of set_dataout(), it does not seem
> straight forward to be used here. It expects (struct gpio_bank *bank,
> int gpio, int enable) to be passed to it.

IOW, it expects to only set 1 bit, where the context restore needs to
set the value for the whole register.

OK, then keep the original version, but make sure the if statement
matches is checking for ->set_dataout and ->clr_dataout like the other one.

Kevin
