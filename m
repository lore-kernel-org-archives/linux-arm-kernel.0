From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 23 Apr 2014 13:16:13 +0200
Subject: [PATCH v2 03/38] pinctrl: mvebu: new driver for Orion platforms
In-Reply-To: <1398202002-28530-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5357A0FD.5020508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 11:26 PM, Thomas Petazzoni wrote:
> This commit extends the pinctrl mvebu logic with a new driver to cover
> Orion5x SoC. It supports the definitions for the 5181l, 5182 and 5281
> variants of Orion5x, which are the three ones supported by the old
> style MPP code in arch/arm/mach-orion5x/.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   .../bindings/pinctrl/marvell,orion-pinctrl.txt     |  91 +++++++
>   drivers/pinctrl/mvebu/Kconfig                      |   4 +
>   drivers/pinctrl/mvebu/Makefile                     |   1 +
>   drivers/pinctrl/mvebu/pinctrl-orion.c              | 261 +++++++++++++++++++++
>   4 files changed, 357 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,orion-pinctrl.txt
>   create mode 100644 drivers/pinctrl/mvebu/pinctrl-orion.c
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,orion-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,orion-pinctrl.txt
> new file mode 100644
> index 0000000..27570a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/marvell,orion-pinctrl.txt
> @@ -0,0 +1,91 @@
> +* Marvell Orion SoC pinctrl driver for mpp
> +
> +Please refer to marvell,mvebu-pinctrl.txt in this directory for common binding
> +part and usage.
> +
> +Required properties:
> +- compatible: "marvell,88f5181l-pinctrl", "marvell,88f5182-pinctrl",
> +              "marvell,88f5281-pinctrl"
> +
> +- reg: two register areas, the first one describing the first two
> +  contiguous MPP registers, and the second one describing the single
> +  final MPP register, separated from the previous one.
> +
> +Available mpp pins/groups and functions:
> +Note: brackets (x) are not part of the mpp name for marvell,function and given
> +only for more detailed description in this document.
> +
> +* Marvell Orion 88f5181l
> +
> +name          pins     functions
> +================================================================================
> +mpp0          0        pcie(rstout), pci(req2), gpio
> +mpp1          1        gpio, pci(gnt2)
> +mpp2          2        gpio, pci(req3), pci-1(pme)
> +mpp3          3        gpio, pci(gnt3)
> +mpp4          4        gpio, pci(req4)
> +mpp5          5        gpio, pci(gnt4)
> +mpp6          6        gpio, pci(req5), pci-1(clk)
> +mpp7          7        gpio, pci(gnt5), pci-1(clk)
> +mpp8          8        gpio, ge(col)
> +mpp9          9        gpio, ge(rxerr)
> +mpp10         10       gpio, ge(crs)
> +mpp11         11       gpio, ge(txerr)
> +mpp12         12       gpio, ge(txd4)
> +mpp13         13       gpio, ge(txd5)
> +mpp14         14       gpio, ge(txd6)
> +mpp15         15       gpio, ge(txd7)
> +mpp16         16       ge(rxd4)
> +mpp17         17       ge(rxd5)
> +mpp18         18       ge(rxd6)
> +mpp19         19       ge(rxd7)
> +
> +* Marvell Orion 88f5182
> +
> +name          pins     functions
> +================================================================================
> +mpp0          0        pcie(rstout), pci(req2), gpio
> +mpp1          1        gpio, pci(gnt2)
> +mpp2          2        gpio, pci(req3), pci-1(pme)
> +mpp3          3        gpio, pci(gnt3)
> +mpp4          4        gpio, pci(req4), bootnand(re), sata0(prsnt)
> +mpp5          5        gpio, pci(gnt4), bootnand(we), sata1(prsnt)
> +mpp6          6        gpio, pci(req5), nand(re0), sata0(act)
> +mpp7          7        gpio, pci(gnt5), nand(we0), sata1(act)
> +mpp8          8        gpio, ge(col)
> +mpp9          9        gpio, ge(rxerr)
> +mpp10         10       gpio, ge(crs)
> +mpp11         11       gpio, ge(txerr)
> +mpp12         12       gpio, ge(txd4), nand(re1), sata0(ledprsnt)
> +mpp13         13       gpio, ge(txd5), nand(we1), sata1(ledprsnt)
> +mpp14         14       gpio, ge(txd6), nand(re2), sata0(ledact)
> +mpp15         15       gpio, ge(txd7), nand(we2), sata1(ledact)
> +mpp16         16       uart1(rxd), ge(rxd4), gpio
> +mpp17         17       uart1(txd), ge(rxd5), gpio
> +mpp18         18       uart1(cts), ge(rxd6), gpio
> +mpp19         19       uart1(rts), ge(rxd7), gpio
> +
> +* Marvell Orion 88f5281
> +
> +name          pins     functions
> +================================================================================
> +mpp0          0        pcie(rstout), pci(req2), gpio
> +mpp1          1        gpio, pci(gnt2)
> +mpp2          2        gpio, pci(req3), pci(pme)
> +mpp3          3        gpio, pci(gnt3)
> +mpp4          4        gpio, pci(req4), bootnand(re)
> +mpp5          5        gpio, pci(gnt4), bootnand(we)
> +mpp6          6        gpio, pci(req5), nand(re0)
> +mpp7          7        gpio, pci(gnt5), nand(we0)
> +mpp8          8        gpio, ge(col)
> +mpp9          9        gpio, ge(rxerr)
> +mpp10         10       gpio, ge(crs)
> +mpp11         11       gpio, ge(txerr)
> +mpp12         12       gpio, ge(txd4), nand(re1)
> +mpp13         13       gpio, ge(txd5), nand(we1)
> +mpp14         14       gpio, ge(txd6), nand(re2)
> +mpp15         15       gpio, ge(txd7), nand(we2)
> +mpp16         16       uart1(rxd), ge(rxd4)
> +mpp17         17       uart1(txd), ge(rxd5)
> +mpp18         18       uart1(cts), ge(rxd6)
> +mpp19         19       uart1(rts), ge(rxd7)
> diff --git a/drivers/pinctrl/mvebu/Kconfig b/drivers/pinctrl/mvebu/Kconfig
> index cc298fad..d6dd835 100644
> --- a/drivers/pinctrl/mvebu/Kconfig
> +++ b/drivers/pinctrl/mvebu/Kconfig
> @@ -30,4 +30,8 @@ config PINCTRL_ARMADA_XP
>   	bool
>   	select PINCTRL_MVEBU
>
> +config PINCTRL_ORION
> +	bool
> +	select PINCTRL_MVEBU
> +
>   endif
> diff --git a/drivers/pinctrl/mvebu/Makefile b/drivers/pinctrl/mvebu/Makefile
> index bc1b9f1..a0818e9 100644
> --- a/drivers/pinctrl/mvebu/Makefile
> +++ b/drivers/pinctrl/mvebu/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_PINCTRL_ARMADA_370) += pinctrl-armada-370.o
>   obj-$(CONFIG_PINCTRL_ARMADA_375) += pinctrl-armada-375.o
>   obj-$(CONFIG_PINCTRL_ARMADA_38X) += pinctrl-armada-38x.o
>   obj-$(CONFIG_PINCTRL_ARMADA_XP)  += pinctrl-armada-xp.o
> +obj-$(CONFIG_PINCTRL_ORION)  += pinctrl-orion.o
> diff --git a/drivers/pinctrl/mvebu/pinctrl-orion.c b/drivers/pinctrl/mvebu/pinctrl-orion.c
> new file mode 100644
> index 0000000..dda1e72
> --- /dev/null
> +++ b/drivers/pinctrl/mvebu/pinctrl-orion.c
> @@ -0,0 +1,261 @@
> +/*
> + * Marvell Orion pinctrl driver based on mvebu pinctrl core
> + *
> + * Author: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * The first 16 MPP pins on Orion are easy to handle: they are
> + * configured through 2 consecutive registers, located at the base
> + * address of the MPP device.
> + *
> + * However the last 4 MPP pins are handled by a register at offset
> + * 0x50 from the base address, so it is not consecutive with the first
> + * two registers.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +
> +#include "pinctrl-mvebu.h"
> +
> +static void __iomem *mpp_base;
> +static void __iomem *high_mpp_base;
> +
> +static int orion_mpp_ctrl_get(unsigned pid, unsigned long *config)
> +{
> +	unsigned shift = (pid % MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
> +
> +	if (pid < 16) {
> +		unsigned off = (pid / MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
> +		*config = (readl(mpp_base + off) >> shift) & MVEBU_MPP_MASK;
> +	}
> +	else {
> +		*config = (readl(high_mpp_base) >> shift) & MVEBU_MPP_MASK;
> +	}
> +
> +	return 0;
> +}
> +
> +static int orion_mpp_ctrl_set(unsigned pid, unsigned long config)
> +{
> +	unsigned shift = (pid % MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
> +
> +	if (pid < 16) {
> +		unsigned off = (pid / MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
> +		u32 reg = readl(mpp_base + off) & ~(MVEBU_MPP_MASK << shift);
> +		writel(reg | (config << shift), mpp_base + off);
> +	}
> +	else {
> +		u32 reg = readl(high_mpp_base) & ~(MVEBU_MPP_MASK << shift);
> +		writel(reg | (config << shift), high_mpp_base);
> +	}
> +
> +	return 0;
> +}
> +
> +#define V(f5181l, f5182, f5281) \
> +	((f5181l << 0) | (f5182 << 1) | (f5281 << 2))
> +
> +enum orion_variant {
> +	V_5181L = V(1, 0, 0),
> +	V_5182  = V(0, 1, 0),
> +	V_5281  = V(0, 0, 1),
> +	V_ALL   = V(1, 1, 1),
> +};
> +
> +static struct mvebu_mpp_mode orion_mpp_modes[] = {
> +	MPP_MODE(0,
> +		 MPP_VAR_FUNCTION(0x0, "pcie", "rstout",    V_ALL),
> +		 MPP_VAR_FUNCTION(0x2, "pci", "req2",       V_ALL),
> +		 MPP_VAR_FUNCTION(0x3, "gpio", NULL,        V_ALL)),
> +	MPP_MODE(1,
> +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
> +		 MPP_VAR_FUNCTION(0x2, "pci", "gnt2",       V_ALL)),
> +	MPP_MODE(2,
> +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
> +		 MPP_VAR_FUNCTION(0x2, "pci", "req3",       V_ALL),
> +		 MPP_VAR_FUNCTION(0x3, "pci-1", "pme",      V_ALL)),
> +	MPP_MODE(3,
> +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
> +		 MPP_VAR_FUNCTION(0x2, "pci", "gnt3",       V_ALL)),
> +	MPP_MODE(4,
> +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
> +		 MPP_VAR_FUNCTION(0x2, "pci", "req4",       V_ALL),
> +		 MPP_VAR_FUNCTION(0x4, "bootnand", "re",    V_5182 | V_5281),
> +		 MPP_VAR_FUNCTION(0x5, "sata0", "prsnt",    V_5182)),
> +	MPP_MODE(5,
> +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
> +		 MPP_VAR_FUNCTION(0x2, "pci", "gnt4",       V_ALL),
> +		 MPP_VAR_FUNCTION(0x4, "bootnand", "we",    V_5182 | V_5281),
> +		 MPP_VAR_FUNCTION(0x5, "sata1", "prsnt",    V_5182)),
> +	MPP_MODE(6,
> +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
> +		 MPP_VAR_FUNCTION(0x2, "pci", "req5",       V_ALL),
> +		 MPP_VAR_FUNCTION(0x4, "nand", "re0",       V_5182 | V_5281),
> +		 MPP_VAR_FUNCTION(0x5, "pci-1", "clk",      V_5181L),
> +		 MPP_VAR_FUNCTION(0x5, "sata0", "act",      V_5182)),
> +	MPP_MODE(7,
> +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
> +		 MPP_VAR_FUNCTION(0x2, "pci", "gnt5",       V_ALL),
> +		 MPP_VAR_FUNCTION(0x4, "nand", "we0",       V_5182 | V_5281),
> +		 MPP_VAR_FUNCTION(0x5, "pci-1", "clk",      V_5181L),
> +		 MPP_VAR_FUNCTION(0x5, "sata1", "act",      V_5182)),
> +	MPP_MODE(8,
> +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
> +		 MPP_VAR_FUNCTION(0x1, "ge", "col",         V_ALL)),
> +	MPP_MODE(9,
> +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
> +		 MPP_VAR_FUNCTION(0x1, "ge", "rxerr",       V_ALL)),
> +	MPP_MODE(10,
> +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
> +		 MPP_VAR_FUNCTION(0x1, "ge", "crs",         V_ALL)),
> +	MPP_MODE(11,
> +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
> +		 MPP_VAR_FUNCTION(0x1, "ge", "txerr",       V_ALL)),
> +	MPP_MODE(12,
> +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
> +		 MPP_VAR_FUNCTION(0x1, "ge", "txd4",        V_ALL),
> +		 MPP_VAR_FUNCTION(0x4, "nand", "re1",       V_5182 | V_5281),
> +		 MPP_VAR_FUNCTION(0x5, "sata0", "ledprsnt", V_5182)),
> +	MPP_MODE(13,
> +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
> +		 MPP_VAR_FUNCTION(0x1, "ge", "txd5",        V_ALL),
> +		 MPP_VAR_FUNCTION(0x4, "nand", "we1",       V_5182 | V_5281),
> +		 MPP_VAR_FUNCTION(0x5, "sata1", "ledprsnt", V_5182)),
> +	MPP_MODE(14,
> +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
> +		 MPP_VAR_FUNCTION(0x1, "ge", "txd6",        V_ALL),
> +		 MPP_VAR_FUNCTION(0x4, "nand", "re2",       V_5182 | V_5281),
> +		 MPP_VAR_FUNCTION(0x5, "sata0", "ledact",   V_5182)),
> +	MPP_MODE(15,
> +		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,        V_ALL),
> +		 MPP_VAR_FUNCTION(0x1, "ge", "txd7",        V_ALL),
> +		 MPP_VAR_FUNCTION(0x4, "nand", "we2",       V_5182 | V_5281),
> +		 MPP_VAR_FUNCTION(0x5, "sata1", "ledact",   V_5182)),
> +	MPP_MODE(16,
> +		 MPP_VAR_FUNCTION(0x0, "uart1", "rxd",      V_5182 | V_5281),
> +		 MPP_VAR_FUNCTION(0x1, "ge", "rxd4",        V_ALL),
> +		 MPP_VAR_FUNCTION(0x5, "gpio", NULL,        V_5182)),
> +	MPP_MODE(17,
> +		 MPP_VAR_FUNCTION(0x0, "uart1", "txd",      V_5182 | V_5281),
> +		 MPP_VAR_FUNCTION(0x1, "ge", "rxd5",        V_ALL),
> +		 MPP_VAR_FUNCTION(0x5, "gpio", NULL,        V_5182)),
> +	MPP_MODE(18,
> +		 MPP_VAR_FUNCTION(0x0, "uart1", "cts",      V_5182 | V_5281),
> +		 MPP_VAR_FUNCTION(0x1, "ge", "rxd6",        V_ALL),
> +		 MPP_VAR_FUNCTION(0x5, "gpio", NULL,        V_5182)),
> +	MPP_MODE(19,
> +		 MPP_VAR_FUNCTION(0x0, "uart1", "rts",      V_5182 | V_5281),
> +		 MPP_VAR_FUNCTION(0x1, "ge", "rxd7",        V_ALL),
> +		 MPP_VAR_FUNCTION(0x5, "gpio", NULL,        V_5182)),
> +};
> +
> +static struct mvebu_mpp_ctrl orion_mpp_controls[] = {
> +	MPP_FUNC_CTRL(0, 19, NULL, orion_mpp_ctrl),
> +};
> +
> +static struct pinctrl_gpio_range mv88f5181l_gpio_ranges[] = {
> +	MPP_GPIO_RANGE(0, 0, 0, 16),
> +};
> +
> +static struct pinctrl_gpio_range mv88f5182_gpio_ranges[] = {
> +	MPP_GPIO_RANGE(0, 0, 0, 19),
> +};
> +
> +static struct pinctrl_gpio_range mv88f5281_gpio_ranges[] = {
> +	MPP_GPIO_RANGE(0, 0, 0, 16),
> +};
> +
> +static struct mvebu_pinctrl_soc_info mv88f5181l_info = {
> +	.variant = V_5181L,
> +	.controls = orion_mpp_controls,
> +	.ncontrols = ARRAY_SIZE(orion_mpp_controls),
> +	.modes = orion_mpp_modes,
> +	.nmodes = ARRAY_SIZE(orion_mpp_modes),
> +	.gpioranges = mv88f5181l_gpio_ranges,
> +	.ngpioranges = ARRAY_SIZE(mv88f5181l_gpio_ranges),
> +};
> +
> +static struct mvebu_pinctrl_soc_info mv88f5182_info = {
> +	.variant = V_5182,
> +	.controls = orion_mpp_controls,
> +	.ncontrols = ARRAY_SIZE(orion_mpp_controls),
> +	.modes = orion_mpp_modes,
> +	.nmodes = ARRAY_SIZE(orion_mpp_modes),
> +	.gpioranges = mv88f5182_gpio_ranges,
> +	.ngpioranges = ARRAY_SIZE(mv88f5182_gpio_ranges),
> +};
> +
> +static struct mvebu_pinctrl_soc_info mv88f5281_info = {
> +	.variant = V_5281,
> +	.controls = orion_mpp_controls,
> +	.ncontrols = ARRAY_SIZE(orion_mpp_controls),
> +	.modes = orion_mpp_modes,
> +	.nmodes = ARRAY_SIZE(orion_mpp_modes),
> +	.gpioranges = mv88f5281_gpio_ranges,
> +	.ngpioranges = ARRAY_SIZE(mv88f5281_gpio_ranges),
> +};
> +
> +/*
> + * There are multiple variants of the Orion SoCs, but in terms of pin
> + * muxing, they are identical.
> + */
> +static struct of_device_id orion_pinctrl_of_match[] = {
> +	{ .compatible = "marvell,88f5181l-pinctrl", .data = &mv88f5181l_info },
> +	{ .compatible = "marvell,88f5182-pinctrl", .data = &mv88f5182_info },
> +	{ .compatible = "marvell,88f5281-pinctrl", .data = &mv88f5281_info },
> +	{ }
> +};
> +
> +static int orion_pinctrl_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match =
> +		of_match_device(orion_pinctrl_of_match, &pdev->dev);
> +	struct resource *res;
> +
> +	pdev->dev.platform_data = (void*)match->data;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mpp_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(mpp_base))
> +		return PTR_ERR(mpp_base);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	high_mpp_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(high_mpp_base))
> +		return PTR_ERR(high_mpp_base);
> +
> +	return mvebu_pinctrl_probe(pdev);
> +}
> +
> +static int orion_pinctrl_remove(struct platform_device *pdev)
> +{
> +	return mvebu_pinctrl_remove(pdev);
> +}
> +
> +static struct platform_driver orion_pinctrl_driver = {
> +	.driver = {
> +		.name = "orion-pinctrl",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(orion_pinctrl_of_match),
> +	},
> +	.probe = orion_pinctrl_probe,
> +	.remove = orion_pinctrl_remove,
> +};
> +
> +module_platform_driver(orion_pinctrl_driver);
> +
> +MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
> +MODULE_DESCRIPTION("Marvell Orion pinctrl driver");
> +MODULE_LICENSE("GPL v2");
>
