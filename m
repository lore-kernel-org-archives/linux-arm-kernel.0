From: zonque@gmail.com (Daniel Mack)
Date: Mon, 06 Aug 2012 10:11:33 +0200
Subject: [PATCH v3 4/9] GPIO: gpio-pxa: simplify pxa_gpio_to_irq() and
 pxa_irq_to_chip()
In-Reply-To: <201208060809.15527.arnd@arndb.de>
References: <1343470061-16879-1-git-send-email-zonque@gmail.com>
 <CAN1soZzOTMChr7WQzguH_CPQ8s=tyrsjwmAYNSBAVeMtwRE2uA@mail.gmail.com>
 <CACRpkdYaL65VGFKD-3OM173jQV6zeAj3bCcpHneC2L0yK504rw@mail.gmail.com>
 <201208060809.15527.arnd@arndb.de>
Message-ID: <501F7C35.7040409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.08.2012 10:09, Arnd Bergmann wrote:
> On Sunday 05 August 2012, Linus Walleij wrote:
>>>>>
>>>>> +#ifdef CONFIG_ARCH_PXA
>>>>> +               if (gpio_is_pxa_type(gpio_type))
>>>>> +                       irq_base = PXA_GPIO_TO_IRQ(0);
>>>>> +#endif
>>>>> +#ifdef CONFIG_ARCH_MMP
>>>>> +               if (gpio_is_mmp_type(gpio_type))
>>>>> +                       irq_base = MMP_GPIO_TO_IRQ(0);
>>>>> +#endif
>>>>
>>>> Grrr. Can we think of a way to get rid of these #ifdef:s?
>>>>
>>>
>>> It's used for non-DT mode. This driver is used in both arch-pxa
>>> and arch-mmp. Since we use static irq allocation in non-DT mode,
>>> we have to use this kind of code to get irq_base.
>>>
>>> What Daniel did is only simplifying the code.
>>
>> Yep I know, and the result is better than without the patch, so
>> I Acked it. But if I have my dreams come true we could do away
>> with this compile-time stuff as well...
> 
> I think the real solution for these is to merge ARCH_PXA and ARCH_MMP
> and move all the code into one directory. I think it's ok to have
> the above hack in there in the meantime as long as we can agree on where
> we're heading eventually.

I don't know how much work that would be but I agree that it would
definitiely be nicer, yes. Note, however, that there was a lot more
#ifdef hackery in that driver before the cleanup.


Daniel
