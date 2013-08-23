From: markus.mayer@linaro.org (Markus Mayer)
Date: Fri, 23 Aug 2013 10:58:23 -0700
Subject: [PATCH v4 1/3] ARM: bcm281xx: Add GPIO driver
In-Reply-To: <CACRpkdbm2cKpz2SrUgsUpB4x5xjm=Bz=VCu279sEAKFJ1x9SPg@mail.gmail.com>
References: <1376938761-13657-1-git-send-email-markus.mayer@linaro.org>
 <1376938761-13657-2-git-send-email-markus.mayer@linaro.org>
 <CACRpkdbm2cKpz2SrUgsUpB4x5xjm=Bz=VCu279sEAKFJ1x9SPg@mail.gmail.com>
Message-ID: <CAPdLdqm+r1P=48Aujz9nuDb_vpFj-wBvmCV=oOKNZ0YENmbL1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 August 2013 10:34, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Aug 19, 2013 at 8:59 PM, Markus Mayer <markus.mayer@linaro.org> wrote:
>
>> From: Markus Mayer <mmayer@broadcom.com>
>>
>> This patch adds the GPIO driver for the bcm281xx family of chips.
>>
>> Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
>> Reviewed-by: Christian Daudt <csd@broadcom.com>
>> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
>> Reviewed-by: Matt Porter <matt.porter@linaro.org>
>
> This is getting into nice shape quickly, but at this point the driver
> will still miss the v3.12 merge window as it seems, so let's
> aim for v3.13.

Yes, it is starting to look that way.

>> +/* This function counts IRQ entries in the device tree */
>> +static int bcm_kona_count_irq_resources(struct platform_device *pdev)
>> +{
>> +       int i, ret;
>> +
>> +       for (i = 0;; i++) {
>> +               ret = platform_get_irq(pdev, i);
>> +               if (ret < 0)
>> +                       break;
>> +       }
>> +       return i;
>> +}
>
> This looks weird, and it is not operating on a device tree but
> on the platform resources created by the device tree core,
> so atleast remove that comment. What it does is just count
> the number of IRQs for this device, no matter where it came
> from, right?

That function is actually gone now in my current working version. I
have taken Thomesz's advice and am using of_count_irq().

You are right that we only care about the number of IRQs, no matter
where they came from. In our case, they'd always come from device
tree, though.

>> +static void bcm_kona_gpio_set(struct gpio_chip *chip, unsigned gpio,
>> +       int value)
>> +{
> (...)
>> +       val = readl(reg_base + reg_offset);
>> +       val |= 1 << bit;
>
> I would really like you to do like this:
>
> #include <linux/bitops.h>
>
> val |= BIT(bit);

I'll incorporate the bit operations here and below.

[...]

>> +static void bcm_kona_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>> +{
>> +       void __iomem *reg_base;
>> +       int bit, bank_id;
>> +       unsigned long sta;
>> +       struct bcm_kona_gpio_bank *bank = irq_get_handler_data(irq);
>> +       struct irq_chip *chip = irq_desc_get_chip(desc);
>> +
>> +       chained_irq_enter(chip, desc);
>> +
>> +       /*
>> +        * For bank interrupts, we can't use chip_data to store the kona_gpio
>> +        * pointer, since GIC needs it for its own purposes. Therefore, we get
>> +        * our pointer from the bank structure.
>> +        */
>> +       reg_base = bank->reg_base;
>> +       bank_id = bank->id;
>> +       bcm_kona_gpio_unlock_bank(reg_base, bank_id);
>> +
>> +       sta = readl(reg_base + GPIO_INT_STATUS(bank_id)) &
>> +           (~(readl(reg_base + GPIO_INT_MASK(bank_id))));
>> +
>> +       for_each_set_bit(bit, &sta, 32) {
>> +               /*
>> +                * Clear interrupt before handler is called so we don't
>> +                * miss any interrupt occurred during executing them.
>> +                */
>> +               writel(readl(reg_base + GPIO_INT_STATUS(bank_id)) |
>> +                               (1 << bit),
>
> Use BIT(bit)
>
>> +                               reg_base + GPIO_INT_STATUS(bank_id));
>> +               /* Invoke interrupt handler */
>> +               generic_handle_irq(gpio_to_irq(GPIO_PER_BANK * bank_id + bit));
>> +       }
>
> Usually you may want to re-read thet status for each iteration
> of this loop, if IRQs appear as you are processing.

Will do.

>> +static int bcm_kona_gpio_probe(struct platform_device *pdev)
>> +{
> (...)
>> +       kona_gpio->irq_base = irq_alloc_descs(-1, 0, chip->ngpio, 0);
>> +       if (kona_gpio->irq_base < 0) {
>> +               dev_err(dev, "Couldn't allocate IRQ numbers\n");
>> +               return -ENXIO;
>> +       }
>
> As mentioned by Tomasz this looks strange.

Yep, it does, and it's gone now. It was a forgotten and overlooked
piece of code from an old version of the driver that used legacy
mapping. I took it out.

Thanks,
-Markus

-- 
Markus Mayer
Broadcom Landing Team
