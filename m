From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Jul 2014 18:11:24 +0200
Subject: [PATCH 5/8] pinctrl: add driver for MB86S7x
In-Reply-To: <1405233067-4725-1-git-send-email-mollie.wu@linaro.org>
References: <1405233067-4725-1-git-send-email-mollie.wu@linaro.org>
Message-ID: <CACRpkdb_NC7j=XkbMPv8YYLSeEd1AOpFqmD8x+ohC7ds3cPCfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 13, 2014 at 8:31 AM, Mollie Wu <mollie.wu@linaro.org> wrote:

> The mb86s70 and mb86s73 Fujitsu SoCs differ in that the latter provide a pinmux.
> GPIOs are supported on top of Pinctrl api.
>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Tetsuya Takinishi <t.takinishi@jp.fujitsu.com>
> Signed-off-by: Mollie Wu <mollie.wu@linaro.org>

This doesn't seem to be just about muxing but a full featured pin control
driver including pin config for electrical portions?

> +++ b/Documentation/devicetree/bindings/gpio/fujitsu,mb86s7x-gpio.txt

This looks OK.

> diff --git a/Documentation/devicetree/bindings/pinctrl/fujitsu,mb86s7x-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fujitsu,mb86s7x-pinctrl.txt
> new file mode 100644
> index 0000000..ce2011b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fujitsu,mb86s7x-pinctrl.txt
> @@ -0,0 +1,30 @@
> +Fujitsu MB86S7x Pin Controller
> +------------------------------
> +
> +Required properties:
> +- compatible: Should be "fujitsu,mb86s70-pinctrl" or "fujitsu,mb86s73-pinctrl"
> +- reg: Should contain the register physical address and length for the
> +  pin controller.
> +- #gpio-range-cells: Should be 3
> +
> +Optional subnode-properties:
> +- mb86s7x,function: String specifying the function name.
> +- mb86s7x,drvst: Drive strength needed for pins to operate in that mode.
> +    0 (Hi-z), 2mA, 4mA, 6mA or 8mA
> +- mb86s7x,pullup: Should be 0 for Pull-Down or non-zero for Pull-Up

For all of these please switch the driver to using generic pin configuration.
We have stopped letting drivers use custom props for these things, even
functions are nowadays standardized to be just the function = "foo";
strings.

Consult
Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
for the bindings,

Since the driver selects GENERIC_PINCONF, utilize the core
support for parsing DT info etc for these settings in
drivers/pinctrl/pinconf-generic.c and look how other drivers
exploit these helpers.

> +++ b/drivers/pinctrl/pinctrl-mb86s7x.c
(...)
> +#define PDR(x) (0x0 + x)
> +#define DDR(x) (0x10 + x)
> +#define PFR(x) (0x20 + x)
> +
> +#define CDRV_PDG(x)    (0x0 + ((x) / 16) * 4)
> +#define FORCEZ_PDG(x)  (0x100 + ((x) / 16) * 4)
> +#define PULL_PDG(x)    (0x200 + ((x) / 16) * 4)
> +#define PIN_OFF(x)     (((x) % 16) * 2)

I think the 0x0, 0x10, 0x20, 0x100, 0x200 etc offsets should
be named #defines telling us what kind of registers they will be
hitting.

> +#define PMUX_MB86S70   0
> +#define PMUX_MB86S73   1

More something like MB86S70_ID, MB86S73_ID or something are
better names for this?

> +/* Virtual pin numbers start so that reg offset calculations get simple */
> +enum {
> +       PINS_VIRT = 128,
> +       PINS_PCIE0 = PINS_VIRT,
> +       PINS_HOLE1,
> +       PINS_USB3H0,
> +       PINS_HOLE2,
> +       PINS_USB2H0,
> +       PINS_USB2D0,
> +       PINS_SDH30,
> +       PINS_HOLE3,
> +       PINS_EMMC0,
> +       PINS_HSSPI0,
> +       PINS_GMACD0,
> +       PINS_GMACM0,
> +       PINS_I2S0,
> +       PINS_UART0,
> +       PINS_OTHER0,
> +       PINS_JTAG0,
> +       PINS_PCIE1,
> +       PINS_HOLE4,
> +       PINS_USB3H1,
> +       MB86S70_PMUX_PINS,
> +};
> +
> +struct mb86s70_gpio_chip {
> +       spinlock_t lock; /* for goio regs */
> +       struct clk *clk;
> +       void __iomem *base;
> +       struct gpio_chip gc;
> +};
> +
> +static int mb86s70_gpio_request(struct gpio_chip *gc, unsigned offset)
> +{
> +       int ret = pinctrl_request_gpio(gc->base + offset);
> +
> +       if (!ret) {
> +               struct mb86s70_gpio_chip *gchip = container_of(gc,
> +                                               struct mb86s70_gpio_chip, gc);
> +               unsigned long flags;
> +               u32 val;
> +
> +               spin_lock_irqsave(&gchip->lock, flags);
> +               val = readl(gchip->base + PFR(offset / 8 * 4));
> +               val &= ~(1 << (offset % 8)); /* as gpio-port */
> +               writel(val, gchip->base + PFR(offset / 8 * 4));

When PFR is used like this I don't see how those macros are
really helpful. It's just very hard to read:

readl(base + PFR(offset / 8 * 4));

(Whis is already scary unless you know expression evaluation order by heart...)

Expands to

readl(base + 0x20 + (offset / 8 * 4));

Is it possible to just get rid of the PFR macro and create an inline
function like this:

static inline unsigned mb86s70_pfr(unsigned offset)
{
      return 0x20 + (offset / 8 * 4);
}

And the above becomes:

#include <linux/bitops.h>

val = readl(gchip->base + mb86s70_pfr(offset));
val &= ~BIT(offset % 8);
writel(val, gchip->base + mb86s70_pfr(offset));

This way it's less cluttered IMO. But it's not a strong preference.

> +static int mb86s70_gpio_direction_output(struct gpio_chip *gc,
> +                                        unsigned offset, int value)
> +{
> +       struct mb86s70_gpio_chip *gchip =
> +                       container_of(gc, struct mb86s70_gpio_chip, gc);
> +       unsigned long flags;
> +       unsigned char val;
> +
> +       spin_lock_irqsave(&gchip->lock, flags);
> +
> +       val = readl(gchip->base + PDR(offset / 8 * 4));
> +       if (value)
> +               val |= (1 << (offset % 8));
> +       else
> +               val &= ~(1 << (offset % 8));

In this and other places I'd just

val |= BIT(offset % 8); (etc)

> +       writel(val, gchip->base + PDR(offset / 8 * 4));
> +
> +       val = readl(gchip->base + DDR(offset / 8 * 4));
> +       val |= (1 << (offset % 8));
> +       writel(val, gchip->base + DDR(offset / 8 * 4));
> +
> +       spin_unlock_irqrestore(&gchip->lock, flags);
> +
> +       return 0;
> +}

Don't you want to use pinctrl_gpio_direction_output()
and pinctrl_gpio_direction_input() in these?

(Well maybe not.)

> +static int mb86s70_gpio_get(struct gpio_chip *gc, unsigned offset)
> +{
> +       struct mb86s70_gpio_chip *gchip =
> +                       container_of(gc, struct mb86s70_gpio_chip, gc);
> +       unsigned char val;
> +
> +       val = readl(gchip->base + PDR(offset / 8 * 4));
> +       val &= (1 << (offset % 8));
> +       return val ? 1 : 0;

I usually just do this:

#include <linux/bitops.h>

return !!(readl(...) & BIT(offset % 8));

This applied in a few places simplifies the code I think.

> +static int mb86s70_gpio_probe(struct platform_device *pdev)
> +{
> +       struct mb86s70_gpio_chip *gchip;
> +       struct resource *res;
> +       int ret;
> +
> +       gchip = devm_kzalloc(&pdev->dev, sizeof(*gchip), GFP_KERNEL);
> +       if (gchip == NULL)
> +               return -ENOMEM;

Just

if (!gchip)

> +static int func_count, grp_count;
> +static const struct mb86s70_pmx_grp *mb86s7x_pgrps;
> +static const struct mb86s70_pmx_function *mb86s7x_pmx_funcs;

No static locals please. Add these to struct mb86s70_pmux_chip or
similar state container as they seem to be dynamic. Use
pinctrl_dev_get_drvdata()
to get from struct pinctrl_dev *pctl to the state container.

> +static int mb86s70_pctrl_get_groups_count(struct pinctrl_dev *pctl)
> +{
> +       return grp_count;
> +}
> +
> +static const char *
> +mb86s70_pctrl_get_group_name(struct pinctrl_dev *pctl, unsigned selector)
> +{
> +       return mb86s7x_pgrps[selector].name;
> +}
>
> +static int
> +mb86s70_pctrl_get_group_pins(struct pinctrl_dev *pctl, unsigned selector,
> +                            const unsigned **pins, unsigned *num_pins)
> +{
> +       *pins = mb86s7x_pgrps[selector].pins;
> +       *num_pins = mb86s7x_pgrps[selector].num_pins;
> +
> +       return 0;
> +}

So these should use that method with pinctrl_dev_get_drvdata().

> +static int
> +mb86s70_pctrl_dt_node_to_map(struct pinctrl_dev *pctl,
> +                            struct device_node *node,
> +                            struct pinctrl_map **map, unsigned *num_maps)
> +{

Rewrite this to use pinconf_generic_dt_node_to_map()
and friends. Read other drivers doing this, for example pinctrl-msm.c

> +       ret = of_property_read_string(node, "mb86s7x,function", &function);
> +       if (ret) {
> +               dev_err(pchip->dev,
> +                       "missing mb86s7x,function property in node %s\n",
> +                       node->name);
> +               return -EINVAL;
> +       }

For generic function parsing use just the name "function" rather
than "mb86s7x,function".

> +static const char * const pcie0_groups[] = {"pcie0_grp"};
> +static const char * const usb3h0_groups[] = {"usb3h0_grp"};
> +static const char * const usb2h0_groups[] = {"usb2h0_grp"};
> +static const char * const usb2d0_groups[] = {"usb2d0_grp"};
> +static const char * const sdh30_groups[] = {"sdh30_grp"};
> +static const char * const emmc0_groups[] = {"emmc0_grp"};
> +static const char * const hsspi0_groups[] = {"hsspi0_grp"};
> +static const char * const gmacd0_groups[] = {"gmacd0_grp"};
> +static const char * const gmacm0_groups[] = {"gmacm0_grp"};
> +static const char * const i2s0_groups[] = {"i2s0_grp"};
> +static const char * const other0_groups[] = {"other0_grp"};
> +static const char * const jtag0_groups[] = {"jtag0_grp"};
> +static const char * const pcie1_groups[] = {"pcie1_grp"};
> +static const char * const usb3h1_groups[] = {"usb3h1_grp"};
> +static const char * const extint16_groups[] = {"extint16_grp"};
> +static const char * const extint5_groups[] = {"extint5_grp"};
> +static const char * const tsif0_groups[] = {"tsif0_grp"};
> +static const char * const tsif1_groups[] = {"tsif1_grp"};
> +static const char * const cfg_groups[] = {"cfg_grp"};
> +static const char * const uart0_groups[] = {"uart0_grp"};
> +static const char * const uart1_groups[] = {"uart1_grp"};
> +static const char * const uart2_groups[] = {"uart2_grp"};
> +static const char * const pl244_groups[] = {"pl244_grp"};
> +static const char * const trace_groups[] = {"trace_grp"};
> +static const char * const memcs_groups[] = {"memcs_grp"};
> +static const char * const cap_groups[] = {"cap_grp"};
> +static const char * const smt_groups[] = {"smt_grp"};
> +
> +static const struct mb86s70_pmx_function mb86s73_pmx_funcs[] = {
> +       {
> +               .prog_val = 0x1,
> +               .name = "extint5",
> +               .groups = extint5_groups,
> +               .num_groups = ARRAY_SIZE(extint5_groups),
> +       },
> +       {
> +               .prog_val = 0x0,
> +               .name = "pcie0",
> +               .groups = pcie0_groups,
> +               .num_groups = ARRAY_SIZE(pcie0_groups),
> +       },
> +       {
> +               .prog_val = 0x0,
> +               .name = "usb3h0",
> +               .groups = usb3h0_groups,
> +               .num_groups = ARRAY_SIZE(usb3h0_groups),
> +       },
> +       {
> +               .prog_val = 0x0,
> +               .name = "usb2h0",
> +               .groups = usb2h0_groups,
> +               .num_groups = ARRAY_SIZE(usb2h0_groups),
> +       },
> +       {
> +               .prog_val = 0x0,
> +               .name = "usb2d0",
> +               .groups = usb2d0_groups,
> +               .num_groups = ARRAY_SIZE(usb2d0_groups),
> +       },
> +       {
> +               .prog_val = 0x0,
> +               .name = "sdh30",
> +               .groups = sdh30_groups,
> +               .num_groups = ARRAY_SIZE(sdh30_groups),
> +       },
> +       {
> +               .prog_val = 0x0,
> +               .name = "emmc0",
> +               .groups = emmc0_groups,
> +               .num_groups = ARRAY_SIZE(emmc0_groups),
> +       },
> +       {
> +               .prog_val = 0x0,
> +               .name = "hsspi0",
> +               .groups = hsspi0_groups,
> +               .num_groups = ARRAY_SIZE(hsspi0_groups),
> +       },
> +       {
> +               .prog_val = 0x0,
> +               .name = "gmacd0",
> +               .groups = gmacd0_groups,
> +               .num_groups = ARRAY_SIZE(gmacd0_groups),
> +       },
> +       {
> +               .prog_val = 0x0,
> +               .name = "gmacm0",
> +               .groups = gmacm0_groups,
> +               .num_groups = ARRAY_SIZE(gmacm0_groups),
> +       },
> +       {
> +               .prog_val = 0x0,
> +               .name = "i2s0",
> +               .groups = i2s0_groups,
> +               .num_groups = ARRAY_SIZE(i2s0_groups),
> +       },
> +       {
> +               .prog_val = 0x0,
> +               .name = "other0",
> +               .groups = other0_groups,
> +               .num_groups = ARRAY_SIZE(other0_groups),
> +       },
> +       {
> +               .prog_val = 0x0,
> +               .name = "jtag0",
> +               .groups = jtag0_groups,
> +               .num_groups = ARRAY_SIZE(jtag0_groups),
> +       },
> +       {
> +               .prog_val = 0x0,
> +               .name = "pcie1",
> +               .groups = pcie1_groups,
> +               .num_groups = ARRAY_SIZE(pcie1_groups),
> +       },
> +       {
> +               .prog_val = 0x0,
> +               .name = "usb3h1",
> +               .groups = usb3h1_groups,
> +               .num_groups = ARRAY_SIZE(usb3h1_groups),
> +       },
> +       {
> +               .prog_val = 0x1,
> +               .name = "cfg",
> +               .groups = cfg_groups,
> +               .num_groups = ARRAY_SIZE(cfg_groups),
> +       },
> +       {
> +               .prog_val = 0x1,
> +               .name = "uart0",
> +               .groups = uart0_groups,
> +               .num_groups = ARRAY_SIZE(uart0_groups),
> +       },
> +       {
> +               .prog_val = 0x1,
> +               .name = "uart1",
> +               .groups = uart1_groups,
> +               .num_groups = ARRAY_SIZE(uart1_groups),
> +       },
> +       {
> +               .prog_val = 0x1,
> +               .name = "uart2",
> +               .groups = uart2_groups,
> +               .num_groups = ARRAY_SIZE(uart2_groups),
> +       },
> +       {
> +               .prog_val = 0x2,
> +               .name = "trace",
> +               .groups = trace_groups,
> +               .num_groups = ARRAY_SIZE(trace_groups),
> +       },
> +       {
> +               .prog_val = 0x2,
> +               .name = "pl244",
> +               .groups = pl244_groups,
> +               .num_groups = ARRAY_SIZE(pl244_groups),
> +       },
> +       {
> +               .prog_val = 0x3,
> +               .name = "smt",
> +               .groups = smt_groups,
> +               .num_groups = ARRAY_SIZE(smt_groups),
> +       },
> +       {
> +               .prog_val = 0x3,
> +               .name = "memcs",
> +               .groups = memcs_groups,
> +               .num_groups = ARRAY_SIZE(memcs_groups),
> +       },
> +};

Open-coding the function tables like this is certainly OK, but most
drivers will use macros to compress the tables. But I'm happy with
this.

> +static int
> +mb86s70_pmx_get_functions_count(struct pinctrl_dev *pctl)
> +{
> +       return func_count;
> +}
> +
> +static const char *
> +mb86s70_pmx_get_function_name(struct pinctrl_dev *pctl, unsigned selector)
> +{
> +       return mb86s7x_pmx_funcs[selector].name;
> +}
> +
> +static int
> +mb86s70_pmx_get_function_groups(struct pinctrl_dev *pctl,
> +                               unsigned selector, const char * const **groups,
> +                               unsigned * const num_groups)
> +{
> +       *groups = mb86s7x_pmx_funcs[selector].groups;
> +       *num_groups = mb86s7x_pmx_funcs[selector].num_groups;
> +
> +       return 0;
> +}

Again get these things from the state container.

> +static int
> +mb86s70_pmx_enable(struct pinctrl_dev *pctl,
> +                  unsigned func_selector, unsigned group_selector)
> +{
> +       struct mb86s70_pmux_chip *pchip = pinctrl_dev_get_drvdata(pctl);
> +       unsigned long flags;
> +       const unsigned *pins;
> +       int i, j;
> +
> +       if (group_selector >= grp_count) {
> +               pr_err("%s:%d\n", __func__, __LINE__);
> +               return -EINVAL;
> +       }
> +
> +       j = mb86s7x_pgrps[group_selector].num_pins;
> +       pins = mb86s7x_pgrps[group_selector].pins;
> +
> +       spin_lock_irqsave(&pchip->lock, flags);
> +
> +       /* Busy if any pin in the same 'bunch' is taken */
> +       for (i = 0; i < j; i++) {
> +               u32 val;
> +               int p = pins[i] / 4 * 4;
> +
> +               if (pins[i] >= PINS_VIRT) /* Not for virtual pins */
> +                       continue;
> +
> +               val = readl(pchip->base + p);
> +               /* skip if no change needed */
> +               if (val == mb86s7x_pmx_funcs[func_selector].prog_val)
> +                       continue;
> +
> +               if (pchip->pin_busy[p]) {
> +                       pr_err("%s:%d:%d %d busy\n",
> +                              __func__, __LINE__, pins[i], p);
> +                       goto busy_exit;
> +               }
> +
> +               if (pchip->pin_busy[p + 1]) {
> +                       pr_err("%s:%d:%d %d busy\n",
> +                              __func__, __LINE__, pins[i], p+1);
> +                       goto busy_exit;
> +               }

I don't see why you are doing this and keeping track of
pins as "busy" or not. One thing the pin control core does
is to make sure pins do not collide in different use cases,
it seems like you're re-implementing this check again.

> +               if (p == 64)
> +                       continue;

This if-clause seems dubious. At least add a comment as
to what is happening here and why.

> +               if (pchip->pin_busy[p + 2]) {
> +                       pr_err("%s:%d:%d %d busy\n",
> +                              __func__, __LINE__, pins[i], p+2);
> +                       goto busy_exit;
> +               }
> +
> +               if (pchip->pin_busy[p + 3]) {
> +                       pr_err("%s:%d:%d %d busy\n",
> +                              __func__, __LINE__, pins[i], p+3);
> +                       goto busy_exit;
> +               }

I don't understand this either.

Why all this fuzz around the four pins from p ... p+3?

> +               continue;
> +busy_exit:
> +               spin_unlock_irqrestore(&pchip->lock, flags);
> +               pr_err("%s:%d Take a look!\n", __func__, __LINE__);
> +               return -EBUSY;
> +       }

You don't have to have the busy_exit: inside the for-loop right?

Just push it below the return 0; in the end of this function
so you can get rid of the dangling continue;

> +       pr_debug("Going to enable %s on pins -",
> +                mb86s7x_pmx_funcs[func_selector].name);
> +       for (i = 0; i < j; i++) {
> +               int p = pins[i];
> +
> +               pr_debug(" %d", p);
> +               pchip->pin_busy[p] = true;

So I'm questioning this....

> +               if (p < PINS_VIRT) /* Not for virtual pins */

We need an explanation somewhere about what "virtual pins"
means in this driver, I have never seen that before.

> +                       writel(mb86s7x_pmx_funcs[func_selector].prog_val,
> +                              pchip->base + p / 4 * 4);

This may need some static inline like described above to simplify
the code and make it more readable, but I see what is going on.

> +       }
> +
> +       spin_unlock_irqrestore(&pchip->lock, flags);
> +       pr_debug("\n");
> +
> +       return 0;
> +}
> +
> +static void
> +mb86s70_pmx_disable(struct pinctrl_dev *pctl,
> +                   unsigned func_selector, unsigned group_selector)
> +{
> +       struct mb86s70_pmux_chip *pchip = pinctrl_dev_get_drvdata(pctl);
> +       unsigned long flags;
> +       const unsigned *pins;
> +       int i, j;
> +
> +       if (group_selector >= grp_count) {
> +               pr_err("%s:%d\n", __func__, __LINE__);
> +               return;
> +       }
> +
> +       j = mb86s7x_pgrps[group_selector].num_pins;
> +       pins = mb86s7x_pgrps[group_selector].pins;
> +
> +       pr_debug("Going to disable %s on pins -",
> +                mb86s7x_pmx_funcs[func_selector].name);
> +       spin_lock_irqsave(&pchip->lock, flags);
> +       for (i = 0; i < j; i++) {
> +               pr_debug(" %d", pins[i]);
> +               pchip->pin_busy[pins[i]] = false;
> +       }
> +       spin_unlock_irqrestore(&pchip->lock, flags);
> +       pr_debug("\n");
> +}

Remove this function. The .disable member is gone from
struct pinmux_ops, as it was ambiguous, see commit
2243a87d90b42eb38bc281957df3e57c712b5e56
"pinctrl: avoid duplicated calling enable_pinmux_setting for a pin"

> +static int
> +mb86s70_pmx_gpio_set_direction(struct pinctrl_dev *pctl,
> +                              struct pinctrl_gpio_range *range,
> +                              unsigned pin, bool input)
> +{
> +       struct gpio_chip *gc = range->gc;
> +       struct mb86s70_gpio_chip *gchip = container_of(gc,
> +                                               struct mb86s70_gpio_chip, gc);
> +       unsigned long flags;
> +       u32 off, bit, val;
> +
> +       if (pin >= 64)
> +               return -EINVAL;

This is a bit strange again...

> +       spin_lock_irqsave(&gchip->lock, flags);
> +       bit = (pin - gc->base) % 8;
> +       off = (pin - gc->base) / 8 * 4;
> +       val = readl(gchip->base + DDR(off));
> +       if (input)
> +               val &= ~(1 << bit);
> +       else
> +               val |= (1 << bit);
> +       writel(val, gchip->base + DDR(off));
> +       spin_unlock_irqrestore(&gchip->lock, flags);
> +
> +       return 0;
> +}

So .set_direction is implemented but not called from the
gpiochip functions as pointed out above.

> +static int
> +mb86s70_pin_config_group_get(struct pinctrl_dev *pctl, unsigned group,
> +                            unsigned long *config)
> +{
> +       return -EINVAL;
> +}

Don't implement stubs for this, just leave the vtable entry
unassigned, the core will return an error.

However it doesn't seem so hard to implement this
actually: the set code just below does exactly this, retrieves
the right bits and alters them, so why is not get implemented?

> +static int
> +mb86s70_pin_config_group_set(struct pinctrl_dev *pctl, unsigned group,
> +                            unsigned long *configs, unsigned num_configs)
> +{
> +       struct mb86s70_pmux_chip *pchip = pinctrl_dev_get_drvdata(pctl);
> +       unsigned long flags;
> +       const unsigned *pin;
> +       int i, j, p;
> +       u32 val, ds;
> +
> +       p = mb86s7x_pgrps[group].num_pins;
> +       pin = mb86s7x_pgrps[group].pins;
> +
> +       spin_lock_irqsave(&pchip->lock, flags);
> +
> +       for (i = 0; i < num_configs; i++) {
> +               switch (pinconf_to_config_param(configs[i])) {
> +               case PIN_CONFIG_DRIVE_STRENGTH:
> +                       /* Drive Strength should be 2, 4, 6 or 8 mA */
> +                       ds = pinconf_to_config_argument(configs[i]);
> +                       ds = (ds - 2) / 2;

I like this use of SI units, so use the generic bindings too!

(...)
> +       pchip->desc.name = dev_name(&pdev->dev);
> +       pchip->desc.npins = MB86S70_PMUX_PINS;
> +       pchip->desc.pins = pchip->pins;
> +       pchip->desc.pctlops = &mb86s70_pctrl_ops;
> +       pchip->desc.pmxops = &mb86s70_pmx_ops;
> +       pchip->desc.owner = THIS_MODULE;
> +       if (type == PMUX_MB86S73) {
> +               pchip->desc.confops = &mb86s70_conf_ops;
> +               res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +               pchip->conf_base = devm_ioremap_resource(&pdev->dev, res);
> +               if (IS_ERR(pchip->conf_base))
> +                       return PTR_ERR(pchip->conf_base);
> +               mb86s7x_pmx_funcs = mb86s73_pmx_funcs;
> +               func_count = ARRAY_SIZE(mb86s73_pmx_funcs);
> +               mb86s7x_pgrps = mb86s73_pgrps;
> +               grp_count = ARRAY_SIZE(mb86s73_pgrps);
> +       } else {
> +               mb86s7x_pmx_funcs = mb86s70_pmx_funcs;
> +               func_count = ARRAY_SIZE(mb86s70_pmx_funcs);
> +               mb86s7x_pgrps = mb86s70_pgrps;
> +               grp_count = ARRAY_SIZE(mb86s70_pgrps);
> +       }

As mentioned don't use static locals for these things, add these
to the state container.

> +static const struct of_device_id mb86s70_gpio_dt_ids[] = {
> +       { .compatible = "fujitsu,mb86s7x-gpio" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mb86s70_gpio_dt_ids);

"fujitsu" does not seem to exist in
Documentation/devicetree/bindings/vendor-prefixes.txt
Do you want to add it?

> +static struct platform_driver mb86s70_gpio_driver = {
> +       .probe     = mb86s70_gpio_probe,
> +       .driver    = {
> +               .name  = "mb86s70-gpio",
> +               .owner = THIS_MODULE,
> +               .of_match_table = mb86s70_gpio_dt_ids,
> +       },
> +};
> +
> +static struct platform_driver mb86s70_pinmux_driver = {
> +       .probe     = mb86s70_pinmux_probe,
> +       .driver    = {
> +               .name  = "mb86s70-pinmux",
> +               .owner = THIS_MODULE,
> +               .of_match_table = mb86s70_pinmux_dt_ids,
> +       },
> +};
> +
> +static int __init mb86s70_pins_init(void)
> +{
> +       int ret;
> +
> +       ret = platform_driver_register(&mb86s70_pinmux_driver);
> +       if (ret)
> +               return ret;
> +
> +       return platform_driver_register(&mb86s70_gpio_driver);
> +}
> +subsys_initcall(mb86s70_pins_init);

It's not really necessary to split this up in two drivers in one
file, it is possible to just use one driver: mb86s70_pinmux_driver,
have just one .probe() function, and register *both* the gpiochip
*and* pin control driver from that probe().

(Well pin control first the gpiochip I guess, but you get the
idea.)

This driver needs some work, but I like the start, please keep at it.

Yours,
Linus Walleij
