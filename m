From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Apr 2014 19:45:01 +0200
Subject: [PATCH 4/5] gpio: omap: convert driver to use gpiolib irqchip
In-Reply-To: <5346D758.5020103@ti.com>
References: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
 <1396796297-13002-5-git-send-email-javier.martinez@collabora.co.uk>
 <5346D758.5020103@ti.com>
Message-ID: <CACRpkdazRZvNwZcdkn1EQpv7PEGv83pL+yaFRHA8z0SSXw2gkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 7:39 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On Sunday 06 April 2014 10:58 AM, Javier Martinez Canillas wrote:

>> +#ifdef CONFIG_ARCH_OMAP1
>> +     /*
>> +      * REVISIT: Once we have OMAP1 supporting SPARSE_IRQ, we can drop
>> +      * irq_alloc_descs() since a base IRQ offset will no longer be needed.
>> +      */
>> +     irq_base = irq_alloc_descs(-1, 0, bank->width, 0);
>> +     if (irq_base < 0) {
>> +             dev_err(bank->dev, "Couldn't allocate IRQ numbers\n");
>> +             return -ENODEV;
>> +     }
>> +#endif
>> +
> Do we still need above after first patch ? Would be good
> to get rid of above ugly #ifdef on the middle of the code.

I don't think so actually, simple irqdomain adds descriptors
for irqbase != 0, and the gpiochip irqchip helpers call
irq_create_mapping() on all offsets.

Preferably a separate patch on top of this removing that code
though so it's bisectable.

Yours,
Linus Walleij
