From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 11 Oct 2017 18:38:48 +0900
Subject: [PATCH v6 2/2] gpio: uniphier: add UniPhier GPIO controller driver
In-Reply-To: <CACRpkdYRwwAVY2JuwB8goOfOJG2w0agoMwA1dFDaKA1RN=q+fw@mail.gmail.com>
References: <1506480022-8995-1-git-send-email-yamada.masahiro@socionext.com>
 <1506480022-8995-3-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdYRwwAVY2JuwB8goOfOJG2w0agoMwA1dFDaKA1RN=q+fw@mail.gmail.com>
Message-ID: <CAK7LNARQa59mQfj8ZQDp9Dig7vCi9xUhCcasYnObUmGry7X9YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-10-11 17:40 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:

>
>> +++ b/include/dt-bindings/gpio/uniphier-gpio.h
>> @@ -0,0 +1,18 @@
>> +/*
>> + * Copyright (C) 2017 Socionext Inc.
>> + *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_GPIO_UNIPHIER_H
>> +#define _DT_BINDINGS_GPIO_UNIPHIER_H
>> +
>> +#define UNIPHIER_GPIO_LINES_PER_BANK   8
>> +
>> +#define UNIPHIER_GPIO_IRQ_OFFSET       ((UNIPHIER_GPIO_LINES_PER_BANK) * 15)
>> +
>> +#define UNIPHIER_GPIO_PORT(bank, line) \
>> +                       ((UNIPHIER_GPIO_LINES_PER_BANK) * (bank) + (line))
>> +
>> +#define UNIPHIER_GPIO_IRQ(n)           ((UNIPHIER_GPIO_IRQ_OFFSET) + (n))
>> +
>> +#endif /* _DT_BINDINGS_GPIO_UNIPHIER_H */
>
> I do not understand what some of these things are doing in the
> device tree header file.
> It just looks creepingly similar to some of the magic I've seen
> in board files.

Because this hardware design is crazy crap.

Only the one's place of the GPIO labels is octal.
The other places are decimal.



> It makes much more sense that the device trees either:
>
> - Use the interrupts as a flat array 0...N across all banks

I think I did so.

But, please note only bank 15, 16, 17 can support irq.
(and bank 15, 16, 17 share the same irq control register)

No irq support for bank 0-14, 18-31.

No symmetry in the hardware structure.


> - Model each bank as a separate GPIO chip

No, no, never.
I had already tried per-bank splitting approach,
but it was a horrible disaster.

Please note there would end up 31 banks if it were split.
(31 nodes in DT)

What is worse, registers from different banks interleave,
and, in some places, share the same registers.



> This is somewhere inbetween, you are modeling it as a single
> gpiochip but still not, becuase the device tree author still need
> to address banking, that is confusing.

This is the best solution I found.



Unfortunately, the hardware specification adopts weird GPIO pin labeling.
The ports are named as
  PORT00,  PORT01,  PORT02,  ..., PORT07,
  PORT10,  PORT11,  PORT12,  ..., PORT17,
  PORT20,  PORT21,  PORT22,  ..., PORT27,
    ...
  PORT90,  PORT91,  PORT92,  ..., PORT97,
  PORT100, PORT101, PORT102, ..., PORT107,
   ...


No PORT08, PORT09, ...
As I said above, only the one's place is octal.




-- 
Best Regards
Masahiro Yamada
