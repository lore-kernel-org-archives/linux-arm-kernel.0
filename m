From: tommy.lin.1101@gmail.com (=?Big5?B?qkynu6Tl?=)
Date: Mon, 15 Aug 2011 15:43:01 +0800
Subject: [PATCH 1/2] gpio: Add CNS3XXX mmio gpio support
In-Reply-To: <20110812091908.GK4775@n2100.arm.linux.org.uk>
References: <1313005731-16074-1-git-send-email-tommy.lin.1101@gmail.com>
	<20110812091908.GK4775@n2100.arm.linux.org.uk>
Message-ID: <CAB8eogeRkzWGVjLS5vhk+wcuyOkopZ_LvQ_zpg5_b2CRMyrVmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +#include <asm-generic/gpio.h>
>
> Please see linux-next's arch/arm/include/asm/gpio.h
That means I have to submit to linux-next, if I following linux-next
gpio.h header file.

>> +#define GPIO_INTR_MASK_OFFSET ? ? ? ? ? ? ? ? ? ? ? ?0x2C
>> +#define GPIO_INTR_CLEAR_OFFSET ? ? ? ? ? ? ? ? ? ? ? 0x30
>> +#define GPIO_INTR_TRIGGER_METHOD_OFFSET ? ? ? ? ? ? ?0x34
>> +#define GPIO_INTR_TRIGGER_BOTH_EDGES_OFFSET ?0x38
>> +#define GPIO_INTR_TRIGGER_POL_OFFSET ? ? ? ? 0x3C
>> +#define GPIO_BOUNCE_ENABLE_OFFSET ? ? ? ? ? ?0x40
>> +#define GPIO_BOUNCE_PRESCALE_OFFSET ? ? ? ? ?0x44
>
> Do you really need to put these here? ?Can they go in a private header file
> maybe in arch/arm/mach-xxx/ ?
I will move these register offset macros to arch/arm/mach-cns3xxx/gpio-regs.h

>> +
>> +
>> +#define gpio_get_value ? ? ? ? ? ? ? ? ? ? ? __gpio_get_value
>> +#define gpio_set_value ? ? ? ? ? ? ? ? ? ? ? __gpio_set_value
>> +#define gpio_cansleep ? ? ? ? ? ? ? ? ? ? ? ?__gpio_cansleep
>> +#define gpio_to_irq ? ? ? ? ? ? ? ? ?cns3xxx_gpio_to_irq
>
> Again, please see linux-next.
>
>> +inline int cns3xxx_gpio_to_irq(unsigned gpio)
>> +{
>> + ? ? return NR_IRQS_CNS3XXX + gpio;
>> +}
>> +EXPORT_SYMBOL(gpio_to_irq);
>
> No. ?Three issues:
>
> 1. You are exporting a function you're not defining here.
> 2. The function is marked inline yet nothing in this file uses it, so
> ? the inline provides no useful purpose.
> 3. Please use the standard gpiolib gpio_to_irq() and hook the translation
> ? into the gpiolib .to_irq method.
I leverage the generic driver for memory mapped GPIO, which is not define
gpio_to_irq(). So I use the lazy way here. I should change the way to use
bgpio_chip and hook gpio_to_irq().

>> +static void __iomem *gpio_map(struct platform_device *pdev,
>> + ? ? ? ? ? ? const char *name, int *err)
>> +{
>> + ? ? struct device *dev = &pdev->dev;
>> + ? ? struct resource *r;
>> + ? ? resource_size_t start;
>> + ? ? resource_size_t sz;
>> + ? ? void __iomem *ret;
>> +
>> + ? ? *err = 0;
>> +
>> + ? ? r = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
>> + ? ? if (!r)
>> + ? ? ? ? ? ? return NULL;
>> +
>> + ? ? sz = resource_size(r);
>> + ? ? start = r->start;
>> +
>> + ? ? if (!devm_request_mem_region(dev, start, sz, r->name)) {
>> + ? ? ? ? ? ? *err = -EBUSY;
>> + ? ? ? ? ? ? return NULL;
>> + ? ? }
>> +
>> + ? ? ret = devm_ioremap(dev, start, sz);
>> + ? ? if (!ret) {
>> + ? ? ? ? ? ? *err = -ENOMEM;
>> + ? ? ? ? ? ? return NULL;
>> + ? ? }
>> +
>> + ? ? return ret;
>> +}
>> +
>> +static int __devinit gpio_probe(struct platform_device *pdev)
>> +{
>> + ? ? int i, nr_gpios = 0, err = 0;
>> + ? ? struct device *dev = &pdev->dev;
>> + ? ? struct resource *res;
>> + ? ? void __iomem *misc_reg;
>> + ? ? struct irq_chip_type *ct;
>> +
>> + ? ? /* TODO Once the clk framework (clk_get() + clk_enable()) is
>> + ? ? ?* implemented. Use clok framework APIs instead of these APIs.
>> + ? ? ?*/
>> + ? ? cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_GPIO);
>> + ? ? cns3xxx_pwr_soft_rst(0x1 << PM_CLK_GATE_REG_OFFSET_GPIO);
>> +
>> +
>> + ? ? misc_reg = gpio_map(pdev, "MISC", &err);
>> + ? ? if (!misc_reg) {
>> + ? ? ? ? ? ? dev_dbg(dev, "%s gpio_map \"MISC\" failure! err=%d\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? __func__, err);
>> + ? ? ? ? ? ? return err;
>> + ? ? }
>> +
>> + ? ? /* Scan and match GPIO resources */
>> + ? ? for (i = 0; i < nr_banks; i++) {
>> + ? ? ? ? ? ? /* Fetech GPIO interrupt control register base address */
>> + ? ? ? ? ? ? gc_info[i].reg_base = gpio_map(pdev, gc_info[i].name, &err);
>> + ? ? ? ? ? ? if (!gc_info[i].reg_base) {
>> + ? ? ? ? ? ? ? ? ? ? dev_dbg(dev, "%s gpio_map %s failure! err=%d\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? __func__, gc_info[i].name, err);
>> + ? ? ? ? ? ? ? ? ? ? goto err1;
>> + ? ? ? ? ? ? }
>> +
>> + ? ? ? ? ? ? /* Fetech GPIO interrupt ID number */
>> + ? ? ? ? ? ? res = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? gc_info[i].name);
>> + ? ? ? ? ? ? if (!res) {
>> + ? ? ? ? ? ? ? ? ? ? dev_dbg(dev, "%s platform_get_resource_byname (%s)"
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "failed!\n", gc_info[i].name, __func__);
>> + ? ? ? ? ? ? ? ? ? ? err = -ENODEV;
>> + ? ? ? ? ? ? ? ? ? ? goto err2;
>> + ? ? ? ? ? ? }
>> + ? ? ? ? ? ? gc_info[i].irq = res->start;
>> + ? ? ? ? ? ? gc_info[i].reg_gpio_dis = misc_reg + 0x14 + i * 4;
>> +
>> + ? ? ? ? ? ? gc_info[i].gc = irq_alloc_generic_chip("GPIO", 1,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? NR_IRQS_CNS3XXX + gc_info[i].base,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? gc_info[i].reg_base, handle_level_irq);
>> + ? ? ? ? ? ? if (!gc_info[i].gc) {
>> + ? ? ? ? ? ? ? ? ? ? dev_dbg(dev, "%s irq_alloc_generic_chip failed!\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? __func__);
>> + ? ? ? ? ? ? ? ? ? ? err = -ENOMEM;
>> + ? ? ? ? ? ? ? ? ? ? goto err2;
>> + ? ? ? ? ? ? }
>> + ? ? ? ? ? ? gc_info[i].gc->private = &gc_info[i];
>> +
>> + ? ? ? ? ? ? ct = gc_info[i].gc->chip_types;
>> + ? ? ? ? ? ? ct->regs.mask = get_offset(GPIO_INTR_ENABLE_OFFSET);
>> + ? ? ? ? ? ? ct->regs.ack = get_offset(GPIO_INTR_CLEAR_OFFSET);
>> + ? ? ? ? ? ? ct->regs.type = get_offset(GPIO_INTR_TRIGGER_METHOD_OFFSET);
>> + ? ? ? ? ? ? ct->regs.polarity = get_offset(GPIO_INTR_TRIGGER_POL_OFFSET);
>> + ? ? ? ? ? ? ct->type = IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW;
>> + ? ? ? ? ? ? ct->chip.irq_ack = irq_gc_ack_set_bit;
>> + ? ? ? ? ? ? ct->chip.irq_mask = irq_gc_mask_clr_bit;
>> + ? ? ? ? ? ? ct->chip.irq_unmask = irq_gc_mask_set_bit;
>> + ? ? ? ? ? ? ct->chip.irq_set_type = cns3xxx_gpio_set_irq_type;
>> +
>> + ? ? ? ? ? ? irq_setup_generic_chip(gc_info[i].gc, IRQ_MSK(gc_info[i].ngpio),
>> + ? ? ? ? ? ? ? ? ? ? IRQ_GC_INIT_MASK_CACHE | IRQ_GC_INIT_NESTED_LOCK,
>> + ? ? ? ? ? ? ? ? ? ? IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
>> +
>> + ? ? ? ? ? ? irq_set_chained_handler(gc_info[i].irq, gpio_irq_handler);
>> + ? ? ? ? ? ? err = irq_set_handler_data(gc_info[i].irq, &gc_info[i]);
>> + ? ? ? ? ? ? if (err) {
>> + ? ? ? ? ? ? ? ? ? ? dev_dbg(dev, "%s irq_set_handler_data fail!\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? __func__);
>> + ? ? ? ? ? ? ? ? ? ? goto err2;
>> + ? ? ? ? ? ? }
>> +
>> + ? ? ? ? ? ? nr_gpios += gc_info[i].ngpio;
>> + ? ? ? ? ? ? if (nr_gpios >= MAX_GPIO_NO)
>> + ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? }
>> +
>> + ? ? return 0;
>> +
>> +err2:
>> + ? ? if (gc_info[1].reg_base)
>> + ? ? ? ? ? ? devm_iounmap(dev, gc_info[0].reg_base);
>
> This looks buggy. ?You're unmapping the wrong reg_base.
>
>> +
>> +err1:
>> + ? ? if (gc_info[0].reg_base)
>> + ? ? ? ? ? ? devm_iounmap(dev, gc_info[0].reg_base);
>> +
>> + ? ? devm_iounmap(dev, misc_reg);
>
> This is also rather inconsistent. ?While you iounmap, you're not releasing
> the region which you claimed in gpio_map().
>
> It's also rather unnecessary. ?One of the reasons for devm_* is that
> drivers shouldn't need to care about cleaning up the managed resources.
> The driver model will take care of that when a probe fails, or upon
> remove. ?It avoids people making mistakes like the above.
I got the idea. There is no need to do any devm_iounmap here. So I can just
remove these devm_iounmap.

> However, I don't see where you're cleaning up the generic irqchip
> which was allocated (which is an unmanaged resource).
irq_remove_generic_chip didn't release the memory allocated by
irq_alloc_generic_chip,
I should release memory myself.

-- 
Best Regards,
Tommy
