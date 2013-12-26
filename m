From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Thu, 26 Dec 2013 09:38:39 +0530
Subject: [PATCH v3 2/2] gpio: davinci: reuse for Keystone SoC
In-Reply-To: <52B98BBC.9060909@ti.com>
References: <1387885284-8119-1-git-send-email-grygorii.strashko@ti.com>
 <1387885284-8119-3-git-send-email-grygorii.strashko@ti.com>
 <CA+V-a8tJRZ5Esn3F4J6_z7VCmGPpptgxMEyyaANbrytAF3pUMA@mail.gmail.com>
 <52B98BBC.9060909@ti.com>
Message-ID: <CA+V-a8u+iFRM=FU86GOaAusUAQ-nUifQ1vpPEfChF9zYZW70MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 24, 2013 at 6:57 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> On 12/24/2013 01:20 PM, Prabhakar Lad wrote:
>>
>> Hi Grygorii,
>>
>> Thanks for the patch.
>>
>> On Tue, Dec 24, 2013 at 5:11 PM, Grygorii Strashko
>> <grygorii.strashko@ti.com> wrote:
>>>
>>> The similar GPIO HW block is used by keystone SoCs as
>>> in Davinci SoCs.
>>> Hence, reuse Davinci GPIO driver for Keystone taking into
>>> account that Keystone contains ARM GIC IRQ controller which
>>> is implemented using IRQ Chip.
>>>
>>> Documentation:
>>>          http://www.ti.com/lit/ug/sprugv1/sprugv1.pdf
>>>
>>> Cc: Alexandre Courbot <gnurou@gmail.com>
>>> Cc: Sekhar Nori <nsekhar@ti.com>
>>> Cc: devicetree at vger.kernel.org
>>>
>>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>> ---
>>>   .../devicetree/bindings/gpio/gpio-davinci.txt      |    4 +-
>>>   drivers/gpio/gpio-davinci.c                        |   48
>>> ++++++++++++++++----
>>>   2 files changed, 42 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>>> b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>>> index a2e839d..4ce9862 100644
>>> --- a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>>> +++ b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>>> @@ -1,7 +1,7 @@
>>> -Davinci GPIO controller bindings
>>> +Davinci/Keystone GPIO controller bindings
>>>
>>>   Required Properties:
>>> -- compatible: should be "ti,dm6441-gpio"
>>> +- compatible: should be "ti,dm6441-gpio", "ti,keystone-gpio"
>>
>>
>> Can you make it something like this ? It isn't readable.
>>
>> - compatible : value should be either one among the following
>>      (a)  "ti,dm6441-gpio" for davinci.
>>      (b)  "ti,keystone-gpio" for keystone.
>>
>>>
>>>   - reg: Physical base address of the controller and the size of memory
>>> mapped
>>>          registers.
>>> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
>>> index 7629b4f..d0f135d 100644
>>> --- a/drivers/gpio/gpio-davinci.c
>>> +++ b/drivers/gpio/gpio-davinci.c
>>> @@ -37,6 +37,8 @@ struct davinci_gpio_regs {
>>>          u32     intstat;
>>>   };
>>>
>>> +typedef struct irq_chip *(*gpio_get_irq_chip_cb_t)(unsigned int irq);
>>> +
>>>   #define BINTEN 0x8 /* GPIO Interrupt Per-Bank Enable Register */
>>>
>>>   #define chip2controller(chip)  \
>>> @@ -413,6 +415,26 @@ static const struct irq_domain_ops
>>> davinci_gpio_irq_ops = {
>>>          .xlate = irq_domain_xlate_onetwocell,
>>>   };
>>>
>>> +static struct irq_chip *davinci_gpio_get_irq_chip(unsigned int irq)
>>> +{
>>> +       static struct irq_chip_type gpio_unbanked;
>>> +
>>> +       gpio_unbanked = *container_of(irq_get_chip(irq),
>>> +                                     struct irq_chip_type, chip);
>>> +
>>> +       return &gpio_unbanked.chip;
>>> +};
>>> +
>>> +static struct irq_chip *keystone_gpio_get_irq_chip(unsigned int irq)
>>> +{
>>> +       static struct irq_chip gpio_unbanked;
>>> +
>>> +       gpio_unbanked = *irq_get_chip(irq);
>>> +       return &gpio_unbanked;
>>> +};
>>> +
>>> +static const struct of_device_id davinci_gpio_ids[];
>>> +
>>>   /*
>>>    * NOTE:  for suspend/resume, probably best to make a platform_device
>>> with
>>>    * suspend_late/resume_resume calls hooking into results of the
>>> set_wake()
>>> @@ -433,6 +455,18 @@ static int davinci_gpio_irq_setup(struct
>>> platform_device *pdev)
>>>          struct davinci_gpio_platform_data *pdata = dev->platform_data;
>>>          struct davinci_gpio_regs __iomem *g;
>>>          struct irq_domain       *irq_domain = NULL;
>>> +       const struct of_device_id *match;
>>> +       struct irq_chip *irq_chip;
>>> +       gpio_get_irq_chip_cb_t gpio_get_irq_chip;
>>> +
>>> +       /*
>>> +        * Use davinci_gpio_get_irq_chip by default to handle non DT
>>> cases
>>> +        */
>>> +       gpio_get_irq_chip = davinci_gpio_get_irq_chip;
>>> +       match = of_match_device(of_match_ptr(davinci_gpio_ids),
>>> +                               dev);
>>
>>
>> Sorry didn't notice that earlier the data structure of_match_ptr()
>> protects is always compiled in.
>> so of_match_ptr() is not needed.
>> While you are at it you can also fix it in davinci_gpio_driver
>> structure as a sperate
>> patch.
>>
>
> Not sure. davinci_gpio_ids defined as:
>
>
> #if IS_ENABLED(CONFIG_OF)
> static const struct of_device_id davinci_gpio_ids[] = {
>
> And seems, Davinci may still be compiled without OF enabled.
>
My Bad, yes its gaurded by CONFIG_OF so my above suggestion doesn't hold good.

Thanks,
--Prabhakar Lad
