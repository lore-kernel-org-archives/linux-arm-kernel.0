From: gnurou@gmail.com (Alexandre Courbot)
Date: Sun, 25 May 2014 16:35:47 +0900
Subject: [PATCH 1/3] gpio: Add APM X-Gene SoC GPIO controller support
In-Reply-To: <CAL85gmDjVszNd3TB51BGa+78wEEZmJfBOLNKOpTEvMTGU2VdBA@mail.gmail.com>
References: <1400263432-922-1-git-send-email-fkan@apm.com>
 <1400263432-922-2-git-send-email-fkan@apm.com>
 <CAAVeFu+TOfjfvisinv3oJ9PobdV9HcNJhr+3VYneSJ54uGwiAg@mail.gmail.com>
 <CAL85gmDjVszNd3TB51BGa+78wEEZmJfBOLNKOpTEvMTGU2VdBA@mail.gmail.com>
Message-ID: <CAAVeFuKw+6OfkrjJ3Xx7zbspptTirYGnF2a-rEHw=y9RBnkjDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 8:54 AM, Feng Kan <fkan@apm.com> wrote:
>> +static void xgene_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
>> +{
>> +       struct xgene_gpio_bank *bank =
>> +                       container_of(gc, struct xgene_gpio_bank, chip);
>> +       unsigned long flags;
>> +       u32 data;
>> +
>> +       spin_lock_irqsave(&bank->lock, flags);
>> +
>> +       data = ioread32(bank->set_dr);
>> +       data = val ? data | GPIO_SET_MASK(gpio) : data & ~GPIO_SET_MASK(gpio);
>
>>Couldn't you use set_bit() / clear_bit() instead here?
> Set_bit/clear_bit seems a bit heavy, I can use the non atomic methods
> of _set_bit/clear_bit
> if you agree? In which case I will rewrite all the other method in
> likewise fashion.

Sounds good.

>
>
>>> +       bank = &gpio->banks[offs];
>>> +       bank->gpio = gpio;
>>> +       spin_lock_init(&bank->lock);
>>> +
>>> +       if (of_property_read_u32(bank_np, "ngpios", &ngpio))
>>> +               ngpio = 16;
>>
>> Here I think you want to distinguish between "property not defined"
>> (-EINVAL) and "property has no value" (-ENODATA) and other possible
>> errors. In the later cases you will want to signal the error and
>> return from here.
>
> I kinda messed up here a bit, I am trying to support ACPI booting but other
> properties are also affected. I will rewrite this part so minimum of_ access
> methods are required.
>
>
>>
>>> +
>>> +       if ((ngpio > 16) || (ngpio < 1)) {
>>> +               dev_info(gpio->dev, "Incorrect number of gpio specified: %s\n",
>>> +                        bank_np->full_name);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       bank->data = gpio->regs + GPIO_DATA + (bank_idx * GPIO_DATA_OFFSET);
>>> +       bank->od = gpio->regs + GPIO_OD + (bank_idx * GPIO_OD_OFFSET);
>>> +       bank->mux = gpio->regs + GPIO_MUX + (bank_idx * GPIO_MUX_OFFSET);
>>> +       bank->set_dr = gpio->regs + GPIO_SET_DR
>>> +                               + (bank_idx * GPIO_SET_DR_OFFSET);
>>> +
>>> +       bank->chip.direction_input = xgene_gpio_dir_in;
>>> +       bank->chip.direction_output = xgene_gpio_dir_out;
>>> +       bank->chip.get = xgene_gpio_get;
>>> +       bank->chip.set = xgene_gpio_set;
>>> +
>>> +       if (!of_property_read_u32(bank_np, "odcfg", &odcfg))
>>> +               iowrite32(odcfg, bank->od);
>>> +
>>> +       bank->chip.ngpio = ngpio;
>>> +       bank->chip.of_node = bank_np;
>>> +       bank->chip.base = bank_idx * ngpio;
>>> +
>>> +       err = gpiochip_add(&bank->chip);
>>> +       if (err)
>>> +               dev_err(gpio->dev, "failed to register gpiochip for %s\n",
>>> +                       bank_np->full_name);
>>> +
>>> +       return err;
>>> +}
>>> +
>>> +static int xgene_gpio_probe(struct platform_device *pdev)
>>> +{
>>> +       struct device_node *np = pdev->dev.of_node;
>>> +       struct resource *res;
>>> +       struct xgene_gpio *gpio;
>>> +       int err;
>>> +       unsigned int offs = 0;
>>> +
>>> +       gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
>>> +       if (!gpio)
>>> +               return -ENOMEM;
>>> +       gpio->dev = &pdev->dev;
>>> +
>>> +       gpio->nr_banks = of_get_child_count(pdev->dev.of_node);
>>> +       if (!gpio->nr_banks) {
>>> +               err = -EINVAL;
>>> +               goto err;
>>> +       }
>>
>> Might be worth checking whether nr_banks >= XGENE_GPIO_MAX_PORTS and
>> return an error here.
>>
>>> +
>>> +       gpio->banks = devm_kzalloc(&pdev->dev, gpio->nr_banks *
>>> +                                  sizeof(*gpio->banks), GFP_KERNEL);
>>> +       if (!gpio->banks) {
>>> +               err = -ENOMEM;
>>> +               goto err;
>>> +       }
>>
>> I'm fine with printing the error status the way you do, but could you
>> also do the same for the first kzalloc too?
>>
>> Or maybe you could put your banks member at the end of the xgene_gpio
>> struct as a flexible array member and perform only one kzalloc of size
>> (sizeof(*gpio) + (sizeof(*gpio->banks) * gpio->nr_banks))?
>>
>>> +
>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +       gpio->regs = devm_ioremap_resource(&pdev->dev, res);
>>> +       if (IS_ERR(gpio->regs)) {
>>> +               err = PTR_ERR(gpio->regs);
>>> +               goto err;
>>> +       }
>>> +
>>> +       for_each_child_of_node(pdev->dev.of_node, np) {
>>> +               err = xgene_gpio_add_bank(gpio, np, offs++);
>>> +               if (err)
>>> +                       goto err;
>>> +       }
>>> +
>>> +       platform_set_drvdata(pdev, gpio);
>>> +
>>> +       dev_info(&pdev->dev, "X-Gene GPIO driver registered\n");
>>> +       return 0;
>>> +err:
>>> +       dev_err(&pdev->dev, "X-Gene GPIO driver registration failed\n");
>>> +       return err;
>>> +}
>>> +
>>> +static const struct of_device_id xgene_gpio_of_match[] = {
>>> +       { .compatible = "apm,xgene-gpio", },
>>> +       {},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, xgene_gpio_of_match);
>>> +
>>> +static struct platform_driver xgene_gpio_driver = {
>>> +       .driver = {
>>> +               .name = "xgene-gpio",
>>> +               .owner = THIS_MODULE,
>>> +               .of_match_table = xgene_gpio_of_match,
>>> +       },
>>> +       .probe = xgene_gpio_probe,
>>> +};
>>> +
>>> +static int __init xgene_gpio_init(void)
>>> +{
>>> +       return platform_driver_register(&xgene_gpio_driver);
>>> +}
>>> +postcore_initcall(xgene_gpio_init);
>>> +
>>> +MODULE_AUTHOR("AppliedMicro");
>>> +MODULE_DESCRIPTION("APM X-Gene GPIO driver");
>>> +MODULE_LICENSE("GPL");
>>> --
>>> 1.9.1
>>>
>>
>> Globally the driver looks well-written, but I don't understand the
>> need to have one gpio_chip per bank. Could you elaborate on the
>> reasons for this design?
> I see each bank as separate gpio chip. It is a simple way to
> abstract the banks since they can operate independently. It also
> provided me a way to fix the sysfs gpio base number, regardless if
> a particular bank node is pulled out. This is also done in similar way
> in some other gpio drivers such as the dwapb gpio driver.

I'd like to see what Linus thinks about this, but if there is
precedence, and the banks can work independently, then I agree it may
make sense to have it that way. In that case you should probably have
each bank appearing as its own, independent node in the device tree,
and be probed directly by this driver instead of going through a
higher-level device which only practical use is to provide the number
of banks in your GPIO chip. I.e. if your bank are independent GPIO
devices, let the driver also reflect that fact.
