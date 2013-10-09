From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Oct 2013 11:10:22 +0200
Subject: [PATCH 3/4] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <1380846199-12829-4-git-send-email-syin@broadcom.com>
References: <1380846199-12829-1-git-send-email-syin@broadcom.com>
 <1380846199-12829-4-git-send-email-syin@broadcom.com>
Message-ID: <CACRpkdZah4fFuJL2Vh5JmbBCgnekg8MKqMWHzeheOx3N1Kzwng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 4, 2013 at 2:23 AM, Sherman Yin <syin@broadcom.com> wrote:

> Adds pinctrl driver for Broadcom Capri (BCM281xx) SoCs.
>
> Signed-off-by: Sherman Yin <syin@broadcom.com>
> Reviewed-by: Christian Daudt <bcm@fixthebug.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
(...)

> +config PINCTRL_CAPRI
> +       bool "Broadcom Capri pinctrl driver"
> +       select PINMUX
> +       select PINCONF
> +       help
> +         Say Y here to support Broadcom Capri pinctrl driver, which is used for
> +         the BCM281xx SoC family, including BCM11130, BCM11140, BCM11351,
> +         BCM28145, and BCM28155 SoCs.  This driver requires the pinctrl
> +         framework.  GPIO is provided by a separate GPIO driver.

As mentioned this should be selecting and using GENERIC_PINCONF.
Basically I want that to happen before we look further at this code.

(But I'll take a quick glance anyway...)

> +#define CAPRI_PINCONF_PACK(val, mask)     (((val) << 16) | ((mask) & 0xffff))
> +#define CAPRI_PINCONF_UNPACK_VAL(conf)    ((conf) >> 16)
> +#define CAPRI_PINCONF_UNPACK_MASK(conf)   ((conf) & 0xffff)

This custom horror goes away by using the macros from genric pin config
<linux/pinctrl/pinconf-generic.h> instead.

> +static const struct capri_cfg_param capri_pinconf_params[] = {
> +       {"brcm,hysteresis",     CAPRI_PINCONF_PARAM_HYST},
> +       {"brcm,pull",           CAPRI_PINCONF_PARAM_PULL},
> +       {"brcm,slew",           CAPRI_PINCONF_PARAM_SLEW},
> +       {"brcm,input_dis",      CAPRI_PINCONF_PARAM_INPUT_DIS},
> +       {"brcm,drive_str",      CAPRI_PINCONF_PARAM_DRV_STR},
> +       {"brcm,pull_up_str",    CAPRI_PINCONF_PARAM_PULL_UP_STR},
> +       {"brcm,mode",           CAPRI_PINCONF_PARAM_MODE},
> +};

As well as all this stuff...

> +/* Standard pin register */

Add some more elaborate explanation here. I am half-guessing that
most of the registers are laid out like this and then there are
two exceptions, then write that right here in the comment.

(BTW: this is a HW/driver detail and should not be written in the
device tree doc as was done in patch 2)

> +/* Macro to update reg with new pin config param */
> +#define CAPRI_PIN_REG_SET(reg, type, param, val)                       \
> +       (((reg) & ~CAPRI_ ## type ## _PIN_REG_ ## param ## _MASK)       \
> +       | (((val) << CAPRI_ ## type ## _PIN_REG_ ## param ## _SHIFT)    \
> +       & CAPRI_ ## type ## _PIN_REG_ ## param ## _MASK))

No thanks.

Rewrite this into a static inline which has the same effect when
compiling, but produces *WAY* more readable code than this
horrid thing. Plus you can type the arguments.

> +#define _PIN(offset)                   (offset)

This macro isn't exactly useful.

> +/*
> + * Pin number definition.  The order here must be the same as defined in the
> + * PADCTRLREG block in the RDB.
> + */
> +#define CAPRI_PIN_ADCSYNC              _PIN(0)

If it's just going to be like that, then skip the _PIN() macro.

> +/* Process the pin configuration node */
> +static int capri_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
> +                                       struct device_node *pnode,
> +                                       struct pinctrl_map **map,
> +                                       unsigned *nmaps)
> +{

Make use of these from pinctrl-utils.c:
pinctrl_utils_reserve_map()
pinctrl_utils_add_map_mux()
pinctrl_utils_add_map_configs()
pinctrl_utils_dt_free_map()

Then you get rid of another big chunk of boilerplate code.

After these changes the driver will be much smaller and
cleaner and we can take a closer look.

Yours,
Linus Walleij
