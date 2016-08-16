From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 16 Aug 2016 09:27:54 +0800
Subject: [PATCH 2/2] pinctrl: sunxi: Add A64 R_PIO controller support
In-Reply-To: <363591471306006@web8j.yandex.ru>
References: <20160801145939.50583-1-icenowy@aosc.xyz>
 <20160801145939.50583-2-icenowy@aosc.xyz>
 <CAGb2v64nzOOwZFGzukXehv6Bx6nikHdnuGUkRMJWS8bjfMkeXQ@mail.gmail.com>
 <363591471306006@web8j.yandex.ru>
Message-ID: <CAGb2v64jQT+EQ01ZGSJ=3_FMnG5kckz_AEd3ME2Osi+sYO1dmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 8:06 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
>
>
> 15.08.2016, 21:56, "Chen-Yu Tsai" <wens@csie.org>:
>> Hi,
>>
>> On Mon, Aug 1, 2016 at 10:59 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
>>>  The A64 has a R_PIO pin controller, similar to the one found on the H3 SoCs.
>>>  Add support for the pins controlled by the R_PIO controller.
>>>
>>>  Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>>>  ---
>>>   drivers/pinctrl/sunxi/Kconfig | 5 +
>>>   drivers/pinctrl/sunxi/Makefile | 1 +
>>>   drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c | 148 +++++++++++++++++++++++++++
>>>   3 files changed, 154 insertions(+)
>>>   create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c
>>>
>>>  diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
>>>  index aaf075b..c4b476f 100644
>>>  --- a/drivers/pinctrl/sunxi/Kconfig
>>>  +++ b/drivers/pinctrl/sunxi/Kconfig
>>>  @@ -72,4 +72,9 @@ config PINCTRL_SUN50I_A64
>>>          bool
>>>          select PINCTRL_SUNXI
>>>
>>>  +config PINCTRL_SUN50I_A64_R
>>>  + bool
>>>  + depends on RESET_CONTROLLER
>>>  + select PINCTRL_SUNXI
>>>  +
>>>   endif
>>>  diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
>>>  index 2d8b64e..d6eabdd 100644
>>>  --- a/drivers/pinctrl/sunxi/Makefile
>>>  +++ b/drivers/pinctrl/sunxi/Makefile
>>>  @@ -13,6 +13,7 @@ obj-$(CONFIG_PINCTRL_SUN8I_A23) += pinctrl-sun8i-a23.o
>>>   obj-$(CONFIG_PINCTRL_SUN8I_A23_R) += pinctrl-sun8i-a23-r.o
>>>   obj-$(CONFIG_PINCTRL_SUN8I_A33) += pinctrl-sun8i-a33.o
>>>   obj-$(CONFIG_PINCTRL_SUN50I_A64) += pinctrl-sun50i-a64.o
>>>  +obj-$(CONFIG_PINCTRL_SUN50I_A64_R) += pinctrl-sun50i-a64-r.o
>>>   obj-$(CONFIG_PINCTRL_SUN8I_A83T) += pinctrl-sun8i-a83t.o
>>>   obj-$(CONFIG_PINCTRL_SUN8I_H3) += pinctrl-sun8i-h3.o
>>>   obj-$(CONFIG_PINCTRL_SUN8I_H3_R) += pinctrl-sun8i-h3-r.o
>>>  diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c
>>>  new file mode 100644
>>>  index 0000000..b836264
>>>  --- /dev/null
>>>  +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c
>>>  @@ -0,0 +1,148 @@
>>>  +/*
>>>  + * Allwinner A64 SoCs special pins pinctrl driver.
>>>  + *
>>>  + * Based on pinctrl-sun8i-a23-r.c
>>>  + *
>>>  + * Copyright (C) 2016 Icenowy Zheng
>>>  + * Icenowy Zheng <icenowy@aosc.xyz>
>>>  + *
>>>  + * Copyright (C) 2014 Chen-Yu Tsai
>>>  + * Chen-Yu Tsai <wens@csie.org>
>>>  + *
>>>  + * Copyright (C) 2014 Boris Brezillon
>>>  + * Boris Brezillon <boris.brezillon@free-electrons.com>
>>>  + *
>>>  + * Copyright (C) 2014 Maxime Ripard
>>>  + * Maxime Ripard <maxime.ripard@free-electrons.com>
>>>  + *
>>>  + * This file is licensed under the terms of the GNU General Public
>>>  + * License version 2. This program is licensed "as is" without any
>>>  + * warranty of any kind, whether express or implied.
>>>  + */
>>>  +
>>>  +#include <linux/module.h>
>>>  +#include <linux/platform_device.h>
>>>  +#include <linux/of.h>
>>>  +#include <linux/of_device.h>
>>
>> Please sort the headers.
> This file is based on pinctrl-sun8i-a23-r.c and pinctrl-sun8i-h3-r.c, which
> both have #include in this sequence.

And we should probably fix them too.

>>
>>>  +#include <linux/pinctrl/pinctrl.h>
>>>  +#include <linux/reset.h>
>>>  +
>>>  +#include "pinctrl-sunxi.h"
>>>  +
>>>  +static const struct sunxi_desc_pin sun50i_a64_r_pins[] = {
>>>  + SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 0),
>>>  + SUNXI_FUNCTION(0x0, "gpio_in"),
>>>  + SUNXI_FUNCTION(0x1, "gpio_out"),
>>>  + SUNXI_FUNCTION(0x2, "s_rsb"), /* SCK */
>>>  + SUNXI_FUNCTION(0x3, "s_twi"), /* SCK */
>>
>> We use "i2c" instead of "twi".
> So as above, in A23 / H3 R_PIO driver, they're called as "s_twi" other than "s_i2c"

These as well.

ChenYu

>>
>>>  + SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)), /* PL_EINT0 */
>>>  + SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 1),
>>>  + SUNXI_FUNCTION(0x0, "gpio_in"),
>>>  + SUNXI_FUNCTION(0x1, "gpio_out"),
>>>  + SUNXI_FUNCTION(0x2, "s_rsb"), /* SDA */
>>>  + SUNXI_FUNCTION(0x3, "s_twi"), /* SDA */
>>
>> Same here.
>>
>>>  + SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)), /* PL_EINT1 */
>>>  + SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 2),
>>>  + SUNXI_FUNCTION(0x0, "gpio_in"),
>>>  + SUNXI_FUNCTION(0x1, "gpio_out"),
>>>  + SUNXI_FUNCTION(0x2, "s_uart"), /* TX */
>>>  + SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)), /* PL_EINT2 */
>>>  + SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 3),
>>>  + SUNXI_FUNCTION(0x0, "gpio_in"),
>>>  + SUNXI_FUNCTION(0x1, "gpio_out"),
>>>  + SUNXI_FUNCTION(0x2, "s_uart"), /* RX */
>>>  + SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)), /* PL_EINT3 */
>>>  + SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 4),
>>>  + SUNXI_FUNCTION(0x0, "gpio_in"),
>>>  + SUNXI_FUNCTION(0x1, "gpio_out"),
>>>  + SUNXI_FUNCTION(0x3, "s_jtag"), /* MS */
>>>  + SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)), /* PL_EINT4 */
>>>  + SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 5),
>>>  + SUNXI_FUNCTION(0x0, "gpio_in"),
>>>  + SUNXI_FUNCTION(0x1, "gpio_out"),
>>>  + SUNXI_FUNCTION(0x3, "s_jtag"), /* CK */
>>>  + SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)), /* PL_EINT5 */
>>>  + SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 6),
>>>  + SUNXI_FUNCTION(0x0, "gpio_in"),
>>>  + SUNXI_FUNCTION(0x1, "gpio_out"),
>>>  + SUNXI_FUNCTION(0x3, "s_jtag"), /* DO */
>>>  + SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)), /* PL_EINT6 */
>>>  + SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 7),
>>>  + SUNXI_FUNCTION(0x0, "gpio_in"),
>>>  + SUNXI_FUNCTION(0x1, "gpio_out"),
>>>  + SUNXI_FUNCTION(0x3, "s_jtag"), /* DI */
>>>  + SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)), /* PL_EINT7 */
>>>  + SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 8),
>>>  + SUNXI_FUNCTION(0x0, "gpio_in"),
>>>  + SUNXI_FUNCTION(0x1, "gpio_out"),
>>>  + SUNXI_FUNCTION(0x2, "s_twi"), /* SCK */
>>
>> Ditto.
>>
>>>  + SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)), /* PL_EINT8 */
>>>  + SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 9),
>>>  + SUNXI_FUNCTION(0x0, "gpio_in"),
>>>  + SUNXI_FUNCTION(0x1, "gpio_out"),
>>>  + SUNXI_FUNCTION(0x2, "s_twi"), /* SDA */
>>
>> Ditto.
>>
>>>  + SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 9)), /* PL_EINT9 */
>>>  + SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 10),
>>>  + SUNXI_FUNCTION(0x0, "gpio_in"),
>>>  + SUNXI_FUNCTION(0x1, "gpio_out"),
>>>  + SUNXI_FUNCTION(0x2, "s_pwm"),
>>>  + SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 10)), /* PL_EINT10 */
>>>  + SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 11),
>>>  + SUNXI_FUNCTION(0x0, "gpio_in"),
>>>  + SUNXI_FUNCTION(0x1, "gpio_out"),
>>>  + SUNXI_FUNCTION(0x2, "s_cir_rx"),
>>>  + SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 11)), /* PL_EINT11 */
>>
>> You missed PL12.
> Sorry... I forgot to add it...
>>
>>>  +};
>>>  +
>>>  +static const struct sunxi_pinctrl_desc sun50i_a64_r_pinctrl_data = {
>>>  + .pins = sun50i_a64_r_pins,
>>>  + .npins = ARRAY_SIZE(sun50i_a64_r_pins),
>>>  + .pin_base = PL_BASE,
>>>  + .irq_banks = 1,
>>>  +};
>>>  +
>>>  +static int sun50i_a64_r_pinctrl_probe(struct platform_device *pdev)
>>>  +{
>>>  + struct reset_control *rstc;
>>>  + int ret;
>>>  +
>>>  + rstc = devm_reset_control_get(&pdev->dev, NULL);
>>>  + if (IS_ERR(rstc)) {
>>>  + dev_err(&pdev->dev, "Reset controller missing\n");
>>>  + return PTR_ERR(rstc);
>>>  + }
>>>  +
>>>  + ret = reset_control_deassert(rstc);
>>>  + if (ret)
>>>  + return ret;
>>>  +
>>>  + ret = sunxi_pinctrl_init(pdev,
>>>  + &sun50i_a64_r_pinctrl_data);
>>>  +
>>>  + if (ret)
>>>  + reset_control_assert(rstc);
>>>  +
>>>  + return ret;
>>>  +}
>>>  +
>>>  +static const struct of_device_id sun50i_a64_r_pinctrl_match[] = {
>>>  + { .compatible = "allwinner,sun50i-a64-r-pinctrl", },
>>>  + {}
>>>  +};
>>>  +MODULE_DEVICE_TABLE(of, sun50i_a64_r_pinctrl_match);
>>>  +
>>>  +static struct platform_driver sun50i_a64_r_pinctrl_driver = {
>>>  + .probe = sun50i_a64_r_pinctrl_probe,
>>>  + .driver = {
>>>  + .name = "sun50i-a64-r-pinctrl",
>>>  + .of_match_table = sun50i_a64_r_pinctrl_match,
>>>  + },
>>>  +};
>>>  +module_platform_driver(sun50i_a64_r_pinctrl_driver);
>>>  +
>>>  +MODULE_AUTHOR("Icenowy Zheng <icenowy@aosc.xyz>");
>>>  +MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
>>>  +MODULE_AUTHOR("Boris Brezillon <boris.brezillon@free-electrons.com");
>>>  +MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com");
>>>  +MODULE_DESCRIPTION("Allwinner A64 R_PIO pinctrl driver");
>>>  +MODULE_LICENSE("GPL");
>>
>> Since you have a bool Kconfig symbol, you can drop all the module related
>> stuff. Just use builtin_platform_driver like the A64 main pinctrl driver
>> does.
>>
>> Regards
>> ChenYu
>>
>>>  --
>>>  2.9.0
