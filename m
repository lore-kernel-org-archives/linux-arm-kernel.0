From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Fri, 24 Feb 2012 19:23:02 +0530
Subject: [RFC PATCH] gpio/omap: Fix IRQ handling for SPARSE_IRQ
In-Reply-To: <4F47915B.7050507@ti.com>
References: <4F46C1AF.2040201@ti.com> <20120223230821.GD18185@atomide.com>
 <4F47623E.5060908@ti.com>
 <CAC83ZvLm-ruk3pMkeLhiyOMAVVnByk9PPWsM40AyPErSqz=dKA@mail.gmail.com>
 <CAC83ZvJ-mCZFYzOPQ177th7qVC9GBrKnB2pL=R3knMktOeau2g@mail.gmail.com>
 <4F47915B.7050507@ti.com>
Message-ID: <CAC83ZvJS8BoOD0GUE5UkgGz15e+wsgVv2CbRB5nnpBFZurJ18w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 7:02 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> On 2/24/2012 2:24 PM, DebBarma, Tarun Kanti wrote:
>>
>> Hi Benoit,
>>
>> On Fri, Feb 24, 2012 at 4:07 PM, DebBarma, Tarun Kanti
>> <tarun.kanti@ti.com> ?wrote:
>>>
>>> On Fri, Feb 24, 2012 at 3:41 PM, Cousson, Benoit<b-cousson@ti.com>
>>> ?wrote:
>>>>
>>>> + Tarun
>>>>
>>>>
>>>> On 2/24/2012 12:08 AM, Tony Lindgren wrote:
>>>>>
>>>>>
>>>>> * Cousson, Benoit<b-cousson@ti.com> ? ?[120223 14:14]:
>>>>>>
>>>>>>
>>>>>> The GPIO driver is still relying on internal OMAP IRQ defines that
>>>>>> are not relevant anymore if OMAP is built with SPARSE_IRQ.
>>>>>
>>>>>
>>>>>
>>>>> Great :)
>>>>>
>>>>>> Please note that this patch is still RFC, because I do not know
>>>>>> how to fix properly the ugly cpu_class_is_omap1 and the dependency
>>>>>> with IH_MPUIO_BASE to detect a MPUIO.
>>>>>
>>>>>
>>>>>
>>>>> Sounds like gpio_to_irq() needs to be set in the
>>>>> arch/arm/*omap*/gpio*.c then.
>>>>
>>>>
>>>>
>>>> In fact, after a second thought, that might even work for OMAP1 because
>>>> I'm
>>>> using the proper base (IRQ and GPIO) to convert the IRQ number.
>>>>
>>>>
>>>> static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
>>>> {
>>>>
>>>> ? ? ? ?return gpio_irq - bank->irq_base + bank->chip.base;
>>>> }
>>>>
>>>> But it might be good to test it on OMAP1 platform.
>>>>
>>>>
>>>> Tarun,
>>>>
>>>> Do you have an OMAP1 board to test that.
>>>
>>> Yes, I will test on OMAP1 board.
>>
>> I have booted the image on OMAP1 with following change.
>> I guess bank->irq_base was a typo?
>
>
> Not at all :-), it was done on purpose to get rid if the static IRQ
> definition.
BTW, it was giving me following compilation error...
drivers/gpio/gpio-omap.c: In function 'irq_to_gpio':
drivers/gpio/gpio-omap.c:90: error: 'struct gpio_bank' has no member
named 'irq_base'
make[2]: *** [drivers/gpio/gpio-omap.o] Error 1
--
Tarun

> I was expecting that kind of issue because OMAP1 is populating
> virtual_irq_start with the IH_MPUIO_BASE, but was expecting the dynamic
> alloc_decs to still provide the good value. The easy fix is to still use
> that for OMAP1 GPIO since nobody will want to spend time fixing OMAP1 boards
> to do that properly :-(
>
> I'll update the patch accordingly.
>
>
>> static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
>> {
>> ? ? ? ? //return gpio_irq - bank->irq_base + bank->chip.base;
>> ? ? ? ? return gpio_irq - bank->virtual_irq_start + bank->chip.base;
>> }
>> --
>
>
> Thanks for the help,
> Benoit
>
>
