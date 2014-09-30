From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Tue, 30 Sep 2014 11:56:20 +0200
Subject: [PATCH V2] bcma: use device from DT (brcm,
 bus-gpio) for SoC GPIO chip
In-Reply-To: <7035315.8m6ICWZ25d@wuerfel>
References: <1411741733-13888-1-git-send-email-zajec5@gmail.com>
 <1411892641-5662-1-git-send-email-zajec5@gmail.com>
 <7035315.8m6ICWZ25d@wuerfel>
Message-ID: <CACna6ry-mmc8QD-bYUNGLfTh07TcUepjZdPYqKyxLc3HbMPung@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 September 2014 11:37, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 28 September 2014 10:24:01 Rafa? Mi?ecki wrote:
>> @@ -17,4 +33,12 @@ Example:
>>               ranges = <0x00000000 0x18000000 0x00100000>;
>>               #address-cells = <1>;
>>               #size-cells = <1>;
>> +
>> +             chipcommon at 0 {
>> +                     gpio at 0 {
>> +                             compatible = "brcm,bus-gpio";
>> +                             gpio-controller;
>> +                             #gpio-cells = <2>;
>> +                     };
>> +             };
>
> I think you should list the 'reg' property of the chipcommon area
> and make that match the unit address, rather than using '0', mostly
> for consistency.

Do you mean this chipcommon at 0? We propose this foo at offset syntax since
V1 which was posted 1,5 month ago, it's nothing new.


> Can you have multiple gpio areas in chipcommon? If not, I'd probably
> leave out the extra node and mark the chipcommon device itself as
> a 'gpio-controller'. It can also be other things at the same time,
> e.g. 'interrupt-controller' or provide things like pwms or pinctrl
> if that's what the hardware does. No need to have separate nodes
> for those if it's all the same register set.

OK


>> @@ -218,6 +218,11 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
>>  #if IS_BUILTIN(CONFIG_BCM47XX)
>>       chip->to_irq            = bcma_gpio_to_irq;
>>  #endif
>> +#if IS_BUILTIN(CONFIG_OF)
>> +     if (cc->core->bus->hosttype == BCMA_HOSTTYPE_SOC)
>> +             chip->of_node   = of_find_compatible_node(NULL, NULL,
>> +                                                       "brcm,bus-gpio");
>> +#endif
>
> Just commenting on the general style here, I think you can skip this
> step entirely, as mentioned above.
>
> You should use C syntax here:
>
>         if (IS_BUILTIN(CONFIG_OF) && cc->core->bus->hosttype == BCMA_HOSTTYPE_SOC))
>                 chip->of_node = of_find_compatible_node(NULL, NULL, "brcm,bus-gpio");

OK


> If CONFIG_OF is not set, of_find_compatible_node() is turned into an inline
> function that returns NULL, so you probably don't even need that.

But I need to have of_node defined. Please check out "struct gpio_chip".


> Finally, of_find_compatible_node() is a really slow operation, and "brcm,bus-gpio"
> is a much too generic name. If you need to look for something that is a child
> node, use something based on for_each_available_child_of_node().

Will see what I can do.

-- 
Rafa?
