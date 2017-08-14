From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 14 Aug 2017 16:33:09 +0200
Subject: [PATCH 2/8] gpio: zynq: Wakeup gpio controller when it is used as
 IRQ controller
In-Reply-To: <CACRpkdZE-Edr7fWZY5VQM1_65iw7MYGP-iDa2ExZsPxpM0rurQ@mail.gmail.com>
References: <cover.1502103715.git.michal.simek@xilinx.com>
 <72d3cd83bed792a23ab60cf9b6d51b618f5aa084.1502103715.git.michal.simek@xilinx.com>
 <CACRpkdZE-Edr7fWZY5VQM1_65iw7MYGP-iDa2ExZsPxpM0rurQ@mail.gmail.com>
Message-ID: <6da5fd79-fbc8-b613-954f-dcbe2ef8d6c5@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.8.2017 15:53, Linus Walleij wrote:
> On Mon, Aug 7, 2017 at 1:01 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> 
>> From: Borsodi Petr <Petr.Borsodi@i.cz>
>>
>> There is a problem with GPIO driver when used as IRQ controller.
>> It is not working because the module is sleeping (clock is disabled).
>> The patch enables clocks when IP is used as IRQ controller.
>>
>> Signed-off-by: Borsodi Petr <Petr.Borsodi@i.cz>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> I'm a bit worried about this patch.
> 
>> +static int zynq_gpio_irq_request_resources(struct irq_data *d)
>> +{
>> +       struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
>> +       int ret;
>> +
>> +       if (!try_module_get(chip->gpiodev->owner))
>> +               return -ENODEV;
> 
> You are poking around in gpiolib internals, I don't really like that.
> I prefer that you use accessors and try to make the core deal with
> this instead of fixing it up with a local hack in the driver.
> 
>> +       ret = pm_runtime_get_sync(chip->parent);
>> +       if (ret < 0) {
>> +               module_put(chip->gpiodev->owner);
>> +               return ret;
>> +       }
> 
> What you essentially do is disable runtime PM while IRQs are in
> use, the patch commit log should say this.
> 
>> +       if (gpiochip_lock_as_irq(chip, d->hwirq)) {
>> +               chip_err(chip, "unable to lock HW IRQ %lu for IRQ\n", d->hwirq);
>> +               pm_runtime_put(chip->parent);
>> +               module_put(chip->gpiodev->owner);
>> +               return -EINVAL;
>> +       }
> 
> This is essentially a separate patch that should be done orthogonally.
> (I don't care super-much about that though.)
> 
>> +static void zynq_gpio_irq_release_resources(struct irq_data *d)
>> +{
>> +       struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
>> +
>> +       gpiochip_unlock_as_irq(chip, d->hwirq);
>> +       pm_runtime_put(chip->parent);
>> +       module_put(chip->gpiodev->owner);
>> +}
> (...)
>> +       .irq_request_resources = zynq_gpio_irq_request_resources,
>> +       .irq_release_resources = zynq_gpio_irq_release_resources,
> 
> Look at this from gpiolib.c:
> 
> static int gpiochip_irq_reqres(struct irq_data *d)
> {
>         struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
> 
>         if (!try_module_get(chip->gpiodev->owner))
>                 return -ENODEV;
> 
>         if (gpiochip_lock_as_irq(chip, d->hwirq)) {
>                 chip_err(chip,
>                         "unable to lock HW IRQ %lu for IRQ\n",
>                         d->hwirq);
>                 module_put(chip->gpiodev->owner);
>                 return -EINVAL;
>         }
>         return 0;
> }
> 
> static void gpiochip_irq_relres(struct irq_data *d)
> {
>         struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
> 
>         gpiochip_unlock_as_irq(chip, d->hwirq);
>         module_put(chip->gpiodev->owner);
> }
> 
> If you add pm_runtime_get_sync()/put to this and export
> the functions you have the same thing and you can just reuse this
> code instead of copying it.
> 
> Arguably the above should indeed have that runtime PM code
> (unless we know a better way to deal with IRQs).
> 
> So can we fix this in the core and reuse it from there?

I have checked 4.13-rc1 and none is doing anything with clock in these
irq routines.
It means it is a question if they have the same issue when device is
sleeping or we do something wrong.
It is not a problem to move these calls to core (patch is quite simple)
but validate that if this is correct on others SoC.
Do you know if we can validate this on different SoC?

Nava: Can you please validate this again on ZynqMP?

Thanks,
Michal

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9568708a550b..a08a044fa4aa 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1647,14 +1647,22 @@ static void gpiochip_irq_unmap(struct irq_domain
*d, unsigned int irq)
 static int gpiochip_irq_reqres(struct irq_data *d)
 {
        struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+       int ret;

        if (!try_module_get(chip->gpiodev->owner))
                return -ENODEV;

+       ret = pm_runtime_get_sync(chip->parent);
+       if (ret < 0) {
+               module_put(chip->gpiodev->owner);
+               return ret;
+       }
+
        if (gpiochip_lock_as_irq(chip, d->hwirq)) {
                chip_err(chip,
                        "unable to lock HW IRQ %lu for IRQ\n",
                        d->hwirq);
+               pm_runtime_put(chip->parent);
                module_put(chip->gpiodev->owner);
                return -EINVAL;
        }
@@ -1666,6 +1674,7 @@ static void gpiochip_irq_relres(struct irq_data *d)
        struct gpio_chip *chip = irq_data_get_irq_chip_data(d);

        gpiochip_unlock_as_irq(chip, d->hwirq);
+       pm_runtime_put(chip->parent);
        module_put(chip->gpiodev->owner);
 }
