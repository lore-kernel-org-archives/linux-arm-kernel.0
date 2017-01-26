From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 26 Jan 2017 12:38:49 +0200
Subject: [PATCH V11 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <20170126101521.GA10324@red-moon>
References: <1484879660-1960-1-git-send-email-agustinv@codeaurora.org>
 <1484879660-1960-3-git-send-email-agustinv@codeaurora.org>
 <CAHp75VeYxfuMuaZCMk+MYdxLTs7cCa6j6M7Ot3XnwMmeHP7kBA@mail.gmail.com>
 <20170126101521.GA10324@red-moon>
Message-ID: <CAHp75Vd7wBq7saVj_+1Zh8Dt8v59HWc6S-PdWWT84zuwO0VWTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 12:15 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Thu, Jan 26, 2017 at 03:01:18AM +0200, Andy Shevchenko wrote:
>> On Fri, Jan 20, 2017 at 4:34 AM, Agustin Vega-Frias
>> <agustinv@codeaurora.org> wrote:
>> > ACPI extended IRQ resources may contain a ResourceSource to specify
>> > an alternate interrupt controller. Introduce acpi_irq_get and use it
>> > to implement ResourceSource/IRQ domain mapping.
>> >
>> > The new API is similar to of_irq_get and allows re-initialization
>> > of a platform resource from the ACPI extended IRQ resource, and
>> > provides proper behavior for probe deferral when the domain is not
>> > yet present when called.

>> > +       list_for_each_entry(hwid, &device->pnp.ids, list) {
>>
>> > +               for (devid = &__dsdt_irqchip_acpi_probe_table;
>> > +                    devid < &__dsdt_irqchip_acpi_probe_table_end; devid++) {
>> > +                       if (devid->id && !strcmp(devid->id, hwid->id)) {
>> > +                               result = &device->fwnode;
>> > +                               break;
>> > +                       }
>> > +               }
>>
>> Looks like a candidate for linker table API. (I recommend to Cc Luis
>> for this part)
>
> This linker table entry scheme is just an optimization and should
> not gate the series.

That's correct. Though Luis might give some advice regarding to this
piece of code.

>> > +#ifdef CONFIG_ACPI_GENERIC_GSI
>>
>> #if IS_ENABLED()

>> > +int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res);
>> > +#else
>> > +static inline int acpi_irq_get(acpi_handle handle, unsigned int index,
>> > +                              struct resource *res)
>>
>> Perhaps
>>
>> static inline
>> int ...
>
> It is late -rc5 and notwithstanding cosmetics changes, can we make
> progress with this patch series or not please ?

I agree for the second case from what's left above, first one might be
useful to amend.
At the end it's a Rafael's word, I'm not insisting on cosmetic
changes. So, what about the rest?

-- 
With Best Regards,
Andy Shevchenko
