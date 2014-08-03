From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 3 Aug 2014 14:40:36 +0200
Subject: [PATCH 1/9] ARM: sunxi: introduce SoC identification support
In-Reply-To: <1406842092-25207-2-git-send-email-emilio@elopez.com.ar>
References: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
 <1406842092-25207-2-git-send-email-emilio@elopez.com.ar>
Message-ID: <20140803124036.GS3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Thu, Jul 31, 2014 at 06:28:04PM -0300, Emilio L?pez wrote:
> This commit adds SoC bus support on the sunxi platform, and exposes
> information such as the hardware revision to userspace and other kernel
> clients during init. A message with this information is also printed to
> the kernel log to ease future bug triaging.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
>  arch/arm/mach-sunxi/Kconfig        |   1 +
>  arch/arm/mach-sunxi/Makefile       |   2 +-
>  arch/arm/mach-sunxi/sunxi-soc-id.c | 226 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-sunxi/sunxi-soc-id.h |   6 +
>  4 files changed, 234 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-sunxi/sunxi-soc-id.c
>  create mode 100644 arch/arm/mach-sunxi/sunxi-soc-id.h
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 6434e3b..4a199df 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -5,6 +5,7 @@ menuconfig ARCH_SUNXI
>  	select GENERIC_IRQ_CHIP
>  	select PINCTRL
>  	select PINCTRL_SUNXI
> +	select SOC_BUS
>  	select SUN4I_TIMER
>  
>  if ARCH_SUNXI
> diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
> index 27b168f..589239b 100644
> --- a/arch/arm/mach-sunxi/Makefile
> +++ b/arch/arm/mach-sunxi/Makefile
> @@ -1,2 +1,2 @@
> -obj-$(CONFIG_ARCH_SUNXI) += sunxi.o
> +obj-$(CONFIG_ARCH_SUNXI) += sunxi.o sunxi-soc-id.o
>  obj-$(CONFIG_SMP) += platsmp.o
> diff --git a/arch/arm/mach-sunxi/sunxi-soc-id.c b/arch/arm/mach-sunxi/sunxi-soc-id.c
> new file mode 100644
> index 0000000..c7eff1c
> --- /dev/null
> +++ b/arch/arm/mach-sunxi/sunxi-soc-id.c
> @@ -0,0 +1,226 @@
> +/*
> + * SoC revision detection for sunxi SoCs
> + *
> + * Copyright 2014 Emilio L?pez
> + *
> + * Emilio L?pez <emilio@elopez.com.ar>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/sys_soc.h>
> +
> +#include "sunxi-soc-id.h"
> +
> +/*
> + * On the A10 SoC, we can read the revision information from the timer
> + * block. The detection logic is extracted from similar code on the
> + * Allwinner vendor tree, as this is undocumented on the user manual
> + */
> +
> +#define TIMER_SOC_REV_REG		0x13c
> +#define TIMER_SOC_REV_CLEAR(val)	((val) & ~(0x3 << 6))
> +#define TIMER_SOC_REV_GET(val)		(((val) >> 6) & 0x3)
> +
> +static const struct of_device_id sun4i_timer_compatible[] __initconst = {
> +	{ .compatible = "allwinner,sun4i-a10-timer", },
> +	{},
> +};
> +
> +static int __init sun4i_get_soc_revision(void)
> +{
> +	struct device_node *np;
> +	void __iomem *base;
> +	u32 val;
> +	int ret;
> +
> +	/* Find the timer node */
> +	np = of_find_matching_node(NULL, sun4i_timer_compatible);
> +	if (!np)
> +		return -ENODEV;
> +
> +	/* Temporarily map it for reading */
> +	base = of_iomap(np, 0);
> +	if (!base) {
> +		of_node_put(np);
> +		return -ENOMEM;
> +	}
> +
> +	/* Clear the SoC revision bits and rewrite the register */
> +	val = readl(base + TIMER_SOC_REV_REG);
> +	val = TIMER_SOC_REV_CLEAR(val);
> +	writel(val, base + TIMER_SOC_REV_REG);
> +
> +	/* Now read it again and see what shows up */
> +	val = readl(base + TIMER_SOC_REV_REG);
> +	val = TIMER_SOC_REV_GET(val);
> +
> +	switch (val) {
> +	case 0:  /* revision A */
> +		ret = 'A';
> +	case 3:  /* revision B */
> +		ret = 'B';
> +	default: /* revision C */
> +		ret = 'C';

What's programmed in there in the case of the rev C?

> +	}
> +
> +	iounmap(base);
> +	of_node_put(np);
> +
> +	return ret;
> +}
> +
> +/*
> + * On the sun5i SoCs (A10S, A13), we can read the revision information
> + * from the first bits in the Security ID. The detection logic is
> + * extracted from similar code on the Allwinner vendor tree, as this
> + * is undocumented on the user manual.
> + */
> +
> +static const struct of_device_id sun5i_sid_compatible[] __initconst = {
> +	{ .compatible = "allwinner,sun4i-a10-sid", },
> +	{},
> +};
> +
> +static int __init sun5i_get_soc_revision(void)
> +{
> +	struct device_node *np;
> +	void __iomem *sid;
> +	u32 val;
> +	int ret;
> +
> +	/* Find the SID node */
> +	np = of_find_matching_node(NULL, sun5i_sid_compatible);
> +	if (!np)
> +		return -ENODEV;
> +
> +	/* Temporarily map it for reading */
> +	sid = of_iomap(np, 0);
> +	if (!sid) {
> +		of_node_put(np);
> +		return -ENOMEM;
> +	}
> +
> +	/* Read and extract the chip revision from the SID */
> +	val = readl(sid);
> +	val = (val >> 8) & 0xffffff;
> +
> +	switch (val) {
> +	case 0:        /* A10S/A13 rev A */
> +	case 0x162541: /* A10S/A13 rev A */
> +	case 0x162565: /* A13 rev A */

Some defines would be nice.

Also, isn't the SID supposed to identify any SoC, not just the sun5i?

> +		ret = 'A';
> +		break;
> +	case 0x162542: /* A10S/A13 rev B */
> +		ret = 'B';
> +		break;
> +	default:       /* Unknown chip revision */
> +		ret = -ENODATA;
> +	}
> +
> +	iounmap(sid);
> +	of_node_put(np);
> +
> +	return ret;
> +}
> +
> +int __init sunxi_soc_revision(void)
> +{
> +	static int revision = -ENODEV;
> +
> +	/* Try to query the hardware just once */
> +	if (!IS_ERR_VALUE(revision))
> +		return revision;
> +
> +	if (of_machine_is_compatible("allwinner,sun4i-a10")) {
> +		revision = sun4i_get_soc_revision();
> +	} else if (of_machine_is_compatible("allwinner,sun5i-a10s") ||
> +		   of_machine_is_compatible("allwinner,sun5i-a13")) {
> +		revision = sun5i_get_soc_revision();
> +	}
> +
> +	return revision;
> +}
> +
> +/* Matches for the sunxi SoCs we know of */
> +static const struct of_device_id soc_matches[] __initconst = {
> +	{ .compatible = "allwinner,sun4i-a10", .data = "A10 (sun4i)" },
> +	{ .compatible = "allwinner,sun5i-a13", .data = "A13 (sun5i)" },
> +	{ .compatible = "allwinner,sun5i-a10s", .data = "A10S (sun5i)" },
> +	{ .compatible = "allwinner,sun6i-a31", .data = "A31 (sun6i)" },
> +	{ .compatible = "allwinner,sun7i-a20", .data = "A20 (sun7i)" },
> +	{ .compatible = "allwinner,sun8i-a23", .data = "A23 (sun8i)" },
> +	{ /* sentinel */ },
> +};

Hmmm, no, either auto-detect it, or don't, but that's useless. We can
already have the same information from the DT directly.

> +static int __init sunxi_register_soc_device(void)
> +{
> +	struct soc_device_attribute *soc_dev_attr;
> +	struct soc_device *soc_dev;
> +	const struct of_device_id *match;
> +	struct device_node *root;
> +	int revision;
> +
> +	/* Only run on sunxi SoCs that we know of */
> +	root = of_find_node_by_path("/");
> +	match = of_match_node(soc_matches, root);
> +	if (!match)
> +		goto exit;
> +
> +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +	if (!soc_dev_attr)
> +		goto exit;
> +
> +	/* Read the machine name if available */
> +	of_property_read_string(root, "model", &soc_dev_attr->machine);
> +
> +	soc_dev_attr->family = kstrdup("Allwinner A Series", GFP_KERNEL);

I think the family should be sun*i

> +	soc_dev_attr->soc_id = kstrdup(match->data, GFP_KERNEL);

And soc_id would be just the name of the SoC.

> +
> +	/* Revision may not always be available */
> +	revision = sunxi_soc_revision();
> +	if (IS_ERR_VALUE(revision))
> +		soc_dev_attr->revision = kstrdup("Unknown", GFP_KERNEL);
> +	else
> +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%c", revision);
> +
> +	soc_dev = soc_device_register(soc_dev_attr);
> +	if (IS_ERR(soc_dev))
> +		goto free_struct;
> +
> +	/*
> +	 * Print an informational line mentioning the hardware details.
> +	 * It may come in handy during bug reports, as some early SoC
> +	 * revisions have hardware quirks and do not get much testing.
> +	 */
> +	pr_info("SoC bus registered, running %s %s, revision %s\n",
> +		soc_dev_attr->family, soc_dev_attr->soc_id,
> +		soc_dev_attr->revision);

Maybe a pr_fmt would be nice here.


> +
> +	return 0;
> +
> +free_struct:
> +	kfree(soc_dev_attr->family);
> +	kfree(soc_dev_attr->soc_id);
> +	kfree(soc_dev_attr->revision);
> +	kfree(soc_dev_attr);
> +exit:
> +	of_node_put(root);
> +
> +	return 0;
> +}
> +postcore_initcall(sunxi_register_soc_device)

I'm kind of reluctant to this. That would mean that it will run for
every SoC.

Can't you tie it to the system controller, and have it probed as
usual?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140803/2a956bf9/attachment-0001.sig>
