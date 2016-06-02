From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 2 Jun 2016 07:42:12 +0200
Subject: [PATCH/RFC v3 02/22] soc: renesas: Add R-Car RST driver
In-Reply-To: <1464808880-343-3-git-send-email-geert+renesas@glider.be>
References: <1464808880-343-1-git-send-email-geert+renesas@glider.be>
 <1464808880-343-3-git-send-email-geert+renesas@glider.be>
Message-ID: <d38d97fb-5b96-0773-abf6-c737b4f2fef1@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.06.2016 21:21, Geert Uytterhoeven wrote:
> Add a driver for the Renesas R-Car Gen1 RESET/WDT and R-Car Gen2/Gen3
> RST module.
>
> For now this driver just provides an API to obtain the state of the mode
> pins, as latched at reset time.  As this is typically called from the
> probe function of a clock driver, which can run much earlier than any
> initcall, calling rcar_rst_read_mode_pins() may force an early
> initialization of the driver.
>
> Despite the current simple and almost identical handling for all
> supported SoCs, the driver matches against SoC-specific compatible
> values only, as the features provided by the hardware module differ a
> lot across the various SoC families and members.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - New.
> ---
>  drivers/soc/renesas/Makefile         |  5 ++
>  drivers/soc/renesas/rcar-rst.c       | 94 ++++++++++++++++++++++++++++++++++++
>  include/linux/soc/renesas/rcar-rst.h |  6 +++
>  3 files changed, 105 insertions(+)
>  create mode 100644 drivers/soc/renesas/rcar-rst.c
>  create mode 100644 include/linux/soc/renesas/rcar-rst.h
>
> diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
> index f32a001c65c3ab44..0d732ff893dd8fba 100644
> --- a/drivers/soc/renesas/Makefile
> +++ b/drivers/soc/renesas/Makefile
> @@ -1,3 +1,8 @@
> +obj-$(CONFIG_ARCH_RCAR_GEN1)	+= rcar-rst.o
> +obj-$(CONFIG_ARCH_RCAR_GEN2)	+= rcar-rst.o
> +obj-$(CONFIG_ARCH_R8A7795)	+= rcar-rst.o
> +obj-$(CONFIG_ARCH_R8A7796)	+= rcar-rst.o
> +
>  obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o r8a7779-sysc.o
>  obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o r8a7790-sysc.o
>  obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o r8a7791-sysc.o
> diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
> new file mode 100644
> index 0000000000000000..1997c348c0853254
> --- /dev/null
> +++ b/drivers/soc/renesas/rcar-rst.c
> @@ -0,0 +1,94 @@
> +/*
> + * R-Car Gen1 RESET/WDT and R-Car Gen2/Gen3 RST Driver
> + *
> + * Copyright (C) 2016 Glider bvba
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/soc/renesas/rcar-rst.h>
> +
> +struct rst_config {
> +	unsigned int modemr;	/* Mode Monitoring Register Offset */
> +};
> +
> +static const struct rst_config rcar_rst_gen1 __initconst = {
> +	.modemr = 0x20,
> +};
> +
> +static const struct rst_config rcar_rst_gen2 __initconst = {
> +	.modemr = 0x60,
> +};
> +
> +static const struct rst_config rcar_rst_gen3 __initconst = {
> +	.modemr = 0x60,
> +};
> +
> +static const struct of_device_id rcar_rst_matches[] __initconst = {
> +	{ .compatible = "renesas,r8a7778-reset-wdt", .data = &rcar_rst_gen1 },
> +	{ .compatible = "renesas,r8a7779-reset-wdt", .data = &rcar_rst_gen1 },
> +	{ .compatible = "renesas,r8a7790-rst", .data = &rcar_rst_gen2 },
> +	{ .compatible = "renesas,r8a7791-rst", .data = &rcar_rst_gen2 },
> +	{ .compatible = "renesas,r8a7792-rst", .data = &rcar_rst_gen2 },
> +	{ .compatible = "renesas,r8a7793-rst", .data = &rcar_rst_gen2 },
> +	{ .compatible = "renesas,r8a7794-rst", .data = &rcar_rst_gen2 },
> +	{ .compatible = "renesas,r8a7795-rst", .data = &rcar_rst_gen3 },
> +	{ .compatible = "renesas,r8a7796-rst", .data = &rcar_rst_gen3 },
> +	{ /* sentinel */ }
> +};
> +
> +static void __iomem *rcar_rst_base __initdata;
> +static u32 saved_mode __initdata;
> +
> +static int __init rcar_rst_init(void)
> +{
> +	const struct of_device_id *match;
> +	const struct rst_config *cfg;
> +	struct device_node *np;
> +	void __iomem *base;
> +	int error = 0;
> +
> +	if (rcar_rst_base)
> +		return 0;
> +
> +	np = of_find_matching_node_and_match(NULL, rcar_rst_matches, &match);
> +	if (!np)
> +		return -ENODEV;
> +
> +	base = of_iomap(np, 0);
> +	if (!base) {
> +		pr_warn("%s: Cannot map regs\n", np->full_name);
> +		error = -ENOMEM;
> +		goto out_put;
> +	}
> +
> +	rcar_rst_base = base;
> +	cfg = match->data;
> +	saved_mode = ioread32(base + cfg->modemr);
> +
> +	pr_debug("%s: MODE = 0x%08x\n", np->full_name, saved_mode);
> +
> +out_put:
> +	of_node_put(np);
> +	return error;
> +}
> +arch_initcall(rcar_rst_init);
> +
> +int __init rcar_rst_read_mode_pins(u32 *mode)


Just a style issue: Is the string 'pins' in the function name still 
relevant? I.e. what's about just 'rcar_rst_read_mode()'?


Best regards

Dirk
