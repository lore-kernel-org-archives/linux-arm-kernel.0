From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Dec 2013 21:54:50 +0100
Subject: [PATCH v3 5/6] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <1386787041-6035-6-git-send-email-syin@broadcom.com>
References: <1381174108-25168-1-git-send-email-syin@broadcom.com>
 <1386787041-6035-1-git-send-email-syin@broadcom.com>
 <1386787041-6035-6-git-send-email-syin@broadcom.com>
Message-ID: <CACRpkdaeZCodKv6R+4ZS3o-5u=QQuV3JidEp7uaLsN9aYG7bqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 7:37 PM, Sherman Yin <syin@broadcom.com> wrote:

> Adds pinctrl driver for Broadcom Capri (BCM281xx) SoCs.
>
> Signed-off-by: Sherman Yin <syin@broadcom.com>
> Reviewed-by: Christian Daudt <bcm@fixthebug.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
> v3: Re-work driver to be based on generic pin config. Moved config selection
>     from Kconfig to bcm_defconfig.

(...)

> +#define CAPRI_PIN_SHIFT(type, param) \
> +       (CAPRI_ ## type ## _PIN_REG_ ## param ## _SHIFT)
> +
> +#define CAPRI_PIN_MASK(type, param) \
> +       (CAPRI_ ## type ## _PIN_REG_ ## param ## _MASK)
> +
> +/* Macro to update reg with new pin config param */
> +#define CAPRI_PIN_UPDATE(reg, type, param, val)                                \
> +       (((reg) & ~CAPRI_PIN_MASK(type, param)) |                       \
> +       (((val) << CAPRI_PIN_SHIFT(type, param)) & CAPRI_PIN_MASK(type, param)))

Yuck! Are you sure you cannot convert these to static inlines and
make them much simpler in the process?

We do have an optimizing compiler, you don't need to do
everything on one line... besides we're not on the hotpath.

> +/*
> + * Write to the register using the value and mask if current value is different
> + */
> +static void capri_reg_write(struct pinctrl_dev *pctldev,
> +                           void __iomem *reg,
> +                           u32 val,
> +                           u32 mask)
> +{
> +       u32 old_val;
> +       u32 new_val;
> +
> +       old_val = readl(reg);
> +       new_val = (old_val & ~mask) | (val & mask);
> +
> +       if (new_val == old_val) {
> +               dev_dbg(pctldev->dev,
> +                       "Reg 0x%p=0x%x (no change)\n",
> +                       reg, old_val);
> +               return;
> +       }
> +
> +       dev_dbg(pctldev->dev,
> +               "Reg 0x%p change from 0x%x to 0x%x\n",
> +               reg, old_val, new_val);
> +       writel(new_val, reg);
> +}

This is a reimplementation of regmap for MMIO.
See drivers/base/regmap/regmap-mmio.c
Notice how regmap_update_bits() is used throughout the
kernel.

If you want to do this, use regmap.

> +               case PIN_CONFIG_DRIVE_STRENGTH:
> +                       /* Valid range is 2-16 mA, even numbers only */
> +                       if ((arg < 2) || (arg > 16) || (arg % 2)) {
> +                               dev_err(pctldev->dev,
> +                                       "Invalid Drive Strength value (%d) for "
> +                                       "pin %s (%d). Valid values are "
> +                                       "(2..16) mA, even numbers only.\n",
> +                                       arg, pdata->pins[pin].name, pin);
> +                               return -EINVAL;
> +                       }
> +                       *val = CAPRI_PIN_UPDATE(*val, STD, DRV_STR, (arg/2)-1);
> +                       *mask |= CAPRI_STD_PIN_REG_DRV_STR_MASK;
> +                       break;

Hm rather nice integer math...

> +/* Goes through the configs and update register val/mask */
> +static int capri_i2c_pin_update(struct pinctrl_dev *pctldev,
> +                               unsigned pin,
> +                               unsigned long *configs,
> +                               unsigned num_configs,
> +                               u32 *val,
> +                               u32 *mask)
> +{
> +       struct capri_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
> +       int i;
> +       enum pin_config_param param;
> +       u16 arg;
> +
> +       for (i = 0; i < num_configs; i++) {
> +               param = pinconf_to_config_param(configs[i]);
> +               arg = pinconf_to_config_argument(configs[i]);
> +
> +               switch (param) {
> +               case PIN_CONFIG_BIAS_PULL_UP:
> +                       if ((arg < 1) || (arg > 7)) {
> +                               dev_err(pctldev->dev,
> +                                       "Invalid Pull Up value (%d) for pin %s "
> +                                       "(%d). Valid values are (1..7).\n",
> +                                       arg, pdata->pins[pin].name, pin);
> +                               return -EINVAL;
> +                       }

No don't do that as mentioned in the other patch. Pass pull up strength
in Ohms.

Then have a translation table here, and do some best-effort fuzzy match.

> +       /* Different pins have different configuration options */
> +       switch (pin_type) {
> +       case CAPRI_PIN_TYPE_STD:
> +               rc = capri_std_pin_update(pctldev, pin, configs, num_configs,
> +                       &cfg_val, &cfg_mask);
> +               break;
> +
> +       case CAPRI_PIN_TYPE_I2C:
> +               rc = capri_i2c_pin_update(pctldev, pin, configs, num_configs,
> +                       &cfg_val, &cfg_mask);
> +               break;
> +
> +       case CAPRI_PIN_TYPE_HDMI:
> +               rc = capri_hdmi_pin_update(pctldev, pin, configs, num_configs,
> +                       &cfg_val, &cfg_mask);
> +               break;

This is really nice and elegant.

Yours,
Linus Walleij
