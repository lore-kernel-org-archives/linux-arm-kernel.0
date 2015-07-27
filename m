From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Jul 2015 13:39:05 -0500
Subject: [PATCH v2 06/13] irqchip: kill off set_irq_flags usage
In-Reply-To: <55B3904B.3050408@free-electrons.com>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
 <1436711211-18223-7-git-send-email-robh@kernel.org>
 <55B3904B.3050408@free-electrons.com>
Message-ID: <CAL_JsqKJgYYEghd3PHZawkHnrqBp1+ok0Fj45a8roipMDmCQjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 25, 2015 at 8:34 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Rob,
>
> On 12/07/2015 16:26, Rob Herring wrote:
>> set_irq_flags is ARM specific with custom flags which have genirq
>> equivalents. Convert drivers to use the genirq interfaces directly, so we
>> can kill off set_irq_flags. The translation of flags is as follows:
>>
>> IRQF_VALID -> !IRQ_NOREQUEST
>> IRQF_PROBE -> !IRQ_NOPROBE
>> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
>>
>> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
>> and setting IRQ_NOREQUEST already, so there is no need to do this in
>> .map() functions and we can simply remove the set_irq_flags calls. Some
>> users also set IRQ_NOPROBE and this has been maintained although it is not
>> clear that is really needed. There appears to be a great deal of blind
>> copy and paste of this code.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>> Cc: Lee Jones <lee@kernel.org>
>> Cc: Alexander Shiyan <shc_work@mail.ru>
>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-samsung-soc at vger.kernel.org
>> Cc: linux-rpi-kernel at lists.infradead.org
>> ---
>> v2:
>> - Fix build error on clps711x
>>
> [...]
>
>> diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
>> index 0d3b0fe..b8bf8b0 100644
>> --- a/drivers/irqchip/irq-armada-370-xp.c
>> +++ b/drivers/irqchip/irq-armada-370-xp.c
>> @@ -201,7 +201,6 @@ static int armada_370_xp_msi_map(struct irq_domain *domain, unsigned int virq,
>>  {
>>       irq_set_chip_and_handler(virq, &armada_370_xp_msi_irq_chip,
>>                                handle_simple_irq);
>> -     set_irq_flags(virq, IRQF_VALID);
>
> OK
>
>>
>>       return 0;
>>  }
>> @@ -318,7 +317,7 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
>>               irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
>>                                       handle_level_irq);
>>       }
>> -     set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
>> +     irq_set_noprobe(virq);
>
> I think it should be irq_set_probe(virq), I don't see why you inverted the probe flag.

Yes, this translation and similar ones are messed up. I've gone back
thru and fixed these.

However, it is questionable whether you really want to enable probing
on these lines or care either way.

Rob
