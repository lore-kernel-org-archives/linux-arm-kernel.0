From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Wed, 5 Oct 2016 14:17:55 +0200
Subject: [PATCH/RFC 4/4] soc: renesas: Identify SoC and register with the
 SoC bus
In-Reply-To: <1475572167-29581-5-git-send-email-geert+renesas@glider.be>
References: <1475572167-29581-1-git-send-email-geert+renesas@glider.be>
 <1475572167-29581-5-git-send-email-geert+renesas@glider.be>
Message-ID: <36af9b87-dfbf-4e34-78d4-c09b04100604@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

I've been offline some weeks, so sorry if I'm not completely up to date, 
yet, or miss anything.

Overall, having a quick look, the proposal in this patch series and your 
second series "arm64: renesas: r8a7795: R-Car H3 ES2.0 Prototype" looks 
nice to me. At least much better than encoding the ESx.x in the device 
tree as discussed some month ago ;)

Two minor comments below:


On 04.10.2016 11:09, Geert Uytterhoeven wrote:
> Identify the SoC type and revision, and register this information with
> the SoC bus, so it is available under /sys/devices/soc0/, and can be
> checked where needed using soc_device_match().
>
> In addition, on SoCs that support it, the product ID is read from a
> hardware register and validated, to catch accidental use of a DTB for a
> different SoC.
>
> Example:
>
>     Detected Renesas r8a7791 ES1.0
>     ...
>     # cat /sys/devices/soc0/{family,machine,soc_id,revision}
>     R-Car Gen2
>     Koelsch
>     r8a7791
>     ES1.0
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This patch does NOT add a call to
>
>         of_platform_default_populate(NULL, NULL,
>                                      soc_device_to_device(soc_dev));
>
> Contrary to suggested by commit 74d1d82cdaaec727 ("drivers/base: add bus
> for System-on-Chip devices), doing so would not only move on-SoC devices
> from /sys/devices/platform/ to /sys/devices/soc0/, but also all other
> board (off-SoC) devices specified in the DTB.
> ---
>  arch/arm/mach-shmobile/Kconfig    |   1 +
>  arch/arm64/Kconfig.platforms      |   1 +
>  drivers/soc/renesas/Makefile      |   2 +
>  drivers/soc/renesas/renesas-soc.c | 266 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 270 insertions(+)
>  create mode 100644 drivers/soc/renesas/renesas-soc.c
>
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index b5a3cbe81dd1d1f0..e41d2cbb2c825981 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -42,6 +42,7 @@ menuconfig ARCH_RENESAS
>  	select HAVE_ARM_TWD if SMP
>  	select NO_IOPORT_MAP
>  	select PINCTRL
> +	select SOC_BUS
>  	select ZONE_DMA if ARM_LPAE
>
>  if ARCH_RENESAS
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index be5d824ebdba2dab..a2675afc61baba8d 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -131,6 +131,7 @@ config ARCH_RENESAS
>  	select PM
>  	select PM_GENERIC_DOMAINS
>  	select RENESAS_IRQC
> +	select SOC_BUS
>  	help
>  	  This enables support for the ARMv8 based Renesas SoCs.
>
> diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
> index 623039c3514cdc34..ae6ae8a11f98aba1 100644
> --- a/drivers/soc/renesas/Makefile
> +++ b/drivers/soc/renesas/Makefile
> @@ -1,3 +1,5 @@
> +obj-y				+= renesas-soc.o
> +
>  obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o r8a7779-sysc.o
>  obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o r8a7790-sysc.o
>  obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o r8a7791-sysc.o
> diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
> new file mode 100644
> index 0000000000000000..74b72e4112b8889e
> --- /dev/null
> +++ b/drivers/soc/renesas/renesas-soc.c
> @@ -0,0 +1,266 @@
> +/*
> + * Renesas SoC Identification
> + *
> + * Copyright (C) 2014-2016 Glider bvba
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/sys_soc.h>
> +
> +
> +struct renesas_family {
> +	const char name[16];
> +	u32 reg;			/* CCCR, PVR, or PRR */


I'm wondering if we want to encode this information in the device tree?

 From the structs below it looks like this is information would be 
typically given in the device tree, and not hard coded in this C code?

On the other hand, above you mention

"catch accidental use of a DTB for a different SoC"

which is a nice feature, too.

So I just want to talk about the pros & cons, most probably both ways 
are fine.


> +};
> +
> +static const struct renesas_family fam_emev2 __initconst = {
> +	.name	= "Emma Mobile EV2",
> +};
> +
> +static const struct renesas_family fam_rmobile __initconst = {
> +	.name	= "R-Mobile",
> +	.reg	= 0xe600101c,		/* CCCR (Common Chip Code Register) */
> +};
> +
> +static const struct renesas_family fam_rcar_gen1 __initconst = {
> +	.name	= "R-Car Gen1",
> +	.reg	= 0xff000044,		/* PRR (Product Register) */
> +};
> +
> +static const struct renesas_family fam_rcar_gen2 __initconst = {
> +	.name	= "R-Car Gen2",
> +	.reg	= 0xff000044,		/* PRR (Product Register) */
> +};
> +
> +static const struct renesas_family fam_rcar_gen3 __initconst = {
> +	.name	= "R-Car Gen3",
> +	.reg	= 0xfff00044,		/* PRR (Product Register) */
> +};
> +
> +static const struct renesas_family fam_rza __initconst = {
> +	.name	= "RZ/A",
> +};
> +
> +static const struct renesas_family fam_rzg __initconst = {
> +	.name	= "RZ/G",
> +	.reg	= 0xff000044,		/* PRR (Product Register) */
> +};
> +
> +static const struct renesas_family fam_shmobile __initconst = {
> +	.name	= "SH-Mobile",
> +	.reg	= 0xe600101c,		/* CCCR (Common Chip Code Register) */
> +};
> +
> +
> +struct renesas_soc {
> +	const struct renesas_family *family;
> +	u8 id;
> +};
> +
> +static const struct renesas_soc soc_emev2 __initconst = {
> +	.family	= &fam_emev2,
> +};
> +
> +static const struct renesas_soc soc_rz_a1h __initconst = {
> +	.family	= &fam_rza,
> +};
> +
> +static const struct renesas_soc soc_rmobile_ape6 __initconst = {
> +	.family	= &fam_rmobile,
> +	.id	= 0x3f,
> +};
> +
> +static const struct renesas_soc soc_rmobile_a1 __initconst = {
> +	.family	= &fam_rmobile,
> +	.id	= 0x40,
> +};
> +
> +static const struct renesas_soc soc_rz_g1m __initconst = {
> +	.family	= &fam_rzg,
> +	.id	= 0x47,
> +};
> +
> +static const struct renesas_soc soc_rz_g1e __initconst = {
> +	.family	= &fam_rzg,
> +	.id	= 0x4c,
> +};
> +
> +static const struct renesas_soc soc_rcar_m1a __initconst = {
> +	.family	= &fam_rcar_gen1,
> +};
> +
> +static const struct renesas_soc soc_rcar_h1 __initconst = {
> +	.family	= &fam_rcar_gen1,
> +	.id	= 0x3b,
> +};
> +
> +static const struct renesas_soc soc_rcar_h2 __initconst = {
> +	.family	= &fam_rcar_gen2,
> +	.id	= 0x45,
> +};
> +
> +static const struct renesas_soc soc_rcar_m2_w __initconst = {
> +	.family	= &fam_rcar_gen2,
> +	.id	= 0x47,
> +};
> +
> +static const struct renesas_soc soc_rcar_v2h __initconst = {
> +	.family	= &fam_rcar_gen2,
> +	.id	= 0x4a,
> +};
> +
> +static const struct renesas_soc soc_rcar_m2_n __initconst = {
> +	.family	= &fam_rcar_gen2,
> +	.id	= 0x4b,
> +};
> +
> +static const struct renesas_soc soc_rcar_e2 __initconst = {
> +	.family	= &fam_rcar_gen2,
> +	.id	= 0x4c,
> +};
> +
> +static const struct renesas_soc soc_rcar_h3 __initconst = {
> +	.family	= &fam_rcar_gen3,
> +	.id	= 0x4f,
> +};
> +
> +static const struct renesas_soc soc_rcar_m3_w __initconst = {
> +	.family	= &fam_rcar_gen3,
> +	.id	= 0x52,
> +};
> +
> +static const struct renesas_soc soc_shmobile_ag5 __initconst = {
> +	.family	= &fam_shmobile,
> +	.id	= 0x37,
> +};
> +
> +static const struct of_device_id renesas_socs[] __initconst = {
> +#ifdef CONFIG_ARCH_EMEV2
> +	{ .compatible = "renesas,emev2",	.data = &soc_emev2 },
> +#endif
> +#ifdef CONFIG_ARCH_R7S72100
> +	{ .compatible = "renesas,r7s72100",	.data = &soc_rz_a1h },
> +#endif
> +#ifdef CONFIG_ARCH_R8A73A4
> +	{ .compatible = "renesas,r8a73a4",	.data = &soc_rmobile_ape6 },
> +#endif
> +#ifdef CONFIG_ARCH_R8A7740
> +	{ .compatible = "renesas,r8a7740",	.data = &soc_rmobile_a1 },
> +#endif
> +#ifdef CONFIG_ARCH_R8A7743
> +	{ .compatible = "renesas,r8a7743",	.data = &soc_rz_g1m },
> +#endif
> +#ifdef CONFIG_ARCH_R8A7745
> +	{ .compatible = "renesas,r8a7745",	.data = &soc_rz_g1e },
> +#endif
> +#ifdef CONFIG_ARCH_R8A7778
> +	{ .compatible = "renesas,r8a7778",	.data = &soc_rcar_m1a },
> +#endif
> +#ifdef CONFIG_ARCH_R8A7779
> +	{ .compatible = "renesas,r8a7779",	.data = &soc_rcar_h1 },
> +#endif
> +#ifdef CONFIG_ARCH_R8A7790
> +	{ .compatible = "renesas,r8a7790",	.data = &soc_rcar_h2 },
> +#endif
> +#ifdef CONFIG_ARCH_R8A7791
> +	{ .compatible = "renesas,r8a7791",	.data = &soc_rcar_m2_w },
> +#endif
> +#ifdef CONFIG_ARCH_R8A7792
> +	{ .compatible = "renesas,r8a7792",	.data = &soc_rcar_v2h },
> +#endif
> +#ifdef CONFIG_ARCH_R8A7793
> +	{ .compatible = "renesas,r8a7793",	.data = &soc_rcar_m2_n },
> +#endif
> +#ifdef CONFIG_ARCH_R8A7794
> +	{ .compatible = "renesas,r8a7794",	.data = &soc_rcar_e2 },
> +#endif
> +#ifdef CONFIG_ARCH_R8A7795
> +	{ .compatible = "renesas,r8a7795",	.data = &soc_rcar_h3 },
> +#endif
> +#ifdef CONFIG_ARCH_R8A7796
> +	{ .compatible = "renesas,r8a7796",	.data = &soc_rcar_m3_w },
> +#endif
> +#ifdef CONFIG_ARCH_SH73A0
> +	{ .compatible = "renesas,sh73a0",	.data = &soc_shmobile_ag5 },
> +#endif
> +	{ /* sentinel */ }
> +};
> +
> +static int __init renesas_soc_init(void)
> +{
> +	struct soc_device_attribute *soc_dev_attr;
> +	const struct renesas_family *family;
> +	unsigned int product, esi = 0, esf;
> +	const struct of_device_id *match;
> +	const struct renesas_soc *soc;
> +	struct soc_device *soc_dev;
> +	struct device_node *np;
> +	void __iomem *mapped;
> +
> +	np = of_find_matching_node_and_match(NULL, renesas_socs, &match);
> +	if (!np)
> +		return -ENODEV;
> +
> +	of_node_put(np);
> +	soc = match->data;
> +	family = soc->family;
> +
> +	if (soc->id) {
> +		mapped = ioremap(family->reg, 4);
> +		if (!mapped)
> +			return -ENOMEM;
> +
> +		product = readl(mapped);
> +		iounmap(mapped);
> +
> +		if (((product >> 8) & 0xff) != soc->id) {
> +			pr_crit("SoC mismatch (product = 0x%x)\n", product);
> +			return -ENODEV;
> +		}
> +
> +		esi = ((product >> 4) & 0x0f) + 1;
> +		esf = product & 0xf;


I'm somehow surprised to see that all SoCs covered here use the same way 
to encode esi and esf? I would have expected that we need different 
decoding for different SoCs. But if this isn't the case, even better :)


Best regards

Dirk
