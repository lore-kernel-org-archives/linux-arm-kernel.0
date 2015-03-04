From: rjui@broadcom.com (Ray Jui)
Date: Wed, 4 Mar 2015 09:37:14 -0800
Subject: [PATCH v9 2/4] pinctrl: cygnus: add gpio/pinconf driver
In-Reply-To: <CACRpkda-C1upKfa4FKLcVF9sxL4T=B+eG9ndun4fS6DZ9TfCSw@mail.gmail.com>
References: <1423606584-21795-1-git-send-email-rjui@broadcom.com>	<1423606584-21795-3-git-send-email-rjui@broadcom.com>
 <CACRpkda-C1upKfa4FKLcVF9sxL4T=B+eG9ndun4fS6DZ9TfCSw@mail.gmail.com>
Message-ID: <54F742CA.7080500@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 3/4/2015 1:48 AM, Linus Walleij wrote:
> On Tue, Feb 10, 2015 at 11:16 PM, Ray Jui <rjui@broadcom.com> wrote:
> 
>> This adds the initial support of the Broadcom Cygnus GPIO/PINCONF driver
>> that supports all 3 GPIO controllers on Cygnus including the ASIU GPIO
>> controller, the chipCommonG GPIO controller, and the always-on GPIO
>> controller. Basic PINCONF configurations such as bias pull up/down, and
>> drive strength are also supported in this driver.
>>
>> Pins from the ASIU GPIO controller can be individually muxed to GPIO
>> function, through interaction with the Cygnus IOMUX controller
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> 
> OK!
> 
>> diff --git a/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c b/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
> (...)
> 
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/module.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/gpio.h>
> 
> This should be:
> #include <linux/gpio/driver.h>
> 
>> +static u32 cygnus_readl(struct cygnus_gpio *chip, unsigned int offset)
>> +{
>> +       return readl(chip->base + offset);
>> +}
>> +
>> +static void cygnus_writel(struct cygnus_gpio *chip, unsigned int offset,
>> +                         u32 val)
>> +{
>> +       writel(val, chip->base + offset);
>> +}
> 
> If these look like so, just use readl(val, chip->base +
> offset)/writel() at all sites.
> These functions just adds a pointless layer of abstraction.
> 
>> +static void cygnus_set_bit(struct cygnus_gpio *chip, unsigned int reg,
>> +                          unsigned gpio, int set)
> 
> "set" should be bool, right?
> 
>> +{
>> +       unsigned int offset = CYGNUS_GPIO_REG(gpio, reg);
>> +       unsigned int shift = CYGNUS_GPIO_SHIFT(gpio);
>> +       u32 val;
>> +
>> +       val = cygnus_readl(chip, offset);
>> +       if (set)
>> +               val |= BIT(shift);
>> +       else
>> +               val &= ~BIT(shift);
>> +       cygnus_writel(chip, offset, val);
>> +}
>> +
>> +static int cygnus_get_bit(struct cygnus_gpio *chip, unsigned int reg,
>> +                         unsigned gpio)
> 
> This should be bool right, not int?
> 
>> +{
>> +       unsigned int offset = CYGNUS_GPIO_REG(gpio, reg);
>> +       unsigned int shift = CYGNUS_GPIO_SHIFT(gpio);
>> +       u32 val;
>> +
>> +       val =
>> +       if (val)
>> +               return 1;
>> +       else
>> +               return 0;
> 
> Just:
> return !!(cygnus_readl(chip, offset) & BIT(shift));
> 
> Both of these are a bit overzealous like the readl/writel functions above,
> consider just inlining them.
> 
>> +static int cygnus_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>> +{
>> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>> +       struct cygnus_gpio *chip = to_cygnus_gpio(gc);
>> +       unsigned gpio = d->hwirq;
>> +       int int_type = 0, dual_edge = 0, edge_lvl = 0;
> 
> It looks like some of these should be bool.
> 
>> +       unsigned long flags;
>> +
>> +       switch (type & IRQ_TYPE_SENSE_MASK) {
>> +       case IRQ_TYPE_EDGE_RISING:
>> +               edge_lvl = 1;
> 
> = true;
> 
> etc.
> 
>> +               break;
>> +
>> +       case IRQ_TYPE_EDGE_FALLING:
>> +               break;
>> +
>> +       case IRQ_TYPE_EDGE_BOTH:
>> +               dual_edge = 1;
>> +               break;
>> +
>> +       case IRQ_TYPE_LEVEL_HIGH:
>> +               int_type = 1;
>> +               edge_lvl = 1;
>> +               break;
>> +
>> +       case IRQ_TYPE_LEVEL_LOW:
>> +               int_type = 1;
>> +               break;
>> +
>> +       default:
>> +               dev_err(chip->dev, "invalid GPIO IRQ type 0x%x\n",
>> +                       type);
>> +               return -EINVAL;
>> +       }
>> +
>> +       spin_lock_irqsave(&chip->lock, flags);
>> +       cygnus_set_bit(chip, CYGNUS_GPIO_IN_TYPE_OFFSET, gpio, int_type);
>> +       cygnus_set_bit(chip, CYGNUS_GPIO_INT_DE_OFFSET, gpio, dual_edge);
>> +       cygnus_set_bit(chip, CYGNUS_GPIO_INT_EDGE_OFFSET, gpio,
>> +                      edge_lvl);
>> +       spin_unlock_irqrestore(&chip->lock, flags);
>> +
>> +       dev_dbg(chip->dev,
>> +               "gpio:%u set int_type:%d dual_edge:%d edge_lvl:%d\n",
>> +               gpio, int_type, dual_edge, edge_lvl);
>> +
>> +       return 0;
>> +}
> 
> (...)
>> +/*
>> + * Request the Cygnus IOMUX pinmux controller to mux individual pins to GPIO
>> + */
>> +static int cygnus_gpio_request(struct gpio_chip *gc, unsigned offset)
>> +{
>> +       struct cygnus_gpio *chip = to_cygnus_gpio(gc);
>> +       unsigned gpio = gc->base + offset;
>> +
>> +       /* not all Cygnus GPIO pins can be muxed individually */
>> +       if (!chip->pinmux_is_supported)
>> +               return 0;
>> +
>> +       return pinctrl_request_gpio(gpio);
>> +}
>> +
>> +static void cygnus_gpio_free(struct gpio_chip *gc, unsigned offset)
>> +{
>> +       struct cygnus_gpio *chip = to_cygnus_gpio(gc);
>> +       unsigned gpio = gc->base + offset;
>> +
>> +       if (!chip->pinmux_is_supported)
>> +               return;
>> +
>> +       pinctrl_free_gpio(gpio);
>> +}
> 
> Nice!
> 
>> +static const struct pinconf_ops cygnus_pconf_ops = {
>> +       .is_generic = true,
>> +       .pin_config_get = cygnus_pin_config_get,
>> +       .pin_config_set = cygnus_pin_config_set,
>> +};
> 
> This pin config thing looks really nice.
> 
>> +/*
>> + * Map a GPIO in the local gpio_chip pin space to a pin in the Cygnus IOMUX
>> + * pinctrl pin space
>> + */
>> +struct cygnus_gpio_pin_range {
>> +       unsigned offset;
>> +       unsigned pin_base;
>> +       unsigned num_pins;
>> +};
>> +
>> +#define CYGNUS_PINRANGE(o, p, n) { .offset = o, .pin_base = p, .num_pins = n }
> 
> Aha so this mapping is really very sparse...
> 
>> +/*
>> + * Pin mapping table for mapping local GPIO pins to Cygnus IOMUX pinctrl pins
>> + */
>> +static const struct cygnus_gpio_pin_range cygnus_gpio_pintable[] = {
>> +       CYGNUS_PINRANGE(0, 42, 1),
>> +       CYGNUS_PINRANGE(1, 44, 3),
>> +       CYGNUS_PINRANGE(4, 48, 1),
>> +       CYGNUS_PINRANGE(5, 50, 3),
>> +       CYGNUS_PINRANGE(8, 126, 1),
>> +       CYGNUS_PINRANGE(9, 155, 1),
>> +       CYGNUS_PINRANGE(10, 152, 1),
>> +       CYGNUS_PINRANGE(11, 154, 1),
>> +       CYGNUS_PINRANGE(12, 153, 1),
>> +       CYGNUS_PINRANGE(13, 127, 3),
>> +       CYGNUS_PINRANGE(16, 140, 1),
>> +       CYGNUS_PINRANGE(17, 145, 7),
>> +       CYGNUS_PINRANGE(24, 130, 10),
>> +       CYGNUS_PINRANGE(34, 141, 4),
>> +       CYGNUS_PINRANGE(38, 54, 1),
>> +       CYGNUS_PINRANGE(39, 56, 3),
>> +       CYGNUS_PINRANGE(42, 60, 3),
>> +       CYGNUS_PINRANGE(45, 64, 3),
>> +       CYGNUS_PINRANGE(48, 68, 2),
>> +       CYGNUS_PINRANGE(50, 84, 6),
>> +       CYGNUS_PINRANGE(56, 94, 6),
>> +       CYGNUS_PINRANGE(62, 72, 1),
>> +       CYGNUS_PINRANGE(63, 70, 1),
>> +       CYGNUS_PINRANGE(64, 80, 1),
>> +       CYGNUS_PINRANGE(65, 74, 3),
>> +       CYGNUS_PINRANGE(68, 78, 1),
>> +       CYGNUS_PINRANGE(69, 82, 1),
>> +       CYGNUS_PINRANGE(70, 156, 17),
>> +       CYGNUS_PINRANGE(87, 104, 12),
>> +       CYGNUS_PINRANGE(99, 102, 2),
>> +       CYGNUS_PINRANGE(101, 90, 4),
>> +       CYGNUS_PINRANGE(105, 116, 10),
>> +       CYGNUS_PINRANGE(123, 11, 1),
>> +       CYGNUS_PINRANGE(124, 38, 4),
>> +       CYGNUS_PINRANGE(128, 43, 1),
>> +       CYGNUS_PINRANGE(129, 47, 1),
>> +       CYGNUS_PINRANGE(130, 49, 1),
>> +       CYGNUS_PINRANGE(131, 53, 1),
>> +       CYGNUS_PINRANGE(132, 55, 1),
>> +       CYGNUS_PINRANGE(133, 59, 1),
>> +       CYGNUS_PINRANGE(134, 63, 1),
>> +       CYGNUS_PINRANGE(135, 67, 1),
>> +       CYGNUS_PINRANGE(136, 71, 1),
>> +       CYGNUS_PINRANGE(137, 73, 1),
>> +       CYGNUS_PINRANGE(138, 77, 1),
>> +       CYGNUS_PINRANGE(139, 79, 1),
>> +       CYGNUS_PINRANGE(140, 81, 1),
>> +       CYGNUS_PINRANGE(141, 83, 1),
>> +       CYGNUS_PINRANGE(142, 10, 1)
>> +};
>> +
>> +/*
>> + * The Cygnus IOMUX controller mainly supports group based mux configuration,
>> + * but certain pins can be muxed to GPIO individually. Only the ASIU GPIO
>> + * controller can support this, so it's an optional configuration
>> + *
>> + * Return -ENODEV means no support and that's fine
>> + */
>> +static int cygnus_gpio_pinmux_add_range(struct cygnus_gpio *chip)
>> +{
>> +       struct device_node *node = chip->dev->of_node;
>> +       struct device_node *pinmux_node;
>> +       struct platform_device *pinmux_pdev;
>> +       struct gpio_chip *gc = &chip->gc;
>> +       int i, ret = 0;
>> +
>> +       /* parse DT to find the phandle to the pinmux controller */
>> +       pinmux_node = of_parse_phandle(node, "pinmux", 0);
>> +       if (!pinmux_node)
>> +               return -ENODEV;
>> +
>> +       pinmux_pdev = of_find_device_by_node(pinmux_node);
>> +       /* no longer need the pinmux node */
>> +       of_node_put(pinmux_node);
>> +       if (!pinmux_pdev) {
>> +               dev_err(chip->dev, "failed to get pinmux device\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* now need to create the mapping between local GPIO and PINMUX pins */
>> +       for (i = 0; i < ARRAY_SIZE(cygnus_gpio_pintable); i++) {
>> +               ret = gpiochip_add_pin_range(gc, dev_name(&pinmux_pdev->dev),
>> +                                            cygnus_gpio_pintable[i].offset,
>> +                                            cygnus_gpio_pintable[i].pin_base,
>> +                                            cygnus_gpio_pintable[i].num_pins);
>> +               if (ret) {
>> +                       dev_err(chip->dev, "unable to add GPIO pin range\n");
>> +                       goto err_put_device;
>> +               }
>> +       }
> 
> This is really nice. Awesome job, exactly how it should be done,
> even if it's a bit complex.
> 
>> +       chip->pinmux_is_supported = (ret == 0);
> 
> Just = true;
> 
> You cannot get here with ret != 0.
> 
>> +static void cygnus_gpio_pinmux_remove_range(struct cygnus_gpio *chip)
>> +{
>> +       struct gpio_chip *gc = &chip->gc;
>> +
>> +       if (chip->pinmux_is_supported)
>> +               gpiochip_remove_pin_ranges(gc);
>> +}
> 
> You don't need to do this. Look in gpiochip_remove() and you see it
> will remove the range for you.
> 
>  +
>> +err_unregister_pinconf:
>> +       cygnus_gpio_unregister_pinconf(chip);
>> +
>> +err_rm_range:
>> +       cygnus_gpio_pinmux_remove_range(chip);
> 
> Not needed I think.
> 
>> +
>> +err_rm_gpiochip:
>> +       gpiochip_remove(gc);
> 
> Because this will do it.
> 
>> +
>> +       return ret;
>> +}
> 
> Apart from that this looks really good!
> 
> If you resend with the above nitpicks fixed I will merge this.
> 
> Yours,
> Linus Walleij
> 

Great! I will address all comments and re-send a BIG patch series with
the other pinctrl patch series consolidated.

Thanks!

Ray
