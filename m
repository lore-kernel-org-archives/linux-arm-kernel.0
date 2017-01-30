From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 30 Jan 2017 17:29:55 +0100
Subject: [PATCH 2/8] pinctrl: stm32: use gpio-ranges to declare bank range
In-Reply-To: <CACRpkdYtZCJVrZhXOPXd-MNMX0Ry_H1dLQopKwsj9HnO03BtKg@mail.gmail.com>
References: <1485533721-9019-1-git-send-email-alexandre.torgue@st.com>
 <1485533721-9019-3-git-send-email-alexandre.torgue@st.com>
 <CACRpkdYtZCJVrZhXOPXd-MNMX0Ry_H1dLQopKwsj9HnO03BtKg@mail.gmail.com>
Message-ID: <2d0cd144-9a72-52d5-b2c9-c6c9e09ac494@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 01/30/2017 04:19 PM, Linus Walleij wrote:
> On Fri, Jan 27, 2017 at 5:15 PM, Alexandre TORGUE
> <alexandre.torgue@st.com> wrote:
>
>> Use device tree entries to declare gpio range. It will allow to use
>> no contiguous gpio bank and holes inside a bank.
>>
>> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
>
> (...)
>> +       of_property_read_string(np, "st,bank-name", &bank->gpio_chip.label);
>> +
>> +       if (!of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args))
>> +               bank_nr = args.args[1] / STM32_GPIO_PINS_PER_BANK;
>> +       else {
>> +               range->name = bank->gpio_chip.label;
>> +               range->id = bank_nr;
>> +               range->pin_base = range->id * STM32_GPIO_PINS_PER_BANK;
>> +               range->base = range->id * STM32_GPIO_PINS_PER_BANK;
>> +               range->npins = npins;
>> +               range->gc = &bank->gpio_chip;
>> +               pinctrl_add_gpio_range(pctl->pctl_dev,
>> +                                      &pctl->banks[bank_nr].range);
>> +       }

I Keep the old way to get range in order to keep compatibility with 
older device tree (if no gpio ranges are defined).

>
> Why are you doing this?
>
> There is already code in drivers/gpio/gpiolib-of.c to pick ranges
> from the device tree and add when you're adding the GPIO chips.

Yes, If I declare gpio-ranges inside DT node, the range is well handled 
by the gpiolib. But in this condition I use gpio-ranges entry to get the 
pin base offset for the bank we are registering. For example, if there 
an hole between 2 banks (GPIOA, GPIOD, ...) I need to know at which pin 
offset the bank D starts. It is the only way I found.

The "else" statement is here to get compatibility with older device tree 
(which don't use gpio-ranges entry).

Regards
Alex


>
> Please use that or figure out what is needed to make it work for
> you instead of reimplementing it.
>
> Yours,
> Linus Walleij
>
