From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Nov 2015 11:23:52 +0100
Subject: [PATCH 4/4] gpio: lpc32xx: add new LPC32xx GPIO controller driver
In-Reply-To: <1447982995-30231-5-git-send-email-vz@mleia.com>
References: <1447982995-30231-1-git-send-email-vz@mleia.com>
 <1447982995-30231-5-git-send-email-vz@mleia.com>
Message-ID: <CACRpkdb+hUVQY-RBsWkRRhxN37wapaxL6FNfkAxozPtHeU5Fqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 2:29 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:

> The change adds a replacement to a legacy unmaintainable LPC32xx GPIO
> controller driver.
>
> The driver gets all information to configure a GPIO bank from its
> device tree node, the driver is capable to assign interrupt controller
> roles to its GPIO banks and it has no hardcoded dependencies on
> hardware interrupt numbers, control register addresses, mapping of
> GPIO lines to interrupts or bitfields.
>
> The new driver is compatible with device tree clients of the legacy
> driver, no changes on GPIO client side are needed.
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
(...)

Overall question: why are you not creating one device and thus
one gpio_chip per bank?

That would make this driver a lot simpler I think. Please motivate
if you want to keep it like this.

Doing that would probably also enable you to use
GPIOLIB_IRQCHIP which would be a big win.

> +#define pr_fmt(fmt) "%s: " fmt, __func__

Usually a driver shall use dev_*(dev,) and not need quirks
like this to modify prints. Why is this needed?

> +#include <linux/interrupt.h>
> +#include <linux/of_address.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>

This file will need
#include <linux/bitops.h>

You should also include
#include <linux/gpio/driver.h>

Even if this gets in implicitly.

> +#define to_lpc32xx_gpio_chip(c)        container_of(chip, struct lpc32xx_gpio_chip, c)

Rewrite this into a static inline function. Defines are ugly.

> +struct lpc32xx_gpio_chip;
> +
> +struct lpc32xx_irq_data {
> +       struct lpc32xx_gpio_chip *bank;
> +       u32 idx;
> +       u32 parent;
> +       u32 gpio;
> +};

This needs some kerneldoc, and I think it looks very weird,
like you are reimplementing irqdomain or something.

Some circular dependency of one device pointing
back to the other, why? Is this necessary?

> +struct lpc32xx_gpio_chip {
> +       struct gpio_chip chip;
> +
> +       struct device *dev;
> +       void __iomem *base;
> +       void __iomem *input;
> +       void __iomem *output;
> +       void __iomem *dir;
> +
> +       bool input_only;
> +       bool output_only;
> +       u32 *output_states;
> +       u32 offset;
> +       u32 input_mask;
> +       u32 interrupt_mask;
> +
> +       const char **gpio_names;

The gpio_chip has a field named .names for this,
why are you reimplementing this in your driver?

> +       u32 nirq;
> +       struct resource *irq_res;
> +       struct lpc32xx_irq_data *irqs;
> +};

Kerneldoc this struct so I understand it, too.

> +
> +static struct lpc32xx_gpio_chip *lpc32xx_gpio_chips[LPC32XX_GPIO_BANKS];

I don't see why you are doing a local array of these but I
guess I will find out...

> +/* Count set bits in mask, i.e. get max relative bit position */
> +static int bit_count(u32 mask)
> +{
> +       int count = 0;
> +
> +       for (; mask; mask >>= 1)
> +               if (mask & 0x1)
> +                       count++;
> +
> +       return count;
> +}

Nope. This is already in the kernel, sometimes assembly-optimized
for certain architectures.

Just use

#include <linux/bitops.h>
hweight32(mask);

> +/*
> + * If mask has less or equal than "rel" set bits, i.e.
> + * relative bit is set, find its abosulute bit position

Spelling.

> + */
> +static int bit_abs(u32 rel, u32 mask)
> +{
> +       int idx, val = 0;
> +
> +       for (idx = 0; idx <= rel; val++, mask >>= 1) {
> +               if (mask & 0x1)
> +                       idx++;
> +               if (!mask)
> +                       return -EINVAL;
> +       }
> +       val--;
> +
> +       return val;
> +}
> +
> +/*
> + * If mask has set bit on absolute position,
> + * find relative bit number in set bits
> + */
> +static int bit_rel(u32 abs, u32 mask)
> +{
> +       int val = 0;
> +
> +       if (!(BIT(abs) & mask))
> +               return -EINVAL;
> +
> +       for (; abs; abs--, mask >>= 1) {
> +               if (mask & 0x1)
> +                       val++;
> +       }
> +       return val;
> +}
> +
> +/*
> + * Composition of bit_abs() and bit_rel(),
> + * mapping of one relative bit position into another
> + */
> +static int bit_map(u32 rel, u32 from, u32 to)
> +{
> +       int ret;
> +
> +       ret = bit_abs(rel, from);
> +       if (ret < 0)
> +               return ret;
> +       return bit_rel(ret, to);
> +}

I suspect these are reiplementations of generic concepts as well.
Please study <linux/bitops.h> and <asm/bitops.h>

We have all kinds of operations for finding first set bit, last set
bit, hamming weight, modifying bitmasks etc etc.

> +static int lpc32xx_gpio_get(struct gpio_chip *chip, unsigned gpio)

Rename parameter "gpio" to "offset", as this is not a global number
but chip-local.

> +{
> +       struct lpc32xx_gpio_chip *c = to_lpc32xx_gpio_chip(chip);
> +       u32 val, direction = lpc32xx_gpio_dir_get(chip, gpio);
> +       int ret;
> +
> +       if (direction == GPIOF_DIR_OUT) {
> +               /* Return cached value in case of P2 bank */
> +               if (c->output_states)
> +                       return c->output_states[gpio];
> +
> +               val = readl(c->output + LPC32XX_GPIO_STATE);
> +               val >>= gpio + c->offset;

Do it like this:

return !!(readl(c->output + LPC32XX_GPIO_STATE) & BIT(c->offset + offset));

> +       } else {

Just skip the else clause and un-indent. If we're here, it is input.

> +               if (c->input_mask) {
> +                       /* Special case of GPI and GPIO decomposition */
> +                       ret = bit_abs(gpio, c->input_mask);
> +                       if (ret < 0)
> +                               return ret;
> +               } else {
> +                       ret = gpio;
> +               }
> +
> +               val = readl(c->input) >> ret;

Just
return !!(readl(c->input) & BIT(offset));

> +       }
> +
> +       return val & 0x1;
> +}

(...)
> +static int lpc32xx_gpio_dir_input(struct gpio_chip *chip, unsigned gpio)

Rename "gpio" to "offset"

> +{
> +       struct lpc32xx_gpio_chip *c = to_lpc32xx_gpio_chip(chip);
> +
> +       if (c->output_only)
> +               return -EINVAL;
> +
> +       writel(BIT(gpio + c->offset), c->dir + LPC32XX_GPIO_CLEAR);

This looks right.

> +static int lpc32xx_gpio_dir_output(struct gpio_chip *chip,
> +                                  unsigned gpio, int value)

Rename "gpio" to "offset".

> +static int lpc32xx_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
> +{
> +       struct lpc32xx_gpio_chip *bank = to_lpc32xx_gpio_chip(chip);
> +       int ret;
> +
> +       if (!bank->chip.irqchip) {
> +               dev_dbg(bank->dev, "%s: no interrupt controller\n",
> +                       bank->gpio_names[gpio]);
> +               return -EINVAL;
> +       }
> +
> +       if (bank->input_mask) {
> +               ret = bit_map(gpio, bank->input_mask, bank->interrupt_mask);
> +               if (ret >= 0)
> +                       ret = irq_find_mapping(bank->chip.irqdomain, ret);
> +       }
> +
> +       return ret;

What happens if bank.irqchip is exis and bank->input_mask is blank?

You return an unitialized ret variable.

Again: why is it not possible to use the GPIOLIB_IRQCHIP and get rid of
all the custom IRQ handling in the driver? If you do one device
per bank I think this would be possible, and maybe even if you
keep this composite driver, because gpiochip_irqchip_add() can
be called several times if referring to the same gpio_chip.

> +static irqreturn_t lpc32xx_gpio_irq_handler(int irq, void *irqdata)
> +{
> +       struct lpc32xx_irq_data *data = irqdata;
> +       struct lpc32xx_gpio_chip *c = data->bank;
> +       int virq = irq_find_mapping(c->chip.irqdomain, data->idx);
> +       u32 val;
> +
> +       if (irq_get_trigger_type(virq) == IRQ_TYPE_EDGE_BOTH) {
> +               val = lpc32xx_gpio_get(&c->chip, c->irqs[data->idx].gpio);
> +               if (val)
> +                       irq_set_irq_type(irq, IRQ_TYPE_EDGE_FALLING);
> +               else
> +                       irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
> +       }
> +
> +       generic_handle_irq(virq);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int lpc32xx_gpio_irq_set_type(struct irq_data *d, unsigned type)
> +{
> +       struct irq_domain *id = d->domain;
> +       struct lpc32xx_gpio_chip *c = (struct lpc32xx_gpio_chip *)id->host_data;
> +       u32 val;
> +
> +       irqd_set_trigger_type(d, type);
> +
> +       if (type == IRQ_TYPE_EDGE_BOTH) {
> +               val = lpc32xx_gpio_get(&c->chip, c->irqs[d->hwirq].gpio);
> +               if (val)
> +                       type = IRQ_TYPE_EDGE_FALLING;
> +               else
> +                       type = IRQ_TYPE_EDGE_RISING;
> +       }

Use a switch() statement here. What if somebody tries to set a
LEVEL IRQ? You need a default: clause.

> +       irq_set_irq_type(c->irqs[d->hwirq].parent, type);

This looks weird. Why is the IRQ output line from the gpiochip
changing type just because it is starting to detect IRQs on its
GPIO lines in a different way?

Just because the gpiochip starts to do edges, it doesn't mean
it starts outputting edges all of a sudden, if i was level
IRQs before (the most common).

Please explain this or put in a big comment about how these
IRQs work on the platform.

> +static unsigned int lpc32xx_gpio_irq_startup(struct irq_data *d)
> +{
> +       struct irq_domain *id = d->domain;
> +       struct lpc32xx_gpio_chip *c = (struct lpc32xx_gpio_chip *)id->host_data;
> +       int ret;
> +
> +       ret = request_irq(c->irqs[d->hwirq].parent,
> +                         lpc32xx_gpio_irq_handler,
> +                         IRQF_TRIGGER_NONE, dev_name(c->dev),
> +                         &c->irqs[d->hwirq]);

And here the parent IRQ is requested with NONE trigger.
Why? Isn't the gpio chip coupled to that line with some
buffer logic that clearly states which IRQ type should
be used to interface the parent?

> +static int lpc32xx_of_xlate(struct gpio_chip *gc,
> +                           const struct of_phandle_args *gpiospec, u32 *flags)
> +{
> +       u32 idx = gpiospec->args[0];
> +
> +       if (idx > LPC32XX_GPIO_BANKS || &lpc32xx_gpio_chips[idx]->chip != gc)
> +               return -EINVAL;

return of_gpio_simple_xlate(gc, gpiospec, flags);

> +
> +       if (flags)
> +               *flags = gpiospec->args[2];
> +
> +       return gpiospec->args[1];
> +}

Then you don't need to reimplement this, right?

> +static int lpc32xx_add_irqchip(struct lpc32xx_gpio_chip *bank,
> +                              struct device_node *node)

Please try to use GPIOLIB_IRQCHIP instead. Please.

> +{
> +       int idx, virq;
> +       struct gpio_chip *gpiochip = &bank->chip;
> +       struct irq_chip *irqchip;
> +
> +       irqchip = devm_kzalloc(bank->dev, sizeof(*irqchip), GFP_KERNEL);
> +       if (!irqchip)
> +               return -ENOMEM;
> +
> +       irqchip->name           = bank->chip.label;
> +       irqchip->irq_startup    = lpc32xx_gpio_irq_startup;
> +       irqchip->irq_shutdown   = lpc32xx_gpio_irq_shutdown;
> +       irqchip->irq_set_type   = lpc32xx_gpio_irq_set_type;

If you persist on this, you need to have
.irq_request_resources()/.irq_release_resources() calling
gpiochip_lock_as_irq() and gpiochip_unlock_as_irq() to
protect the IRQ lines. GPIOLIB_IRQCHIP would again
handle this for you.

> +static int lpc32xx_set_irqs(struct lpc32xx_gpio_chip *bank,
> +                           struct device_node *node)
> +{
> +       int idx, ret;
> +       u32 nirq;
> +
> +       nirq = bit_count(bank->interrupt_mask);
> +       if (nirq != of_irq_count(node)) {
> +               dev_err(bank->dev, "mismatch in interrupt configuration\n");
> +               return -EINVAL;
> +       }
> +
> +       bank->irqs = devm_kzalloc(bank->dev, sizeof(*bank->irqs) * nirq,
> +                                 GFP_KERNEL);
> +       if (!bank->irqs)
> +               return -ENOMEM;
> +
> +       for (idx = 0; idx < nirq; idx++) {
> +               bank->irqs[idx].parent = irq_of_parse_and_map(node, idx);
> +               if (!bank->irqs[idx].parent) {
> +                       dev_err(bank->dev, "can not parse irq %d\n", idx);
> +                       return -EINVAL;
> +               }
> +
> +               bank->irqs[idx].bank = bank;
> +               bank->irqs[idx].idx = idx;
> +
> +               ret = bit_map(idx, bank->interrupt_mask, bank->input_mask);
> +               if (ret < 0)
> +                       return ret;
> +               bank->irqs[idx].gpio = ret;
> +       }

This all looks weird to me. A bit like a reimplemented irqdomain, and I
have no clue what this code is doing because this weird IRQ
scheme is not explained anywhere.

I strongly suspect that creating one device per GPIO bank would make
things simpler. Or at least one GPIO chip per bank.

> +static int lpc32xx_set_gpio_names(struct lpc32xx_gpio_chip *bank, u32 ngpio)
> +{
> +       char *gpio_names;
> +       u32 mask, idx, val = 0, step = strlen(bank->chip.label) + 4;
> +
> +       bank->gpio_names = devm_kzalloc(bank->dev,
> +                                       ngpio * sizeof(*bank->gpio_names),
> +                                       GFP_KERNEL);
> +       if (!bank->gpio_names)
> +               return -ENOMEM;

The gpio_chip has a names field. If you want to do this stuff,
use that.

> +static int of_node_to_gpio(struct device *dev, struct device_node *node)
> +{
> +       int ret, id;
> +       struct lpc32xx_gpio_chip *bank;
> +       u32 ngpio = 0;
> +
> +       bank = devm_kzalloc(dev, sizeof(*bank), GFP_KERNEL);
> +       if (!bank)
> +               return -ENOMEM;
> +       bank->dev = dev;
> +
> +       bank->base = of_iomap(node, 0);
> +       if (!bank->base) {
> +               dev_err(dev, "cannot map GPIO registers\n");
> +               return -ENOMEM;
> +       }

If every bank has its own register range it *should* be its own device
too.

> +       bank->input_only = of_property_read_bool(node, "gpio-input-only");
> +       bank->output_only = of_property_read_bool(node, "gpio-output-only");
> +       if (bank->input_only && bank->output_only) {
> +               dev_err(dev, "%s: input-only and output-only is invalid\n",
> +                       node->full_name);
> +               return -EINVAL;
> +       }

Since these properties are named "gpio-*" not "nxp,*" they should
be documented in Documentation/devicetree/bindings/gpio/gpio.txt
before you use them. (They seem totally reasonable and useful
to me!)

> +       of_property_read_u32(node, "gpio-offset", &bank->offset);

What is this exactly?

> +
> +       if (of_find_property(node, "gpio-input-mask", &id)) {
> +               if (id < 2 * sizeof(u32)) {
> +                       dev_err(dev, "invalid format of gpio-input-mask\n");
> +                       return -EINVAL;
> +               }
> +
> +               of_property_read_u32_index(node, "gpio-input-mask",
> +                                          0, &bank->input_mask);
> +               of_property_read_u32_index(node, "gpio-input-mask",
> +                                          1, &bank->interrupt_mask);
> +
> +               if ((bank->input_mask & bank->interrupt_mask) !=
> +                   bank->interrupt_mask) {
> +                       dev_err(dev, "interrupt mask must be a subset of input mask\n");
> +                       return -EINVAL;
> +               }
> +
> +               ret = lpc32xx_set_irqs(bank, node);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       if (bank->input_mask)
> +               ngpio = bit_count(bank->input_mask);
> +       else
> +               of_property_read_u32(node, "gpios", &ngpio);
> +       if (!ngpio) {
> +               dev_err(dev, "cannot get number of gpios\n");
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * Special handling of P2, the bank does not have output state
> +        * register and its mapping starts from direction control registers
> +        */
> +       if (of_property_read_bool(node, "gpio-no-output-state")) {
> +               bank->output_states = devm_kzalloc(dev, ngpio * (sizeof(u32)),
> +                                                  GFP_KERNEL);
> +               if (!bank->output_states)
> +                       return -ENOMEM;
> +
> +               bank->input = bank->base + LPC32XX_GPIO_P2_INPUT;
> +               bank->output = bank->base + LPC32XX_GPIO_P2_OUTPUT;
> +               bank->dir = bank->base + LPC32XX_GPIO_P2_DIR;
> +       } else {
> +               bank->input = bank->base + LPC32XX_GPIO_INPUT;
> +               bank->output = bank->base + LPC32XX_GPIO_OUTPUT;
> +               bank->dir = bank->base + LPC32XX_GPIO_DIR;
> +       }
> +
> +       of_property_read_string(node, "gpio-bank-name", &bank->chip.label);
> +       if (bank->chip.label) {
> +               ret = lpc32xx_set_gpio_names(bank, ngpio);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       /* Default GPIO bank enumeration, first address cell from reg */
> +       ret = of_property_read_u32(node, "reg", &id);
> +       if (ret < 0 || id >= LPC32XX_GPIO_BANKS) {
> +               dev_err(dev, "can not get valid GPIO bank id\n");
> +               return -EINVAL;
> +       }
> +
> +       lpc32xx_gpio_chips[id] = bank;
> +
> +       bank->chip.dev = dev;
> +
> +       bank->chip.direction_input      = lpc32xx_gpio_dir_input;
> +       bank->chip.direction_output     = lpc32xx_gpio_dir_output;
> +       bank->chip.get_direction        = lpc32xx_gpio_dir_get;
> +
> +       bank->chip.get                  = lpc32xx_gpio_get;
> +       bank->chip.set                  = lpc32xx_gpio_set;
> +
> +       bank->chip.to_irq               = lpc32xx_gpio_to_irq;
> +
> +       bank->chip.base                 = id * 32;

Use -1 instead so you get a dynamically assigned base.

> +       bank->chip.ngpio                = ngpio;
> +       bank->chip.names                = bank->gpio_names;
> +       bank->chip.can_sleep            = false;
> +
> +       bank->chip.of_xlate             = lpc32xx_of_xlate;
> +       bank->chip.of_gpio_n_cells      = 3;

I wonder if you even need your own translation functions.
With one device per bank, certainly not.

> +       bank->chip.of_node              = dev->of_node;
> +
> +       ret = gpiochip_add(&bank->chip);
> +       if (ret)
> +               return ret;
> +
> +       if (of_find_property(node, "interrupt-controller", NULL)) {
> +               if (bank->input_mask)
> +                       ret = lpc32xx_add_irqchip(bank, node);
> +       }
> +
> +       return ret;
> +}
> +
> +static int lpc32xx_gpio_remove(struct platform_device *pdev);
> +static int lpc32xx_gpio_probe(struct platform_device *pdev)
> +{
> +       struct device_node *child;
> +       int ret;
> +
> +       for_each_available_child_of_node(pdev->dev.of_node, child) {
> +               ret = of_node_to_gpio(&pdev->dev, child);
> +               if (ret)
> +                       goto error;
> +       }

If the node in the device tree just declares "simple-bus"
it will spawn devices for all subnodes, if they have
compatible ="" strings.

> +static int lpc32xx_gpio_remove(struct platform_device *pdev)
> +{
> +       u32 idx, i;
> +       struct irq_domain *irqd;
> +
> +       for (idx = 0; idx < LPC32XX_GPIO_BANKS; idx++) {
> +               if (!lpc32xx_gpio_chips[idx])
> +                       continue;

Use the platform device data to find a reference to the chip
and remove it. Get rid of this complicated array. Look
at how other drivers do it.

Just use platform_set_drvdata(pdev, foo); in probe()
then in remove():

struct my_gpio *foo = platform_get_drvdata(pdev);

gpiochip_remove(&foo->gc);

Like that.

Yours,
Linus Walleij
