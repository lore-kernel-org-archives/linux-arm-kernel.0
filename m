From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 May 2014 09:59:58 +0200
Subject: [PATCH 1/3] gpio: Add APM X-Gene SoC GPIO controller support
In-Reply-To: <1400263432-922-2-git-send-email-fkan@apm.com>
References: <1400263432-922-1-git-send-email-fkan@apm.com>
 <1400263432-922-2-git-send-email-fkan@apm.com>
Message-ID: <CACRpkdbh9z2qP3XU_7DS_5ijYMzPe7VO+c0eY4tBpjGg8ATBcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 8:03 PM, Feng Kan <fkan@apm.com> wrote:

> Add APM X-Gene SoC gpio controller driver.
>
> Signed-off-by: Feng Kan <fkan@apm.com>

That's a very terse commit message for an entirely new driver. This needs
to be descriptive, mostly the same as in the Kconfig entry, but also some
info on the target platform and so on.

> +config GPIO_XGENE
> +       bool "APM X-Gene GPIO controller support"
> +       depends on ARM64 && OF_GPIO
> +       help
> +         This driver is to support the GPIO block within the APM X-Gene
> +         platform's generic flash controller. The GPIO pins are muxed with
> +         the generic flash controller's address and data pins. Say yes
> +         here to enable the GFC GPIO functionality.

Stop it right there. If there is pin muxing involved:

- The driver definately goes into drivers/pinctrl
- You need to read Documentation/pinctrl.txt
- Implement the proper muxing interface and select CONFIG_PINMUX
  apart from CONFIG_PINCTRL

> +#define GPIO_MASK(x)           (1U << ((x) % 32))

I think the %32 modifier is unnecessary, see below.

> +#define GPIO_MUX_SEL(x)                (3U << ((x * 2) % 32))

Yeah that is a pin multiplexing register all right.

Instead of these scary macros, write static inline functions in C.

> +#define GPIO_SET_MASK(x)       (1U << ((x + 16) % 32))

This should be a static inline or similar as well, and I think the
%32 modifier is unnecessary, see below.

> +
> +#define GPIO_SET_DR            0x0c
> +#define GPIO_SET_DR_OFFSET     0x0c
> +#define GPIO_DATA              0x14
> +#define GPIO_DATA_OFFSET       0x0c
> +#define GPIO_OD                        0x30
> +#define GPIO_OD_OFFSET         0x04
> +#define GPIO_MUX               0x10
> +#define GPIO_MUX_OFFSET                0x0c

And that is pinmux too.

> +struct xgene_gpio_bank {
> +       struct gpio_chip        chip;
> +       void __iomem            *data;
> +       void __iomem            *set_dr;
> +       void __iomem            *od;
> +       void __iomem            *mux;

Instead of putting a pointer to every register, store a base pointer
and make all writes relative to that pointer.

ioread32(xgene_bank->base + offset)... etc

> +       struct xgene_gpio       *gpio;
> +       spinlock_t              lock;
> +};
> +
> +struct xgene_gpio {
> +       struct  device          *dev;
> +       void __iomem            *regs;
> +       struct xgene_gpio_bank  *banks;
> +       unsigned int            nr_banks;
> +};

If you're instantiating one struct xgene_gpio_bank and that
contains the struct gpio_chip why can you not register one
device per chip too? That is usually much better. And you don't
need two different state container structs like this.

If the registers are mingled in the address space I can understand
this layout, but if they are separated then there is no point in
complicating things like this.

> +static int xgene_gpio_get(struct gpio_chip *gc, unsigned int gpio)

Rename "gpio" to "offset" as this shall be local to the current
gpio_chip offset from 0.

> +{
> +       struct xgene_gpio_bank *bank =
> +                       container_of(gc, struct xgene_gpio_bank, chip);

Break out all these calls to static inline function like this:

static inline struct xgene_gpio_bank *to_xgene_bank(struct gpio_chip *gc)
{
    return container_of(gc, struct xgene_gpio_bank, chip);
}

So it becomes:

struct xgene_gpio_bank *bank = to_xgene_bank(gc);

> +
> +       return (ioread32(bank->data) & GPIO_MASK(gpio));
> +}

This GPIO_MASK() seems completely surplus. As the "gpio" (that I
say shall be renamed "offset") is local to the chip and will be in
the range 0..31.

You also should clamp the returned value to [0,1].

Just do this:

#include <linux/bitops.h>

return !!(ioread32(bank->data) & BIT(offset));

> +static void xgene_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)

Rename gpio->offset

> +{
> +       struct xgene_gpio_bank *bank =
> +                       container_of(gc, struct xgene_gpio_bank, chip);
> +       unsigned long flags;
> +       u32 data;

Call it "val" rather than "data". Data is usually used for void * pointers.

> +
> +       spin_lock_irqsave(&bank->lock, flags);
> +
> +       data = ioread32(bank->set_dr);
> +       data = val ? data | GPIO_SET_MASK(gpio) : data & ~GPIO_SET_MASK(gpio);

That was complicated to read. Just do this so it's readable:

if (val)
   data |= gpio_set_mask(offset);
else
   data &= ~gpio_set_mask(offset);


> +       iowrite32(data, bank->set_dr);
> +
> +       spin_unlock_irqrestore(&bank->lock, flags);
> +}
> +
> +static void xgene_gpio_muxcfg(struct gpio_chip *gc, unsigned int gpio)
> +{
> +       struct xgene_gpio_bank *bank =
> +                       container_of(gc, struct xgene_gpio_bank, chip);
> +       u32 data;
> +
> +       data = ioread32(bank->mux);
> +       data |= GPIO_MUX_SEL(gpio);
> +       iowrite32(data, bank->mux);
> +}

You're simply not allowed to do this kind of stuff in a GPIO driver.
This should be part of the pinctrl interface, and to mux in the GPIO
function of a pin from the GPIO side of the world you use

pinctrl_request_gpio()
pinctrl_free_gpio()
pinctrl_gpio_direction_input()
pinctrl_gpio_direction_output()

After first registering a GPIO range for the gpio_chip in the
probe() function using gpiochip_add_pin_range() right after
registering firs the pin controller and then the gpio_chip.

> +static int xgene_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)

Rename gpio->offset

> +{
> +       struct xgene_gpio_bank *bank =
> +                       container_of(gc, struct xgene_gpio_bank, chip);
> +       unsigned long flags;
> +       u32 data;
> +
> +       spin_lock_irqsave(&bank->lock, flags);
> +
> +       data = ioread32(bank->set_dr);
> +       data |= GPIO_MASK(gpio);

Probably just data |= BIT(offset);

> +       iowrite32(data, bank->set_dr);
> +       xgene_gpio_muxcfg(gc, gpio);
> +
> +       spin_unlock_irqrestore(&bank->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int xgene_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> +       struct xgene_gpio_bank *bank =
> +                       container_of(gc, struct xgene_gpio_bank, chip);
> +       unsigned long flags;
> +       u32 data;
> +
> +       spin_lock_irqsave(&bank->lock, flags);
> +       data = ioread32(bank->set_dr);
> +       data = data & ~GPIO_MASK(gpio);
> +       iowrite32(data, bank->set_dr);
> +       xgene_gpio_muxcfg(gc, gpio);
> +
> +       spin_unlock_irqrestore(&bank->lock, flags);
> +
> +       return 0;
> +}

Much the same comments here.

> +static int xgene_gpio_add_bank(struct xgene_gpio *gpio,
> +                              struct device_node *bank_np,
> +                              unsigned int offs)
> +{
> +       struct xgene_gpio_bank *bank;
> +       u32 bank_idx, ngpio, odcfg;
> +       int err;
> +
> +       if (of_property_read_u32(bank_np, "bank", &bank_idx) ||
> +               bank_idx >= XGENE_GPIO_MAX_PORTS) {
> +               dev_err(gpio->dev, "missing/invalid bank index for %s index %d\n",
> +                               bank_np->full_name, bank_idx);
> +               return -EINVAL;
> +       }

I strongly question the usefulness of sub-"banks" here. You should try
to have one DT entry per "bank" and let each one be a device on its
own.

> +       bank = &gpio->banks[offs];
> +       bank->gpio = gpio;
> +       spin_lock_init(&bank->lock);
> +
> +       if (of_property_read_u32(bank_np, "ngpios", &ngpio))
> +               ngpio = 16;

Does this really vary, or will it always be 16 in all device trees?

Then there is no point in having it in the device tree...

> +       if ((ngpio > 16) || (ngpio < 1)) {
> +               dev_info(gpio->dev, "Incorrect number of gpio specified: %s\n",
> +                        bank_np->full_name);
> +               return -EINVAL;
> +       }

Like is this always 16?

> +       bank->data = gpio->regs + GPIO_DATA + (bank_idx * GPIO_DATA_OFFSET);
> +       bank->od = gpio->regs + GPIO_OD + (bank_idx * GPIO_OD_OFFSET);
> +       bank->mux = gpio->regs + GPIO_MUX + (bank_idx * GPIO_MUX_OFFSET);
> +       bank->set_dr = gpio->regs + GPIO_SET_DR
> +                               + (bank_idx * GPIO_SET_DR_OFFSET);

As I said: don't do this. Save a base pointer in the state container
and make all read/writes relative to the base.

> +       bank->chip.direction_input = xgene_gpio_dir_in;
> +       bank->chip.direction_output = xgene_gpio_dir_out;
> +       bank->chip.get = xgene_gpio_get;
> +       bank->chip.set = xgene_gpio_set;
> +
> +       if (!of_property_read_u32(bank_np, "odcfg", &odcfg))
> +               iowrite32(odcfg, bank->od);
> +
> +       bank->chip.ngpio = ngpio;
> +       bank->chip.of_node = bank_np;
> +       bank->chip.base = bank_idx * ngpio;

Also set up chip.dev and chip.name etc.

> +       err = gpiochip_add(&bank->chip);
> +       if (err)
> +               dev_err(gpio->dev, "failed to register gpiochip for %s\n",
> +                       bank_np->full_name);

Right after here you should register a gpio pin range.

> +       return err;
> +}
> +
> +static int xgene_gpio_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct resource *res;
> +       struct xgene_gpio *gpio;
> +       int err;
> +       unsigned int offs = 0;
> +
> +       gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
> +       if (!gpio)
> +               return -ENOMEM;
> +       gpio->dev = &pdev->dev;
> +
> +       gpio->nr_banks = of_get_child_count(pdev->dev.of_node);
> +       if (!gpio->nr_banks) {
> +               err = -EINVAL;
> +               goto err;
> +       }

This is too complicated. Use one device per bank and split up
the register range.

(...)
> +static const struct of_device_id xgene_gpio_of_match[] = {
> +       { .compatible = "apm,xgene-gpio", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, xgene_gpio_of_match);
> +
> +static struct platform_driver xgene_gpio_driver = {
> +       .driver = {
> +               .name = "xgene-gpio",
> +               .owner = THIS_MODULE,
> +               .of_match_table = xgene_gpio_of_match,
> +       },
> +       .probe = xgene_gpio_probe,
> +};
> +
> +static int __init xgene_gpio_init(void)
> +{
> +       return platform_driver_register(&xgene_gpio_driver);
> +}
> +postcore_initcall(xgene_gpio_init);

Why does this have to register so early? Use a simple module
driver and module_platform_driver() please.

Yours,
Linus Walleij
