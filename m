From: tommy.lin.1101@gmail.com (=?Big5?B?qkynu6Tl?=)
Date: Thu, 28 Jul 2011 20:13:08 +0800
Subject: [PATCH 2/3] arch: arm: mach-cns3xxx: Add gpiolib support
In-Reply-To: <20110728101523.GA2690@pulham.picochip.com>
References: <1311873401-26075-1-git-send-email-tommy.lin.1101@gmail.com>
	<20110728101523.GA2690@pulham.picochip.com>
Message-ID: <CAB8eogcbZNVvhnocF3vhseDmpQLurPGHqdMcCwNP2V7YhE_0_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,
  Thanks for your comments.

> [...]
>> +#define CONFIG_GPIO_CNS3XXX_DEBUG
>> +
>> +#ifdef CONFIG_GPIO_CNS3XXX_DEBUG
>> +#define __pr_debug(fmt, args...) ? ? printk(KERN_ERR fmt, ##args)
>> +#else
>> +#define __pr_debug(fmt, args...)
>> +#endif
>
> Could you use the kernel debug infrastructure for this? #define DEBUG
> and pr_debug()?
Ok I will do it.

>> +static struct proc_dir_entry *proc_cns3xxx_gpio;
>> +static struct irq_chip ? ? ? ? ? ? ? cns3xxx_gpio_irq_chip;
>
> I think debugfs would be preferred for this rather than proc.
The proc entry is used in the old package, so I have to keep it.
Can I keep it? Or should I move it to debugfs?

>> +static int cns3xxx_request(struct gpio_chip *chip, unsigned offset)
>> +{
>> + ? ? /* GPIOA4 is reserved for chip bonding configuration. Please don't use
>> + ? ? ?* and configure GPIOA4.
>> + ? ? ?*/
>> + ? ? if ((strcmp(chip->label, "GPIOA") == 0) && (offset == 4))
>> + ? ? ? ? ? ? return -EINVAL;
>> + ? ? return 0;
>> +}
>> +
>
> The generic gpio (include/linux/basic_mmio_gpio.h) driver will support
> all of these accessors and provide all of the value caching too. ?You
> can add your .request method in to make sure you can't access the bond
> option pins but still use the other default accessors.
>> +static struct irq_chip cns3xxx_gpio_irq_chip = {
>> + ? ? .name = "GPIO",
>> + ? ? .irq_enable = cns3xxx_irq_enable,
>> + ? ? .irq_disable = cns3xxx_irq_disable,
>> + ? ? .irq_mask = cns3xxx_gpio_mask,
>> + ? ? .irq_unmask = cns3xxx_gpio_unmask,
>> + ? ? .irq_set_type = cns3xxx_gpio_set_irq_type,
>> +};
>
> Thomas provided a generic irq chip infrastructure for this sort of thing
> (struct irq_chip_generic) that would be useful here.
I have to study how to use basic_mmio_gpio.h and irq_chip_generic.

>> + ? ? void __iomem *misc_reg;
>> +
>> + ? ? cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_GPIO);
>
> Should this be using the clk framework (clk_get() + clk_enable())?
The platform device didn't implement these function yet! Maybe I should complete
the work first.

>> + ? ? cns3xxx_pwr_soft_rst(0x1 << PM_CLK_GATE_REG_OFFSET_GPIO);
>> +
>> + ? ? if (cns3xxx_proc_dir) {
>> + ? ? ? ? ? ? proc_cns3xxx_gpio = create_proc_entry(GPIO_PROC_NAME,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? S_IFREG | S_IRUGO, cns3xxx_proc_dir) ;
>> + ? ? ? ? ? ? if (proc_cns3xxx_gpio)
>> + ? ? ? ? ? ? ? ? ? ? proc_cns3xxx_gpio->read_proc = cns3xxx_gpio_read_proc;
>> + ? ? }
>> +
>> + ? ? res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "MISC");
>> + ? ? if (res)
>> + ? ? ? ? ? ? misc_reg = (void __iomem *)res->start;
>
> request_mem_region() and ioremap(). ?IORESOURCE_MEM resources should be
> physical addresses.
The memory space is statically mapped when platform initialized so I
just query virtual
memory space here. Should I use ioremap() rather than static mapping?

>
>> + ? ? else
>> + ? ? ? ? ? ? return -ENODEV;
>> +
>> + ? ? /* Scan and match GPIO resources */
>> + ? ? for (i = 0; i < nr_banks; i++) {
>> + ? ? ? ? ? ? /* Fetech GPIO base address */
>> + ? ? ? ? ? ? res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? cns3xxx_gchip[i].chip.label);
>> + ? ? ? ? ? ? if (!res)
>> + ? ? ? ? ? ? ? ? ? ? continue;
>> + ? ? ? ? ? ? cns3xxx_gchip[i].reg_base = (void __iomem *)res->start;
>
> The same here.
>
>> +#ifdef CONFIG_PM
>> +static int gpio_cns3xxx_suspend(struct platform_device *dev, pm_message_t state)
>> +{
>> + ? ? __pr_debug("%s,%s,%d\n", __FILE__, __func__, __LINE__);
>> +
>> + ? ? return 0;
>> +}
>> +
>> +static int gpio_cns3xxx_resume(struct platform_device *dev)
>> +{
>> + ? ? __pr_debug("%s,%s,%d\n", __FILE__, __func__, __LINE__);
>> +
>> + ? ? return 0;
>> +}
>> +#endif /* CONFIG_PM */
>> +
>> +static struct platform_driver gpio_driver = {
>> + ? ? .probe ? ? ? ? ?= gpio_probe,
>> +#ifdef CONFIG_PM
>> + ? ? .suspend ? ? ? ?= gpio_cns3xxx_suspend,
>> + ? ? .resume ? ? ? ? = gpio_cns3xxx_resume,
>> +#endif /* CONFIG_PM */
>
> You can put the power management operations in .dev_pm_ops, but as they
> don't do anything you can just remove them.
OK, I will remove it.

-- 
Best Regards,
Tommy
