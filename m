From: fkan@apm.com (Feng Kan)
Date: Wed, 13 May 2015 08:44:44 -0700
Subject: [PATCH v4 2/3] irqchip: GIC: Add support for irq_{get,
 set}_irqchip_state
In-Reply-To: <CACRpkdYffHJEzksc5mg7JZdwTzShGaQofAmbmn65=_V3ot04Rg@mail.gmail.com>
References: <1426676484-21812-1-git-send-email-marc.zyngier@arm.com>
 <1426676484-21812-3-git-send-email-marc.zyngier@arm.com>
 <CAL85gmBrkonMcKdUVGmYx6zT3wSe-e2jPhnL_+Tkf3s4jsAiWg@mail.gmail.com>
 <CACRpkdYffHJEzksc5mg7JZdwTzShGaQofAmbmn65=_V3ot04Rg@mail.gmail.com>
Message-ID: <CAL85gmC4ovR99wQQYoKs=oo24So80jZ_guxDDFhi-1MXXj0uSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 4:58 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, May 13, 2015 at 4:25 AM, Feng Kan <fkan@apm.com> wrote:
>
>> Marc:
>>
>> Sorry for top posting. It seems with GIC-400, the get_irqstate is not a reliable
>> way of accessing the GPIO status. In our case, the gpio interrupt status can
>> only be read correctly with the SPISR register. So it seems we have to go
>> back to the old way of mapping the SPISR portion of the GIC in our GPIO
>> driver. We wanted to ask you if that is acceptable since SPISR in not
>> standard in all GIC, perhaps we can treat it differently.
>
> As GPIO maintainer I am curious about what this is...
>
> Can you describe the scenario where your GPIO (!) driver needs
> to be poking around in the GIC SPISR?

We are using the gpio driver with gpio_key for power button. The gpio
status can only be retrieved from the GIC register when the gpio is
acting as a interrupt. Marc had provided a patch which allow the
getting of the irq status
using the PENDING_SET register, however it seems it is not reliable.
Another register in the GIC call the SPISR always give the correct
status but it is only available in the GIC-400 and hence not likely to
be incorporated into the general GIC code. We would like to go back
the version 1 of the patch and ioremap the region in the gpio driver
and access the status that way. Please let us know what you think.

>
> Yours,
> Linus Walleij
