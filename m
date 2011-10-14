From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 14 Oct 2011 16:40:29 +0800
Subject: [PATCH v4 3/8] ARM: pxa: rename gpio_to_irq and irq_to_gpio
In-Reply-To: <CAMPhdO-3C=YXNF0qSRaDeHm7hHMfq+mU9W62wak=Pn-LB4bLqg@mail.gmail.com>
References: <1318478825-17187-1-git-send-email-haojian.zhuang@marvell.com>
	<1318478825-17187-4-git-send-email-haojian.zhuang@marvell.com>
	<20111013191848.GU18574@ponder.secretlab.ca>
	<CAN1soZyFEn2pcWvnWFx1BC_Hr7qw468JzygYqiBnkM2FDJBE9g@mail.gmail.com>
	<CAMPhdO-3C=YXNF0qSRaDeHm7hHMfq+mU9W62wak=Pn-LB4bLqg@mail.gmail.com>
Message-ID: <CAN1soZzYCh7sxBgg0O5h_Ea06q0QBB3UPDvwqzkV1qwhzizOuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2011 at 4:35 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Fri, Oct 14, 2011 at 4:27 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> On Fri, Oct 14, 2011 at 3:18 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>> On Thu, Oct 13, 2011 at 12:07:00PM +0800, Haojian Zhuang wrote:
>>>> Avoid to define gpio_to_irq() and irq_to_gpio() for potential name
>>>> confliction since multiple architecture will be built together.
>>>>
>>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>>>> ---
>>>> @@ -55,6 +66,49 @@ static inline struct pxa_gpio_chip *gpio_to_pxachip(unsigned gpio)
>>>> ? ? ? return &pxa_gpio_chips[gpio_to_bank(gpio)];
>>>> ?}
>>>>
>>>> +static inline int gpio_is_pxa_type(int type)
>>>> +{
>>>> + ? ? if (type & MMP_GPIO)
>>>> + ? ? ? ? ? ? return 0;
>>>> + ? ? return 1;
>>>> +}
>>>
>>> or simply: "return (type & MMP_GPIO) == 0;"
>>>
>>>> +
>>>> +static inline int gpio_is_mmp_type(int type)
>>>> +{
>>>> + ? ? if (type & MMP_GPIO)
>>>> + ? ? ? ? ? ? return 1;
>>>> + ? ? return 0;
>>>
>>> return (type & MMP_GPIO) != 0;
>>>
>> Your code is better than me. I'll change it.
>>
>>>> +}
>>>> +
>>>> +static int pxa_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
>>>> +{
>>>> + ? ? int gpio;
>>>> +
>>>> + ? ? gpio = chip->base + offset;
>>>> +#ifdef CONFIG_ARCH_PXA
>>>> + ? ? if (gpio_is_pxa_type(gpio_type))
>>>> + ? ? ? ? ? ? return PXA_GPIO_TO_IRQ(gpio);
>>>> +#endif
>>>> +#ifdef CONFIG_ARCH_MMP
>>>> + ? ? if (gpio_is_mmp_type(gpio_type))
>>>> + ? ? ? ? ? ? return MMP_GPIO_TO_IRQ(gpio);
>>>> +#endif
>>>
>>> Blech! ?Ugly #ifdef blocks. ?It would be better to have the #ifdef
>>> around the gpio_is_*_type macros with empty versions when the arch
>>> isn't enabled.
>>>
>> OK. I'll append some small API to cover the transition. So #ifdef will
>> around the new API.
>>
>>>> + ? ? return 0;
>>>> +}
>>>> +
>>>> +int pxa_irq_to_gpio(int irq)
>>>> +{
>>>> +#ifdef CONFIG_ARCH_PXA
>>>> + ? ? if (gpio_is_pxa_type(gpio_type))
>>>> + ? ? ? ? ? ? return irq - PXA_GPIO_TO_IRQ(0);
>>>> +#endif
>>>> +#ifdef CONFIG_ARCH_MMP
>>>> + ? ? if (gpio_is_mmp_type(gpio_type))
>>>> + ? ? ? ? ? ? return irq - MMP_GPIO_TO_IRQ(0);
>>>> +#endif
>>>
>>> Ditto here.
>>>
>>>> +static int pxa_gpio_nums(void)
>>>> +{
>>>> + ? ? int count = 0;
>>>> +
>>>> +#ifdef CONFIG_ARCH_PXA
>>>> + ? ? if (cpu_is_pxa25x()) {
>>>> +#ifdef CONFIG_CPU_PXA26x
>>>> + ? ? ? ? ? ? count = 89;
>>>> + ? ? ? ? ? ? gpio_type = PXA26X_GPIO;
>>>> +#elif defined(CONFIG_PXA25x)
>>>> + ? ? ? ? ? ? count = 84;
>>>> + ? ? ? ? ? ? gpio_type = PXA26X_GPIO;
>>>> +#endif /* CONFIG_CPU_PXA26x */
>>>
>>> This isn't multiplatform friendly. ?My expectation is that new driver
>>> code will not have either/or #ifdef CONFIG blocks like this. ?The
>>> driver should be written in a way that either option can be turned on.
>>>
>> Yes, it's not friendly. But the question is that I can't identify
>> PXA26x by cpuid.
>> Now we have to identify pxa25x and pxa26x depends on the macro
>> CONFIG_CPU_PXA26x.
>>
>
> Haojian,
>
> Please also separate the removal of global pxa_last_gpio into
> another patch.
>

no problem
