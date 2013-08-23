From: markus.mayer@linaro.org (Markus Mayer)
Date: Fri, 23 Aug 2013 12:30:57 -0700
Subject: [PATCH v4 1/3] ARM: bcm281xx: Add GPIO driver
In-Reply-To: <CAPdLdqm+r1P=48Aujz9nuDb_vpFj-wBvmCV=oOKNZ0YENmbL1g@mail.gmail.com>
References: <1376938761-13657-1-git-send-email-markus.mayer@linaro.org>
 <1376938761-13657-2-git-send-email-markus.mayer@linaro.org>
 <CACRpkdbm2cKpz2SrUgsUpB4x5xjm=Bz=VCu279sEAKFJ1x9SPg@mail.gmail.com>
 <CAPdLdqm+r1P=48Aujz9nuDb_vpFj-wBvmCV=oOKNZ0YENmbL1g@mail.gmail.com>
Message-ID: <CAPdLdq=atsbY8QDzH-aaHJvLk1CDe5qK3phSGLVZSvm=FoncjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> +static void bcm_kona_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>>> +{
>>> +       void __iomem *reg_base;
>>> +       int bit, bank_id;
>>> +       unsigned long sta;
>>> +       struct bcm_kona_gpio_bank *bank = irq_get_handler_data(irq);
>>> +       struct irq_chip *chip = irq_desc_get_chip(desc);
>>> +
>>> +       chained_irq_enter(chip, desc);
>>> +
>>> +       /*
>>> +        * For bank interrupts, we can't use chip_data to store the kona_gpio
>>> +        * pointer, since GIC needs it for its own purposes. Therefore, we get
>>> +        * our pointer from the bank structure.
>>> +        */
>>> +       reg_base = bank->reg_base;
>>> +       bank_id = bank->id;
>>> +       bcm_kona_gpio_unlock_bank(reg_base, bank_id);
>>> +
>>> +       sta = readl(reg_base + GPIO_INT_STATUS(bank_id)) &
>>> +           (~(readl(reg_base + GPIO_INT_MASK(bank_id))));
>>> +
>>> +       for_each_set_bit(bit, &sta, 32) {
>>> +               /*
>>> +                * Clear interrupt before handler is called so we don't
>>> +                * miss any interrupt occurred during executing them.
>>> +                */
>>> +               writel(readl(reg_base + GPIO_INT_STATUS(bank_id)) |
>>> +                               (1 << bit),
>>
>> Use BIT(bit)
>>
>>> +                               reg_base + GPIO_INT_STATUS(bank_id));
>>> +               /* Invoke interrupt handler */
>>> +               generic_handle_irq(gpio_to_irq(GPIO_PER_BANK * bank_id + bit));
>>> +       }
>>
>> Usually you may want to re-read thet status for each iteration
>> of this loop, if IRQs appear as you are processing.
>
> Will do.

I have a follow-up question regarding status reads for each iteration.
Is this what you are looking for?

        for (;;) {
                sta = readl(reg_base + GPIO_INT_STATUS(bank_id)) &
                    (~(readl(reg_base + GPIO_INT_MASK(bank_id))));
                if (sta == 0)
                        break;

                for_each_set_bit(bit, &sta, 32) {
                        int gpio = GPIO_PER_BANK * bank_id + bit;
                        int virq = irq_find_mapping(bank->kona_gpio->irq_domain,
                                                    gpio);
                        /*
                         * Clear interrupt before handler is called so
we don't
                         * miss any interrupt occurred during
executing them.
                         */
                        writel(readl(reg_base +
GPIO_INT_STATUS(bank_id)) |
                               BIT(bit), reg_base + GPIO_INT_STATUS(bank_id));
                        /* Invoke interrupt handler */
                        generic_handle_irq(virq);
                }
        }

It's an extra loop, since I am not sure it would work to modify "sta"
within the for_each_set_bit loop. Say an interrupt occurred whose bit
we already checked, we'd still miss that.

Thanks,
-Markus
