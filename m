From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 3 May 2014 00:09:20 +0800
Subject: pinctrl: sirf: switch driver to use gpiolib irqchip helpers
In-Reply-To: <5EB3BFCD089AD643B9BB63439F5FD5E9012BE8AD2D@SHAASIEXM01.ASIA.ROOT.PRI>
References: <20140502105536.GA32382@mwanda>
 <5EB3BFCD089AD643B9BB63439F5FD5E9012BE8AD2D@SHAASIEXM01.ASIA.ROOT.PRI>
Message-ID: <CAGsJ_4yKeopvXSe7KkecL0OZExyEp0otV86m0h+VPnprXF8LzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
>
>> -----Original Message-----
>> From: Dan Carpenter [mailto:dan.carpenter at oracle.com]
>> Sent: Friday, May 02, 2014 6:56 PM
>> To: linus.walleij at linaro.org
>> Cc: Barry Song; linux-arm-kernel at lists.infradead.org
>> Subject: re: pinctrl: sirf: switch driver to use gpiolib irqchip helpers
>>
>> Hello Linus Walleij,
>>
>> The patch 7420d2d09b12: "pinctrl: sirf: switch driver to use gpiolib irqchip
>> helpers" from Apr 15, 2014, leads to the following static checker warning:
>>
>>       drivers/pinctrl/sirf/pinctrl-sirf.c:578 sirfsoc_gpio_handle_irq()
>>       warn: buffer overflow 'sgpio_chip.sgpio_bank' 5 <= 31
>>
>> drivers/pinctrl/sirf/pinctrl-sirf.c
>>    569  static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc
>> *desc)
>>    570  {
>>    571          struct sirfsoc_gpio_bank *bank;
>>    572          u32 status, ctrl;
>>    573          int idx = 0;
>>    574          struct irq_chip *chip = irq_get_chip(irq);
>>    575          int i;
>>    576
>>    577          for (i = 0; i < SIRFSOC_GPIO_BANK_SIZE; i++) {
>>
>> Probably i < SIRFSOC_GPIO_NO_OF_BANKS (5) was intended here.

yes. it was a typo. i'll do a patch to fix it.

>>
>>    578                  bank = &sgpio_chip.sgpio_bank[i];
>>    579                  if (bank->parent_irq == irq)
>>    580                          break;
>>    581          }
>>
>> regards,
>> dan carpenter

-barry
