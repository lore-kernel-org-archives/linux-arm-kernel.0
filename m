From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 8 Sep 2016 17:47:02 +0200
Subject: [PATCH v4 6/9] pinctrl: Add IRQ support to STM32 gpios
In-Reply-To: <CACRpkdZ_r0phJeScTYs_LmEHavcjGo6YjHPEHo-rKAv+rLgiFg@mail.gmail.com>
References: <1473180341-1999-1-git-send-email-alexandre.torgue@st.com>
 <1473180341-1999-7-git-send-email-alexandre.torgue@st.com>
 <CACRpkdZ_r0phJeScTYs_LmEHavcjGo6YjHPEHo-rKAv+rLgiFg@mail.gmail.com>
Message-ID: <0063a1ef-1b09-7cfc-f18b-76f2bb07eb84@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 09/07/2016 11:06 PM, Linus Walleij wrote:
> On Tue, Sep 6, 2016 at 6:45 PM, Alexandre TORGUE
> <alexandre.torgue@st.com> wrote:
>
>> This patch adds IRQ support to STM32 gpios.
>>
>> The EXTI controller has 16 lines dedicated to GPIOs.
>> EXTI line n can be connected to only line n of one of the GPIO ports, for
>> example EXTI0 can be connected to either PA0, or PB0, or PC0...
>> This port selection is done by specifying the port number into System
>> Config registers.
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
>
>> +++ b/drivers/pinctrl/stm32/Kconfig
>> @@ -6,6 +6,8 @@ config PINCTRL_STM32
>>         select PINMUX
>>         select GENERIC_PINCONF
>>         select GPIOLIB
>> +       select GPIOLIB_IRQCHIP
>
> But you're not really using GPIOLIB_IRQCHIP. You have a different,
> super-complex irqchip in use.

Thanks Linus for this review. I will send a V5.
Just one question, when you say "super-complex irqchip in use", do you 
mean I could use another (simplest) solution to handle this EXTI controller?

Regards

Alex

>
> So just don't select this.
>
>> +       bank->gpio_chip.irqdomain = irq_domain_create_hierarchy(pctl->domain,
>> +                                       0, STM32_GPIO_IRQ_LINE, bank->fwnode,
>> +                                       &stm32_gpio_domain_ops, bank);
>
> Don't use that irqdomain pointer inside the gpio_chip.
>
> Instead declare the irqdomain pointer inside struct stm32_gpio_bank
> or something like that.
>
> Yours,
> Linus Walleij
>
