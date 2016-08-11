From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Aug 2016 11:20:10 +0200
Subject: [PATCH 06/12] gpio: Add Aspeed driver
In-Reply-To: <1468994313-13538-7-git-send-email-andrew@aj.id.au>
References: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
 <1468994313-13538-7-git-send-email-andrew@aj.id.au>
Message-ID: <CACRpkdYvZdTa7dpSs5=vnK77wpRGFT2W3e3=AS3GJGY7CXdwRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 7:58 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

> diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
> index 25a0ae01429e..a52de9d3adfb 100644
> --- a/arch/arm/mach-aspeed/Kconfig
> +++ b/arch/arm/mach-aspeed/Kconfig
> @@ -6,6 +6,10 @@ menuconfig ARCH_ASPEED
>         select ASPEED_WATCHDOG
>         select MOXART_TIMER
>         select PINCTRL
> +       select GPIOLIB
> +       select GPIO_ASPEED

Again this needs to be a separate patch to ARM SoC.

> +       select GPIO_SYSFS

NAK over my dead body. I strongly discourage the use of the
GPIO sysfs, use the new character device, see
toos/gpio/* for examples.

> +config GPIO_ASPEED
> +       bool "Aspeed GPIO support"
> +       depends on (ARCH_ASPEED || COMPILE_TEST) && OF
> +       select GENERIC_IRQ_CHIP

Why are you using GENERIC_IRQ_CHIP but not
GPIOLIB_IRQCHIP? Well I guess I may find out by
reading the code...

> +       help
> +         Say Y here to support Aspeed AST2400 and AST2500 GPIO controllers.
> +
>  config GPIO_BCM_KONA
>         bool "Broadcom Kona GPIO"
>         depends on OF_GPIO && (ARCH_BCM_MOBILE || COMPILE_TEST)
> @@ -1072,7 +1079,6 @@ config GPIO_SODAVILLE
>         select GENERIC_IRQ_CHIP
>         help
>           Say Y here to support Intel Sodaville GPIO.
> -
>  endmenu

Drop this unrelated whitespace change.

> +#define GPIO_BANK(x)   ((x) >> 5)
> +#define GPIO_OFFSET(x) ((x) & 0x1f)
> +#define GPIO_BIT(x)    BIT(GPIO_OFFSET(x))

Clever, maybe needs some comments on how they work?
Or is it obvious from context?

> +#define GPIO_DATA      0x00
> +#define GPIO_DIR       0x04
> +
> +#define GPIO_IRQ_ENABLE        0x00
> +#define GPIO_IRQ_TYPE0 0x04
> +#define GPIO_IRQ_TYPE1 0x08
> +#define GPIO_IRQ_TYPE2 0x0c
> +#define GPIO_IRQ_STATUS        0x10

> +static inline struct aspeed_gpio *to_aspeed_gpio(struct gpio_chip *chip)
> +{
> +       return container_of(chip, struct aspeed_gpio, chip);
> +}

NAK rewrite your code to use devm_gpiochip_add_data() and
then use gpiochip_get_data() inline in every function that
needs to get the state container from the gpiochip. Read
the code in the upstream kernel for *any* driver because I
think I changed this virtually everywhere.

(...)
> +static void __aspeed_gpio_irq_set_mask(struct irq_data *d, bool set)

Why __underscoring. It is just confusing, drop the underscores.
The function does set the mask.

> +{
> +       const struct aspeed_gpio_bank *bank;
> +       struct aspeed_gpio *gpio;
> +       unsigned long flags;
> +       u32 reg, bit;
> +       void *addr;
> +       int rc;
> +
> +       rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit);
> +       if (rc)
> +               return;
> +
> +       addr = bank_irq_reg(gpio, bank, GPIO_IRQ_ENABLE);
> +
> +       spin_lock_irqsave(&gpio->lock, flags);
> +
> +       reg = ioread32(addr);
> +       if (set)
> +               reg |= bit;
> +       else
> +               reg &= bit;
> +       iowrite32(reg, addr);

Hm, if this was done with regmap it would be regmap_update_bits()
simply ... maybe you should just throw a 32bit MMIO regmap over
the registers? (Not required, just an idea to simplify stuff...)

> +static int aspeed_gpio_set_type(struct irq_data *d, unsigned int type)
> +{
> +       u32 type0, type1, type2, bit, reg;
> +       const struct aspeed_gpio_bank *bank;
> +       irq_flow_handler_t handler;
> +       struct aspeed_gpio *gpio;
> +       unsigned long flags;
> +       void *addr;
> +       int rc;
> +
> +       rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit);
> +       if (rc)
> +               return -EINVAL;
> +
> +       type0 = type1 = type2 = 0;

Assign zero when declaring instead:

u32 type0 = 0;
u32 type1 = 0;
...

> +
> +       switch (type & IRQ_TYPE_SENSE_MASK) {
> +       case IRQ_TYPE_EDGE_BOTH:
> +               type2 |= bit;
> +       case IRQ_TYPE_EDGE_RISING:
> +               type0 |= bit;
> +       case IRQ_TYPE_EDGE_FALLING:
> +               handler = handle_edge_irq;
> +               break;
> +       case IRQ_TYPE_LEVEL_HIGH:
> +               type0 |= bit;
> +       case IRQ_TYPE_LEVEL_LOW:
> +               type1 |= bit;
> +               handler = handle_level_irq;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }

Very nice, this looks exactly as it should, handling the different
IRQs very nicely.

> +       spin_lock_irqsave(&gpio->lock, flags);
> +
> +       addr = bank_irq_reg(gpio, bank, GPIO_IRQ_TYPE0);
> +       reg = ioread32(addr);
> +       reg = (reg & ~bit) | type0;
> +       iowrite32(reg, addr);
> +
> +       addr = bank_irq_reg(gpio, bank, GPIO_IRQ_TYPE1);
> +       reg = ioread32(addr);
> +       reg = (reg & ~bit) | type1;
> +       iowrite32(reg, addr);
> +
> +       addr = bank_irq_reg(gpio, bank, GPIO_IRQ_TYPE2);
> +       reg = ioread32(addr);
> +       reg = (reg & ~bit) | type2;
> +       iowrite32(reg, addr);
> +
> +       spin_unlock_irqrestore(&gpio->lock, flags);
> +
> +       irq_set_handler_locked(d, handler);
> +
> +       return 0;
> +}

Overall very nice .set_type().

> +static void aspeed_gpio_irq_handler(struct irq_desc *desc)
> +{
> +       struct aspeed_gpio *gpio = irq_desc_get_handler_data(desc);
> +       struct irq_chip *chip = irq_desc_get_chip(desc);
> +       unsigned int i, p, girq;
> +       unsigned long reg;
> +
> +       chained_irq_enter(chip, desc);
> +
> +       for (i = 0; i < ARRAY_SIZE(aspeed_gpio_banks); i++) {
> +               const struct aspeed_gpio_bank *bank = &aspeed_gpio_banks[i];
> +
> +               reg = ioread32(bank_irq_reg(gpio, bank, GPIO_IRQ_STATUS));
> +
> +               for_each_set_bit(p, &reg, 32) {
> +                       girq = irq_find_mapping(gpio->irq_domain, i * 32 + p);
> +                       generic_handle_irq(girq);
> +               }
> +
> +       }
> +
> +       chained_irq_exit(chip, desc);
> +}

This looks so generic so I think you should be using
GPIOLIB_IRQCHIP.

> +
> +static struct irq_chip aspeed_gpio_irqchip = {
> +       .name           = "aspeed-gpio",
> +       .irq_ack        = aspeed_gpio_irq_ack,
> +       .irq_mask       = aspeed_gpio_irq_mask,
> +       .irq_unmask     = aspeed_gpio_irq_unmask,
> +       .irq_set_type   = aspeed_gpio_set_type,
> +};

There is a missing .request/.release resources marking the lines
as irq to the GPIO core. But if you switch to using GPIOLIB_IRQCHIP
the core will handle all that for you.

> +static int aspeed_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct aspeed_gpio *gpio = to_aspeed_gpio(chip);
> +
> +       return irq_find_mapping(gpio->irq_domain, offset);
> +}
> +
> +static void aspeed_gpio_setup_irqs(struct aspeed_gpio *gpio,
> +               struct platform_device *pdev)
> +{
> +       int i, irq;
> +
> +       /* request our upstream IRQ */
> +       gpio->irq = platform_get_irq(pdev, 0);
> +       if (gpio->irq < 0)
> +               return;
> +
> +       /* establish our irq domain to provide IRQs for each extended bank */
> +       gpio->irq_domain = irq_domain_add_linear(pdev->dev.of_node,
> +                       gpio->chip.ngpio, &irq_domain_simple_ops, NULL);
> +       if (!gpio->irq_domain)
> +               return;
> +
> +       for (i = 0; i < gpio->chip.ngpio; i++) {
> +               irq = irq_create_mapping(gpio->irq_domain, i);
> +               irq_set_chip_data(irq, gpio);
> +               irq_set_chip_and_handler(irq, &aspeed_gpio_irqchip,
> +                               handle_simple_irq);
> +               irq_set_probe(irq);
> +       }
> +
> +       irq_set_chained_handler_and_data(gpio->irq,
> +                       aspeed_gpio_irq_handler, gpio);
> +}

Also all this goes away with GPILIB_IRQCHIP, so use it.

See e.g. drivers/gpio/gpio-pl061.c for an example of a similar
driver doing this.

> +static int __init aspeed_gpio_probe(struct platform_device *pdev)
> +{
> +       struct aspeed_gpio *gpio;
> +       struct resource *res;
> +       int rc;
> +
> +       gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
> +       if (!gpio)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -ENXIO;
> +
> +       gpio->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (!gpio->base)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&gpio->lock);
> +
> +       gpio->chip.ngpio = ARRAY_SIZE(aspeed_gpio_banks) * 32;
> +
> +       gpio->chip.parent = &pdev->dev;
> +       gpio->chip.direction_input = aspeed_gpio_dir_in;
> +       gpio->chip.direction_output = aspeed_gpio_dir_out;

Please add gpio->chip.get_direction() to complete the picture.

> +       gpio->chip.request = aspeed_gpio_request;
> +       gpio->chip.free = aspeed_gpio_free;
> +       gpio->chip.get = aspeed_gpio_get;
> +       gpio->chip.set = aspeed_gpio_set;
> +       gpio->chip.to_irq = aspeed_gpio_to_irq;

.to_irq goes away with GPILIB_IRQCHIP.

> +       gpio->chip.label = dev_name(&pdev->dev);
> +       gpio->chip.base = -1;
> +
> +       platform_set_drvdata(pdev, gpio);
> +
> +       rc = gpiochip_add(&gpio->chip);
> +       if (rc < 0)
> +               return rc;

Use devm_gpiochip_add_data(), then gpiochip_irqchip_add().

> +static int aspeed_gpio_remove(struct platform_device *pdev)
> +{
> +       struct aspeed_gpio *gpio = platform_get_drvdata(pdev);
> +
> +       gpiochip_remove(&gpio->chip);
> +       return 0;
> +}

And then this is not even needed. (devm*)

Yours,
Linus Walleij
