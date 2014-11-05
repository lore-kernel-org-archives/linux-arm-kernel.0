From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 5 Nov 2014 12:43:14 -0800
Subject: [PATCH] mtd: physmap_of: add a hook for Versatile write protection
In-Reply-To: <1415100846-31541-1-git-send-email-linus.walleij@linaro.org>
References: <1415100846-31541-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20141105204314.GO23619@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 12:34:06PM +0100, Linus Walleij wrote:
> In order to support device tree probing of Versatile flash chips,
> there must be a way to add the VPP (write protection) enable/disable
> callback. The register in question is in the system controllers
> of these platforms.
> 
> Solve this by adding a arm,versatile-vpp compatibility to the
> device tree node, and look for this. In the driver, add a special

I believe this would require a new Documentation/devicetree/bindings/*
document. And please CC devicetree at vger.kernel.org for your next
revision when you create one.

> hook to check for the syscon and register a callback if this
> property is present. Provide a special Kconfig entry for the addon
> hook so it will not be compiled in if the RealView or Integrator
> (or later other Versatile boards) are not supported. Stubs in the
> header file make sure the impact would be zero on other platforms.

Your code still has some impact for kernels which have
CONFIG_MTD_PHYSMAP_OF_VERSATILE=y, but aren't using this particular flash type
(e.g., multiplatform kernels). See below.

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

You've got several checkpatch errors:

ERROR:FSF_MAILING_ADDRESS: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
#118: FILE: drivers/mtd/maps/physmap_of_versatile.c:18:
+ * along with this program; if not, write to the Free Software$

ERROR:FSF_MAILING_ADDRESS: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
#119: FILE: drivers/mtd/maps/physmap_of_versatile.c:19:
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,$

ERROR:COMPLEX_MACRO: Macros with complex values should be enclosed in parentheses
#157: FILE: drivers/mtd/maps/physmap_of_versatile.c:57:
+#define INTEGRATOR_SC_CTRL_FLASH_BITS	BIT(1) | BIT(2)

ERROR:COMPLEX_MACRO: Macros with complex values should be enclosed in parentheses
#286: FILE: drivers/mtd/maps/physmap_of_versatile.c:186:
+#define CINTEGRATOR_FLASHPROG_BITS	BIT(0) | BIT(1)

> ---
>  drivers/mtd/maps/Kconfig                |  10 +
>  drivers/mtd/maps/Makefile               |   1 +
>  drivers/mtd/maps/physmap_of.c           |   5 +
>  drivers/mtd/maps/physmap_of_versatile.c | 334 ++++++++++++++++++++++++++++++++
>  drivers/mtd/maps/physmap_of_versatile.h |  19 ++
>  5 files changed, 369 insertions(+)
>  create mode 100644 drivers/mtd/maps/physmap_of_versatile.c
>  create mode 100644 drivers/mtd/maps/physmap_of_versatile.h
> 
> diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> index ba801d2c6dcc..b01cd6e80774 100644
> --- a/drivers/mtd/maps/Kconfig
> +++ b/drivers/mtd/maps/Kconfig
> @@ -74,6 +74,16 @@ config MTD_PHYSMAP_OF
>  	  physically into the CPU's memory. The mapping description here is
>  	  taken from OF device tree.
>  
> +config MTD_PHYSMAP_OF_VERSATILE
> +	bool "Support ARM Versatile physmap OF"
> +	depends on MTD_PHYSMAP_OF
> +	depends on MFD_SYSCON
> +	default y if (REALVIEW_DT || ARCH_INTEGRATOR)
> +	help
> +	  This provides some extra DT physmap parsing for the ARM Versatile
> +	  platforms, basically to add a VPP (write protection) callback so
> +	  the flash can be taken out of write protection.
> +
>  config MTD_PMC_MSP_EVM
>  	tristate "CFI Flash device mapped on PMC-Sierra MSP"
>  	depends on PMC_MSP && MTD_CFI
> diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
> index 141c91a5b24c..c60b2b40a592 100644
> --- a/drivers/mtd/maps/Makefile
> +++ b/drivers/mtd/maps/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_MTD_TSUNAMI)	+= tsunami_flash.o
>  obj-$(CONFIG_MTD_PXA2XX)	+= pxa2xx-flash.o
>  obj-$(CONFIG_MTD_PHYSMAP)	+= physmap.o
>  obj-$(CONFIG_MTD_PHYSMAP_OF)	+= physmap_of.o
> +physmap_of-$(CONFIG_MTD_PHYSMAP_OF_VERSATILE) += physmap_of_versatile.o
>  obj-$(CONFIG_MTD_PISMO)		+= pismo.o
>  obj-$(CONFIG_MTD_PMC_MSP_EVM)   += pmcmsp-flash.o
>  obj-$(CONFIG_MTD_PCMCIA)	+= pcmciamtd.o
> diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
> index c1d21cb501ca..e9b23022ec94 100644
> --- a/drivers/mtd/maps/physmap_of.c
> +++ b/drivers/mtd/maps/physmap_of.c
> @@ -24,6 +24,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/slab.h>
> +#include "physmap_of_versatile.h"
>  
>  struct of_flash_list {
>  	struct mtd_info *mtd;
> @@ -67,6 +68,7 @@ static int of_flash_remove(struct platform_device *dev)
>  			kfree(info->list[i].res);
>  		}
>  	}
> +	of_flash_remove_versatile();
>  	return 0;
>  }
>  
> @@ -241,6 +243,9 @@ static int of_flash_probe(struct platform_device *dev)
>  		info->list[i].map.size = res_size;
>  		info->list[i].map.bankwidth = be32_to_cpup(width);
>  		info->list[i].map.device_node = dp;
> +		err = of_flash_probe_versatile(&dev->dev, &info->list[i].map);
> +		if (err)
> +			dev_err(&dev->dev, "Can't probe Versatile VPP\n");
>  
>  		err = -ENOMEM;
>  		info->list[i].map.virt = ioremap(info->list[i].map.phys,
> diff --git a/drivers/mtd/maps/physmap_of_versatile.c b/drivers/mtd/maps/physmap_of_versatile.c
> new file mode 100644
> index 000000000000..f5d55cead0ab
> --- /dev/null
> +++ b/drivers/mtd/maps/physmap_of_versatile.c
> @@ -0,0 +1,334 @@
> +/*
> + * Versatile OF physmap driver add-on
> + *
> + * Copyright (c) 2014, Linaro Limited
> + * Author: Linus Walleij <linus.walleij@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
> + * MA 02111-1307 USA
> + */
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/mtd/map.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include "physmap_of_versatile.h"
> +
> +/**
> + * struct flashprot_data - per-variant flash protection information
> + * @init: function to call on initialization
> + * @exit: function to call on de-initialization
> + * @set_vpp: function to set the VPP (Voltage for Programming Protection)
> + */
> +struct flashprot_data {
> +	int (*init)(void);
> +	void (*exit)(void);
> +	void (*set_vpp)(struct map_info *, int);
> +};
> +
> +struct versatile_flash_prot {
> +	struct device *dev;
> +	struct regmap *syscon_regmap;
> +	struct regmap *ap_ebi_regmap;
> +	const struct flashprot_data *fprot;
> +};
> +
> +struct versatile_flash_prot *vprot;

Make this static? But then, do you only support a single flash device?
It's better practice not to keep static data like this in a potentially
reusable driver.

> +
> +#define INTEGRATOR_SC_CTRLS_OFFSET	0x08 /* For setting bits */
> +#define INTEGRATOR_SC_CTRLC_OFFSET	0x0C /* For clearing bits */
> +#define INTEGRATOR_SC_CTRL_FLASH_BITS	BIT(1) | BIT(2)
> +#define INTEGRATOR_SC_CTRL_nFLVPPEN	BIT(1)
> +#define INTEGRATOR_SC_CTRL_nFLWP	BIT(2)
> +
> +#define INTEGRATOR_EBI_CSR0_OFFSET      0x00
> +#define INTEGRATOR_EBI_CSR1_OFFSET      0x04
> +#define INTEGRATOR_EBI_CSR2_OFFSET      0x08
> +#define INTEGRATOR_EBI_CSR3_OFFSET      0x0C
> +#define INTEGRATOR_EBI_LOCK_OFFSET      0x20
> +#define INTEGRATOR_EBI_WRITE_ENABLE     BIT(2)
> +
> +static const struct of_device_id ebi_match[] = {
> +	{ .compatible = "arm,external-bus-interface", },
> +	{},
> +};
> +
> +static int integrator_ap_vpp_init(void)
> +{
> +	struct device_node *ebinp;
> +	int ret;
> +
> +	/* Find the EBI regmap */
> +	ebinp = of_find_matching_node(NULL, ebi_match);
> +	if (!ebinp) {
> +		dev_err(vprot->dev, "no EBI node\n");
> +		return -ENODEV;
> +	}
> +
> +	vprot->ap_ebi_regmap = syscon_node_to_regmap(ebinp);
> +	if (IS_ERR(vprot->ap_ebi_regmap)) {
> +		dev_err(vprot->dev, "no EBI regmap\n");
> +		return PTR_ERR(vprot->ap_ebi_regmap);
> +	}
> +
> +	/* Disable VPP and set write protection on startup */
> +	ret = regmap_write(vprot->syscon_regmap, INTEGRATOR_SC_CTRLC_OFFSET,
> +			   INTEGRATOR_SC_CTRL_FLASH_BITS);
> +	if (ret) {
> +		dev_err(vprot->dev, "failed setting flash protection\n");
> +		return ret;
> +	}
> +
> +	/* Unlock EBI */
> +	ret = regmap_write(vprot->ap_ebi_regmap, INTEGRATOR_EBI_LOCK_OFFSET,
> +			   0xa05f);
> +	if (ret) {
> +		dev_err(vprot->dev, "failed unlocking EBI\n");
> +		return ret;
> +	}
> +	ret = regmap_update_bits(vprot->ap_ebi_regmap,
> +				 INTEGRATOR_EBI_CSR1_OFFSET,
> +				 INTEGRATOR_EBI_WRITE_ENABLE,
> +				 INTEGRATOR_EBI_WRITE_ENABLE);
> +	if (ret)
> +		dev_err(vprot->dev, "failed EBI WE CSR1\n");
> +
> +	/* Lock EBI */
> +	ret = regmap_write(vprot->ap_ebi_regmap, INTEGRATOR_EBI_LOCK_OFFSET, 0);
> +	if (ret) {
> +		dev_err(vprot->dev, "failed locking EBI\n");
> +		return ret;
> +	}
> +	dev_info(vprot->dev, "initialized Integrator/AP flash protection\n");
> +
> +	return 0;
> +}
> +
> +static void integrator_ap_vpp_exit(void)
> +{
> +	int ret;
> +
> +	if (!vprot || !vprot->syscon_regmap || !vprot->ap_ebi_regmap)
> +		return;
> +
> +	/* Disable VPP and set write protection on exit */
> +	ret = regmap_write(vprot->syscon_regmap, INTEGRATOR_SC_CTRLC_OFFSET,
> +			   INTEGRATOR_SC_CTRL_FLASH_BITS);
> +	if (ret)
> +		dev_err(vprot->dev, "failed enabling flash protection\n");
> +
> +	/* Unlock EBI */
> +	ret = regmap_write(vprot->ap_ebi_regmap, INTEGRATOR_EBI_LOCK_OFFSET,
> +			   0xa05f);
> +	if (ret)
> +		dev_err(vprot->dev, "failed unlocking EBI\n");
> +
> +	ret = regmap_update_bits(vprot->ap_ebi_regmap,
> +				 INTEGRATOR_EBI_CSR1_OFFSET,
> +				 INTEGRATOR_EBI_WRITE_ENABLE,
> +				 0);
> +	if (ret)
> +		dev_err(vprot->dev, "failed EBI WE CSR1\n");
> +
> +	/* Lock EBI */
> +	ret = regmap_write(vprot->ap_ebi_regmap, INTEGRATOR_EBI_LOCK_OFFSET, 0);
> +	if (ret)
> +		dev_err(vprot->dev, "failed locking EBI\n");
> +
> +	dev_info(vprot->dev, "enabled flash protection\n");
> +}
> +
> +static void integrator_ap_set_vpp(struct map_info *map, int on)
> +{
> +	int ret;
> +
> +	if (on) {
> +		ret = regmap_write(vprot->syscon_regmap,
> +				   INTEGRATOR_SC_CTRLS_OFFSET,
> +				   INTEGRATOR_SC_CTRL_nFLVPPEN);
> +		if (ret)
> +			dev_err(vprot->dev, "error enable flash VPP\n");
> +	} else {
> +		ret = regmap_write(vprot->syscon_regmap,
> +				   INTEGRATOR_SC_CTRLC_OFFSET,
> +				   INTEGRATOR_SC_CTRL_nFLVPPEN);
> +		if (ret)
> +			dev_err(vprot->dev, "error disable flash VPP");
> +	}
> +}
> +
> +struct flashprot_data integrator_ap_flashprot_data = {
> +	.init = integrator_ap_vpp_init,
> +	.exit = integrator_ap_vpp_exit,
> +	.set_vpp = integrator_ap_set_vpp,
> +};
> +
> +#define INTCP_FLASHPROG			0x04
> +#define CINTEGRATOR_FLASHPROG_FLVPPEN	BIT(0)
> +#define CINTEGRATOR_FLASHPROG_FLWREN	BIT(1)
> +#define CINTEGRATOR_FLASHPROG_BITS	BIT(0) | BIT(1)
> +
> +#define REALVIEW_FLASH_OFFSET 0x4c
> +
> +static int integrator_cp_vpp_init(void)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(vprot->ap_ebi_regmap,
> +				 INTCP_FLASHPROG,
> +				 CINTEGRATOR_FLASHPROG_BITS,
> +				 CINTEGRATOR_FLASHPROG_FLWREN);
> +	if (ret)
> +		dev_err(vprot->dev, "failed flash WE\n");
> +
> +	dev_info(vprot->dev, "initialized Integrator/CP flash protection\n");
> +
> +	return 0;
> +}
> +
> +static void integrator_cp_vpp_exit(void)
> +{
> +	int ret;
> +
> +	if (!vprot || !vprot->syscon_regmap || !vprot->ap_ebi_regmap)
> +		return;
> +
> +	ret = regmap_update_bits(vprot->ap_ebi_regmap,
> +				 INTCP_FLASHPROG,
> +				 CINTEGRATOR_FLASHPROG_BITS,
> +				 0);
> +	if (ret)
> +		dev_err(vprot->dev, "failed flash WE\n");
> +
> +	dev_info(vprot->dev, "enabled flash protection\n");
> +}
> +
> +static void integrator_cp_set_vpp(struct map_info *map, int on)
> +{
> +	int ret;
> +
> +	if (on) {
> +		ret = regmap_update_bits(vprot->ap_ebi_regmap,
> +					 INTCP_FLASHPROG,
> +					 CINTEGRATOR_FLASHPROG_FLVPPEN,
> +					 CINTEGRATOR_FLASHPROG_FLVPPEN);
> +		if (ret)
> +			dev_err(vprot->dev, "error enable flash VPP\n");
> +	} else {
> +		ret = regmap_update_bits(vprot->ap_ebi_regmap,
> +					 INTCP_FLASHPROG,
> +					 CINTEGRATOR_FLASHPROG_FLVPPEN,
> +					 0);
> +		if (ret)
> +			dev_err(vprot->dev, "error disable flash VPP\n");
> +	}
> +}
> +
> +struct flashprot_data integrator_cp_flashprot_data = {
> +	.init = integrator_cp_vpp_init,
> +	.exit = integrator_cp_vpp_exit,
> +	.set_vpp = integrator_cp_set_vpp,
> +};
> +
> +static void realview_set_vpp(struct map_info *map, int on)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(vprot->syscon_regmap, REALVIEW_FLASH_OFFSET,
> +				 0x01, !!on);
> +	if (ret)
> +		dev_err(vprot->dev, "error setting RealView VPP\n");
> +}
> +
> +struct flashprot_data realview_flashprot_data = {
> +	.set_vpp = realview_set_vpp,
> +};
> +
> +static const struct of_device_id syscon_match[] = {
> +	{
> +		.compatible = "arm,integrator-ap-syscon",
> +		.data = &integrator_ap_flashprot_data,
> +	},
> +	{
> +		.compatible = "arm,integrator-cp-syscon",
> +		.data = &integrator_cp_flashprot_data,
> +	},
> +	{
> +		.compatible = "arm,realview-pb1176-syscon",
> +		.data = &realview_flashprot_data,
> +	},
> +	{},
> +};
> +
> +int of_flash_probe_versatile(struct device *dev,
> +			     struct map_info *map)
> +{
> +	struct device_node *sysnp;
> +	const struct of_device_id *devid;
> +	struct regmap *rmap;
> +	struct device_node *np = dev->of_node;
> +
> +	vprot = devm_kzalloc(dev, sizeof(*vprot), GFP_KERNEL);
> +	if (!vprot)
> +		return -ENOMEM;
> +	vprot->dev = dev;
> +
> +	/* Not all flash chips have to use this protection line */
> +	if (!of_device_is_compatible(np, "arm,versatile-flash"))
> +		return 0;

If you return here, then you're essentially leaking the 'vprot' memory.
It really seems like it's not safe to rely on devm_* functions to
automatically free resources in this probe path. Or you at least need to
clean up after yourself in the non-fatal paths.

> +
> +	/* For first chip probed, look up the syscon regmap */
> +	if (!vprot->syscon_regmap) {
> +		int ret;
> +
> +		sysnp = of_find_matching_node_and_match(NULL,
> +							syscon_match,
> +							&devid);
> +		if (!sysnp) {
> +			dev_err(dev, "no syscon match\n");
> +			return -ENODEV;
> +		}
> +
> +		rmap = syscon_node_to_regmap(sysnp);
> +		if (IS_ERR(rmap)) {
> +			dev_err(dev, "no syscon regmap\n");
> +			return PTR_ERR(rmap);
> +		}
> +
> +		vprot->syscon_regmap = rmap;
> +		vprot->fprot = devid->data;
> +
> +		if (vprot->fprot->init) {
> +			ret = vprot->fprot->init();
> +			if (ret)
> +				return ret;
> +		}
> +
> +		map->set_vpp = vprot->fprot->set_vpp;
> +	}
> +	return 0;
> +}
> +
> +void of_flash_remove_versatile(void)
> +{
> +	if (!vprot || !vprot->fprot || !vprot->fprot->exit)
> +		return;
> +	vprot->fprot->exit();
> +}
> diff --git a/drivers/mtd/maps/physmap_of_versatile.h b/drivers/mtd/maps/physmap_of_versatile.h
> new file mode 100644
> index 000000000000..7d176d313860
> --- /dev/null
> +++ b/drivers/mtd/maps/physmap_of_versatile.h
> @@ -0,0 +1,19 @@
> +#include <linux/of.h>
> +#include <linux/mtd/map.h>
> +
> +#ifdef CONFIG_MTD_PHYSMAP_OF_VERSATILE
> +int of_flash_probe_versatile(struct device *dev,
> +			     struct map_info *map);
> +void of_flash_remove_versatile(void);
> +#else
> +static inline int

The line break here seems a little inconsistent.

> +of_flash_probe_versatile(struct device *dev,
> +			 struct map_info *map)
> +{
> +	return 0;
> +}
> +static inline void
> +of_flash_remove_versatile(void)
> +{
> +}
> +#endif

Brian
